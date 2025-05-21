import { createRouter, createWebHashHistory } from 'vue-router'
import Home from '@/views/HomeView.vue'

const routes = [
  {
    path: '/',
    redirect: '/dashboard'
  },
  {
    meta: {
      title: 'Dashboard'
    },
    path: '/dashboard',
    name: 'dashboard',
    component: Home
  },
  {
    meta: {
      title: 'Conversations'
    },
    path: '/Conversations',
    name: 'Conversations',
    component: () => import('@/views/ConversationView.vue')
  },
  {
    meta: {
      title: 'Web_Answers'
    },
    path: '/Web_Answers',
    name: 'Web Answers',
    component: () => import('@/views/WebAnswers.vue')
  },
  {
    meta: {
      title: 'User'
    },
    path: '/User',
    name: 'User',
    component: () => import('@/views/UserView.vue')
  },
  {
    meta: {
      title: 'Places'
    },
    path: '/Places',
    name: 'Places',
    component: () => import('@/views/Places.vue')
  },
  {
    meta: {
      title: 'FlexMessage'
    },
    path: '/FlexMessage',
    name: 'FlexMessage',
    component: () => import('@/views/FlexMessage.vue')
  },
  {
    meta: {
      title: 'Event'
    },
    path: '/Event',
    name: 'Event',
    component: () => import('@/views/Event.vue')
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    return savedPosition || { top: 0 }
  }
})

export default router
