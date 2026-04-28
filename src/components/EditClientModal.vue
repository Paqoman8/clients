<script setup>
import { defineProps, defineEmits, ref, watch, computed } from 'vue';

const props = defineProps({
  client: Object,
  show: Boolean
});

const emit = defineEmits(['close', 'save']);

const editableClient = ref(null);

const isNewClient = computed(() => !props.client || !props.client.id);

watch(() => props.client, (newClient) => {
  if (newClient) {
    editableClient.value = { ...newClient };
  } else {
    editableClient.value = {
      type_client: 'P',
      nom: '',
      prenom: '',
      raison_sociale: '',
      telephone: '',
      email: '',
      adresse: '',
      taux_remise: 0.00,
      etat: 1
    };
  }
}, { immediate: true, deep: true });

function closeModal() {
  emit('close');
}

function saveChanges() {
  emit('save', editableClient.value);
}
</script>

<template>
  <div v-if="show" class="modal-overlay">
    <div class="modal-content">
      <h2>{{ isNewClient ? 'Ajouter un client' : 'Modifier le client' }}</h2>
      <form v-if="editableClient" @submit.prevent="saveChanges">
        <div class="form-row">
          <div class="form-group">
            <label>Nom</label>
            <input type="text" v-model="editableClient.nom" required />
          </div>
          <div class="form-group">
            <label>Prénom</label>
            <input type="text" v-model="editableClient.prenom" />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label>Email</label>
            <input type="email" v-model="editableClient.email" />
          </div>
          <div class="form-group">
            <label>Téléphone</label>
            <input type="text" v-model="editableClient.telephone" />
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label>Type</label>
            <select v-model="editableClient.type_client">
              <option value="P">Particulier</option>
              <option value="E">Entreprise</option>
            </select>
          </div>
          <div class="form-group">
            <label>État</label>
            <select v-model="editableClient.etat">
              <option :value="1">Actif</option>
              <option :value="0">Inactif</option>
            </select>
          </div>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label>Raison Sociale</label>
            <input type="text" v-model="editableClient.raison_sociale" />
          </div>
          <div class="form-group">
            <label>Adresse</label>
            <input type="text" v-model="editableClient.adresse" />
          </div>
        </div>
        <div class="form-group">
          <label>Taux Remise (%)</label>
          <input type="number" step="0.01" v-model="editableClient.taux_remise" />
        </div>
        <div class="modal-actions">
          <button type="button" @click="closeModal">Annuler</button>
          <button type="submit">{{ isNewClient ? 'Ajouter' : 'Modifier' }}</button>
        </div>
      </form>
    </div>
  </div>
</template>

<style scoped>
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}
.modal-content {
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  width: 600px;
}
.form-row {
  display: flex;
  gap: 20px;
  margin-bottom: 15px;
}
.form-group {
  flex: 1;
  margin-bottom: 0;
}
.form-group label {
  display: block;
  margin-bottom: 5px;
}
.form-group input, .form-group select {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}
.modal-actions {
  text-align: right;
  margin-top: 20px;
}
.modal-actions button {
  margin-left: 10px;
}
</style>
