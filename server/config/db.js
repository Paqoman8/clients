import mysql from 'mysql2/promise';

// Création du pool de connexion MySQL (Homebrew par défaut)
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '', // Par défaut sans mot de passe sous Homebrew
  database: 'gstock',
  port: 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

export default pool;
