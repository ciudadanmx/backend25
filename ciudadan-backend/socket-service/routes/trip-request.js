// routes/trip-request.js
const express = require('express');
const router = express.Router();

// POST /trip-request
router.post('/trip-request', async (req, res) => {
  try {
    console.log('taxi debug (server): /trip-request recibido - body:', JSON.stringify(req.body));

    const { driverId, message } = req.body;
    if (!driverId || !message) {
      console.log('taxi debug (server): falta driverId o message en body');
      return res.status(400).json({ error: 'Faltan driverId o message' });
    }

    const io = req.app.get('io');
    if (!io) {
      console.warn('taxi debug (server): io NO disponible en req.app.get("io")');
      return res.status(500).json({ error: 'socket server not available' });
    }

    // ==========================
    //  **AQUÍ ES LO ÚNICO NUEVO**
    // ==========================

    // generar travelId en el backend
    const travelId = `travel_${Date.now()}_${Math.floor(Math.random() * 9999)}`;

    // clonar el payload original agregando travelId
    const payload = {
      ...req.body,
      travelId
    };

    // ==========================
    //  FIN DE CAMBIO
    // ==========================

    // emit a una room específica si driverId es una room (opcional)
    try {
      io.to(driverId).emit('trip-request', payload); // <--- ahora envía también travelId
      console.log(`taxi debug (server): emit a room ${driverId} -> trip-request`);
    } catch (e) {
      console.warn('taxi debug (server): fallo emitiendo a room, continuar con emit global', e);
    }

    // Emit global adicional (asegura que cualquier conductor conectado lo reciba para debug)
    io.emit('trip-request', payload); // <--- igual, con travelId
    console.log('taxi debug (server): emit global -> trip-request');

    return res.status(200).json({
      message: 'Mensaje enviado al conductor',
      travelId // opcional: se lo regresamos al cliente HTTP
    });
  } catch (error) {
    console.error('taxi debug (server): Error en /trip-request', error);
    return res.status(500).json({ error: 'Hubo un problema al enviar el mensaje' });
  }
});

module.exports = router;
