<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center py-8">
    <div class="w-full max-w-3xl p-4">
      <div class="border rounded-lg shadow-md bg-white p-6">
        <form @submit.prevent="submitForm">
          <h1 class="text-2xl font-bold text-gray-800 mb-6 text-center">Registrar Expediente Médico</h1>

          <!-- ID del Paciente -->
          <div class="mb-4">
            <label for="Persona_ID" class="block text-gray-700 mb-1">ID del Paciente</label>
            <input 
              type="text" 
              id="Persona_ID" 
              v-model="expediente.Persona_ID" 
              class="w-full rounded-lg border py-2 px-3 focus:outline-none focus:ring-2 focus:ring-teal-500 text-gray-800" 
              placeholder="Introduce el ID del paciente" 
              required
            />
          </div>

          <!-- Grid de Inputs -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <!-- Hora de la Consulta -->
            <div>
              <label for="Hora_Consulta" class="block text-gray-700 mb-1">Hora de la Consulta</label>
              <input 
                type="datetime-local" 
                id="Hora_Consulta" 
                v-model="expediente.Hora_Consulta" 
                class="w-full rounded-lg border py-2 px-3 focus:outline-none focus:ring-2 focus:ring-teal-500 text-gray-800" 
                required
              />
            </div>

            <!-- Diagnóstico -->
            <div>
              <label for="Diagnostico" class="block text-gray-700 mb-1">Diagnóstico</label>
              <input 
                type="text" 
                id="Diagnostico" 
                v-model="expediente.Diagnostico" 
                class="w-full rounded-lg border py-2 px-3 focus:outline-none focus:ring-2 focus:ring-teal-500 text-gray-800" 
                placeholder="Escribe el diagnóstico" 
                required
              />
            </div>
          </div>

          <!-- Tratamiento y Estatus -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
            <!-- Tratamiento Recomendado -->
            <div>
              <label for="Tratamiento_Relacionado" class="block text-gray-700 mb-1">Tratamiento Recomendado</label>
              <textarea 
                id="Tratamiento_Relacionado" 
                v-model="expediente.Tratamiento_Relacionado" 
                class="w-full rounded-lg border py-2 px-3 focus:outline-none focus:ring-2 focus:ring-teal-500 text-gray-800" 
                placeholder="Describe el tratamiento recomendado" 
                required
              ></textarea>
            </div>

            <!-- Estatus -->
            <div>
              <label for="Estatus" class="block text-gray-700 mb-1">Estatus</label>
              <select 
                id="Estatus" 
                v-model="expediente.Estatus" 
                class="w-full rounded-lg border py-2 px-3 focus:outline-none focus:ring-2 focus:ring-teal-500 text-gray-800" 
                required
              >
                <option value="Activo">Activo</option>
                <option value="Inactivo">Inactivo</option>
                <option value="Bloqueado">Bloqueado</option>
                <option value="Suspendido">Suspendido</option>
              </select>
            </div>
          </div>

          <!-- Observaciones -->
          <div class="mt-4">
            <label for="Observaciones" class="block text-gray-700 mb-1">Observaciones</label>
            <textarea 
              id="Observaciones" 
              v-model="expediente.Observaciones" 
              class="w-full rounded-lg border py-2 px-3 focus:outline-none focus:ring-2 focus:ring-teal-500 text-gray-800" 
              placeholder="Añade observaciones adicionales si es necesario"
            ></textarea>
          </div>

          <!-- Botones -->
          <div class="mt-6 flex justify-between">
            <button 
              type="submit" 
              class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 focus:ring-2 focus:ring-teal-300"
            >
              Registrar Expediente
            </button>
            <router-link to="/expediente">
              <button 
                type="button" 
                class="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-700 focus:ring-2 focus:ring-gray-300"
              >
                Ver Expedientes
              </button>
            </router-link>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
/* eslint-disable */
export default {
  data() {
    return {
        expediente: {
            Persona_ID: '',
            Hora_Consulta: '',
            Diagnostico: '',
            Tratamiento_Relacionado: '',
            Observaciones: '',
            Estatus: '',
            message: ''
        }
      
    };
  },
  mounted() {
    this.obtenerDatosExpediente();
    },
  methods: {obtenerDatosExpediente() {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
      const id = this.$route.params.id;
      fetch(`https://backenhospital.onrender.com/expedienteOne/${id}/`,{
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('No se pudieron obtener los datos del expediente.');
          }
          return response.json();
        })
        .then(data => {
          this.expediente = data;
        })
        .catch(error => {
          this.message = "Error al obtener los datos del expediente: " + error.message;
        });
    },
    submitForm() {
      this.message = "Guardando cambios...";
      const id = this.$route.params.id;
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
      fetch(`https://backenhospital.onrender.com/expedienteUpdate/${id}/`,{
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify(this.expediente),
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('No se pudieron guardar los cambios.');
          }
          this.message = "Expediente editado exitosamente!";
        })
        .catch(error => {
          this.message = "Error al guardar los cambios: " + error.message;
        });
    }
  }
}
</script>