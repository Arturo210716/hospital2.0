<template>
    <div>
      <div class="flex flex-col md:flex-row justify-center items-center">
        <div class="w-max md:w-2/4 p-8">
          <div class="border rounded-lg shadow-md p-6">
            <form @submit.prevent="submitForm">
              <h1 class="text-2xl font-bold text-black  mb-4">Registrar Citas:</h1>
  
              <div class="mb-6">
                <div class="mt-4 py-2">
                  <div>
                    <label for="Persona_ID" class="block text-gray-700 text-black mb-1">ID de la Persona</label>
                    <input type="text" id="Persona_ID" v-model="cita.Persona_ID" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Introduce el ID de la persona" required>
                  </div>
                </div>
                <div class="grid grid-cols-2 gap-4">
                  <div>
                    <label for="Hora_Cita" class="block text-gray-700 text-black mb-1">Hora de la cita</label>
                    <input type="datetime-local" id="Hora_Cita" v-model="cita.Hora_Cita" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                  </div>
                  <div>
                    <label for="Telefono" class="block text-gray-700 text-black mb-1">Número de Teléfono</label>
                    <input type="tel" id="Telefono" v-model="cita.Telefono" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="+52 xxx xxx xxxx" required>
                  </div>
                  <div>
                    <label for="Correo_Electronico" class="block text-gray-700 text-black mb-1">Correo Electrónico</label>
                    <input type="email" id="Correo_Electronico" v-model="cita.Correo_Electronico" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="example@gmail.com" required>
                  </div>
                  <div>
                    <label for="Estatus" class="block text-gray-700 text-black mb-1">Estatus</label>
                    <select id="Estatus" v-model="cita.Estatus" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                      <option value="Activo">Activo</option>
                      <option value="Inactivo">Inactivo</option>
                      <option value="Bloqueado">Bloqueado</option>
                      <option value="Suspendido">Suspendido</option>
                    </select>
                  </div>
                </div>
  
                <div class="mt-4">
                  <label for="Motivo_Cita" class="block text-gray-700 text-black mb-1">Motivo de la cita</label>
                  <textarea id="Motivo_Cita" v-model="cita.Motivo_Cita" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Ingresa el motivo de la cita" required></textarea>
                </div>
  
  
                <div class="mt-8 flex justify-between">
                <button type="submit" class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 dark:bg-teal-600 dark:hover:bg-teal-900">Agendar Cita</button>
                <router-link to="/citas">
                    <button class="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-700 dark:bg-gray-600 dark:hover:bg-gray-900">Citas</button>
                </router-link>
                </div>

              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  /* eslint-disable */
  export default {
    data() {
      return {
        cita: {
        Persona_ID: '',
        Hora_Cita: '',
        Telefono: '',
        Correo_Electronico: '',
        Motivo_Cita: '',
        Estatus: '',
        message: ''
    }
      };
    },
    mounted() {
    this.obtenerDatosCita();
    },
    methods: {
      obtenerDatosCita() {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
      const id = this.$route.params.id;
      fetch(`https://backenhospital.onrender.com/citaOne/${id}/`,{
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('No se pudieron obtener los datos de la cita.');
          }
          return response.json();
        })
        .then(data => {
          this.cita = data;
        })
        .catch(error => {
          this.message = "Error al obtener los datos de la cita: " + error.message;
        });
    },
    submitForm() {
      this.message = "Guardando cambios...";
      const id = this.$route.params.id;
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'
      fetch(`https://backenhospital.onrender.com/citaUpdate/${id}/`,{
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify(this.cita),
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('No se pudieron guardar los cambios.');
          }
          this.message = "Cita editada exitosamente!";
        })
        .catch(error => {
          this.message = "Error al guardar los cambios: " + error.message;
        });
    }
  }
}
</script>