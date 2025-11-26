// routes/testTrip.js
const express = require('express');
const router = express.Router();

/**
 * POST /test/send-trip
 * Body (JSON) opcional:
 * {
 *   "broadcast": true,              // si true envía a todos
 *   "driverId": "correo@ejemplo",  // opcional: driverId objetivo (no hace room logic aquí, sólo lo incluye en payload)
 *   "candidateDrivers": ["a@a","b@b"], // opcional
 *   "originCoordinates": { "lat": 19.432607, "lng": -99.133209 },
 *   "originAdress": "Zócalo, CDMX",
 *   "destinationAdress": "Av. Reforma 1",
 *   "id": "trip-test-1"
 * }
 */
router.post('/send-trip', (req, res) => {
  try {
    const io = req.app.get('io');
    if (!io) return res.status(500).json({ ok: false, error: 'Socket.io no disponible (io no seteado)' });

    const body = req.body || {};
    // payload por defecto si no mandas nada
    const payload = {
      id: body.id || `trip-${Date.now()}`,
      originCoordinates: body.originCoordinates || { lat: 19.432607, lng: -99.133209 },
      originAdress: body.originAdress || 'Zócalo, CDMX',
      destinationAdress: body.destinationAdress || 'Av. Reforma 1',
      broadcast: body.broadcast === undefined ? true : Boolean(body.broadcast),
      driverId: body.driverId || null,
      candidateDrivers: Array.isArray(body.candidateDrivers) ? body.candidateDrivers : [],
      createdAt: new Date().toISOString(),
      // agrega más campos que tu Conductor espere si hace falta
    };

    // Emite a todos (broadcast). Si quieres lógica por room/email, puedes cambiar aquí.
    io.emit('trip-request', payload);

    return res.json({ ok: true, emittedTo: 'all', payload });
  } catch (err) {
    console.error('Error /test/send-trip', err);
    return res.status(500).json({ ok: false, error: err.message });
  }
});

module.exports = router;
