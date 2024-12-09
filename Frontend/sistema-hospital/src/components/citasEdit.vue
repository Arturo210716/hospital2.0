<template>
  <div class="flex flex-col items-center md:flex-row md:justify-center p-4">
    <!-- Contenedor del formulario -->
    <div class="w-full md:w-2/4 lg:w-1/3 p-4">
      <div class="border rounded-lg shadow-md p-6 bg-white">
        <form @submit.prevent="submitForm">
          <h1 class="text-2xl font-bold text-black mb-4">Registrar Citas:</h1>

          <!-- Campos del formulario -->
          <div class="space-y-4">
            <!-- ID de la Persona -->
            <div>
              <label for="Persona_ID" class="block text-gray-700 text-black mb-1">ID de la Persona</label>
              <input
                type="text"
                id="Persona_ID"
                v-model="cita.Persona_ID"
                class="w-full rounded-lg border py-2 px-3 text-black"
                placeholder="Introduce el ID de la persona"
                required
              />
            </div>

            <!-- Hora de la cita y Teléfono -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label for="Hora_Cita" class="block text-gray-700 text-black mb-1">Hora de la cita</label>
                <input
                  type="datetime-local"
                  id="Hora_Cita"
                  v-model="cita.Hora_Cita"
                  class="w-full rounded-lg border py-2 px-3 text-black"
                  required
                />
              </div>
              <div>
                <label for="Telefono" class="block text-gray-700 text-black mb-1">Número de Teléfono</label>
                <input
                  type="tel"
                  id="Telefono"
                  v-model="cita.Telefono"
                  class="w-full rounded-lg border py-2 px-3 text-black"
                  placeholder="+52 xxx xxx xxxx"
                  required
                />
              </div>
            </div>

            <!-- Correo Electrónico y Estatus -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label for="Correo_Electronico" class="block text-gray-700 text-black mb-1">Correo Electrónico</label>
                <input
                  type="email"
                  id="Correo_Electronico"
                  v-model="cita.Correo_Electronico"
                  class="w-full rounded-lg border py-2 px-3 text-black"
                  placeholder="example@gmail.com"
                  required
                />
              </div>
              <div>
                <label for="Estatus" class="block text-gray-700 text-black mb-1">Estatus</label>
                <select
                  id="Estatus"
                  v-model="cita.Estatus"
                  class="w-full rounded-lg border py-2 px-3 text-black"
                  required
                >
                  <option value="Activo">Activo</option>
                  <option value="Inactivo">Inactivo</option>
                  <option value="Bloqueado">Bloqueado</option>
                  <option value="Suspendido">Suspendido</option>
                </select>
              </div>
            </div>

            <!-- Motivo de la cita -->
            <div>
              <label for="Motivo_Cita" class="block text-gray-700 text-black mb-1">Motivo de la cita</label>
              <textarea
                id="Motivo_Cita"
                v-model="cita.Motivo_Cita"
                class="w-full rounded-lg border py-2 px-3 text-black"
                placeholder="Ingresa el motivo de la cita"
                required
              ></textarea>
            </div>
          </div>

          <!-- Botones -->
          <div class="mt-8 flex justify-between">
            <button
              type="submit"
              class="bg-teal-500 text-white px-4 py-2 rounded-lg hover:bg-teal-700 transition"
            >
              Agendar Cita
            </button>
            <router-link to="/citas">
              <button
                type="button"
                class="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-700 transition"
              >
                Citas
              </button>
            </router-link>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
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
        message: '',
      },
    };
  },
  mounted() {
    this.obtenerDatosCita();
  },
  methods: {
    obtenerDatosCita() {
      const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE';
      const id = this.$route.params.id;
      fetch(`https://backenhospital.onrender.com/citaOne/${id}/`, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${token}`,
          'Content-Type': 'application/json',
        },
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error('No se pudieron obtener los datos de la cita.');
          }
          return response.json();
        })
        .then((data) => {
          this.cita = data;
        })
        .catch((error) => {
          this.message =
            'Error al obtener los datos de la cita: ' + error.message;
        });
    },
    submitForm() {
      this.message = 'Guardando cambios...';
      const id = this.$route.params.id;
      const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmVfVXN1YXJpbyI6IkFydHVybyIsIkNvcnJlb19FbGVjdHJvbmljbyI6InN0cmluZyIsIkNvbnRyYXNlbmEiOiIxMjMiLCJOdW1lcm9fVGVsZWZvbmljb19Nb3ZpbCI6InN0cmluZyJ9.SsK8F6Kdj41MK2iip-McFVoVrm2__IQOOcRu4DNjRdE';
      fetch(`https://backenhospital.onrender.com/citaUpdate/${id}/`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(this.cita),
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error('No se pudieron guardar los cambios.');
          }
          this.message = 'Cita editada exitosamente!';
        })
        .catch((error) => {
          this.message = 'Error al guardar los cambios: ' + error.message;
        });
    },
  },
};
</script>
