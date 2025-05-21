<script setup>
import { RouterView } from 'vue-router'
import DataFromBackend from './components/DataFromBackend.vue'
</script>

<template>
  <RouterView />
  <div id="app">
    <DataFromBackend />
  </div>
</template>
