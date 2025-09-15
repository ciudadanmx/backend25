module.exports = {
  routes: [
    {
      method: 'GET',
      path: '/mi-membresia',
      handler: 'mimembresia.estado',
      config: {
        // Aquí llamas tu middleware antes del controller
        middlewares: ['global::auth0jwt'],
        auth: false  // ya lo maneja el middleware
      },
    },
  ],
};
