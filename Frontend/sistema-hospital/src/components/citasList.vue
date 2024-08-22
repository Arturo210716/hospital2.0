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
            @input="buscarCitas"
            placeholder="Buscar por Id del paciente..."
            style="width: 80%; padding: 8px; border-radius: 4px; border: 1px solid #ddd;">
        </div>
      </div>
      <br>
  
      <div class="tabla1">
        <table>
          <thead>
            <tr>
              <th>Id de la Cita</th>
              <th>Id del Paciente</th>
              <th>Hora de la Cita</th>
              <th>Teléfono</th>
              <th>Correo electrónico del contacto</th>
              <th>Motivo de la Cita</th>
              <th>Estatus</th>
              <th>Fecha de registro</th>
              <th>Fecha de actualización</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(Cita, index) in CitasFiltrados" :key="index">
              <td>{{ Cita.ID }}</td>
              <td>{{ Cita.Persona_ID }}</td>
              <td>{{ Cita.Hora_Cita }}</td>
              <td>{{ Cita.Telefono }}</td>
              <td>{{ Cita.Correo_Electronico }}</td>
              <td>{{ Cita.Motivo_Cita }}</td>
              <td>{{ Cita.Estatus }}</td>
              <td>{{ Cita.Fecha_Registro }}</td>
              <td>{{ Cita.Fecha_Actualizacion }}</td>
              <td>
              <button class="mt-2 flex justify-between botonEliminar" @click="eliminarCita(Cita.ID)">
                <i ></i> Eliminar
              </button>
              &nbsp;&nbsp;&nbsp;

              <router-link :to="{ name: 'editar', params: { id: Cita.ID } }">
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
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'; 
        fetch(`http://127.0.0.1:8000/citaAll/?page=${this.paginaActual - 1}&limit=${this.itemsPorPagina}`,{
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
        const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'; 
        fetch(`http://127.0.0.1:8000/citaDelete/${ID}`, {
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
  