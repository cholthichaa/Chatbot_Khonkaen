import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'

export const useConversationStore = defineStore('conversations', () => {
  const conversations = ref([])

  async function fetchConversations() {
    const url = `${ENDPOINT.CONVERSATIONS}`
    try {
      const res = await axios.get(url)
      if (res.status === 200) {
        console.log('Fetched conversations:', res.data)
        conversations.value = res.data
      }
    } catch (error) {
      console.error('Error fetching conversations:', error)
    }
  }

  return {
    conversations,
    fetchConversations
  }
})
