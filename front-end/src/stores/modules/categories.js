import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'
import Swal from 'sweetalert2'

export const useCategoriesStore = defineStore('categories', () => {
  const categories = ref([])

  async function fetchCategories() {
    const url = ENDPOINT.CATEGORISE
    try {
      const res = await axios.get(url)
      console.log('Fetched categories:', res.data)
      if (res.status === 200) {
        categories.value = res.data
      }
    } catch (error) {
      console.error('Error fetching categories:', error)
    }
  }

  async function addCategories(categoriesToAdd) {
    try {
      const payload = { categories_name: categoriesToAdd.categories_name }
      console.log('Payload to send:', payload)

      await axios.post(`${ENDPOINT.CATEGORISE}`, payload, {
        headers: {
          'Content-Type': 'application/json' 
        }
      })
      await fetchCategories()
    } catch (error) {
      console.error(
        'Error adding categories:',
        error.response ? error.response.data : error.message
      )
      Swal.fire({
        icon: 'error',
        title: 'Error Adding Categories',
        text: error.response ? error.response.data : error.message
      })
    }
  }

  const updateCategories = async (categoriesToUpdate) => {
    if (!categoriesToUpdate.id) {
      console.error('Categories ID is required for updating.')
      return
    }
  
    try {
      const payload = { categories_name: categoriesToUpdate.categories_name }
      console.log('Updating category with payload:', payload)
  
      const response = await axios.patch(
        `${ENDPOINT.CATEGORISE}/${categoriesToUpdate.id}`,
        payload,
        {
          headers: {
            'Content-Type': 'application/json'
          }
        }
      )
  
      console.log('Update response:', response.data)
      await fetchCategories()
      console.log('The category has been updated successfully.')
    } catch (error) {
      console.error('Error updating categories:', error.response ? error.response.data : error.message)
    }
  }
  

  const deleteCategories = async (id) => {
    if (!id) {
      console.error('Categories ID is required.')
      return
    }
  
    try {
      console.log(`Deleting category with ID: ${id}`)
  
      const response = await axios.delete(`${ENDPOINT.CATEGORISE}/${id}`, {
        headers: {
          'Content-Type': 'application/json'
        }
      })
  
      console.log('Delete response:', response.data)
      console.log(`Category with ID ${id} deleted successfully.`)
      await fetchCategories()
    } catch (error) {
      console.error('Error deleting category:', error.response ? error.response.data : error.message)
    }
  }
  

  return {
    categories,
    fetchCategories,
    addCategories,
    updateCategories,
    deleteCategories
  }
})
