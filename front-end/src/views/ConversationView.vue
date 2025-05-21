<template>
  <LayoutAuthenticated>
    <SectionMain>
      <SectionTitleLineWithButton :icon="mdiTableBorder" title="Conversations" main />
      <CardBox class="mb-6" has-table>
        <table class="w-full">
          <thead>
            <tr>
              <th>No</th>
              <th>Question</th>
              <th>Answers</th>
              <th>UserId</th>
              <th>WebAnswerId</th>
              <th>PlaceId</th>
              <th>SourceType</th>
              <th>Created</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(conversation, index) in sortedConversations" :key="conversation.id" class="odd:bg-white even:bg-gray-50">
              <td>{{ index + 1 }}</td>
              <td class="border border-gray-300 px-4 py-2" :class="{ 'text-red-500': isEmpty(conversation.question_text) }">
                {{ formatValue(conversation.question_text) }}
              </td>
              <td class="border border-gray-300 px-4 py-2" :class="{ 'text-red-500': isEmpty(conversation.answer_text) }">
                {{ formatValue(conversation.answer_text) }}
              </td>
              <td class="border border-gray-300 px-4 py-2" :class="{ 'text-red-500': isEmpty(conversation.user_id) }">
                {{ formatValue(conversation.user_id) }}
              </td>
              <td class="border border-gray-300 px-4 py-2" :class="{ 'text-red-500': isEmpty(conversation.web_answer_id) }">
                {{ formatValue(conversation.web_answer_id) }}
              </td>
              <td class="border border-gray-300 px-4 py-2" :class="{ 'text-red-500': isEmpty(conversation.place_id) }">
                {{ formatValue(conversation.place_id) }}
              </td>
              <td class="border border-gray-300 px-4 py-2" :class="{ 'text-red-500': isEmpty(conversation.source_type) }">
                {{ formatValue(conversation.source_type) }}
              </td>
              <td class="border border-gray-300 px-4 py-2">{{ formatDate(conversation.created_at) }}</td>
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
import { useConversationStore } from '@/stores/modules/conversations'

const isEmpty = (value) => {
  return value === null || value === undefined || value === '';
}

const formatValue = (value) => {
  return isEmpty(value) ? 'No data available	' : value;
}

const formatDate = (date) => {
  return date ? new Date(date).toLocaleDateString() : '-';
}

const store = useConversationStore()

const sortedConversations = computed(() => {
  return [...store.conversations].sort((a, b) => {
    if (a.user_id !== b.user_id) {
      return a.user_id - b.user_id; // เรียงตาม user_id ก่อน
    }
    return new Date(b.created_at) - new Date(a.created_at); // ถ้า user_id เท่ากันให้เรียง created_at จากล่าสุดไปเก่าสุด
  });
});

onMounted(() => {
  store.fetchConversations()
  console.log('Sorted Conversations in Component:', sortedConversations.value)
});
</script>