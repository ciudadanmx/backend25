// server.js (reemplaza tu archivo con esto)
const path = require("path");
require("dotenv").config({ path: path.resolve(__dirname, "../.env") });

const express = require("express");
const http = require("http");
const socketIo = require("socket.io");
const cors = require("cors"); // ✅ IMPORTANTE

const app = express();
const server = http.createServer(app);

// Añadí localhost:33422 al array de orígenes permitidos
const accept = [
  "http://localhost:3000",
  "http://localhost",
  "http://localhost:33422" // <-- agregado para tu frontend dev
];
const PORT = 3033;

// ✅ Configurar CORS para Express (antes de registrar rutas)
app.use(
  cors({
    origin: accept,
    methods: ["GET", "POST", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization", "X-Requested-With", "Accept", "Origin"],
    credentials: true,
    optionsSuccessStatus: 200
  })
);

// ✅ Configurar WebSocket con CORS (Socket.IO)
const io = socketIo(server, {
  cors: {
    origin: accept,
    methods: ["GET", "POST", "OPTIONS"],
    credentials: true
  },
  // path: '/socket.io', // descomenta si usas path custom
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
const testTrip = require('./routes/testTrip');
const calculateFare = require('./routes/calculateFare');
let openpayRoute;
try {
  openpayRoute = require("./routes/openpay");
} catch (err) {
  console.error("❌ Error cargando ./routes/openpay:", err);
}
if (openpayRoute) app.use("/api", openpayRoute);

// 🔹 Registrar rutas
app.use("/", priceCalculatingRoute);
app.use("/", sendMessageRoute);
app.use("/wiki", wikiRoute);
app.use("/notifica", notificaRoute);
app.use('/test', testTrip);
app.use('/api', calculateFare);

console.log("🔎 Rutas registradas:");
app._router.stack.forEach((middleware) => {
  if (middleware.route) {
    const methods = Object.keys(middleware.route.methods).join(",").toUpperCase();
    console.log(`${methods} ${middleware.route.path}`);
  } else if (middleware.name === "router" && middleware.handle && middleware.regexp) {
    console.log(`-- router montado:`, middleware.regexp);
  }
});

// Manejo de WebSocket
io.on("connection", (socket) => {
  console.log("✅ Cliente conectado a WebSocket:", socket.id);

  // Permite al cliente registrarse en una "room" con su email:
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
  console.log(`🌐 CORS habilitado para: ${JSON.stringify(accept)}`);
});
