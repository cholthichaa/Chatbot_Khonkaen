import { defineStore } from 'pinia'
import { reactive } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'
import Swal from 'sweetalert2'

export const usePlacesStore = defineStore('places', () => {
  const places = reactive([])

  async function fetchPlaces() {
    console.log('📥 Fetching places from:', ENDPOINT.PLACES)
    try {
      const res = await axios.get(ENDPOINT.PLACES)
      console.log('✅ Places fetched successfully:', res.data)

      if (res.status === 200) {
        places.length = 0  
        places.push(...res.data.map(place => ({
          ...place,
          images: place.images || []
        })))
      }
    } catch (error) {
      console.error('❌ Error fetching places:', error)
    }
  }

  async function addPlaces(placesToAdd) {
    console.log('📤 Adding new place:', placesToAdd)
    try {
      if (!placesToAdd.images || !Array.isArray(placesToAdd.images)) {
        placesToAdd.images = []
      }

      const res = await axios.post(ENDPOINT.PLACES, placesToAdd)
      console.log('✅ Place added successfully:', res.data)

      await fetchPlaces()
    } catch (error) {
      console.error('❌ Error adding place:', error.response ? error.response.data : error.message)
      Swal.fire({
        icon: 'error',
        title: 'Error Adding Place',
        text: error.response ? error.response.data : error.message
      })
    }
  }

  const updatePlaces = async (placesToUpdate) => {
    console.log('📤 Updating place:', placesToUpdate)
    try {
      const res = await axios.patch(`${ENDPOINT.PLACES}/${placesToUpdate.id}`, placesToUpdate)
      console.log('✅ Place updated successfully:', res.data)

      if (placesToUpdate.images && placesToUpdate.images.length > 0) {
        console.log('📤 Updating images for place ID:', placesToUpdate.id, placesToUpdate.images)
        const imgRes = await axios.patch(`${ENDPOINT.PLACES}/${placesToUpdate.id}/images`, {
          images: placesToUpdate.images
        })
        console.log('✅ Images updated successfully:', imgRes.data)
      }
      await fetchPlaces()
    } catch (error) {
      console.error('❌ Error updating place:', error)
    }
  }
  const updatePlaceImages = async (placeId, newImages) => {
    try {
      const response = await axios.patch(`${ENDPOINT.PLACES}/${placeId}/images`, { images: newImages });
      console.log('✅ Images updated successfully:', response.data);
    } catch (error) {
      console.error('❌ Error updating images:', error.response ? error.response.data : error.message);
    }
  };
  
  const deletePlaces = async (id) => {
    if (!id) {
      console.error('❌ Error: Place ID is required for deletion')
      return
    }

    console.log('🗑 Deleting place with ID:', id)
    try {
      const res = await axios.delete(`${ENDPOINT.PLACES}/${id}`)
      console.log(`✅ Place with ID ${id} deleted successfully.`, res.data)

      await fetchPlaces()
    } catch (error) {
      console.error('❌ Error deleting place:', error)
      throw error
    }
  }

  return {
    places,
    fetchPlaces,
    updatePlaceImages,
    addPlaces,
    updatePlaces,
    deletePlaces
  }
})
