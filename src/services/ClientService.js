import axios from 'axios';

const apiClient = axios.create({
  // Appel du backend Node.js (Express)
  baseURL: 'http://localhost:3000/api',
  headers: {
    'Content-Type': 'application/json'
  }
});

export default {
  getClients() {
    return apiClient.get('/clients/get.php');
  },
  updateClient(client) {
    return apiClient.post('/clients/update.php', client);
  },
  createClient(client) {
    return apiClient.post('/clients/create.php', client);
  }
};
