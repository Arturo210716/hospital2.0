import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:8000', // Cambia esto a la URL de tu API
  headers: {
    'Content-Type': 'application/json',
    // Añade más cabeceras si es necesario
  },
});

export default api;
