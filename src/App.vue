<script setup>
// Le code de fetch des clients a été retiré d'ici car ClientList.vue s'en charge déjà
</script>

<template>
  <div class="app-layout">
    <!-- Header Premium Glassmorphism -->
    <header class="topbar glass-panel">
      <div class="logo">
        <span class="logo-icon">✧</span>
        <span class="logo-text">Roi Soleil</span>
      </div>

      <nav class="nav-menu">
        <router-link to="/clients" class="nav-link" active-class="nav-link-active">Clients</router-link>
      </nav>

      <div class="user-profile">
        <div class="avatar">A</div>
        <span class="user-role">Administrateur</span>
      </div>
    </header>

    <!-- Contenu Principal -->
    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<style scoped>
.app-layout {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

.topbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 32px;
  margin: 24px;
  border-radius: var(--radius-lg);
  z-index: 10;
}

.logo {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--primary-gold);
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.logo-icon {
  font-size: 1.8rem;
  animation: pulse-glow 4s infinite alternate;
}

@keyframes pulse-glow {
  0% { text-shadow: 0 0 5px rgba(212, 175, 55, 0.2); }
  100% { text-shadow: 0 0 20px rgba(212, 175, 55, 0.8); }
}

.nav-menu {
  display: flex;
  gap: 20px;
}

.nav-link {
  color: var(--text-muted);
  text-decoration: none;
  font-weight: 500;
  font-size: 1rem;
  padding: 8px 16px;
  border-radius: var(--radius-md);
  transition: var(--transition-fast);
}

.nav-link:hover {
  color: var(--primary-gold);
  background: rgba(255, 255, 255, 0.03);
}

.nav-link-active {
  color: var(--primary-gold);
  background: var(--primary-gold-light);
}

.user-profile {
  display: flex;
  align-items: center;
  gap: 12px;
  font-weight: 500;
}

.user-role {
  color: var(--text-muted);
  font-size: 0.9rem;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary-gold) 0%, #b8962c 100%);
  color: #111;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1.1rem;
  box-shadow: var(--shadow-glow);
}

.main-content {
  flex: 1;
  padding: 0 24px 40px;
  max-width: 1400px;
  margin: 0 auto;
  width: 100%;
  animation: fade-in 0.6s ease-out forwards;
}

@keyframes fade-in {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
