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
            @input="buscarExpedientes"
            placeholder="Buscar por Id del paciente..."
            style="width: 80%; padding: 8px; border-radius: 4px; border: 1px solid #ddd;">
        </div>
      </div>
      <br>
  
      <div class="tabla1">
        <table>
          <thead>
            <tr>
              <th>Id del Expediente</th>
              <th>Id del Paciente</th>
              <th>Hora de la Consulta</th>
              <th>Diagnostico</th>
              <th>Tratamiento Relacionado</th>
              <th>Obervaciones</th>
              <th>Estatus</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(Expediente, index) in ExpedientesFiltrados" :key="index">
              <td>{{ Expediente.ID }}</td>
              <td>{{ Expediente.Persona_ID }}</td>
              <td>{{ Expediente.Hora_Consulta }}</td>
              <td>{{ Expediente.Diagnostico }}</td>
              <td>{{ Expediente.Tratamiento_Relacionado }}</td>
              <td>{{ Expediente.Observaciones }}</td>
              <td>{{ Expediente.Estatus }}</td>
              <td>
              <button class="mt-2 flex justify-between botonEliminar" @click="eliminarExpediente(Expediente.ID)">
                <i ></i> Eliminar
              </button>
              &nbsp;&nbsp;&nbsp;

              <router-link :to="{ name: 'editarE', params: { id: Expediente.ID } }">
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
  