<template>
  <div class="min-h-screen bg-gray-100 py-8">
    <div class="container mx-auto">
      <div class="flex flex-col md:flex-row justify-center items-center">
        <div class="w-full md:w-2/3 lg:w-1/2 p-6">
          <div class="bg-white border rounded-lg shadow-md p-6">
            <form @submit.prevent="submitForm">
              <h1 class="text-2xl font-bold text-black mb-6">
                Registrar Expediente Médico
              </h1>

              <!-- Campo ID del Paciente -->
              <div class="mb-4">
                <label for="Persona_ID" class="block text-gray-700 font-medium mb-2">
                  ID del Paciente
                </label>
                <input
                  type="text"
                  id="Persona_ID"
                  v-model="Persona_ID"
                  class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
                  placeholder="Introduce el ID del paciente"
                  required
                />
              </div>

              <!-- Campos en cuadrícula -->
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <!-- Hora de la Consulta -->
                <div>
                  <label for="Hora_Consulta" class="block text-gray-700 font-medium mb-2">
                    Hora de la Consulta
                  </label>
                  <input
                    type="datetime-local"
                    id="Hora_Consulta"
                    v-model="Hora_Consulta"
                    class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
                    required
                  />
                </div>

                <!-- Diagnóstico -->
                <div>
                  <label for="Diagnostico" class="block text-gray-700 font-medium mb-2">
                    Diagnóstico
                  </label>
                  <input
                    type="text"
                    id="Diagnostico"
                    v-model="Diagnostico"
                    class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
                    placeholder="Escribe el diagnóstico"
                    required
                  />
                </div>
              </div>

              <!-- Tratamiento y Estatus -->
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                <div>
                  <label for="Tratamiento_Relacionado" class="block text-gray-700 font-medium mb-2">
                    Tratamiento Recomendado
                  </label>
                  <textarea
                    id="Tratamiento_Relacionado"
                    v-model="Tratamiento_Relacionado"
                    class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
                    placeholder="Describe el tratamiento recomendado"
                    rows="3"
                    required
                  ></textarea>
                </div>
                <div>
                  <label for="Estatus" class="block text-gray-700 font-medium mb-2">
                    Estatus
                  </label>
                  <select
                    id="Estatus"
                    v-model="Estatus"
                    class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
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
                <label for="Observaciones" class="block text-gray-700 font-medium mb-2">
                  Observaciones
                </label>
                <textarea
                  id="Observaciones"
                  v-model="Observaciones"
                  class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-teal-500"
                  placeholder="Añade observaciones adicionales"
                  rows="4"
                ></textarea>
              </div>

              <!-- Botón de Enviar -->
              <div class="mt-6 flex justify-start">
                <button
                  type="submit"
                  class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-600 focus:ring-2 focus:ring-teal-500"
                >
                  Registrar Expediente Médico
                </button>
              </div>
            </form>
          </div>
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
      const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE'

      let data = {
        Persona_ID: this.Persona_ID,
        Hora_Consulta: this.Hora_Consulta,
        Diagnostico: this.Diagnostico,
        Tratamiento_Relacionado: this.Tratamiento_Relacionado,
        Observaciones: this.Observaciones,
        Estatus: this.Estatus
      };

      fetch('https://backenhospital.onrender.com/expedienteCreate/', {
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

  