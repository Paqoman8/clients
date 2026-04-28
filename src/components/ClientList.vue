<script setup>
import { ref, onMounted } from 'vue';
import ClientService from '../services/ClientService.js';
import EditClientModal from './EditClientModal.vue';

const clients = ref([]);
const isModalVisible = ref(false);
const selectedClient = ref(null);

// Ajout d'un état de chargement pour l'UX
const isLoading = ref(true);

async function loadClients() {
  isLoading.value = true;
  try {
    const response = await ClientService.getClients();
    clients.value = response.data;
  } catch (error) {
    console.error('Erreur lors du chargement des clients:', error);
  } finally {
    isLoading.value = false;
  }
}

onMounted(() => {
  loadClients();
});

function openEditModal(client) {
  selectedClient.value = client;
  isModalVisible.value = true;
}

function closeEditModal() {
  isModalVisible.value = false;
  selectedClient.value = null;
}

async function handleSaveClient(clientData) {
  if (clientData.id) {
    try {
      await ClientService.updateClient(clientData);
      const index = clients.value.findIndex(c => c.id === clientData.id);
      if (index !== -1) {
        clients.value[index] = clientData;
      }
    } catch (error) {
      console.error('Failed to update client:', error);
    }
  } else {
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
  selectedClient.value = null;
  isModalVisible.value = true;
}
</script>

<template>
  <div class="client-view">
    <!-- Toolbar -->
    <div class="toolbar glass-panel">
      <div class="toolbar-left">
        <h1 class="page-title">Portefeuille Clients</h1>
        <p class="subtitle">Gérez vos relations clients avec élégance</p>
      </div>
      <button class="btn-primary" @click="openNewModal">
        <span class="icon">+</span> Nouveau Client
      </button>
    </div>

    <!-- Loading State -->
    <div v-if="isLoading" class="loading-state glass-panel">
      <div class="spinner"></div>
      <p>Chargement des données...</p>
    </div>

    <!-- Data Table -->
    <div v-else class="table-container glass-panel">
      <table class="data-table">
        <thead>
          <tr>
            <th>Type</th>
            <th>Client</th>
            <th>Contact</th>
            <th>Localisation</th>
            <th>Remise</th>
            <th>Statut</th>
            <th class="align-right">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="client in clients" :key="client.id" class="table-row">
            <td>
              <span class="type-badge" :class="client.type_client === 'E' ? 'type-e' : 'type-p'">
                {{ client.type_client === 'E' ? 'PRO' : 'PART' }}
              </span>
            </td>
            <td>
              <div class="client-name">
                <span class="primary-name">
                  {{ client.type_client === 'E' ? client.raison_sociale : `${client.nom} ${client.prenom || ''}` }}
                </span>
                <span class="secondary-name" v-if="client.type_client === 'E' && client.nom">
                  Réf: {{ client.nom }} {{ client.prenom }}
                </span>
              </div>
            </td>
            <td>
              <div class="contact-info">
                <span v-if="client.telephone" class="contact-item">
                  <span class="contact-icon">✆</span> {{ client.telephone }}
                </span>
                <span v-if="client.email" class="contact-item text-muted">
                  <span class="contact-icon">✉</span> {{ client.email }}
                </span>
              </div>
            </td>
            <td class="location-col">{{ client.adresse || '-' }}</td>
            <td>
              <span class="discount" v-if="client.taux_remise > 0">{{ client.taux_remise }}%</span>
              <span class="text-muted" v-else>-</span>
            </td>
            <td>
              <span class="status-badge" :class="client.etat ? 'status-active' : 'status-inactive'">
                <span class="status-dot"></span>
                {{ client.etat ? 'Actif' : 'Inactif' }}
              </span>
            </td>
            <td class="align-right">
              <button class="btn-icon" @click="openEditModal(client)" title="Modifier ce client">
                ✎
              </button>
            </td>
          </tr>
          <tr v-if="clients.length === 0">
            <td colspan="7" class="empty-state">
              Aucun client trouvé. Commencez par en ajouter un !
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <EditClientModal 
      :show="isModalVisible" 
      :client="selectedClient" 
      @close="closeEditModal"
      @save="handleSaveClient"
    />
  </div>
</template>

<style scoped>
.client-view {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

/* Toolbar */
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px 32px;
}

.page-title {
  font-size: 2rem;
  color: var(--text-main);
  margin-bottom: 4px;
}

.subtitle {
  color: var(--text-muted);
  font-size: 0.95rem;
}

.btn-primary .icon {
  margin-right: 6px;
  font-size: 1.1em;
  font-weight: normal;
}

/* Loading */
.loading-state {
  padding: 60px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 20px;
  color: var(--primary-gold);
}

.spinner {
  width: 40px;
  height: 40px;
  border: 3px solid var(--surface-border);
  border-top-color: var(--primary-gold);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin { to { transform: rotate(360deg); } }

/* Table */
.table-container {
  overflow-x: auto;
  padding: 0;
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.data-table th {
  padding: 20px 24px;
  color: var(--text-muted);
  font-weight: 500;
  font-size: 0.85rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  border-bottom: 1px solid var(--surface-border);
}

.data-table td {
  padding: 20px 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.03);
  vertical-align: middle;
}

.table-row {
  transition: var(--transition-fast);
}

.table-row:hover {
  background-color: rgba(255, 255, 255, 0.02);
}

.table-row:last-child td {
  border-bottom: none;
}

.align-right {
  text-align: right;
}

/* Badges & Cell Content */
.type-badge {
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 0.75rem;
  font-weight: 700;
  letter-spacing: 0.05em;
}

.type-e {
  background: rgba(139, 92, 246, 0.15);
  color: #a78bfa;
  border: 1px solid rgba(139, 92, 246, 0.3);
}

.type-p {
  background: rgba(56, 189, 248, 0.15);
  color: #7dd3fc;
  border: 1px solid rgba(56, 189, 248, 0.3);
}

.client-name {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.primary-name {
  font-weight: 600;
  font-size: 1.05rem;
  color: var(--text-main);
}

.secondary-name {
  font-size: 0.8rem;
  color: var(--text-muted);
}

.contact-info {
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-size: 0.9rem;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 8px;
}

.contact-icon {
  color: var(--primary-gold);
  font-size: 1rem;
}

.text-muted {
  color: var(--text-muted);
}

.location-col {
  color: var(--text-muted);
  font-size: 0.9rem;
  max-width: 200px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.discount {
  font-weight: 600;
  color: var(--primary-gold);
  background: var(--primary-gold-light);
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 0.9rem;
}

.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
}

.status-active {
  background: var(--status-active-bg);
  color: var(--status-active-text);
}

.status-inactive {
  background: var(--status-inactive-bg);
  color: var(--status-inactive-text);
}

.status-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: currentColor;
}

.status-active .status-dot { box-shadow: 0 0 8px currentColor; }

/* Buttons */
.btn-icon {
  background: transparent;
  border: 1px solid var(--surface-border);
  color: var(--text-muted);
  width: 36px;
  height: 36px;
  border-radius: 8px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: var(--transition-fast);
  font-size: 1.1rem;
}

.btn-icon:hover {
  background: var(--primary-gold-light);
  color: var(--primary-gold);
  border-color: var(--primary-gold);
  transform: translateY(-2px);
}

.empty-state {
  text-align: center;
  padding: 40px !important;
  color: var(--text-muted);
  font-style: italic;
}
</style>
