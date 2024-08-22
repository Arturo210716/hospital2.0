<template>
    <div>
      <div class="flex flex-col md:flex-row justify-center items-center">
        <div class="w-max md:w-2/4 p-8">
          <div class="border rounded-lg shadow-md p-6">
            <form @submit.prevent="submitForm">
              <h1 class="text-2xl font-bold text-black mb-4">Registrar Expediente Médico:</h1>
  
              <div class="mb-6">
                <div class="mt-4 py-2">
                  <div>
                    <label for="Persona_ID" class="block text-black mb-1">ID del Paciente</label>
                    <input type="text" id="Persona_ID" v-model="Persona_ID" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Introduce el ID del paciente" required>
                  </div>
                </div>
                <div class="grid grid-cols-2 gap-4">
                  <div>
                    <label for="Hora_Consulta" class="block text-black mb-1">Hora de la Consulta</label>
                    <input type="datetime-local" id="Hora_Consulta" v-model="Hora_Consulta" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                  </div>
                  <div>
                    <label for="Diagnostico" class="block text-black mb-1">Diagnóstico</label>
                    <input type="text" id="Diagnostico" v-model="Diagnostico" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Escribe el diagnóstico" required>
                  </div>
                  <div>
                    <label for="Tratamiento_Relacionado" class="block text-black mb-1">Tratamiento Recomendado</label>
                    <textarea id="Tratamiento_Relacionado" v-model="Tratamiento_Relacionado" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Describe el tratamiento recomendado" required></textarea>
                  </div>
                  <div>
                  <label for="Estatus" class="block text-gray-700 text-black mb-1">Estatus</label>
                  <select id="Estatus" v-model="Estatus" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                    <option value="Activo">Activo</option>
                    <option value="Inactivo">Inactivo</option>
                    <option value="Bloqueado">Bloqueado</option>
                    <option value="Suspendido">Suspendido</option>
                  </select>
                </div>
                </div>
  
                <div class="mt-4">
                  <label for="Observaciones" class="block text-black mb-1">Observaciones</label>
                  <textarea id="Observaciones" v-model="Observaciones" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Añade observaciones adicionales si es necesario"></textarea>
                </div>
  
                <div class="mt-8 flex justify-start">
                  <button type="submit" class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 dark:bg-teal-600 dark:hover:bg-teal-900">Registrar Expediente Médico</button>
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
      Persona_ID: '',
      Hora_Consulta: '',
      Diagnostico: '',
      Tratamiento_Relacionado: '',
      Observaciones: '',
      Estatus: 'Activo',
      message: ''
    };
  },
  methods: {
    submitForm() {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6InlhaXIiLCJDb3JyZW9fRWxlY3Ryb25pY28iOiJzdHJpbmciLCJDb250cmFzZW5hIjoiMTIzNCIsIk51bWVyb19UZWxlZm9uaWNvX01vdmlsIjoic3RyaW5nIn0.aEXy_fgDdUHif1wzhfpxddKVg4fWAyGR3fd1p-SWDOc'; 

      let data = {
        Persona_ID: this.Persona_ID,
        Hora_Consulta: this.Hora_Consulta,
        Diagnostico: this.Diagnostico,
        Tratamiento_Relacionado: this.Tratamiento_Relacionado,
        Observaciones: this.Observaciones,
        Estatus: this.Estatus
      };

      fetch('http://127.0.0.1:8000/expedienteCreate/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(data),
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Hubo un problema al registrar el expediente.');
        }
        return response.json();
      })
      .then(data => {
        this.message = "¡Expediente registrado exitosamente!";
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
      this.Hora_Consulta = '';
      this.Diagnostico = '';
      this.Tratamiento_Relacionado = '';
      this.Observaciones = '';
      this.Estatus = 'Activo';

    }
  }
}
</script>

  