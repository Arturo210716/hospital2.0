<template>
    <div class="flex flex-col md:flex-row justify-center items-center">
      <div class="w-max md:w-2/4 p-8">
        <div class="border rounded-lg shadow-md p-6">
          <form @submit.prevent="submitForm">
            <h1 class="text-2xl font-bold text-black mb-4">Receta Médica</h1>
  
            <!-- Información del Paciente -->
            <div class="mb-6">
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <label for="Nombre" class="block text-black mb-1">Nombre</label>
                  <input type="text" id="Nombre" v-model="Nombre" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Introduce tu nombre" required>
                </div>
                <div>
                  <label for="Fecha_Nacimiento" class="block text-black mb-1">Fecha</label>
                  <input type="date" id="Fecha_Nacimiento" v-model="Fecha_Nacimiento" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
              </div>
  
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <label for="Peso" class="block text-black mb-1">Peso (kg)</label>
                  <input type="text" id="Peso" v-model="Peso" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
                <div>
                  <label for="Talla" class="block text-black mb-1">Talla (m)</label>
                  <input type="text" id="Talla" v-model="Talla" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
              </div>
  
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <label for="Edad" class="block text-black mb-1">Edad</label>
                  <input type="text" id="Edad" v-model="Edad" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
                <div>
                  <label for="Presion_arterial" class="block text-black mb-1">Presión Arterial</label>
                  <input type="text" id="Presion_arterial" v-model="Presion_arterial" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
              </div>
  
              <div class="mb-4">
                <label for="Diagnostico" class="block text-black mb-1">Diagnóstico</label>
                <input type="text" id="Diagnostico" v-model="Diagnostico" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
              </div>
  
              <div class="mb-4">
                <label for="Prescripcion_Medica" class="block text-black mb-1">Prescripción Médica</label>
                <textarea id="Prescripcion_Medica" v-model="Prescripcion_Medica" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border"></textarea>
              </div>
            </div>

  
            <div class="mt-8 flex justify-start">
              <button class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 dark:bg-teal-600 dark:text-white dark:hover:bg-teal-900">Generar Receta</button>
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
      Nombre: '',
      Fecha_Nacimiento: '',
      Peso: '',
      Talla: '',
      Edad: '',
      Presion_arterial: '',
      Diagnostico: '',
      Prescripcion_Medica: '',
      message: ''
    };
  },
  methods: {
    submitForm() {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6InlhaXIiLCJDb3JyZW9fRWxlY3Ryb25pY28iOiJzdHJpbmciLCJDb250cmFzZW5hIjoiMTIzNCIsIk51bWVyb19UZWxlZm9uaWNvX01vdmlsIjoic3RyaW5nIn0.aEXy_fgDdUHif1wzhfpxddKVg4fWAyGR3fd1p-SWDOc'; 

      let data = {
        Nombre: this.Nombre,
        Fecha_Nacimiento: this.Fecha_Nacimiento,
        Peso: this.Peso,
        Talla: this.Talla,
        Edad: this.Edad,
        Presion_arterial: this.Presion_arterial,
        Diagnostico: this.Diagnostico,
        Prescripcion_Medica: this.Prescripcion_Medica
      };

      fetch('http://127.0.0.1:8000/recetaCreate/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(data),
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Hubo un problema al registrar la receta.');
        }
        return response.json();
      })
      .then(data => {
        this.message = "¡Receta registrada exitosamente!";
        window.location.reload();
        // Limpiar los campos del formulario después del registro exitoso
        this.resetForm();
      })
      .catch(error => {
        this.message = "Error: " + error.message;
      });
    },
    resetForm() {
      // Reinicia todos los campos del formulario después del registro exitoso
      this.Nombre = '',
      this.Fecha_Nacimiento= '',
      this.Peso= '',
      this.Talla= '',
      this.Edad= '',
      this.Presion_arterial= '',
      this.Diagnostico= '',
      this.Prescripcion_Medica= ''
    }
  }
}
</script>
