// routes/calculateFare.js
const express = require('express');
const axios = require('axios');
const router = express.Router();
const { calculateFareFromMetersSeconds } = require('../lib/fareServer'); // same as before

// Config cache simple (evita solicitar Strapi en cada request)
let configCache = null;
let configCacheAt = 0;
const CONFIG_TTL_MS = 60 * 1000; // 60s cache (ajusta si quieres)

async function fetchTarifaConfig() {
  const now = Date.now();
  if (configCache && (now - configCacheAt) < CONFIG_TTL_MS) {
    return configCache;
  }

  const STRAPI_URL = process.env.STRAPI_URL;
  if (!STRAPI_URL) {
    throw new Error('STRAPI_URL no definido en .env');
  }

  // Endpoint Strapi v4 — filtramos por parametro == "tarifataxi" y poblamos el campo basic_set
  const endpoint = `${STRAPI_URL.replace(/\/$/, '')}/api/configuraciones-sistema?filters[parametro][$eq]=tarifataxi&populate=basic_set`;

  const resp = await axios.get(endpoint, { timeout: 8000 });
  // La respuesta típica de Strapi v4: { data: [ { id, attributes: { basic_set: {...}, parametro: "..."} } ], meta: {...} }
  if (!resp.data || !Array.isArray(resp.data.data) || resp.data.data.length === 0) {
    throw new Error('Configuración "tarifataxi" no encontrada en Strapi');
  }

  const first = resp.data.data[0];
  let basic = first.attributes && first.attributes.basic_set ? first.attributes.basic_set : null;

  // Si Strapi guardó basic_set como string JSON
  if (basic && typeof basic === 'string') {
    try {
      basic = JSON.parse(basic);
    } catch (e) {
      // leave as string (invalid) - handled later
    }
  }

  // Si no es objeto válido, lanzar
  if (!basic || typeof basic !== 'object') {
    throw new Error('basic_set inválido o vacío para parametro tarifataxi');
  }

  // guardar en cache
  configCache = basic;
  configCacheAt = Date.now();
  return basic;
}

router.post('/calculate-fare', async (req, res) => {
  try {
    const { origin, destination, fareOpts } = req.body;
    if (!origin || !destination) return res.status(400).json({ ok: false, error: 'origin y destination requeridos' });

    // Obtener configuración de tarifa desde Strapi
    let tarifaConfig = null;
    try {
      tarifaConfig = await fetchTarifaConfig();
    } catch (cfgErr) {
      console.warn('No se pudo obtener tarifa desde Strapi, usando defaults:', String(cfgErr));
      tarifaConfig = null; // luego caerá en defaults
    }

    // Defaults si Strapi falla o faltan campos
    const DEFAULTS = {
      baseFare: 9.19,
      perKm: 5.84,
      perMin: 1.95,
      surge: 1,
      minFare: 30,
      roundTo: 1,
    };

    const config = Object.assign({}, DEFAULTS, tarifaConfig || {});

    // Construimos el origin/destination para Google
    const originParam = typeof origin === 'string' ? origin : `${origin.lat},${origin.lng}`;
    const destParam = typeof destination === 'string' ? destination : `${destination.lat},${destination.lng}`;

    const GEOCODING_KEY = process.env.GEOCODING_KEY;
    if (!GEOCODING_KEY) {
      return res.status(500).json({ ok: false, error: 'GEOCODING_KEY no definido en .env' });
    }

    const url = `https://maps.googleapis.com/maps/api/directions/json?origin=${encodeURIComponent(originParam)}&destination=${encodeURIComponent(destParam)}&key=${encodeURIComponent(GEOCODING_KEY)}`;

    const r = await axios.get(url, { timeout: 10000 });
    if (!r.data || r.data.status !== 'OK' || !r.data.routes || !r.data.routes.length) {
      // fallback: intentamos aproximar distancia por Haversine si vienen coords
      let fallback = {};
      try {
        if (typeof origin === 'object' && typeof destination === 'object' && origin.lat && origin.lng && destination.lat && destination.lng) {
          const meters = haversineMeters(origin, destination);
          // estimar tiempo (velocidad promedio 30 km/h -> 8.33 m/s) -> tiempo = meters / 8.33
          const approxDuration = Math.max(60, Math.round(meters / 8.33)); // al menos 1 minuto
          const fareObj = calculateFareFromMetersSeconds(meters, approxDuration, {
            baseFare: config.baseFare,
            perKm: config.perKm,
            perMin: config.perMin,
            surge: config.surge,
            minFare: config.minFare,
            roundTo: config.roundTo
          });
          fallback = {
            fallback: true,
            distanceMeters: Math.round(meters),
            durationSeconds: approxDuration,
            fare: fareObj.fare,
            breakdown: fareObj.breakdown
          };
          return res.json({ ok: true, ...fallback, config });
        }
      } catch (e) {
        console.warn('Fallback haversine fallo', e);
      }

      return res.status(500).json({ ok: false, error: 'No route from Google Directions', details: r.data, config });
    }

    const leg = r.data.routes[0].legs[0];
    const distanceMeters = leg.distance && leg.distance.value ? leg.distance.value : null;
    const durationSeconds = leg.duration && leg.duration.value ? leg.duration.value : null;

    if (distanceMeters === null || durationSeconds === null) {
      return res.status(500).json({ ok: false, error: 'No se obtuvo distancia/tiempo de Google', route: r.data.routes[0], config });
    }

    // calcular tarifa usando los valores obtenidos de Strapi (o defaults)
    const fareResult = calculateFareFromMetersSeconds(distanceMeters, durationSeconds, {
      baseFare: Number(config.baseFare),
      perKm: Number(config.perKm),
      perMin: Number(config.perMin),
      surge: Number(config.surge),
      minFare: Number(config.minFare),
      roundTo: Number(config.roundTo),
      ...fareOpts // permite override por request si hace falta
    });

    return res.json({
      ok: true,
      distanceMeters,
      durationSeconds,
      fare: fareResult.fare,
      breakdown: fareResult.breakdown,
      route: r.data.routes[0],
      configUsed: config
    });
  } catch (err) {
    console.error('calculate-fare error', err && err.message ? err.message : err);
    return res.status(500).json({ ok: false, error: err && err.message ? err.message : String(err) });
  }
});

module.exports = router;

/* ---------------------
   Helpers internos
   --------------------- */
function haversineMeters(a, b) {
  const toRad = v => (v * Math.PI) / 180;
  const R = 6371000; // m
  const dLat = toRad(b.lat - a.lat);
  const dLon = toRad(b.lng - a.lng);
  const lat1 = toRad(a.lat);
  const lat2 = toRad(b.lat);
  const sinDLat = Math.sin(dLat / 2);
  const sinDLon = Math.sin(dLon / 2);
  const h = sinDLat * sinDLat + Math.cos(lat1) * Math.cos(lat2) * sinDLon * sinDLon;
  const c = 2 * Math.atan2(Math.sqrt(h), Math.sqrt(1 - h));
  return R * c;
}
