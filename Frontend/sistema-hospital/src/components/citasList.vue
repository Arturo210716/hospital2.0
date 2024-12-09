<template>
  <div class="min-h-screen bg-gray-100 py-8">
    <div class="container mx-auto">
      <!-- Mensaje de acción -->
      <div v-if="message" class="text-center text-lg text-red-500 p-4 rounded mb-4">
      {{ message }}
    </div>

      <!-- Barra de búsqueda -->
      <div class="flex justify-center mb-6">
        <input 
          type="text" 
          v-model="textoBusqueda" 
          @input="buscarCitas"
          placeholder="Buscar por ID del paciente..." 
          class="w-3/4 md:w-1/2 px-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-teal-500"
        />
      </div>

      <!-- Tabla -->
      <div class="overflow-x-auto">
        <table class="w-full border-collapse bg-white rounded-lg shadow-lg">
          <thead>
            <tr class="bg-teal-500 text-white">
              <th class="px-4 py-2">ID de la Cita</th>
              <th class="px-4 py-2">ID del Paciente</th>
              <th class="px-4 py-2">Hora de la Cita</th>
              <th class="px-4 py-2">Teléfono</th>
              <th class="px-4 py-2">Correo Electrónico</th>
              <th class="px-4 py-2">Motivo</th>
              <th class="px-4 py-2">Estatus</th>
              <th class="px-4 py-2">Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="(Cita, index) in CitasFiltrados" 
              :key="index" 
              class="hover:bg-gray-100"
            >
              <td class="px-4 py-2 text-center">{{ Cita.ID }}</td>
              <td class="px-4 py-2 text-center">{{ Cita.Persona_ID }}</td>
              <td class="px-4 py-2 text-center">{{ Cita.Hora_Cita }}</td>
              <td class="px-4 py-2 text-center">{{ Cita.Telefono }}</td>
              <td class="px-4 py-2 text-center">{{ Cita.Correo_Electronico }}</td>
              <td class="px-4 py-2 text-center">{{ Cita.Motivo_Cita }}</td>
              <td class="px-4 py-2 text-center">
                <span 
                  :class="{
                    'text-green-500': Cita.Estatus === 'Activo',
                    'text-yellow-500': Cita.Estatus === 'Suspendido',
                    'text-red-500': Cita.Estatus === 'Bloqueado'
                  }"
                >
                  {{ Cita.Estatus }}
                </span>
              </td>
              <td class="px-4 py-2 text-center">
                <!-- Botón Eliminar -->
                <button 
                  class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600 mr-2"
                  @click="eliminarCita(Cita.ID)"
                >
                  Eliminar
                </button>
                <!-- Botón Editar -->
                <router-link :to="{ name: 'editar', params: { id: Cita.ID } }">
                  <button 
                    class="bg-blue-500 text-white px-3 py-1 rounded-lg hover:bg-blue-600"
                  >
                    Editar
                  </button>
                </router-link>
              </td>
            </tr>
            <tr v-if="CitasFiltrados.length === 0">
              <td colspan="8" class="px-4 py-4 text-center text-gray-500">
                No se encontraron citas.
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
  
  <script>
  /* eslint-disable */
  export default {
    data() {
      return {
        Citas: [], 
        message: '',
        paginaActual: 1,
        itemsPorPagina: 10,
        textoBusqueda: '', 
      };
    },
    computed: {
      CitasFiltrados() {
        if (this.textoBusqueda.trim() === '') {
          return this.Citas;
        }
        const busqueda = this.textoBusqueda.toLowerCase();
        return this.Citas.filter(Cita =>
          Cita.ID.toLowerCase().includes(busqueda) ||
          Cita.Persona_ID.toLowerCase().includes(busqueda) ||
          Cita.Telefono.toLowerCase().includes(busqueda) ||
          Cita.Correo_Electronico.toLowerCase().includes(busqueda)
        );
      }
    },
    mounted() {
      this.obtenerCitas();
    },
    methods: {
      obtenerCitas() {
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
        fetch(`https://backenhospital.onrender.com/citaAll/?skip=${this.paginaActual - 1}&limit=${this.itemsPorPagina}`,{
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Hubo un problema al obtener la lista de las citas.');
          }
          return response.json();
        })
        .then(data => {
          console.log(data);  
          this.Citas = data;
        })
        .catch(error => {
          this.message = "Error: " + error.message;
        });
      },
      eliminarCita(ID) {
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
        fetch(`https://backenhospital.onrender.com/citaDelete/${ID}`, {
          method: 'DELETE',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Hubo un problema al eliminar la cita.');
          }
          this.message = "¡Cita eliminada exitosamente!";
          this.obtenerCitas();
          setTimeout(() => {
            this.message = '';
          }, 3000);
        })
        .catch(error => {
          this.message = "Error: " + error.message;
        });
      },
      buscarCitas() {}
    }
  }
  </script>
  
  <style scoped>
  .tabla1 {
    width: 100%;
    align-items: center;
    justify-content: center;
    display: flex;
    border-collapse: collapse;
  }
  
  .router-link-custom {
    text-decoration: none;
    color: inherit;
  }
  
  th, td {
    border: 1px solid #1fbcfa;
    padding: 10px;
    text-align: left;
  }
  
  th {
    background-color: #246ab9;
  }
  
  .botonEliminar {
    background-color: #e9351d;
    color: white;
    border: none;
    padding: 8px 12px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    border-radius: 4px;
  }
  
  .botonEliminar:hover {
    background-color: #fc5858;
  }
  
  .botonEditar {
    background-color: #faab00;
    color: white;
    border: none;
    padding: 8px 12px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    border-radius: 4px;
  }
  
  .botonEditar:hover {
    background-color: #ffb546;
  }


  .fas.fa-trash-alt {
    margin-right: 5px;
  }
  </style>
  