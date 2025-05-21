import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'  

export const useDashboardStore = defineStore('dashboard', () => {
  const tablecounts = ref({})

  async function getTableCounts() {
    const url = `${ENDPOINT.DASHBOARD}` 
    try {
      const res = await axios.get(url)
      console.log('Fetched table counts:', res.data)
      if (res.status === 200) {
        tablecounts.value = res.data
      }
    } catch (error) {
      console.error('Error fetching counts:', error)
    }
  }

  return {
    getTableCounts,
    tablecounts,
  }
})
