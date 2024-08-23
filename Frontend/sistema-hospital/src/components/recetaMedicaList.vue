<template>
    <div>
      <div v-if="message" style="margin-top: 10px;">
        {{ message }}
      </div>
  
      <div class="container text-center">
        <!-- Barra de búsqueda -->
        <div style="margin-bottom: 10px;">
          <input 
            type="text" 
            v-model="textoBusqueda" 
            @input="buscarRecetas"
            placeholder="Buscar..."
            style="width: 80%; padding: 8px; border-radius: 4px; border: 1px solid #ddd;">
        </div>
      </div>
      <br>
  
      <div class="tabla1">
        <table>
          <thead>
            <tr>
              <th>Id de Receta</th>
              <th>Nombre</th>
              <th>Fecha de nacimiento</th>
              <th>Peso</th>
              <th>Talla</th>
              <th>Edad</th>
              <th>Presion arterial</th>
              <th>Diagnostico</th>
              <th>Prescripcion_Medica</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(Receta, index) in RecetasFiltrados" :key="index">
              <td>{{ Receta.ID }}</td>
              <td>{{ Receta.Nombre }}</td>
              <td>{{ Receta.Fecha_Nacimiento }}</td>
              <td>{{ Receta.Peso }}</td>
              <td>{{ Receta.Talla }}</td>
              <td>{{ Receta.Edad }}</td>
              <td>{{ Receta.Presion_arterial }}</td>
              <td>{{ Receta.Diagnostico }}</td>
              <td>{{ Receta.Prescripcion_Medica }}</td>
              <td>
              <button class="mt-2 flex justify-between botonEliminar" @click="eliminarReceta(Receta.ID)">
                <i ></i> Eliminar
              </button>
              &nbsp;&nbsp;&nbsp;

              <router-link :to="{ name: 'editarR', params: { id: Receta.ID } }">
                <button class=" mt-2 flex justify-between botonEditar">
                  <i></i> Editar
                </button>
              </router-link>
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
  