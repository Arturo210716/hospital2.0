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
                  <input type="text" id="Nombre" v-model="receta.Nombre" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" placeholder="Introduce tu nombre" required>
                </div>
                <div>
                  <label for="Fecha_Nacimiento" class="block text-black mb-1">Fecha</label>
                  <input type="date" id="Fecha_Nacimiento" v-model="receta.Fecha_Nacimiento" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
              </div>
  
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <label for="Peso" class="block text-black mb-1">Peso (kg)</label>
                  <input type="number" id="Peso" v-model="receta.Peso" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
                <div>
                  <label for="Talla" class="block text-black mb-1">Talla (m)</label>
                  <input type="number" id="Talla" v-model="receta.Talla" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
              </div>
  
              <div class="grid grid-cols-2 gap-4 mb-4">
                <div>
                  <label for="Edad" class="block text-black mb-1">Edad</label>
                  <input type="number" id="Edad" v-model="receta.Edad" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
                <div>
                  <label for="Presion_arterial" class="block text-black mb-1">Presión Arterial</label>
                  <input type="text" id="Presion_arterial" v-model="receta.Presion_arterial" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
                </div>
              </div>
  
              <div class="mb-4">
                <label for="Diagnostico" class="block text-black mb-1">Diagnóstico</label>
                <input type="text" id="Diagnostico" v-model="receta.Diagnostico" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border" required>
              </div>
  
              <div class="mb-4">
                <label for="Prescripcion_Medica" class="block text-black mb-1">Prescripción Médica</label>
                <textarea id="Prescripcion_Medica" v-model="receta.Prescripcion_Medica" class="w-full rounded-lg border py-2 px-3 dark:bg-white-700 text-black dark:border"></textarea>
              </div>
            </div>

  
              <div class="mt-8 flex justify-between">
                <button type="submit" class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 dark:bg-teal-600 dark:hover:bg-teal-900">Registrar Receta</button>
                <router-link to="/receta">
                    <button class="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-700 dark:bg-gray-600 dark:hover:bg-gray-900">Recetas</button>
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
        receta: {
            Nombre: '',
            Fecha_Nacimiento: '',
            Peso: '',
            Talla: '',
            Edad: '',
            Presion_arterial: '',
            Diagnostico: '',
            Prescripcion_Medica: '',
            message: ''
        }
    };
  },
  mounted() {
    this.obtenerDatosReceta();
    },
  methods: {
    obtenerDatosReceta() {
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6InlhaXIiLCJDb3JyZW9fRWxlY3Ryb25pY28iOiJzdHJpbmciLCJDb250cmFzZW5hIjoiMTIzNCIsIk51bWVyb19UZWxlZm9uaWNvX01vdmlsIjoic3RyaW5nIn0.aEXy_fgDdUHif1wzhfpxddKVg4fWAyGR3fd1p-SWDOc'; 
      const id = this.$route.params.id;
      fetch(`http://127.0.0.1:8000/recetaOne/${id}/`,{
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('No se pudieron obtener los datos de la receta.');
          }
          return response.json();
        })
        .then(data => {
          this.receta = data;
        })
        .catch(error => {
          this.message = "Error al obtener los datos de la receta: " + error.message;
        });
    },
    submitForm() {
      this.message = "Guardando cambios...";
      const id = this.$route.params.id;
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6InlhaXIiLCJDb3JyZW9fRWxlY3Ryb25pY28iOiJzdHJpbmciLCJDb250cmFzZW5hIjoiMTIzNCIsIk51bWVyb19UZWxlZm9uaWNvX01vdmlsIjoic3RyaW5nIn0.aEXy_fgDdUHif1wzhfpxddKVg4fWAyGR3fd1p-SWDOc'; 
      fetch(`http://127.0.0.1:8000/recetaUpdate/${id}/`,{
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify(this.receta),
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('No se pudieron guardar los cambios.');
          }
          this.message = "Receta editada exitosamente!";
        })
        .catch(error => {
          this.message = "Error al guardar los cambios: " + error.message;
        });
    }
  }
}
</script>