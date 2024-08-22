<template>
    <div>
      <div class="shadow-lg rounded-lg overflow-hidden mx-4 md:mx-10">
        <div class="bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md border dark:border-gray-700">
          <h1 class="text-2xl font-bold text-gray-800 dark:text-white mb-4">Receta Médica</h1>
  
          <!-- Información del Paciente -->
          <form @submit.prevent="submitReceta">
            <div class="mb-6">
              <h2 class="text-xl font-semibold text-gray-700 dark:text-white mb-2">Información del Paciente</h2>
              <div class="grid grid-cols-2 gap-4">
                <div>
                  <label for="nombre" class="block text-gray-700 dark:text-white mb-1">Nombre</label>
                  <input v-model="receta.nombre" type="text" id="nombre" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" required>
                </div>
                <div>
                  <label for="fecha" class="block text-gray-700 dark:text-white mb-1">Fecha</label>
                  <input v-model="receta.fecha" type="date" id="fecha" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" required>
                </div>
              </div>
  
              <div class="mt-4">
                <label for="peso" class="block text-gray-700 dark:text-white mb-1">Peso (kg)</label>
                <input v-model="receta.peso" type="text" id="peso" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" step="0.1" required>
              </div>
  
              <div class="mt-4">
                <label for="talla" class="block text-gray-700 dark:text-white mb-1">Talla (m)</label>
                <input v-model="receta.talla" type="text" id="talla" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" step="0.01" required>
              </div>
  
              <div class="mt-4">
                <label for="edad" class="block text-gray-700 dark:text-white mb-1">Edad</label>
                <input v-model="receta.edad" type="text" id="edad" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" required>
              </div>
  
              <div class="grid grid-cols-2 gap-4 mt-4">
                <div>
                  <label for="presion_arterial" class="block text-gray-700 dark:text-white mb-1">Presión Arterial</label>
                  <input v-model="receta.presion_arterial" type="text" id="presion_arterial" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" required>
                </div>
                <div>
                  <label for="diagnostico" class="block text-gray-700 dark:text-white mb-1">Diagnóstico</label>
                  <input v-model="receta.diagnostico" type="text" id="diagnostico" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" required>
                </div>
              </div>
  
              <div class="mt-4">
                <label for="prescripcion" class="block text-gray-700 dark:text-white mb-1">Prescripción Médica</label>
                <textarea v-model="receta.prescripcion" id="prescripcion" class="w-full rounded-lg border py-2 px-3 dark:bg-gray-700 dark:text-white dark:border-none" required></textarea>
              </div>
            </div>
  
            <div class="mt-8 flex justify-start">
              <button type="submit" class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 dark:bg-teal-600 dark:text-white dark:hover:bg-teal-900">Generar Receta</button>
            </div>
          </form>
  
          <!-- Mensajes de éxito o error -->
          <div v-if="message" class="mt-4 p-4 rounded-lg" :class="{'bg-green-100 text-green-700': success, 'bg-red-100 text-red-700': !success}">
            {{ message }}
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { createReceta } from '../services/recetaService';
  
  export default {
    data() {
      return {
        receta: {
          nombre: '',
          fecha: '',
          peso: '',
          talla: '',
          edad: '',
          presion_arterial: '',
          diagnostico: '',
          prescripcion: ''
        },
        message: '',
        success: false
      };
    },
    methods: {
      async submitReceta() {
        try {
          const response = await createReceta(this.receta);
          this.message = 'Receta creada exitosamente';
          this.success = true;
          console.log('Receta creada:', response);
          // Limpiar el formulario si es necesario
          this.resetForm();
        } catch (error) {
          this.message = 'Error creando receta: ' + error.message;
          this.success = false;
          console.error('Error creando receta:', error);
        }
      },
      resetForm() {
        this.receta = {
          nombre: '',
          fecha: '',
          peso: '',
          talla: '',
          edad: '',
          presion_arterial: '',
          diagnostico: '',
          prescripcion: ''
        };
      }
    }
  };
  </script>
  
  <style scoped>
  /* Estilos opcionales */
  </style>
  