import { createRouter, createWebHistory } from 'vue-router'
import loginView from '@/components/login.vue'
import registerUser from '@/components/registerUser.vue'
import dashboard from '@/components/dashboard.vue'
import registerP from '@/components/registerPersona.vue'
import register from '@/components/register.vue'

import citasLista from '../components/citas.vue'
import expedientes from '../components/expedientesM.vue'
import recetaMedica from '../components/recetaMedica.vue'
import expedienteEdit from '../components/expedientesEdit.vue'
import CitasEdit from '../components/citasEdit.vue'
import recetaEdit from '../components/recetasEdit.vue'
import Graficas from '@/components/graficas.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'login',
      component: loginView
    },  
    {
      path: '/registerUser',
      name: 'register User',
      component: registerUser
    },
    {
      path: '/registerP',
      name: 'registerP',
      component: registerP
    },
    {
      path: '/register',
      name: 'register',
      component: register
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: dashboard,
      children:[
        {path:'/graficas', name: 'Graficas', component: Graficas},

        {path:'/registerP', name: 'personas',component:registerP},

        {path:'/citas', name:'citasLista', component:citasLista},

        {path:'/expediente', name:'expediente', component:expedientes},

        {path:'/receta', name:'receta', component: recetaMedica },
        {
          path: '/editar/:id',  // Define la ruta con el parámetro `id`
          name: 'editar',
          component: CitasEdit,
          props: true  // Permite pasar el parámetro `id` como prop al componente
        },
        {
          path: '/editarE/:id',  // Define la ruta con el parámetro `id`
          name: 'editarE',
          component: expedienteEdit,
          props: true  // Permite pasar el parámetro `id` como prop al componente
        },
        {
          path: '/editarR/:id',  // Define la ruta con el parámetro `id`
          name: 'editarR',
          component: recetaEdit,
          props: true  // Permite pasar el parámetro `id` como prop al componente
        }

      ]
    }
    
  ]
})

export default router
