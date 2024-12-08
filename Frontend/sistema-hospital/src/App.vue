<script setup>
import { RouterLink, RouterView } from 'vue-router';

// Esta función se encarga de enviar los datos pendientes al servidor
const syncOfflineActions = async () => {
  const storedActions = JSON.parse(localStorage.getItem('actions')) || [];

  if (storedActions.length > 0) {
    for (const action of storedActions) {
      try {
        await sendDataToServer(action);
        // Si se envía correctamente, eliminarlas de localStorage
        storedActions.splice(storedActions.indexOf(action), 1);
        localStorage.setItem('actions', JSON.stringify(storedActions));
        console.log("Datos sincronizados correctamente.");
      } catch (error) {
        console.error('Error al sincronizar', error);
      }
    }
  } else {
    console.log("No hay datos pendientes para sincronizar.");
  }
};

// Función para enviar datos al servidor
const sendDataToServer = async (action) => {
  try {
    const response = await fetch('https://api.mi-backend.com/records', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(action),
    });

    if (!response.ok) throw new Error('No se pudo enviar el registro.');
    return await response.json();
  } catch (error) {
    console.error("Error al enviar los datos:", error);
  }
};

// Registrar la función en la propiedad global de Vue para que sea accesible en cualquier componente
import { defineExpose } from 'vue';
defineExpose({
  syncOfflineActions,
});
</script>

<template>
 <div class="p-4 sm:ml-64" @click="closeSidebarIfOutsideClick">
  <router-view />
</div>
</template>
