import { defineStore } from 'pinia';
import axios from 'axios';
import { ENDPOINT } from '@/constants/endpoint';  // นำเข้า ENDPOINT

export const useUsersStore = defineStore('users', {
  state: () => ({
    users: []
  }),
  actions: {
    async fetchUsers() {
      try {
        const res = await axios.get(ENDPOINT.USERS);  // ใช้ ENDPOINT.USERS สำหรับ URL
        if (res.status === 200) {
          console.log('Fetched Users:', res.data);
          this.users = res.data;
        }
      } catch (error) {
        console.error('Error fetching Users:', error);
      }
    }
  }
});
