import express from 'express';
import pool from '../config/db.js';

const router = express.Router();

// GET: Récupérer tous les clients
router.get('/get.php', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM client');
    res.json(rows);
  } catch (error) {
    console.error('Erreur SQL (get):', error);
    res.status(500).json({ message: 'Erreur serveur lors de la récupération des clients' });
  }
});

// POST: Créer un client
router.post('/create.php', async (req, res) => {
  try {
    const { type_client, nom, prenom, raison_sociale, telephone, email, adresse, taux_remise, etat } = req.body;
    
    const query = `
      INSERT INTO client (type_client, nom, prenom, raison_sociale, telephone, email, adresse, taux_remise, etat)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;
    
    // Valeurs par défaut si certains champs sont vides (pour éviter des erreurs SQL)
    const values = [
      type_client || 'P', 
      nom || '', 
      prenom || null, 
      raison_sociale || null, 
      telephone || null, 
      email || null, 
      adresse || null, 
      taux_remise || 0.00, 
      etat !== undefined ? etat : 1
    ];

    const [result] = await pool.query(query, values);
    
    // Renvoyer le client nouvellement créé (pour que le front l'ajoute à sa liste)
    const [newClient] = await pool.query('SELECT * FROM client WHERE id = ?', [result.insertId]);
    res.status(201).json(newClient[0]);
  } catch (error) {
    console.error('Erreur SQL (create):', error);
    res.status(500).json({ message: 'Erreur serveur lors de la création du client' });
  }
});

// POST: Mettre à jour un client
// Note: Le front utilise axios.post() pour la mise à jour vers '/clients/update.php'
router.post('/update.php', async (req, res) => {
  try {
    const { id, type_client, nom, prenom, raison_sociale, telephone, email, adresse, taux_remise, etat } = req.body;
    
    if (!id) {
      return res.status(400).json({ message: 'L\'identifiant (ID) est requis pour la mise à jour.' });
    }

    const query = `
      UPDATE client 
      SET type_client = ?, nom = ?, prenom = ?, raison_sociale = ?, telephone = ?, email = ?, adresse = ?, taux_remise = ?, etat = ?
      WHERE id = ?
    `;
    
    await pool.query(query, [
      type_client, nom, prenom, raison_sociale, telephone, email, adresse, taux_remise, etat, id
    ]);
    
    res.json({ message: 'Client mis à jour avec succès', id });
  } catch (error) {
    console.error('Erreur SQL (update):', error);
    res.status(500).json({ message: 'Erreur serveur lors de la mise à jour du client' });
  }
});

export default router;
