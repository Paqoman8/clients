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
  <Teleport to="body">
    <transition name="modal">
      <div v-if="show" class="modal-overlay" @click.self="closeModal">
        <div class="modal-content glass-panel">
        <div class="modal-header">
          <h2>{{ isNewClient ? 'Nouveau Client' : 'Modifier le Client' }}</h2>
          <button type="button" class="close-btn" @click="closeModal" aria-label="Fermer">×</button>
        </div>
        
        <form v-if="editableClient" @submit.prevent="saveChanges" class="modern-form">
          <!-- Type & Status -->
          <div class="form-row">
            <div class="form-group">
              <label>Type de Client</label>
              <div class="radio-group">
                <label class="radio-label">
                  <input type="radio" v-model="editableClient.type_client" value="P" />
                  <span class="radio-custom">Particulier</span>
                </label>
                <label class="radio-label">
                  <input type="radio" v-model="editableClient.type_client" value="E" />
                  <span class="radio-custom">Entreprise</span>
                </label>
              </div>
            </div>
            <div class="form-group">
              <label>Statut du compte</label>
              <select v-model="editableClient.etat" class="form-input">
                <option :value="1">Actif</option>
                <option :value="0">Inactif</option>
              </select>
            </div>
          </div>

          <hr class="divider" />

          <!-- Identité -->
          <div class="form-row" v-if="editableClient.type_client === 'P'">
            <div class="form-group">
              <label>Nom <span class="required">*</span></label>
              <input type="text" v-model="editableClient.nom" class="form-input" required placeholder="Ex: Dupont" />
            </div>
            <div class="form-group">
              <label>Prénom</label>
              <input type="text" v-model="editableClient.prenom" class="form-input" placeholder="Ex: Jean" />
            </div>
          </div>
          
          <div class="form-row" v-if="editableClient.type_client === 'E'">
            <div class="form-group">
              <label>Raison Sociale <span class="required">*</span></label>
              <input type="text" v-model="editableClient.raison_sociale" class="form-input" required placeholder="Nom de l'entreprise" />
            </div>
            <div class="form-group">
              <label>Contact (Nom)</label>
              <input type="text" v-model="editableClient.nom" class="form-input" placeholder="Personne de contact" />
            </div>
          </div>

          <!-- Contact -->
          <div class="form-row">
            <div class="form-group">
              <label>Email</label>
              <input type="email" v-model="editableClient.email" class="form-input" placeholder="contact@email.com" />
            </div>
            <div class="form-group">
              <label>Téléphone</label>
              <input type="text" v-model="editableClient.telephone" class="form-input" placeholder="+228..." />
            </div>
          </div>

          <!-- Adresse & Remise -->
          <div class="form-group">
            <label>Adresse</label>
            <input type="text" v-model="editableClient.adresse" class="form-input" placeholder="Adresse complète" />
          </div>

          <div class="form-group half-width">
            <label>Taux de Remise (%)</label>
            <div class="input-with-icon">
              <input type="number" step="0.01" v-model="editableClient.taux_remise" class="form-input" />
              <span class="input-icon">%</span>
            </div>
          </div>

          <div class="modal-actions">
            <button type="button" class="btn-secondary" @click="closeModal">Annuler</button>
            <button type="submit" class="btn-primary">
              {{ isNewClient ? 'Créer le client' : 'Enregistrer' }}
            </button>
          </div>
        </form>
      </div>
    </div>
    </transition>
  </Teleport>
</template>

<style scoped>
/* Overlay with blur */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(15, 23, 42, 0.7);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 100;
}

/* Modal Content */
.modal-content {
  width: 100%;
  max-width: 650px;
  max-height: 90vh;
  overflow-y: auto;
  padding: 32px;
  background: var(--surface-color);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.modal-header h2 {
  color: var(--primary-gold);
  font-size: 1.5rem;
  letter-spacing: 0.02em;
}

.close-btn {
  background: transparent;
  border: none;
  color: var(--text-muted);
  font-size: 2rem;
  cursor: pointer;
  line-height: 1;
  transition: var(--transition-fast);
}

.close-btn:hover {
  color: var(--text-main);
  transform: scale(1.1);
}

.divider {
  border: 0;
  height: 1px;
  background: var(--surface-border);
  margin: 20px 0;
}

/* Form Styles */
.modern-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-row {
  display: flex;
  gap: 20px;
}

.form-group {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.half-width {
  width: 50%;
}

label {
  font-size: 0.9rem;
  font-weight: 500;
  color: var(--text-muted);
  letter-spacing: 0.02em;
}

.required {
  color: #ef4444;
}

.form-input {
  width: 100%;
  background: rgba(15, 23, 42, 0.5);
  border: 1px solid var(--surface-border);
  color: var(--text-main);
  padding: 12px 16px;
  border-radius: var(--radius-md);
  font-family: 'Outfit', sans-serif;
  font-size: 0.95rem;
  transition: var(--transition-fast);
}

.form-input::placeholder {
  color: rgba(148, 163, 184, 0.4);
}

.form-input:focus {
  background: rgba(15, 23, 42, 0.8);
  border-color: var(--primary-gold);
  box-shadow: 0 0 0 3px var(--primary-gold-light);
}

/* Custom Radio */
.radio-group {
  display: flex;
  gap: 12px;
}

.radio-label {
  flex: 1;
  cursor: pointer;
}

.radio-label input {
  display: none;
}

.radio-custom {
  display: block;
  text-align: center;
  padding: 10px;
  background: rgba(15, 23, 42, 0.5);
  border: 1px solid var(--surface-border);
  border-radius: var(--radius-md);
  color: var(--text-muted);
  transition: var(--transition-fast);
}

.radio-label input:checked + .radio-custom {
  background: var(--primary-gold-light);
  border-color: var(--primary-gold);
  color: var(--primary-gold);
  font-weight: 600;
}

/* Input with icon */
.input-with-icon {
  position: relative;
  display: flex;
  align-items: center;
}

.input-with-icon .form-input {
  padding-right: 40px;
}

.input-icon {
  position: absolute;
  right: 16px;
  color: var(--text-muted);
  font-weight: 600;
}

/* Actions */
.modal-actions {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid var(--surface-border);
}

/* Vue Transitions */
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.3s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .modal-content {
  animation: slide-up 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

.modal-leave-active .modal-content {
  animation: slide-down 0.3s ease-in forwards;
}

@keyframes slide-up {
  from { opacity: 0; transform: translateY(40px) scale(0.95); }
  to { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes slide-down {
  from { opacity: 1; transform: translateY(0) scale(1); }
  to { opacity: 0; transform: translateY(20px) scale(0.95); }
}
</style>
