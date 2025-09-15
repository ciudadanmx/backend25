'use strict';

// Importa tu middleware de autenticación
const authMiddleware = require('../../../middlewares/auth0jwt');

module.exports = {
  async estado(ctx) {
    // Logs iniciales para pruebas
    console.log('🔔 [mi-membresia] Controller estado iniciado');
    console.log('🔔 [mi-membresia] Headers Authorization:', ctx.request.headers.authorization);
    console.log('🔔 [mi-membresia] Cookies token:', ctx.cookies.get('token'));

    // Ejecuta el middleware para verificar token (por header o cookie)
    await authMiddleware({}, { strapi })(ctx, async () => {});
    console.log('🔔 [mi-membresia] Middleware ejecutado, ctx.state.user:', ctx.state.user);

    console.log('🔍 [mi-membresia] Entró a controller.estado');
    const user = ctx.state.user;
    if (!user) {
      console.log('⚠️ [mi-membresia] Usuario no autenticado');
      return ctx.unauthorized('No autenticado');
    }

    console.log(`🔍 [mi-membresia] Buscando membresía para user.id=${user.id}`);
    const membresia = await strapi.db.query('api::membresia.membresia').findOne({
      where: {
        usuario: user.id,
        fechaFin: { $gte: new Date() },
      },
      populate: ['usuario'],
      orderBy: { fechaFin: 'desc' },
    });

    if (!membresia) {
      console.log('ℹ️ [mi-membresia] No hay membresía activa');
      return ctx.send({ activo: false });
    }

    console.log('✅ [mi-membresia] Se encontró membresía activa:', membresia);
    return ctx.send({
      activo: true,
      tipo: membresia.tipo,
      fechaInicio: membresia.fechaInicio,
      fechaFin: membresia.fechaFin,
      usuario: {
        id: membresia.usuario.id,
        email: membresia.usuario.email,
      },
    });
  },
};
