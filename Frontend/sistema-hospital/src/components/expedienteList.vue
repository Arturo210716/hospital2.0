<template>
  <div class="min-h-screen bg-gray-100 py-8">
    <div class="container mx-auto">
      <!-- Mensaje -->
      <div v-if="message" class="text-center text-lg text-red-500 p-4 rounded mb-4">
      {{ message }}
    </div>

      <!-- Barra de búsqueda -->
      <div class="flex justify-center mb-6">
        <input
          type="text"
          v-model="textoBusqueda"
          @input="buscarExpedientes"
          placeholder="Buscar por Id del paciente..."
          class="w-4/5 md:w-2/3 lg:w-1/2 px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
        />
      </div>

      <!-- Tabla -->
      <div class="overflow-x-auto bg-white rounded-lg shadow-md">
        <table class="table-auto w-full text-sm text-left">
          <thead class="bg-teal-500 text-white">
            <tr>
              <th class="px-4 py-2">Id del Expediente</th>
              <th class="px-4 py-2">Id del Paciente</th>
              <th class="px-4 py-2">Hora de la Consulta</th>
              <th class="px-4 py-2">Diagnóstico</th>
              <th class="px-4 py-2">Tratamiento Relacionado</th>
              <th class="px-4 py-2">Observaciones</th>
              <th class="px-4 py-2">Estatus</th>
              <th class="px-4 py-2">Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(Expediente, index) in ExpedientesFiltrados"
              :key="index"
              class="border-b hover:bg-gray-100"
            >
              <td class="px-4 py-2">{{ Expediente.ID }}</td>
              <td class="px-4 py-2">{{ Expediente.Persona_ID }}</td>
              <td class="px-4 py-2">{{ Expediente.Hora_Consulta }}</td>
              <td class="px-4 py-2">{{ Expediente.Diagnostico }}</td>
              <td class="px-4 py-2">{{ Expediente.Tratamiento_Relacionado }}</td>
              <td class="px-4 py-2">{{ Expediente.Observaciones }}</td>
              <td class="px-4 py-2">{{ Expediente.Estatus }}</td>
              <td class="px-4 py-2 flex gap-2">
                <!-- Botón Eliminar -->
                <button
                  class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-700 focus:ring-2 focus:ring-red-300"
                  @click="eliminarExpediente(Expediente.ID)"
                >
                  Eliminar
                </button>

                <!-- Botón Editar -->
                <router-link
                  :to="{ name: 'editarE', params: { id: Expediente.ID } }"
                  class="bg-blue-500 text-white px-3 py-1 rounded-lg hover:bg-blue-700 focus:ring-2 focus:ring-blue-300"
                >
                  Editar
                </router-link>
              </td>
            </tr>
            <tr v-if="ExpedientesFiltrados.length === 0">
              <td colspan="8" class="px-4 py-6 text-center text-gray-500">
                No se encontraron expedientes.
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
        Expedientes: [], 
        message: '',
        paginaActual: 1,
        itemsPorPagina: 10,
        textoBusqueda: '', 
      };
    },
    computed: {
        ExpedientesFiltrados() {
        if (this.textoBusqueda.trim() === '') {
          return this.Expedientes;
        }
        const busqueda = this.textoBusqueda.toLowerCase();
        return this.Expedientes.filter(Expediente =>
          Expediente.ID.toLowerCase().includes(busqueda) ||
          Expediente.Persona_ID.toLowerCase().includes(busqueda) ||
          Expediente.Diagnostico.toLowerCase().includes(busqueda) ||
          Expediente.Hora_Consulta.toLowerCase().includes(busqueda)
        );
      }
    },
    mounted() {
      this.obtenerExpedientes();
    },
    methods: {
      obtenerExpedientes() {
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
        fetch(`https://backenhospital.onrender.com/expedienteAll/?skip=${this.paginaActual - 1}&limit=${this.itemsPorPagina}`,{
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Hubo un problema al obtener la lista de los Expedientes.');
          }
          return response.json();
        })
        .then(data => {
          console.log(data);  
          this.Expedientes = data;
        })
        .catch(error => {
          this.message = "Error: " + error.message;
        });
      },
      eliminarExpediente(ID) {
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
        fetch(`https://backenhospital.onrender.com/expedienteDelete/${ID}`, {
          method: 'DELETE',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Hubo un problema al eliminar el expediente.');
          }
          this.message = "¡Expediente eliminada exitosamente!";
          this.obtenerExpedientes();
          setTimeout(() => {
            this.message = '';
          }, 3000);
        })
        .catch(error => {
          this.message = "Error: " + error.message;
        });
      },
      buscarExpedientes() {}
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
  