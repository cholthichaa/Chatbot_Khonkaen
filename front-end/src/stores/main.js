import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import axios from 'axios'
import { ENDPOINT } from '@/constants/endpoint'
import Swal from 'sweetalert2'
export const useMainStore = defineStore('main', () => {
  const userName = ref('Admin Chatbot')
  const userEmail = ref('doe.doe.doe@example.com')

  const userAvatar = computed(
    () =>
      `https://api.dicebear.com/7.x/avataaars/svg?seed=${userEmail.value.replace(
        /[^a-z0-9]+/gi,
        '-'
      )}`
  )

  const isFieldFocusRegistered = ref(false)
  const clients = ref([])
  const history = ref([])
  const places = ref([])
  const categories = ref([])
  const users = ref([])
  const conversations = ref([])
  const web = ref([])
  const tablecounts = ref([])
  const flextourist = ref([])
  const event = ref([])

  function setUser(payload) {
    if (payload.name) {
      userName.value = payload.name
    }
    if (payload.email) {
      userEmail.value = payload.email
    }
  }
    async function fetchPlaces() {
      console.log('📥 Fetching places from:', ENDPOINT.PLACES)
      try {
        const res = await axios.get(ENDPOINT.PLACES)
        console.log('✅ Places fetched successfully:', res.data)
  
        if (res.status === 200) {
          places.value = res.data.map(place => ({
            ...place,
            images: place.images || [] // เผื่อกรณีไม่มีภาพ
          }))
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
  
        // ถ้ามีรูปใหม่ ต้องอัปเดตแยก
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
      console.log('Categories to add:', categoriesToAdd)

      await axios.post(`${ENDPOINT.CATEGORISE}`, categoriesToAdd)
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
      console.error(
        'Error updating categories:',
        error.response ? error.response.data : error.message
      )
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
      console.error(
        'Error deleting category:',
        error.response ? error.response.data : error.message
      )
    }
  }

  async function fetchUsers() {
    try {
      const res = await axios.get(ENDPOINT.USERS);  
      if (res.status === 200) {
        console.log('Fetched Users:', res.data);
        users.value = res.data;
      }
    } catch (error) {
      console.error('Error fetching Users:', error);
    }
  }
  
  async function fetchWeb() {
    try {
      const res = await axios.get(ENDPOINT.WEB);  
      console.log('Response data:', res.data);
      if (res.status === 200) {
        web.value = res.data;
        console.log('Fetched web answers:', web.value);
      }
    } catch (error) {
      console.error('Error fetching web answers:', error);
    }
  }
  
  async function fetchConversations() {
    try {
      const res = await axios.get(ENDPOINT.CONVERSATIONS);  
      if (res.status === 200) {
        console.log('Fetched conversations:', res.data);
        conversations.value = res.data;
      }
    } catch (error) {
      console.error('Error fetching conversations:', error);
    }
  }
  

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

  async function fetchFlexTourist() {
    const url = ENDPOINT.FLEXTOURIST
    try {
      const res = await axios.get(url)
      if (res.status === 200) {
        flextourist.value = res.data
      }
    } catch (error) {
      console.error('Error fetching flextourist:', error)
    }
  }

  async function addFlexTourist(flextouristToAdd) {
    try {
      const payload = {
        name: flextouristToAdd.tourist_name.trim(), 
        place_id: parseInt(flextouristToAdd.place_id, 10),
      };

      console.log("📤 Sending payload:", payload);

      const response = await axios.post(ENDPOINT.FLEXTOURIST, payload, {
        headers: { "Content-Type": "application/json" },
      });

      console.log("✅ Response from add:", response.data);
      await fetchFlexTourist();
    } catch (error) {
      console.error("❌ Error adding flextourist:", error.response || error.message);
      Swal.fire({
        icon: "error",
        title: "Error Adding FlexTourist",
        text: error.response?.data || "An error occurred while adding the item.",
      });
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
        place_id: formattedPlaces[0].place_id 
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
  
  const deleteFlexTourist = async (tourist_id) => {
    try {
        console.log(`Deleting FlexTourist with ID: ${tourist_id}`);
        const response = await axios.delete(`${ENDPOINT.FLEXTOURIST}/${tourist_id}`, {
            headers: {
                'Content-Type': 'application/json',
            },
        });

        console.log('Response from delete:', response);

        if (response.status === 200 || response.status === 204) {
            console.log(`FlexTourist with ID ${tourist_id} deleted successfully.`);
            await fetchFlexTourist();
        } else {
            throw new Error(`Unexpected response status: ${response.status}`);
        }
    } catch (error) {
        console.error('Error deleting flextourist:', error);
        throw error; 
    }
};

async function fetchEvent() {
  const url = ENDPOINT.EVENT
  try {
    const res = await axios.get(url)
    console.log('Fetched event:', res.data)
    if (res.status === 200) {
      event.value = res.data
    }
  } catch (error) {
    console.error('❌ Error fetching event:', error)
  }
}

async function addEvent(eventToAdd) {
  try {
    console.log('📤 Axios Sending Data:', eventToAdd)
    const res = await axios.post(ENDPOINT.EVENT, eventToAdd)
    console.log('✅ Event Added Successfully:', res.data)

    await fetchEvent()

    Swal.fire({
      icon: 'success',
      title: 'Success!',
      text: 'Event added successfully!',
      timer: 1500,
      showConfirmButton: false,
    })
  } catch (error) {
    console.error('❌ Axios Error adding event:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error Adding Event',
      text: error.response?.data || 'Failed to add event'
    })
  }
}

const updateEvent = async (eventToUpdate) => {
  try {
    console.log(`📤 Updating Event ID: ${eventToUpdate.id}`)
    await axios.patch(`${ENDPOINT.EVENT}/${eventToUpdate.id}`, eventToUpdate)

    await fetchEvent()

    Swal.fire({
      icon: 'success',
      title: 'Updated!',
      text: 'Event updated successfully!',
      timer: 1500,
      showConfirmButton: false,
    })
  } catch (error) {
    console.error('❌ Error updating event:', error)
    Swal.fire({
      icon: 'error',
      title: 'Error Updating Event',
      text: error.response?.data || 'Failed to update event'
    })
  }
}

const deleteEvent = async (id) => {
  if (!id) {
    console.error("❌ Error: Event ID is missing")
    return
  }

  try {
    console.log(`📤 Sending DELETE request for Event ID: ${id}`)
    await axios.delete(`${ENDPOINT.EVENT}/${id}`)
    console.log(`✅ Event with ID ${id} deleted successfully.`)

    Swal.fire({
      icon: "success",
      title: "Deleted!",
      text: `Event ID ${id} has been deleted.`,
      timer: 1500,
      showConfirmButton: false,
    })

    event.value = event.value.filter((e) => e.id !== id)
  } catch (error) {
    console.error("❌ Error deleting event:", error)
    Swal.fire({
      icon: "error",
      title: "Error deleting event",
      text: error.response?.data?.error || "Failed to delete event",
    })
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


  return {
    userName,
    userEmail,
    userAvatar,
    updatePlaceImages,
    isFieldFocusRegistered,
    clients,
    history,
    places,
    tablecounts,
    event,
    fetchEvent,
    addEvent,
    updateEvent,
    deleteEvent,
    fetchPlaces,
    fetchUsers,
    addPlaces,
    updatePlaces,
    deletePlaces,
    fetchConversations,
    setUser,
    getTableCounts,
    fetchCategories,
    addCategories,
    updateCategories,
    deleteCategories,
    fetchFlexTourist,
    addFlexTourist,
    updateFlexTourist,
    deleteFlexTourist,
    fetchWeb
  }
})
