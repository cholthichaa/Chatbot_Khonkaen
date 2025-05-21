import { defineStore } from 'pinia'
import { ref } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'
import Swal from 'sweetalert2'

export const useFlexTouristStore = defineStore('flextourist', () => {
  const flextourist = ref([])

  async function fetchFlexTourist() {
    const url = ENDPOINT.FLEXTOURIST
    try {
      const res = await axios.get(url)
      console.log('✅ Fetched flextourist:', res.data)

      if (res.status === 200) {
        flextourist.value = res.data
      } else {
        flextourist.value = []
      }
    } catch (error) {
      console.error('❌ Error fetching flextourist:', error)
      flextourist.value = []
      Swal.fire({
        icon: 'error',
        title: 'Error Fetching FlexTourist',
        text: error.response ? error.response.data : error.message
      })
    }
  }

  async function addFlexTourist(flextouristToAdd) {
    try {
      const payload = {
        name: flextouristToAdd.tourist_name.trim(), // ✅ ใช้ tourist_name
        place_id: parseInt(flextouristToAdd.place_id, 10)
      }

      console.log('📤 Sending payload:', payload)

      const response = await axios.post(ENDPOINT.FLEXTOURIST, payload, {
        headers: { 'Content-Type': 'application/json' }
      })

      console.log('✅ Response from add:', response.data)
      await fetchFlexTourist()
    } catch (error) {
      console.error('❌ Error adding flextourist:', error.response || error.message)
      Swal.fire({
        icon: 'error',
        title: 'Error Adding FlexTourist',
        text: error.response?.data || 'An error occurred while adding the item.'
      })
    }
  }

  async function updateFlexTourist(flextouristToUpdate) {
    if (!flextouristToUpdate.id) {
      console.error('❌ [updateFlexTourist] Error: FlexTourist ID is required for updating.');
      return;
    }
  
    console.log("📌 [updateFlexTourist] Raw places before filtering:", JSON.stringify(flextouristToUpdate.places, null, 2));
  
    const formattedPlaces = (flextouristToUpdate.places || [])
      .map(place => (typeof place === 'number' ? { place_id: place } : place)) // ✅ แปลง number ให้เป็น object
      .filter(place => place && place.place_id && !isNaN(Number(place.place_id)))
      .map(place => ({
        place_id: Number(place.place_id)
      }));
  
    console.log("📌 [updateFlexTourist] Places after filtering:", JSON.stringify(formattedPlaces, null, 2));
  
    if (formattedPlaces.length === 0) {
      Swal.fire({
        icon: 'warning',
        title: 'Validation Error',
        text: 'Please select a valid place before updating.'
      });
      console.warn("⚠️ [updateFlexTourist] No valid places found. Aborting update.");
      return;
    }
  
    try {
      const payload = {
        name: flextouristToUpdate.tourist_name.trim(),
        place_id: formattedPlaces[0].place_id // ✅ ส่งค่าเดียว
      };
      
  
      console.log('📤 [updateFlexTourist] Sending payload:', JSON.stringify(payload, null, 2));
  
      const response = await axios.patch(
        `${ENDPOINT.FLEXTOURIST}/${flextouristToUpdate.id}`,
        payload,
        {
          headers: { 'Content-Type': 'application/json' }
        }
      );
  
      console.log('✅ [updateFlexTourist] Update response:', JSON.stringify(response.data, null, 2));
  
      await fetchFlexTourist();
    } catch (error) {
      console.error('❌ [updateFlexTourist] Error while updating:', error.response || error.message);
      Swal.fire({
        icon: 'error',
        title: 'Error Updating FlexTourist',
        text: error.response?.data || error.message
      });
    }
  }
  
  async function deleteFlexTourist(tourist_id) {
    try {
      console.log(`🗑 Deleting FlexTourist with ID: ${tourist_id}`)

      const response = await axios.delete(`${ENDPOINT.FLEXTOURIST}/${tourist_id}`, {
        headers: { 'Content-Type': 'application/json' }
      })

      if (response.status === 200 || response.status === 204) {
        console.log(`✅ FlexTourist with ID ${tourist_id} deleted successfully.`)
        await fetchFlexTourist()
      } else {
        throw new Error(`Unexpected response status: ${response.status}`)
      }
    } catch (error) {
      console.error('❌ Error deleting flextourist:', error)
      Swal.fire({
        icon: 'error',
        title: 'Error Deleting FlexTourist',
        text: error.response?.data || 'An error occurred while deleting the item.'
      })
    }
  }

  return {
    flextourist,
    fetchFlexTourist,
    addFlexTourist,
    updateFlexTourist,
    deleteFlexTourist
  }
})
