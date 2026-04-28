<script setup>
import { ref, onMounted } from 'vue';
import ClientService from './services/ClientService.js';

const clients = ref([]);

onMounted(async () => {
  try {
    const response = await ClientService.getClients();
    clients.value = response.data;
  } catch (error) {
    console.error('There was an error!', error);
  }
});
</script>

<template>
  <router-view />
</template>

<style scoped></style>
