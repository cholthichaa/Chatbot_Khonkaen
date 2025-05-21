<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';

const message = ref('');
const apiBaseUrl = import.meta.env.VITE_APP_API_BASE; 

onMounted(() => {
  axios.get(`${apiBaseUrl}/api/data`)  
    .then(response => {
      message.value = response.data.message;
    })
    .catch(error => {
      console.error('There was an error!', error);
    });
});
</script>

<style scoped>
</style>
