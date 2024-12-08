import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import { VitePWA } from 'vite-plugin-pwa'; // Plugin PWA
import { fileURLToPath, URL } from 'node:url';

export default defineConfig({
  plugins: [
    vue(),
    VitePWA({
      registerType: 'autoUpdate',
      injectRegister: 'auto', // Inyección automática del código para registrar el service worker
      manifest: {
        name: 'Registros Médicos PWA',
        short_name: 'RM_PWA',
        description: 'PWA del hospital para registros médicos',
        start_url: '/',
        display: 'standalone', // El comportamiento de la PWA como una app independiente
        background_color: '#ffffff',
        theme_color: '#4DBA87', // Color de la barra de navegación en dispositivos móviles
        icons: [
          {
            src: '/img/icons/128x128.png', // Icono de 128x128px
            sizes: '128x128',
            type: 'image/png',
          },
          {
            src: '/img/icons/512x512.png', // Icono de 512x512px
            sizes: '512x512',
            type: 'image/png',
          },
          {
            src: '/img/icons/192x192.png', // Agrega un icono adicional de 192x192px
            sizes: '192x192',
            type: 'image/png',
          },
        ],
      },
      workbox: {
        runtimeCaching: [
          {
            // Caché para todos los archivos de la misma fuente
            urlPattern: ({ url }) => url.origin === self.location.origin,
            handler: 'CacheFirst', // Primer intento para obtener los archivos desde el caché
            options: {
              cacheName: 'assets-cache',
              expiration: {
                maxEntries: 50, // Limitar el número de elementos en el caché
                maxAgeSeconds: 30 * 24 * 60 * 60, // Mantener los archivos en caché durante 30 días
              },
            },
          },
          {
            // Caché para las peticiones a la API (modifica la URL según tu API)
            urlPattern: /^https:\/\/api\.mi-backend\.com\/.*/,
            handler: 'NetworkFirst', // Intentar obtener los datos de la red primero
            options: {
              cacheName: 'api-cache',
              expiration: {
                maxEntries: 50, // Limitar el número de elementos en el caché
                maxAgeSeconds: 7 * 24 * 60 * 60, // Mantener los datos de la API en caché durante 7 días
              },
            },
          },
        ],
      },
      // Si deseas personalizar el service worker, puedes hacerlo aquí
      serviceWorker: {
        src: '/service-worker.js', // Ruta personalizada si tienes un archivo service-worker.js
      },
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)), // Alias para resolver las rutas desde el directorio 'src'
    },
  },
});
