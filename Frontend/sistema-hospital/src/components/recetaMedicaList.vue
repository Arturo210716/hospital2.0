<template>
  <div>
    <!-- Mensaje Condicional -->
    <div v-if="message" class="text-center text-lg text-red-500 mt-4">
      {{ message }}
    </div>

    <div class="container text-center">
      <!-- Barra de búsqueda -->
      <div style="margin-bottom: 10px;">
        <input 
          type="text" 
          v-model="textoBusqueda" 
          @input="buscarRecetas"
          placeholder="Buscar recetas..."
          class="w-4/5 md:w-1/2 py-2 px-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-teal-500"
        />
      </div>
    </div>

    <br>

    <!-- Tabla de Recetas -->
    <div class="tabla1 overflow-x-auto">
      <table class="table-auto w-full text-left border-collapse">
        <thead>
          <tr class="bg-teal-500 text-white">
            <th class="px-4 py-2">Id de Receta</th>
            <th class="px-4 py-2">Nombre</th>
            <th class="px-4 py-2">Fecha de Nacimiento</th>
            <th class="px-4 py-2">Peso</th>
            <th class="px-4 py-2">Talla</th>
            <th class="px-4 py-2">Edad</th>
            <th class="px-4 py-2">Presión Arterial</th>
            <th class="px-4 py-2">Diagnóstico</th>
            <th class="px-4 py-2">Prescripción Médica</th>
            <th class="px-4 py-2">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(Receta, index) in RecetasFiltrados" :key="Receta.ID">
            <td class="px-4 py-2">{{ Receta.ID }}</td>
            <td class="px-4 py-2">{{ Receta.Nombre }}</td>
            <td class="px-4 py-2">{{ Receta.Fecha_Nacimiento }}</td>
            <td class="px-4 py-2">{{ Receta.Peso }}</td>
            <td class="px-4 py-2">{{ Receta.Talla }}</td>
            <td class="px-4 py-2">{{ Receta.Edad }}</td>
            <td class="px-4 py-2">{{ Receta.Presion_arterial }}</td>
            <td class="px-4 py-2">{{ Receta.Diagnostico }}</td>
            <td class="px-4 py-2">{{ Receta.Prescripcion_Medica }}</td>
            <td class="px-4 py-2">
              <!-- Botones de acción -->
              <div class="flex flex-col sm:flex-row sm:space-x-2">
                <button 
                  class="mt-2 bg-red-500 text-white px-4 py-2 rounded-lg hover:bg-red-700"
                  @click="eliminarReceta(Receta.ID)"
                >
                  Eliminar
                </button>
                <router-link :to="{ name: 'editarR', params: { id: Receta.ID } }">
                  <button class="mt-2 bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700">
                    Editar
                  </button>
                </router-link>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

  <script>
  /* eslint-disable */
  export default {
    data() {
      return {
        Recetas: [], 
        message: '',
        paginaActual: 1,
        itemsPorPagina: 10,
        textoBusqueda: '', 
      };
    },
    computed: {
        RecetasFiltrados() {
        if (this.textoBusqueda.trim() === '') {
          return this.Recetas;
        }
        const busqueda = this.textoBusqueda.toLowerCase();
        return this.Recetas.filter(Receta =>
            Receta.ID.toLowerCase().includes(busqueda) ||
            Receta.Nombre.toLowerCase().includes(busqueda) ||
            Receta.Diagnostico.toLowerCase().includes(busqueda) ||
            Receta.Fecha_Nacimiento.toLowerCase().includes(busqueda)
        );
      }
    },
    mounted() {
      this.obtenerRecetas();
    },
    methods: {
        obtenerRecetas() {
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
        fetch(`https://backenhospital.onrender.com/recetaAll/?skip=${this.paginaActual - 1}&limit=${this.itemsPorPagina}`,{
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Hubo un problema al obtener la lista de las recetas.');
          }
          return response.json();
        })
        .then(data => {
          console.log(data);  
          this.Recetas = data;
        })
        .catch(error => {
          this.message = "Error: " + error.message;
        });
      },
      eliminarReceta(ID) {
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
        fetch(`https://backenhospital.onrender.com/recetaDelete/${ID}`, {
          method: 'DELETE',
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          if (!response.ok) {
            throw new Error('Hubo un problema al eliminar la receta.');
          }
          this.message = "¡Receta eliminada exitosamente!";
          this.obtenerRecetas();
          setTimeout(() => {
            this.message = '';
          }, 3000);
        })
        .catch(error => {
          this.message = "Error: " + error.message;
        });
      },
      buscarRecetas() {}
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
  