const path = require("path");
require("dotenv").config({ path: path.resolve(__dirname, "../.env") });

const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const cors = require("cors"); // ✅ IMPORTANTE

const app = express();
const server = http.createServer(app);

//const accept = process.env.CORS_ORIGIN || "http://localhost:33422"; // frontend por defecto
const accept = ["http://localhost:3000", "http://localhost"]; // frontend por defecto
//const PORT = process.env.SOCKET_PORT || 33034;
//const PORT =  33034;
const PORT = 3033;

// ✅ Configurar CORS para Express (antes de registrar rutas)
app.use(
  cors({
    origin: accept,
    methods: ["GET", "POST"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

// ✅ Configurar WebSocket con CORS
const io = socketIo(server, {
  cors: {
    origin: accept,
    methods: ["GET", "POST"],
  },
});

// Guardar `io` en `app` para usar en rutas
app.set("io", io);

// Middleware para parsear JSON
app.use(express.json());

// 🔹 Importar rutas existentes
const priceCalculatingRoute = require("./routes/priceCalculating");
const sendMessageRoute = require("./routes/trip-request");
const wikiRoute = require("./routes/wiki"); // Notion wiki
const notificaRoute = require("./routes/notifica"); // Notion wiki
//const openpayRoute = require("./routes/openpay");

// 🔹 Registrar rutas
app.use("/", priceCalculatingRoute);
app.use("/", sendMessageRoute);
app.use("/wiki", wikiRoute); // ✅ acceso desde /wiki/:id
app.use("/notifica", notificaRoute); // ✅ acceso desde /wiki/:id
let openpayRoute;
try {
  openpayRoute = require("./routes/openpay");
} catch (err) {
  console.error("❌ Error cargando ./routes/openpay:", err);
}
if (openpayRoute) app.use("/api", openpayRoute);

console.log("🔎 Rutas registradas:");
app._router.stack.forEach((middleware) => {
  if (middleware.route) {
    // middleware.route.path — rutas directas
    const methods = Object.keys(middleware.route.methods).join(",").toUpperCase();
    console.log(`${methods} ${middleware.route.path}`);
  } else if (middleware.name === "router" && middleware.handle && middleware.regexp) {
    // mount point de un router
    console.log(`-- router montado:`, middleware.regexp);
  }
});

// Manejo de WebSocket
io.on("connection", (socket) => {
  console.log("✅ Cliente conectado a WebSocket:", socket.id);

  // Permite al cliente registrarse en una "room" con su email:
  // cliente -> socket.emit('register', { email: 'user@example.com' })
  socket.on('register', (data) => {
    try {
      const email = (data && data.email) ? String(data.email) : null;
      if (email) {
        socket.join(email);
        console.debug(`Socket ${socket.id} se unió a room: ${email}`);
      }
    } catch (err) {
      console.error('Error en register:', err);
    }
  });

  socket.on("speakTTS", (message) => {
    console.log("📢 Servidor recibió 'speakTTS' con mensaje:", message);
    io.emit("speakTTS", message);
  });

  socket.on("disconnect", () => {
    console.log("❌ Cliente desconectado:", socket.id);
  });
});

// Iniciar servidor
server.listen(PORT, () => {
  console.log(`🚀 Servidor escuchando en el puerto ${PORT}`);
  console.log(`🌐 CORS habilitado para: ${accept}`);
});
