import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import { VitePWA } from 'vite-plugin-pwa'; // Plugin PWA
import { fileURLToPath, URL } from 'node:url';

export default defineConfig({
  plugins: [
    vue(),
    VitePWA({
      registerType: 'autoUpdate',
      injectRegister: 'auto',
      manifest: {
        name: 'Registros Médicos PWA',
        short_name: 'RM_PWA',
        description: 'PWA del hospital para registros médicos',
        start_url: '/',
        display: 'standalone',
        background_color: '#ffffff',
        theme_color: '#4DBA87',
        icons: [
          {
            src: '/img/icons/128x128.png',
            sizes: '128x128',
            type: 'image/png',
          },
          {
            src: '/img/icons/512x512.png',
            sizes: '512x512',
            type: 'image/png',
          },
          {
            src: '/img/icons/192x192.png',
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
            urlPattern: /^https:\/\/backenhospital\.onrender\.com\/.*/,
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
      serviceWorker: {
        src: '/service-worker.js', 
      },
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)), // Alias para resolver las rutas desde el directorio 'src'
    },
  },
});
