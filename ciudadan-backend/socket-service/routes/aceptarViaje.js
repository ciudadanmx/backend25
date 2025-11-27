// routes/aceptarViaje.js
const express = require('express');
const router = express.Router();
const axios = require('axios');
const { v4: uuidv4 } = require('uuid');

const STRAPI_URL = (process.env.STRAPI_URL || '').replace(/\/$/, '');
const STRAPI_TOKEN = process.env.STRAPI_TOKEN || null;

// Helper: construir headers para Strapi
const buildStrapiHeaders = () => {
  const headers = { 'Content-Type': 'application/json' };
  if (STRAPI_TOKEN) headers['Authorization'] = `Bearer ${STRAPI_TOKEN}`;
  return headers;
};

// POST /api/aceptar-viaje
// Body esperado (ejemplo):
// {
//   "userEmail": "pasajero@example.com",
//   "origencoords": { "lat": 19.43, "lng": -99.13 },
//   "destinocoords": { "lat": 19.44, "lng": -99.14 },
//   "conductorcoords": { "lat": 19.43, "lng": -99.13 },
//   "origendireccion": { "label": "Calle X 123", "street": "Calle X", "city": "CDMX" },
//   "destinodireccion": { "label": "Calle Y 456", "street": "Calle Y", "city": "CDMX" },
//   "solicitado": "2025-11-26T21:00:00.000Z",
//   "travelid": "opcional-si-ya-tienes-uno",
//   "observaciones": "algo opcional",
//   "costo": 120
// }
router.post('/aceptar-viaje', async (req, res) => {
  try {
    const {
      userEmail,
      origencoords,
      destinocoords,
      conductorcoords,
      origendireccion,
      destinodireccion,
      solicitado,
      travelid,
      observaciones,
      costo,
      pagadoefectivo,
      pagadolabory,
    } = req.body || {};

    // validar lo mínimo
    if (!userEmail) {
      return res.status(400).json({ ok: false, error: 'userEmail (pasajeromail) es requerido' });
    }
    // Generar travelid si no viene
    const travelIdToUse = travelid || uuidv4();

    // preparar el objeto data para Strapi (ajusta nombres de campo si tu content-type tiene otro slug)
    const data = {
      origencoords: origencoords || null,
      destinocoords: destinocoords || null,
      conductorcoords: conductorcoords || null,
      origendireccion: origendireccion || null,
      destinodireccion: destinodireccion || null,
      pasajeromail: userEmail,
      conductormail: null,
      solicitado: solicitado || new Date().toISOString(),
      iniciado: null,
      concluido: null,
      travelid: String(travelIdToUse),
      observaciones: observaciones || '',
      costo: typeof costo === 'number' ? costo : null,
      pagadoefectivo: typeof pagadoefectivo === 'number' ? pagadoefectivo : 0,
      pagadolabory: typeof pagadolabory === 'number' ? pagadolabory : 0,
      calificacionconductor: null,
      calificacionpasajero: null,
      track: null,
      status: 'iniciando',
      // pasajero / conductor relations no las llenamos aquí (si luego quieres, agrégalos con sus IDs)
    };

    if (!STRAPI_URL) {
      return res.status(500).json({ ok: false, error: 'STRAPI_URL no configurada en .env' });
    }

    // POST a Strapi
    const endpoint = `${STRAPI_URL}/api/viajes`; // asumo collection 'viajes'
    const resp = await axios.post(
      endpoint,
      { data },
      { headers: buildStrapiHeaders(), timeout: 10000 }
    );

    // resp.data debe tener la estructura de Strapi v4: { data: { id, attributes: {...} } }
    const created = resp.data && resp.data.data ? resp.data.data : null;

    // Emitir por socket usando io que está en app (server.js hizo app.set('io', io))
    try {
      const io = req.app && req.app.get && req.app.get('io');
      const payloadToEmit = {
        travelId: String(travelIdToUse),
        // opcionales, puedes enviar también el id de strapi si lo quieres:
        strapiId: created ? created.id : null,
        timestamp: new Date().toISOString(),
      };
      if (io && typeof io.emit === 'function') {
        io.emit('viajeAceptado', payloadToEmit);
      } else {
        // Si por alguna razón no hay io (no está montado en app), intentamos un log y continuamos
        console.warn('[aceptar-viaje] io no disponible en req.app; no se emitió viajeAceptado');
      }
    } catch (emitErr) {
      console.warn('[aceptar-viaje] error emitiendo viajeAceptado:', emitErr);
      // no abortamos la respuesta por fallas de socket
    }

    return res.status(201).json({ ok: true, created, travelId: travelIdToUse });
  } catch (err) {
    console.error('[aceptar-viaje] error:', err && (err.stack || err.message || err));
    const message = err.response && err.response.data ? err.response.data : (err.message || String(err));
    return res.status(500).json({ ok: false, error: message });
  }
});

module.exports = router;
