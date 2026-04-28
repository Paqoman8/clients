import express from 'express';
import cors from 'cors';
import clientRoutes from './routes/clients.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors()); // Autorise le frontend (Vite sur le port 5173) à faire des requêtes vers ce backend
app.use(express.json()); // Permet de parser le corps des requêtes en JSON

// Routes
// On utilise le préfixe /api pour toutes nos routes backend.
// Ainsi, le front appellera /api/clients/get.php, etc.
app.use('/api/clients', clientRoutes);

// Démarrage du serveur
app.listen(PORT, () => {
  console.log(`Backend server is running on http://localhost:${PORT}`);
});
