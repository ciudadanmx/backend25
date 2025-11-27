// routes/testTrip.js
const express = require('express');
const axios = require('axios');
const router = express.Router();
const { calculateFareFromMetersSeconds } = require('../lib/fareServer');

// constantes (más adelante vendrán de Strapi)
const STEP_METERS = 2000;
const DEFAULT_SPEED_M_S = 8.33; // ~30 km/h para estimar duración si no hay ruta

function roundToStep(meters, step) {
  if (!meters || !step) return meters || 0;
  return Math.round(meters / step) * step;
}

function haversineMeters(a, b) {
  const toRad = v => (v * Math.PI) / 180;
  const R = 6371000;
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

router.post('/send-trip', async (req, res) => {
  try {
    const io = req.app.get('io');
    if (!io) return res.status(500).json({ ok: false, error: 'Socket.io no disponible (io no seteado)' });

    const body = req.body || {};
    const payload = {
      id: body.id || `trip-${Date.now()}`,
      originCoordinates: body.originCoordinates || { lat: 19.432607, lng: -99.133209 },
      originAdress: body.originAdress || 'Zócalo, CDMX',
      destinationCoordinates: body.destinationCoordinates || body.destinationCoordinates || { lat: 19.4286, lng: -99.1276 },
      destinationAdress: body.destinationAdress || 'Av. Reforma 1',
      broadcast: body.broadcast === undefined ? true : Boolean(body.broadcast),
      driverId: body.driverId || null,
      candidateDrivers: Array.isArray(body.candidateDrivers) ? body.candidateDrivers : [],
      createdAt: new Date().toISOString(),
      userEmail: body.userEmail,
    };

    // Intentar llamar al endpoint de cálculo de tarifa (interno HTTP)
    const base = process.env.BASE_URL || `http://localhost:${process.env.PORT || 3033}`;
    const calcUrl = `${base.replace(/\/$/, '')}/calculataxi/calculate-fare`;

    let suggested = null;
    try {
      console.log(`[testTrip] Llamando a calculate-fare -> ${calcUrl}`);
      const calcResp = await axios.post(calcUrl, {
        origin: payload.originCoordinates,
        destination: payload.destinationCoordinates
      }, { timeout: 8000 });

      console.log('[testTrip] calculate-fare status:', calcResp.status);
      if (calcResp?.data?.ok) {
        suggested = {
          fare: calcResp.data.fare,
          fareFormatted: calcResp.data.fareFormatted || null,
          distanceMeters: calcResp.data.distanceMeters || null,
          durationSeconds: calcResp.data.durationSeconds || null,
        };
      } else {
        console.warn('[testTrip] calculate-fare no devolvió ok, body:', calcResp.data);
      }
    } catch (err) {
      // Log detallado para depuración (por ejemplo 405)
      const status = err?.response?.status;
      const bodyPreview = err?.response?.data ? JSON.stringify(err.response.data).slice(0, 2000) : err.message;
      console.warn(`[testTrip] fallo al consultar calculate-fare: status=${status} bodyPreview=${bodyPreview}`);
      // no rethrow: seguimos a fallback
    }

    // Si no hay suggested (falló la API), fallback con Haversine + fareServer
    if (!suggested) {
      try {
        const meters = haversineMeters(payload.originCoordinates, payload.destinationCoordinates);
        const duration = Math.max(60, Math.round(meters / DEFAULT_SPEED_M_S));
        const fareObj = calculateFareFromMetersSeconds(meters, duration, {
          baseFare: 9.19,
          perKm: 5.84,
          perMin: 1.95,
          surge: 1,
          minFare: 30,
          roundTo: 1
        });

        suggested = {
          fare: fareObj.fare,
          fareFormatted: null,
          distanceMeters: Math.round(meters),
          durationSeconds: duration,
        };
        console.log('[testTrip] fallback fare calculated', suggested);
      } catch (e) {
        console.error('[testTrip] fallback fallo:', e);
      }
    }

    // Redondeo de distancia al STEP_METERS
    const roundedDistanceMeters = suggested && suggested.distanceMeters ? roundToStep(suggested.distanceMeters, STEP_METERS) : STEP_METERS;

    // Añadimos campos al payload
    payload.suggestedPrice = suggested ? suggested.fare : null;
    payload.suggestedPriceFormatted = suggested ? suggested.fareFormatted : null;
    payload.distanceMeters = suggested ? suggested.distanceMeters : null;
    payload.durationSeconds = suggested ? suggested.durationSeconds : null;
    payload.roundedDistanceMeters = roundedDistanceMeters;
    payload.meta = payload.meta || {};
    payload.meta.suggested = {
      price: payload.suggestedPrice,
      priceFormatted: payload.suggestedPriceFormatted,
      roundedDistanceMeters
    };

    // Emitir evento 'trip-request' (broadcast)
    io.emit('trip-request', payload);

    return res.json({ ok: true, emittedTo: 'all', payload });
  } catch (err) {
    console.error('Error /test/send-trip', err);
    return res.status(500).json({ ok: false, error: err.message || String(err) });
  }
});

module.exports = router;
