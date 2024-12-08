<template>
    <button
      @click="toggleSidebar"
      aria-controls="sidebar-multi-level-sidebar"
      type="button"
      class="inline-flex items-center p-2 mt-2 ms-3 text-sm text-gray-500 rounded-lg sm:hidden hover:bg-blue-100 focus:outline-none focus:ring-2 focus:ring-gray-200 dark:text-gray-400 dark:hover:bg-gray-700 dark:focus:ring-gray-600"
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
  
    <!-- Sidebar -->
    <aside
      id="sidebar-multi-level-sidebar"
      :class="{'translate-x-0': isSidebarOpen, '-translate-x-full': !isSidebarOpen}"
      class="fixed top-0 left-0 z-40 w-64 h-screen transition-transform sm:translate-x-0"
      aria-label="Sidebar"
    >
      <div class="h-full px-3 py-4 overflow-y-auto bg-blue-50 dark:bg-gray-800">
        <ul class="space-y-2 font-medium">
          <!-- Menu items -->
          <li>
            <a
              href="#"
              class="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 group"
            >
              <span class="material-symbols-outlined">clinical_notes</span>
              <span class="ms-3">Registros Medicos</span>
            </a>
          </li>
          <li>
            <button
              type="button"
              class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-blue-100 dark:text-white dark:hover:bg-gray-700"
              aria-controls="dropdown-example3"
              data-collapse-toggle="dropdown-example3"
            >
              <span class="material-symbols-outlined">insert_chart</span>
              <router-link to="/graficas">
                <a
                  href="#"
                  class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap"
                  >Graficas</a
                >
              </router-link>
            </button>
          </li>
          <li>
            <button
              type="button"
              class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-blue-100 dark:text-white dark:hover:bg-gray-700"
              aria-controls="dropdown-example3"
              data-collapse-toggle="dropdown-example3"
            >
              <span class="material-symbols-outlined">calendar_month</span>
              <router-link to="/citas">
                <a
                  href="#"
                  class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap"
                  >Citas</a
                >
              </router-link>
            </button>
          </li>
          <li>
            <button
              type="button"
              class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-blue-100 dark:text-white dark:hover:bg-gray-700"
              aria-controls="dropdown-example3"
              data-collapse-toggle="dropdown-example3"
            >
              <span class="material-symbols-outlined">folder_open</span>
              <router-link to="/expediente">
                <a
                  href="#"
                  class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap"
                  >Expediente</a
                >
              </router-link>
            </button>
          </li>
          <li>
            <button
              type="button"
              class="flex items-center w-full p-2 text-base text-gray-900 transition duration-75 rounded-lg group hover:bg-blue-100 dark:text-white dark:hover:bg-gray-700"
              aria-controls="dropdown-example3"
              data-collapse-toggle="dropdown-example3"
            >
              <span class="material-symbols-outlined">prescriptions</span>
              <router-link to="/receta">
                <a
                  href="#"
                  class="flex-1 ms-3 text-left rtl:text-right whitespace-nowrap"
                  >Receta</a
                >
              </router-link>
            </button>
          </li>
          <li>
            <router-link to="/">
              <a
                href="#"
                class="flex items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-blue-100 dark:hover:bg-gray-700 group"
              >
                <span class="material-symbols-outlined">logout</span>
                <span class="flex-1 ms-3 whitespace-nowrap">Cerrar Sesion</span>
              </a>
            </router-link>
          </li>
        </ul>
      </div>
    </aside>
  
    <!-- Main Content -->
    <div class="p-4 sm:ml-64">
      <router-view />
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
      
      closeSidebarIfOutsideClick(event) {
        const sidebar = document.getElementById('sidebar-multi-level-sidebar');
        if (!sidebar.contains(event.target) && this.isSidebarOpen) {
          this.isSidebarOpen = false;
        }
      },
    },
    mounted() {
      document.addEventListener("click", this.closeSidebarIfOutsideClick);
    },
    beforeUnmount() {
      document.removeEventListener("click", this.closeSidebarIfOutsideClick);
    },
  };
  </script>
  