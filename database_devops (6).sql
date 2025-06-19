-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Gegenereerd op: 19 jun 2025 om 11:54
-- Serverversie: 9.1.0
-- PHP-versie: 8.3.14

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
-- Tabelstructuur voor tabel `bedrijf`
--

DROP TABLE IF EXISTS `bedrijf`;
CREATE TABLE IF NOT EXISTS `bedrijf` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kvk_nummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btw_nummer` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `straat` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `huisnummer` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plaats` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `land` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Nederland',
  `telefoon` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actief` tinyint(1) NOT NULL DEFAULT '1',
  `aangemaakt_door` int DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `gewijzigd_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniek_kvk` (`kvk_nummer`),
  UNIQUE KEY `uniek_btw` (`btw_nummer`),
  KEY `idx_naam` (`naam`),
  KEY `idx_actief` (`actief`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `bedrijven`
--

DROP TABLE IF EXISTS `bedrijven`;
CREATE TABLE IF NOT EXISTS `bedrijven` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `adres` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plaats` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kvk_nummer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btw_nummer` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `bedrijven`
--

INSERT INTO `bedrijven` (`id`, `naam`, `adres`, `postcode`, `plaats`, `telefoon`, `email`, `kvk_nummer`, `btw_nummer`, `aangemaakt_op`) VALUES
(1, 'Tech Solutions BV', 'Hoofdstraat 1', '1234 AB', 'Amsterdam', '020-1234567', 'info@techsolutions.nl', '12345678', 'NL123456789B01', '2025-06-19 10:25:18'),
(2, 'Digital Services', 'Zakenweg 10', '4321 XY', 'Rotterdam', '010-7654321', 'contact@digitalservices.nl', '87654321', 'NL987654321B01', '2025-06-19 10:25:18'),
(3, 'WebPro BV', 'Internetlaan 25', '5678 CD', 'Utrecht', '030-9876543', 'info@webpro.nl', '23456789', 'NL234567890B01', '2025-06-19 10:25:18');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `facturen`
--

DROP TABLE IF EXISTS `facturen`;
CREATE TABLE IF NOT EXISTS `facturen` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factuurnummer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `klant_id` int NOT NULL,
  `project_id` int DEFAULT NULL,
  `datum` date NOT NULL,
  `vervaldatum` date NOT NULL,
  `subtotaal` decimal(10,2) NOT NULL,
  `btw_percentage` decimal(4,2) NOT NULL DEFAULT '21.00',
  `btw_bedrag` decimal(10,2) NOT NULL,
  `totaal` decimal(10,2) NOT NULL,
  `status` enum('concept','verzonden','betaald','vervallen') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'concept',
  `betaald_op` date DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniek_factuurnummer` (`factuurnummer`),
  KEY `klant_id` (`klant_id`),
  KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `factuur`
--

DROP TABLE IF EXISTS `factuur`;
CREATE TABLE IF NOT EXISTS `factuur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `klant_id` int DEFAULT NULL,
  `bedrag` decimal(10,2) DEFAULT NULL,
  `betaald` tinyint(1) DEFAULT '0',
  `factuurdatum` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `klant_id` (`klant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `factuurregels`
--

DROP TABLE IF EXISTS `factuurregels`;
CREATE TABLE IF NOT EXISTS `factuurregels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `factuur_id` int NOT NULL,
  `omschrijving` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `aantal` decimal(10,2) NOT NULL DEFAULT '1.00',
  `eenheid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'uur',
  `prijs_per_eenheid` decimal(10,2) NOT NULL,
  `btw_percentage` decimal(4,2) NOT NULL DEFAULT '21.00',
  `subtotaal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `factuur_id` (`factuur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `gebruikers`
--

