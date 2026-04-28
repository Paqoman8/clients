-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 27 avr. 2026 à 14:13
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gstock`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_client` char(1) NOT NULL COMMENT 'P: Particulier, E: Entreprise',
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `raison_sociale` varchar(150) DEFAULT NULL,
  `telephone` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `taux_remise` decimal(5,2) DEFAULT '0.00' COMMENT 'Remise spécifique client (%)',
  `etat` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1: Actif, 0: Inactif',
  `user_creation` varchar(20) DEFAULT NULL,
  `date_creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_modification` varchar(20) DEFAULT NULL,
  `date_modification` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `type_client`, `nom`, `prenom`, `raison_sociale`, `telephone`, `email`, `adresse`, `taux_remise`, `etat`, `user_creation`, `date_creation`, `user_modification`, `date_modification`) VALUES
(1, 'P', 'DIVERS', '', NULL, '90000001', '', '', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-02-16 09:18:23'),
(2, 'P', 'THERESE', '', NULL, '90000002', '', 'Lomé - Bè', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-17 15:04:11'),
(3, 'P', 'Junior', '', NULL, '90000003', '', 'Lomé - Agoè', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-16 15:43:30'),
(4, 'P', 'Afi', 'Essi', NULL, '90000004', 'afi.essi@mail.com', 'Lomé - Tokoin', '1.50', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(5, 'P', 'SOKOMA', '', NULL, '90000005', 'sena.kokou@mail.com', 'Lomé - Nyékonakpoè', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-16 16:02:46'),
(6, 'P', 'MAMAN OLE', '', NULL, '90000006', 'yaw.kodjo@mail.com', 'Lomé - Hédzranawoé', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-25 12:40:41'),
(7, 'P', 'Akou', 'Ama', NULL, '90000007', 'akou.ama@mail.com', 'Lomé - Kégué', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(8, 'P', 'Koffi', 'Kwame', NULL, '90000008', 'koffi.kwame@mail.com', 'Lomé - Attiégou', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(9, 'P', 'Eklu', 'Yawa', NULL, '90000009', 'eklu.yawa@mail.com', 'Lomé - Ablogamé', '2.50', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(10, 'P', 'Mensah', 'Komi', NULL, '90000010', 'mensah.komi@mail.com', 'Lomé - Baguida', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(11, 'E', '', '', 'CAP Kpogan', '91000001', '', 'Kpogan', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-06 10:25:08'),
(12, 'E', '', '', 'CAP Kégué', '91000002', '', 'Kégué - LOME', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-06 11:52:48'),
(13, 'E', '', '', 'MISERICORDE', '91000003', 'contact@lagrace.tg', 'Lomé - Agoè Assiyéyé', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-16 16:10:00'),
(14, 'E', '', '', 'CONCORDE', '91000004', '', 'Lomé - Zongo', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-17 12:09:50'),
(15, 'E', '', '', 'BDD', '91000005', 'contact@prestige.tg', 'Lomé - Tokoin Wuiti', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-25 12:15:18'),
(16, 'E', '', '', 'TOTAL', '91000006', 'contact@atlantic.tg', 'Lomé - Bord de mer', '0.00', 1, 'admin', '2026-02-08 10:43:46', NULL, '2026-03-26 11:01:13'),
(17, 'E', 'ETS', '', 'Boutique Les Amis', '91000007', 'contact@lesamis.tg', 'Lomé - Adakpamé', '2.00', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(18, 'E', 'SARL', '', 'Marché Moderne Distribution', '91000008', 'contact@marchemoderne.tg', 'Lomé - Hedzranawoé', '5.50', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(19, 'E', 'SA', '', 'Société des Boissons', '91000009', 'contact@snb.tg', 'Lomé - Zone Portuaire', '9.00', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL),
(20, 'E', 'ETS', '', 'Cave Express', '91000010', 'contact@caveexpress.tg', 'Lomé - Avédji', '4.50', 1, 'admin', '2026-02-08 10:43:46', NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
