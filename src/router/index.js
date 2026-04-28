import { createRouter, createWebHistory } from 'vue-router'
import ClientList from '../components/ClientList.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/clients',
      name: 'clients',
      component: ClientList
    }
  ],
})

export default router
