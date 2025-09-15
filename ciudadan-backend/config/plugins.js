module.exports = {
  graphql: {
    enabled: true,
    config: {
      endpoint: "/graphql", // Endpoint para acceder a GraphQL
      playgroundAlways: true, // Habilita GraphQL Playground en producción
    },
  },
  'strapi-v5-http-only-auth': {
    enabled: true,
    config: {
      cookieOptions: {
        secure: process.env.NODE_ENV === 'production',
        maxAge: 30 * 24 * 60 * 60 * 1000, // 30 días
        sameSite: 'lax',
        domain: process.env.CLIENT_DOMAIN,
        path: '/',
      },
      deleteJwtFromResponse: true,
    },
  },
  'import-export-entries': {
    enabled: true,
  },
};
