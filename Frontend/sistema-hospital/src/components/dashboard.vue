<template>
    <div>
      <!-- Header -->
      <header class="bg-blue-50 dark:bg-gray-800 p-4">
        <div class="flex justify-between items-center">
          <!-- Logo or Brand -->
          <div class="text-xl font-bold text-gray-900 dark:text-white">
            <span>Hospital Registros</span>
          </div>
  
          <!-- Button to toggle sidebar on mobile -->
          <button
            @click="toggleSidebar"
            type="button"
            class="sm:hidden inline-flex items-center p-2 text-sm text-gray-500 rounded-lg hover:bg-blue-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
          >
            <span class="sr-only">Open sidebar</span>
            <svg
              class="w-6 h-6"
              aria-hidden="true"
              fill="currentColor"
              viewBox="0 0 20 20"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                clip-rule="evenodd"
                fill-rule="evenodd"
                d="M2 4.75A.75.75 0 012.75 4h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 4.75zm0 10.5a.75.75 0 01.75-.75h7.5a.75.75 0 010 1.5h-7.5a.75.75 0 01-.75-.75zM2 10a.75.75 0 01.75-.75h14.5a.75.75 0 010 1.5H2.75A.75.75 0 012 10z"
              ></path>
            </svg>
          </button>
          
          <!-- Main Navigation for larger screens -->
          <nav class="hidden sm:flex space-x-4">
            <router-link to="/registros-medicos" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 px-3 py-2 rounded-md">
              Registros Médicos
            </router-link>
            <router-link to="/graficas" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 px-3 py-2 rounded-md">
              Gráficas
            </router-link>
            <router-link to="/citas" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 px-3 py-2 rounded-md">
              Citas
            </router-link>
            <router-link to="/expediente" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 px-3 py-2 rounded-md">
              Expediente
            </router-link>
            <router-link to="/receta" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 px-3 py-2 rounded-md">
              Receta
            </router-link>
            <router-link to="/" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 px-3 py-2 rounded-md">
              Cerrar Sesión
            </router-link>
          </nav>
        </div>
      </header>
  
      <!-- Sidebar for mobile -->
      <aside
        v-if="isSidebarOpen"
        class="fixed top-0 left-0 z-40 w-64 h-screen bg-blue-50 dark:bg-gray-800 sm:hidden"
        aria-label="Sidebar"
      >
        <div class="h-full px-3 py-4 overflow-y-auto">
          <ul class="space-y-2 font-medium">
            <li>
              <router-link to="/graficas" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 p-2 rounded-lg">
                Gráficas
              </router-link>
            </li>
            <li>
              <router-link to="/citas" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 p-2 rounded-lg">
                Citas
              </router-link>
            </li>
            <li>
              <router-link to="/expediente" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 p-2 rounded-lg">
                Expediente
              </router-link>
            </li>
            <li>
              <router-link to="/receta" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 p-2 rounded-lg">
                Receta
              </router-link>
            </li>
            <li>
              <router-link to="/" class="text-gray-900 dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 p-2 rounded-lg">
                Cerrar Sesión
              </router-link>
            </li>
          </ul>
        </div>
      </aside>
  
      <!-- Main Content -->
      <div class="p-4 sm:ml-64">
        <router-view />
      </div>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        isSidebarOpen: false,
      };
    },
    methods: {
      toggleSidebar() {
        this.isSidebarOpen = !this.isSidebarOpen;
      },
    },
  };
  </script>
  
  <style scoped>
  /* Mobile Sidebar */
  .sm\:hidden {
    display: none;
  }
  
  /* Adjustments for responsiveness */
  @media (max-width: 640px) {
    .sm\:hidden {
      display: block;
    }
    nav {
      display: none;
    }
    header {
      position: relative;
    }
    aside {
      display: block;
    }
  }
  </style>
  