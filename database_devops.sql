-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 19, 2025 at 11:15 AM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database_devops`
--

-- --------------------------------------------------------

--
-- Table structure for table `bedrijven`
--

DROP TABLE IF EXISTS `bedrijven`;
CREATE TABLE IF NOT EXISTS `bedrijven` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adres` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plaats` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kvk_nummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btw_nummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bedrijven`
--

INSERT INTO `bedrijven` (`id`, `naam`, `adres`, `postcode`, `plaats`, `telefoon`, `email`, `kvk_nummer`, `btw_nummer`, `aangemaakt_op`) VALUES
(1, 'Tech Solutions BV', 'Hoofdstraat 1', '1234 AB', 'Amsterdam', '020-1234567', 'info@techsolutions.nl', '12345678', 'NL123456789B01', '2025-06-19 10:43:45'),
(2, 'Digital Services', 'Zakenweg 10', '4321 XY', 'Rotterdam', '010-7654321', 'contact@digitalservices.nl', '87654321', 'NL987654321B01', '2025-06-19 10:43:45'),
(3, 'WebPro BV', 'Internetlaan 25', '5678 CD', 'Utrecht', '030-9876543', 'info@webpro.nl', '23456789', 'NL234567890B01', '2025-06-19 10:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `facturen`
--

DROP TABLE IF EXISTS `facturen`;
CREATE TABLE IF NOT EXISTS `facturen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factuurnummer` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `klant_id` int NOT NULL,
  `project_id` int DEFAULT NULL,
  `datum` date NOT NULL,
  `vervaldatum` date NOT NULL,
  `subtotaal` decimal(10,2) NOT NULL,
  `btw_percentage` decimal(4,2) NOT NULL DEFAULT '21.00',
  `btw_bedrag` decimal(10,2) NOT NULL,
  `totaal` decimal(10,2) NOT NULL,
  `status` enum('concept','verzonden','betaald','vervallen') COLLATE utf8mb4_unicode_ci DEFAULT 'concept',
  `betaald_op` date DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniek_factuurnummer` (`factuurnummer`),
  KEY `klant_id` (`klant_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `facturen`
--

INSERT INTO `facturen` (`id`, `factuurnummer`, `klant_id`, `project_id`, `datum`, `vervaldatum`, `subtotaal`, `btw_percentage`, `btw_bedrag`, `totaal`, `status`, `betaald_op`, `aangemaakt_op`) VALUES
(1, 'INV-2024-001', 1, 1, '2024-03-15', '2024-04-15', 15000.00, 21.00, 3150.00, 18150.00, 'verzonden', NULL, '2025-06-19 10:43:45'),
(2, 'INV-2024-002', 2, 2, '2024-05-10', '2024-06-10', 25000.00, 21.00, 5250.00, 30250.00, 'concept', NULL, '2025-06-19 10:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `factuurregels`
--

DROP TABLE IF EXISTS `factuurregels`;
CREATE TABLE IF NOT EXISTS `factuurregels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factuur_id` int NOT NULL,
  `omschrijving` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `aantal` decimal(10,2) NOT NULL DEFAULT '1.00',
  `eenheid` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'uur',
  `prijs_per_eenheid` decimal(10,2) NOT NULL,
  `btw_percentage` decimal(4,2) NOT NULL DEFAULT '21.00',
  `subtotaal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `factuur_id` (`factuur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `factuurregels`
--

INSERT INTO `factuurregels` (`id`, `factuur_id`, `omschrijving`, `aantal`, `eenheid`, `prijs_per_eenheid`, `btw_percentage`, `subtotaal`) VALUES
(1, 1, 'Website Redesign Fase 1', 1.00, 'project', 15000.00, 21.00, 15000.00),
(2, 2, 'E-commerce Ontwikkeling Licentie', 1.00, 'licentie', 5000.00, 21.00, 5000.00),
(3, 2, 'E-commerce Ontwikkeling Uren', 200.00, 'uur', 100.00, 21.00, 20000.00);

-- --------------------------------------------------------

--
-- Table structure for table `gebruikers`
--

DROP TABLE IF EXISTS `gebruikers`;
CREATE TABLE IF NOT EXISTS `gebruikers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wachtwoord` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('beheerder','klant','medewerker') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'klant',
  `bedrijf_id` int DEFAULT NULL,
  `functie` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniek_email` (`email`),
  KEY `bedrijf_id` (`bedrijf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gebruikers`
--

INSERT INTO `gebruikers` (`id`, `naam`, `email`, `wachtwoord`, `rol`, `bedrijf_id`, `functie`, `telefoon`, `aangemaakt_op`) VALUES
(1, 'Beheerder', 'admin@devops.nl', '$2y$10$Mv8YZ0XCV/z1mBGBrnfVDexRruscqjuUNAOpo613eCqxKCe8F/5ce', 'beheerder', NULL, NULL, NULL, '2025-06-19 10:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `klanten`
--

DROP TABLE IF EXISTS `klanten`;
CREATE TABLE IF NOT EXISTS `klanten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bedrijf_id` int DEFAULT NULL,
  `contact_persoon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('actief','inactief') COLLATE utf8mb4_unicode_ci DEFAULT 'actief',
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `bedrijf_id` (`bedrijf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `klanten`
--

INSERT INTO `klanten` (`id`, `bedrijf_id`, `contact_persoon`, `email`, `telefoon`, `status`, `aangemaakt_op`) VALUES
(1, 1, 'John Doe', 'john@techsolutions.nl', '06-12345678', 'actief', '2025-06-19 10:43:45'),
(2, 2, 'Jane Smith', 'jane@digitalservices.nl', '06-23456789', 'actief', '2025-06-19 10:43:45'),
(3, 3, 'Mark Johnson', 'mark@webpro.nl', '06-34567890', 'actief', '2025-06-19 10:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `opdrachten`
--

DROP TABLE IF EXISTS `opdrachten`;
CREATE TABLE IF NOT EXISTS `opdrachten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `titel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beschrijving` text COLLATE utf8mb4_unicode_ci,
  `prioriteit` enum('laag','normaal','hoog','urgent') COLLATE utf8mb4_unicode_ci DEFAULT 'normaal',
  `status` enum('nieuw','in_behandeling','afgerond','gepauzeerd') COLLATE utf8mb4_unicode_ci DEFAULT 'nieuw',
  `toegewezen_aan` int DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `geschatte_uren` decimal(5,2) DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `toegewezen_aan` (`toegewezen_aan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `projecten`
--

DROP TABLE IF EXISTS `projecten`;
CREATE TABLE IF NOT EXISTS `projecten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `beschrijving` text COLLATE utf8mb4_unicode_ci,
  `klant_id` int DEFAULT NULL,
  `start_datum` date DEFAULT NULL,
  `eind_datum` date DEFAULT NULL,
  `status` enum('nieuw','lopend','afgerond','gepauzeerd') COLLATE utf8mb4_unicode_ci DEFAULT 'nieuw',
  `budget` decimal(10,2) DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `klant_id` (`klant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projecten`
--

INSERT INTO `projecten` (`id`, `naam`, `beschrijving`, `klant_id`, `start_datum`, `eind_datum`, `status`, `budget`, `aangemaakt_op`) VALUES
(1, 'Website Redesign', 'Complete redesign van de bedrijfswebsite', 1, '2024-01-01', '2024-03-31', 'lopend', 15000.00, '2025-06-19 10:43:45'),
(2, 'E-commerce Platform', 'Ontwikkeling van webshop', 2, '2024-02-01', '2024-06-30', 'lopend', 25000.00, '2025-06-19 10:43:45'),
(3, 'Mobile App', 'Ontwikkeling van mobiele applicatie', 3, '2024-03-01', '2024-08-31', 'nieuw', 35000.00, '2025-06-19 10:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `uren_registratie`
--

DROP TABLE IF EXISTS `uren_registratie`;
CREATE TABLE IF NOT EXISTS `uren_registratie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `medewerker_id` int NOT NULL,
  `project_id` int NOT NULL,
  `opdracht_id` int DEFAULT NULL,
  `datum` date NOT NULL,
  `start_tijd` time NOT NULL,
  `eind_tijd` time NOT NULL,
  `pauze_minuten` int DEFAULT '0',
  `beschrijving` text COLLATE utf8mb4_unicode_ci,
  `status` enum('concept','ingediend','goedgekeurd','afgekeurd') COLLATE utf8mb4_unicode_ci DEFAULT 'concept',
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `medewerker_id` (`medewerker_id`),
  KEY `project_id` (`project_id`),
  KEY `opdracht_id` (`opdracht_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `facturen`
--
ALTER TABLE `facturen`
  ADD CONSTRAINT `facturen_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `facturen_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `factuurregels`
--
ALTER TABLE `factuurregels`
  ADD CONSTRAINT `factuurregels_ibfk_1` FOREIGN KEY (`factuur_id`) REFERENCES `facturen` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `gebruikers`
--
ALTER TABLE `gebruikers`
  ADD CONSTRAINT `gebruikers_ibfk_1` FOREIGN KEY (`bedrijf_id`) REFERENCES `bedrijven` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `klanten`
--
ALTER TABLE `klanten`
  ADD CONSTRAINT `klanten_ibfk_1` FOREIGN KEY (`bedrijf_id`) REFERENCES `bedrijven` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `opdrachten`
--
ALTER TABLE `opdrachten`
  ADD CONSTRAINT `opdrachten_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `opdrachten_ibfk_2` FOREIGN KEY (`toegewezen_aan`) REFERENCES `gebruikers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `projecten`
--
ALTER TABLE `projecten`
  ADD CONSTRAINT `projecten_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `uren_registratie`
--
ALTER TABLE `uren_registratie`
  ADD CONSTRAINT `uren_registratie_ibfk_1` FOREIGN KEY (`medewerker_id`) REFERENCES `gebruikers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uren_registratie_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uren_registratie_ibfk_3` FOREIGN KEY (`opdracht_id`) REFERENCES `opdrachten` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
