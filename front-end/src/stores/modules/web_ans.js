import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'

export const useWebStore = defineStore('web_ans', () => {
  const web = ref([])

  async function fetchWeb() {
    const url = `${ENDPOINT.WEBANS}`
    try {
      const res = await axios.get(url)
      if (res.status === 200) {
        console.log('Fetched web_ans:', res.data)
        web.value = res.data
      }
    } catch (error) {
      console.error('Error fetching web_ans:', error)
    }
  }

  return {
    web,
    fetchWeb
  }
})
