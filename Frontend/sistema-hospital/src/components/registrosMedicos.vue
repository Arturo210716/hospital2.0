<template>
    
    <div class="flex flex-col md:flex-row justify-center items-center">
            
            <div class="w-max md:w-1/4 p-4">
                <div class="bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md border dark:border-gray-700">
                    <citas></citas>
                </div>
            </div>
            <div class="w-max md:w-1/8 p-4">
                <div class="bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md border dark:border-gray-700">
                    <listarCitas></listarCitas>
                </div>
            </div>
            <div class="w-max md:w-1/4 p-4">
                <div class="bg-white dark:bg-gray-800 p-8 rounded-lg shadow-md border dark:border-gray-700">
                    <Recetas></Recetas>
                </div>
            </div>
        </div>

</template>

<script>

import citas from './citasForm.vue'
import listarCitas from './citasList.vue'
import Recetas from './recetaMedicaForm.vue'

export default{
    components:{
        citas,
        listarCitas,
        Recetas
    }
}
</script>