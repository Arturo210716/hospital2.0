import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const app = express();
const port = process.env.PORT || 3000;

// Obtener la ruta del directorio actual
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Configura la carpeta estática para servir los archivos de Vue.js
app.use(express.static(path.join(__dirname, 'dist')));

// Maneja todas las demás rutas enviando el archivo index.html
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Servidor corriendo en http://192.168.0.107:${port}`);
});
