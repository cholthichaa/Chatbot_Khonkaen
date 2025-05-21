<template>
  <LayoutAuthenticated>
    <SectionMain>
      <SectionTitleLineWithButton :icon="mdiTableBorder" title="Users" main />
      <CardBox class="mb-6" has-table>
        <table class="w-full">
          <thead>
            <tr>
              <th>No</th>
              <th>Username</th>
              <th>Line ID</th>
              <th>Picture</th> 
              <th>Created</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(user, index) in users" :key="user.id">
              <td>{{ index + 1 }}</td>
              <td>{{ user.display_name }}</td>
              <td>{{ user.line_id }}</td>
              <td>
                <img
                  :src="user.picture_url"
                  alt="User Picture"
                  v-if="user.picture_url"
                  class="w-16 h-16 rounded-full object-cover"
                />
                <span v-else>No Image</span>
              </td>
              <td>{{ new Date(user.created_at).toLocaleDateString() }}</td>
            </tr>
          </tbody>
        </table>
      </CardBox>
    </SectionMain>
  </LayoutAuthenticated>
</template>

<script setup>
import SectionMain from '@/components/SectionMain.vue'
import CardBox from '@/components/CardBox.vue'
import LayoutAuthenticated from '@/layouts/LayoutAuthenticated.vue'
import SectionTitleLineWithButton from '@/components/SectionTitleLineWithButton.vue'
import { computed, onMounted } from 'vue'
import { useUsersStore } from '@/stores/modules/users'
const store = useUsersStore()
const users = computed(() => {
  return [...store.users].sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
})

onMounted(() => {
  store.fetchUsers()
  console.log('Users in Component:', users.value)
})
</script>