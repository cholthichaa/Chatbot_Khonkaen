<template>
  <LayoutAuthenticated>
    <SectionMain>
      <SectionTitleLineWithButton :icon="mdiTableBorder" title="Web Answer" main />
      <CardBox class="mb-6" has-table>
        <table class="w-full">
          <thead>
            <tr>
              <th>No</th>
              <th>Place Name</th>
              <th>Answers</th>
              <th>Intents</th>
              <th>Image link</th>
              <th>Image detail</th>
              <th>Contact link</th>
              <th>Created</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(web, index) in web" :key="web.id">
              <td>{{ index + 1 }}</td>
              
              <td :class="!web.place_name ? 'text-red-500' : ''">
                {{ web.place_name || 'No data available' }}
              </td>

              <td>{{ web.answer_text }}</td>
              <td>{{ web.intent_type }}</td>

              <td :class="!web.image_link ? 'text-red-500' : ''">
                {{ web.image_link || 'No data available' }}
              </td>
              <td :class="!web.image_detail ? 'text-red-500' : ''">
                {{ web.image_detail || 'No data available' }}
              </td>

              <td :class="!web.contact_link ? 'text-red-500' : ''">
                {{ web.contact_link || 'No data available' }}
              </td>

              <td>{{ formatDate(web.created_at) }}</td>
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
import { useWebStore } from '@/stores/modules/web_ans'

const formatDate = (date) => {
  return date ? new Date(date).toLocaleDateString() : '-'
}

const store = useWebStore()
const web = computed(() => store.web)

onMounted(async () => {
  await store.fetchWeb()
  console.log('Web answers in Component after fetch:', web.value) 
})
</script>
