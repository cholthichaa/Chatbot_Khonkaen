<script setup>
import {
  mdiAccountMultiple,
  mdiChatProcessing,
  mdiChartTimelineVariant,
  mdiMonitorCellphone,
  mdiWebPlus
} from '@mdi/js'
import * as chartConfig from '@/components/Charts/chart.config.js'
import SectionMain from '@/components/SectionMain.vue'
import CardBoxWidget from '@/components/CardBoxWidget.vue'
import LayoutAuthenticated from '@/layouts/LayoutAuthenticated.vue'
import SectionTitleLineWithButton from '@/components/SectionTitleLineWithButton.vue'
import CardBoxTransaction from '@/components/CardBoxTransaction.vue'
import CardBoxClient from '@/components/CardBoxClient.vue'
import { useDashboardStore } from '@/stores/modules/dashboard'
import { computed, ref, onMounted, watch } from 'vue'

const store = useDashboardStore()
const tableCounts = computed(() => store.tablecounts)

const chartData = ref(null)

const fillChartData = () => {
  chartData.value = chartConfig.sampleChartData()
}

onMounted(() => {
  fillChartData()
  store.getTableCounts()
})

watch(tableCounts, (newVal) => {
  console.log('tableCounts updated:', newVal)
})

const clientBarItems = computed(() => tableCounts.value.clients?.slice(0, 4) || [])
const transactionBarItems = computed(() => tableCounts.value.history || [])
</script>

<template>
  <LayoutAuthenticated>
    <SectionMain>
      <SectionTitleLineWithButton :icon="mdiChartTimelineVariant" title="Overview" main>
      </SectionTitleLineWithButton>

      <div class="grid grid-cols-1 gap-6 lg:grid-cols-3 mb-6">
        <CardBoxWidget
          trend="12%"
          trend-type="up"
          color="text-emerald-500"
          :icon="mdiAccountMultiple"
          :number="tableCounts.users || 0"
          label="Users"
        />

        <CardBoxWidget
          trend="12%"
          trend-type="down"
          color="text-blue-500"
          :icon="mdiWebPlus"
          :number="tableCounts.web_answer || 0"
          label="Web Answers"
        />

        <CardBoxWidget
          trend="Overflow"
          trend-type="alert"
          color="text-red-500"
          :icon="mdiChatProcessing"
          :number="tableCounts.conversations || 0"
          label="Conversations"
        />

        <CardBoxWidget
          trend="Overflow"
          trend-type="alert"
          color="text-yellow-500"
          :icon="mdiMonitorCellphone"
          :number="tableCounts.places || 0"
          label="Places"
        />
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        <div class="flex flex-col justify-between">
          <CardBoxTransaction
            v-for="(transaction, index) in transactionBarItems"
            :key="index"
            :amount="transaction.amount"
            :date="transaction.date"
            :business="transaction.business"
            :type="transaction.type"
            :name="transaction.name"
            :account="transaction.account"
          />
        </div>
        <div class="flex flex-col justify-between">
          <CardBoxClient
            v-for="client in clientBarItems"
            :key="client.id"
            :name="client.name"
            :login="client.login"
            :date="client.created"
            :progress="client.progress"
          />
        </div>
      </div>

      <CardBox has-table>
        <TableSampleClients />
      </CardBox>
    </SectionMain>
  </LayoutAuthenticated>
</template>
