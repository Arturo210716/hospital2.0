<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center">
    <div class="w-full max-w-4xl px-4">
      <div class="bg-white border rounded-lg shadow-md p-6">
        <form @submit.prevent="submitForm" class="space-y-6">
          <h1 class="text-2xl font-bold text-gray-800 text-center mb-4">Registrar Citas</h1>

          <!-- Persona ID -->
          <div>
            <label for="Persona_ID" class="block text-gray-700 mb-1">ID de la Persona</label>
            <input 
              type="text" 
              id="Persona_ID" 
              v-model="Persona_ID" 
              class="w-full rounded-lg border px-3 py-2 focus:ring-teal-500 focus:border-teal-500" 
              placeholder="Introduce el ID de la persona" 
              required>
          </div>

          <!-- Grid Layout for Fields -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <!-- Hora de la Cita -->
            <div>
              <label for="Hora_Cita" class="block text-gray-700 mb-1">Hora de la cita</label>
              <input 
                type="datetime-local" 
                id="Hora_Cita" 
                v-model="Hora_Cita" 
                class="w-full rounded-lg border px-3 py-2 focus:ring-teal-500 focus:border-teal-500" 
                required>
            </div>
            
            <!-- Teléfono -->
            <div>
              <label for="Telefono" class="block text-gray-700 mb-1">Número de Teléfono</label>
              <input 
                type="tel" 
                id="Telefono" 
                v-model="Telefono" 
                class="w-full rounded-lg border px-3 py-2 focus:ring-teal-500 focus:border-teal-500" 
                placeholder="+52 xxx xxx xxxx" 
                required>
            </div>
            
            <!-- Correo Electrónico -->
            <div>
              <label for="Correo_Electronico" class="block text-gray-700 mb-1">Correo Electrónico</label>
              <input 
                type="email" 
                id="Correo_Electronico" 
                v-model="Correo_Electronico" 
                class="w-full rounded-lg border px-3 py-2 focus:ring-teal-500 focus:border-teal-500" 
                placeholder="example@gmail.com" 
                required>
            </div>

            <!-- Estatus -->
            <div>
              <label for="Estatus" class="block text-gray-700 mb-1">Estatus</label>
              <select 
                id="Estatus" 
                v-model="Estatus" 
                class="w-full rounded-lg border px-3 py-2 focus:ring-teal-500 focus:border-teal-500" 
                required>
                <option value="Activo">Activo</option>
                <option value="Inactivo">Inactivo</option>
                <option value="Bloqueado">Bloqueado</option>
                <option value="Suspendido">Suspendido</option>
              </select>
            </div>
          </div>

          <!-- Motivo de la Cita -->
          <div>
            <label for="Motivo_Cita" class="block text-gray-700 mb-1">Motivo de la cita</label>
            <textarea 
              id="Motivo_Cita" 
              v-model="Motivo_Cita" 
              class="w-full rounded-lg border px-3 py-2 focus:ring-teal-500 focus:border-teal-500" 
              placeholder="Ingresa el motivo de la cita" 
              required></textarea>
          </div>

          <!-- Botones -->
          <div class="flex flex-col sm:flex-row justify-center gap-4 mt-6">
            <button 
              type="submit" 
              class="w-full sm:w-auto bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-600">
              Agendar Cita
            </button>
            <router-link to="/citas" class="w-full sm:w-auto">
              <button 
                type="button" 
                class="w-full bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600">
                Ver Citas
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
      Persona_ID: '',
      Hora_Cita: '',
      Telefono: '',
      Correo_Electronico: '',
      Estatus: 'Activo',
      Motivo_Cita: '',
      message: ''
    };
  },
  methods: {
    submitForm() {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'

      let data = {
        Persona_ID: this.Persona_ID,
        Hora_Cita: this.Hora_Cita,
        Telefono: this.Telefono,
        Correo_Electronico: this.Correo_Electronico,
        Estatus: this.Estatus,
        Motivo_Cita: this.Motivo_Cita,
        
      };

      fetch('https://backenhospital.onrender.com/citaCreate/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(data),
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Hubo un problema al registrar la cita.');
        }
        return response.json();
      })
      .then(data => {
        this.message = "¡Cita registrada exitosamente!";
        // Limpiar los campos del formulario después del registro exitoso
        window.location.reload();
        this.resetForm();
      })
      .catch(error => {
        this.message = "Error: " + error.message;
      });
    },
    resetForm() {
      // Reinicia todos los campos del formulario después del registro exitoso
      this.Persona_ID = '';
      this.Hora_Cita = '';
      this.Telefono = '';
      this.Correo_Electronico = '';
      this.Estatus = 'Activo';
      this.Motivo_Cita = '';
    }
  }
}
</script>
