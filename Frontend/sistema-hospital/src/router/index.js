import { createRouter, createWebHistory } from 'vue-router'
import loginView from '@/components/login.vue'
import registerUser from '@/components/registerUser.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'login',
      component: loginView
    },  
    {
      path: '/register',
      name: 'register',
      component: registerUser
    
    }
  ]
})

export default router