DROP TABLE IF EXISTS `gebruikers`;
CREATE TABLE IF NOT EXISTS `gebruikers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `wachtwoord` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('beheerder','klant','medewerker') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'klant',
  `bedrijf_id` int DEFAULT NULL,
  `functie` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniek_email` (`email`),
  KEY `bedrijf_id` (`bedrijf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `gebruikers`
--

INSERT INTO `gebruikers` (`id`, `naam`, `email`, `wachtwoord`, `rol`, `bedrijf_id`, `functie`, `telefoon`, `aangemaakt_op`) VALUES
(3, 'Salar', 'test@a.com', '$2y$10$Io1TBFHxr1Fzui2oY9RkRejOstWy0IXwiofpWun3TXYbuUA6b3rGm', 'klant', NULL, NULL, NULL, '2025-06-19 11:26:57'),
(4, 'mohamed', 'mo@test.nl', '$2y$10$Vw3PYM8CsqFW32kR/9/UsuPxCtxDBErp9xkTc5qpNjPliJrfNarmu', 'medewerker', 3, NULL, NULL, '2025-06-19 11:27:24'),
(5, 'admin', 'admin@devops.nl', '$2y$10$5PNcqdqSiwGhpaPb0MhwDe4iDc9nlyjqTIcb78z1w.nu94bJxlk4m', 'beheerder', NULL, NULL, NULL, '2025-06-19 11:37:21'),
(6, 'TestKlant', 'TestKlant@test.nl', '$2y$10$9cFCfkSqAYgRPgObfmHrHedsz4rQZV2r1QR/rqw.H56eTQeYz30xa', 'klant', NULL, NULL, NULL, '2025-06-19 11:52:09'),
(7, 'TestMedewerker', 'TestMedewerker@test.nl', '$2y$10$40XiQGr0NmYEeIcQfSMG/.tteuWK5naQF2hxKMFUC98n6/QHWqvvC', 'medewerker', NULL, NULL, NULL, '2025-06-19 11:52:35'),
(8, 'TestAdmin', 'TestAdmin@test.nl', '$2y$10$WDsKSqJxpcAJ04ozdk5ly.UypczBNDWP5GwNKKvt.5c6paJpu5keq', 'beheerder', NULL, NULL, NULL, '2025-06-19 11:53:03');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `klanten`
--

DROP TABLE IF EXISTS `klanten`;
CREATE TABLE IF NOT EXISTS `klanten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `bedrijf_id` int DEFAULT NULL,
  `contact_persoon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefoon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('actief','inactief') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'actief',
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `bedrijf_id` (`bedrijf_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `klanten`
--

INSERT INTO `klanten` (`id`, `user_id`, `bedrijf_id`, `contact_persoon`, `email`, `telefoon`, `status`, `aangemaakt_op`) VALUES
(1, NULL, 1, 'John Doe', 'john@techsolutions.nl', '06-12345678', 'actief', '2025-06-19 10:25:18'),
(2, NULL, 2, 'Jane Smith', 'jane@digitalservices.nl', '06-23456789', 'actief', '2025-06-19 10:25:18'),
(3, NULL, 3, 'Mark Johnson', 'mark@webpro.nl', '06-34567890', 'actief', '2025-06-19 10:25:18');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `medewerker`
--

DROP TABLE IF EXISTS `medewerker`;
CREATE TABLE IF NOT EXISTS `medewerker` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gebruiker_id` int DEFAULT NULL,
  `functie` varchar(100) DEFAULT NULL,
  `telefoon` varchar(20) DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `gebruiker_id` (`gebruiker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `opdracht`
--

DROP TABLE IF EXISTS `opdracht`;
CREATE TABLE IF NOT EXISTS `opdracht` (
  `id` int NOT NULL AUTO_INCREMENT,
  `klant_id` int DEFAULT NULL,
  `omschrijving` text,
  `status` enum('open','bezig','afgerond') DEFAULT 'open',
  `startdatum` date DEFAULT NULL,
  `einddatum` date DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `klant_id` (`klant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `opdrachten`
--

DROP TABLE IF EXISTS `opdrachten`;
CREATE TABLE IF NOT EXISTS `opdrachten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `titel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `beschrijving` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `prioriteit` enum('laag','normaal','hoog','urgent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'normaal',
  `status` enum('nieuw','in_behandeling','afgerond','gepauzeerd') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'nieuw',
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
-- Tabelstructuur voor tabel `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `klant_id` int DEFAULT NULL,
  `datum` date DEFAULT NULL,
  `status` enum('nieuw','verwerkt','verzonden','afgerond') DEFAULT 'nieuw',
  PRIMARY KEY (`id`),
  KEY `klant_id` (`klant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `projecten`
--

DROP TABLE IF EXISTS `projecten`;
CREATE TABLE IF NOT EXISTS `projecten` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `beschrijving` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `klant_id` int DEFAULT NULL,
  `start_datum` date DEFAULT NULL,
  `eind_datum` date DEFAULT NULL,
  `status` enum('nieuw','lopend','afgerond','gepauzeerd') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'nieuw',
  `budget` decimal(10,2) DEFAULT NULL,
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `klant_id` (`klant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `projecten`
--

INSERT INTO `projecten` (`id`, `naam`, `beschrijving`, `klant_id`, `start_datum`, `eind_datum`, `status`, `budget`, `aangemaakt_op`) VALUES
(1, 'Website Redesign', 'Complete redesign van de bedrijfswebsite', 1, '2024-01-01', '2024-03-31', 'lopend', 15000.00, '2025-06-19 10:25:18'),
(2, 'E-commerce Platform', 'Ontwikkeling van webshop', 2, '2024-02-01', '2024-06-30', 'lopend', 25000.00, '2025-06-19 10:25:18'),
(3, 'Mobile App', 'Ontwikkeling van mobiele applicatie', 3, '2024-03-01', '2024-08-31', 'nieuw', 35000.00, '2025-06-19 10:25:18');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `naam` varchar(50) NOT NULL,
  `beschrijving` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `uren_registratie`
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
  `beschrijving` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` enum('concept','ingediend','goedgekeurd','afgekeurd') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'concept',
  `aangemaakt_op` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `medewerker_id` (`medewerker_id`),
  KEY `project_id` (`project_id`),
  KEY `opdracht_id` (`opdracht_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `facturen`
--
ALTER TABLE `facturen`
  ADD CONSTRAINT `facturen_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `facturen_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `factuur`
--
ALTER TABLE `factuur`
  ADD CONSTRAINT `factuur_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `factuurregels`
--
ALTER TABLE `factuurregels`
  ADD CONSTRAINT `factuurregels_ibfk_1` FOREIGN KEY (`factuur_id`) REFERENCES `facturen` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `gebruikers`
--
ALTER TABLE `gebruikers`
  ADD CONSTRAINT `gebruikers_ibfk_1` FOREIGN KEY (`bedrijf_id`) REFERENCES `bedrijven` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `klanten`
--
ALTER TABLE `klanten`
  ADD CONSTRAINT `klanten_ibfk_1` FOREIGN KEY (`bedrijf_id`) REFERENCES `bedrijven` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `klanten_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `gebruikers` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `medewerker`
--
ALTER TABLE `medewerker`
  ADD CONSTRAINT `medewerker_ibfk_1` FOREIGN KEY (`gebruiker_id`) REFERENCES `gebruikers` (`id`) ON DELETE CASCADE;

--
-- Beperkingen voor tabel `opdracht`
--
ALTER TABLE `opdracht`
  ADD CONSTRAINT `opdracht_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `opdrachten`
--
ALTER TABLE `opdrachten`
  ADD CONSTRAINT `opdrachten_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `opdrachten_ibfk_2` FOREIGN KEY (`toegewezen_aan`) REFERENCES `gebruikers` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `projecten`
--
ALTER TABLE `projecten`
  ADD CONSTRAINT `projecten_ibfk_1` FOREIGN KEY (`klant_id`) REFERENCES `klanten` (`id`) ON DELETE SET NULL;

--
-- Beperkingen voor tabel `uren_registratie`
--
ALTER TABLE `uren_registratie`
  ADD CONSTRAINT `uren_registratie_ibfk_1` FOREIGN KEY (`medewerker_id`) REFERENCES `gebruikers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uren_registratie_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projecten` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `uren_registratie_ibfk_3` FOREIGN KEY (`opdracht_id`) REFERENCES `opdrachten` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
