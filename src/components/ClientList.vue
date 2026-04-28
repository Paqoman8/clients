<script setup>
import { ref, onMounted } from 'vue';
import ClientService from '../services/ClientService.js';
import EditClientModal from './EditClientModal.vue';

const clients = ref([]);
const isModalVisible = ref(false);
const selectedClient = ref(null);

onMounted(async () => {
  try {
    const response = await ClientService.getClients();
    clients.value = response.data;
  } catch (error) {
    console.error('There was an error!', error);
  }
});

const clientType = (type) => {
  if (type === 'P') return 'Particulier';
  if (type === 'E') return 'Entreprise';
  return type;
};

function openEditModal(client) {
  selectedClient.value = client;
  isModalVisible.value = true;
}

function closeEditModal() {
  isModalVisible.value = false;
  selectedClient.value = null;
}

async function handleSaveClient(clientData) {
  if (clientData.id) { // Update existing client
    try {
      await ClientService.updateClient(clientData);
      const index = clients.value.findIndex(c => c.id === clientData.id);
      if (index !== -1) {
        clients.value[index] = clientData;
      }
    } catch (error) {
      console.error('Failed to update client:', error);
    }
  } else { // Create new client
    try {
      const response = await ClientService.createClient(clientData);
      clients.value.push(response.data);
    } catch (error) {
      console.error('Failed to create client:', error);
    }
  }
  closeEditModal();
}

function openNewModal() {
  selectedClient.value = null; // Important to pass null for a new client
  isModalVisible.value = true;
}
</script>

<template>
  <div>
    <div class="toolbar">
      <h1>Liste des clients</h1>
      <button @click="openNewModal">New Client</button>
    </div>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Type</th>
          <th>Nom</th>
          <th>Prénom</th>
          <th>Raison Sociale</th>
          <th>Téléphone</th>
          <th>Email</th>
          <th>Adresse</th>
          <th>Taux Remise</th>
          <th>État</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="client in clients" :key="client.id">
          <td>{{ client.id }}</td>
          <td>{{ clientType(client.type_client) }}</td>
          <td>{{ client.nom }}</td>
          <td>{{ client.prenom }}</td>
          <td>{{ client.raison_sociale }}</td>
          <td>{{ client.telephone }}</td>
          <td>{{ client.email }}</td>
          <td>{{ client.adresse }}</td>
          <td>{{ client.taux_remise }}%</td>
          <td>{{ client.etat ? 'Actif' : 'Inactif' }}</td>
          <td>
            <button @click="openEditModal(client)">Edit</button>
          </td>
        </tr>
      </tbody>
    </table>
    <EditClientModal 
      :show="isModalVisible" 
      :client="selectedClient" 
      @close="closeEditModal"
      @save="handleSaveClient"
    />
  </div>
</template>

<style scoped>
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #ddd;
  padding: 8px;
}
th {
  background-color: #f2f2f2;
  text-align: left;
}
</style>
