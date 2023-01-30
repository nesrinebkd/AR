-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 30 jan. 2023 à 23:39
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ige42`
--

-- --------------------------------------------------------

--
-- Structure de la table `clubs`
--

CREATE TABLE `clubs` (
  `id` int(5) NOT NULL,
  `id_pays` int(4) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `clubs`
--

INSERT INTO `clubs` (`id`, `id_pays`, `nom`, `ville`, `logo`) VALUES
(5, 6, 'FC Liverpool', 'Liverpool', 'https://upload.wikimedia.org/wikipedia/fr/thumb/5/54/Logo_FC_Liverpool.svg/1200px-Logo_FC_Liverpool.svg.png'),
(6, 7, 'FC Barcelona', 'Barcelona', 'https://upload.wikimedia.org/wikipedia/fr/thumb/a/a1/Logo_FC_Barcelona.svg/1200px-Logo_FC_Barcelona.svg.png'),
(7, 7, 'Real Madrid', 'Madrid', 'https://upload.wikimedia.org/wikipedia/fr/thumb/c/c7/Logo_Real_Madrid.svg/1200px-Logo_Real_Madrid.svg.png'),
(9, 8, 'Juventus Torino', 'Turin', 'https://upload.wikimedia.org/wikipedia/fr/thumb/9/9f/Logo_Juventus.svg/1200px-Logo_Juventus.svg.png'),
(10, 8, 'AC Milano', 'Milan', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Logo_of_AC_Milan.svg/1200px-Logo_of_AC_Milan.svg.png'),
(35, 6, 'Manchester City', 'Manchester', 'https://upload.wikimedia.org/wikipedia/fr/thumb/b/ba/Logo_Manchester_City_2016.svg/langfr-195px-Logo_Manchester_City_2016.svg.png'),
(36, 9, 'PSG', 'Paris', 'https://upload.wikimedia.org/wikipedia/fr/thumb/8/86/Paris_Saint-Germain_Logo.svg/langfr-195px-Paris_Saint-Germain_Logo.svg.png'),
(37, 5, 'RDC Espanyol', 'Barcelone', 'https://upload.wikimedia.org/wikipedia/fr/thumb/7/79/Logo_RCD_Espanyol_Barcelona_2005.svg/langfr-195px-Logo_RCD_Espanyol_Barcelona_2005.svg.png'),
(38, 5, 'Bayern Munich', 'Munich', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg/langfr-195px-FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg.png'),
(42, 6, 'Manchester United', 'Manchester', 'https://upload.wikimedia.org/wikipedia/fr/thumb/b/b9/Logo_Manchester_United.svg/langfr-195px-Logo_Manchester_United.svg.png');

-- --------------------------------------------------------

--
-- Structure de la table `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `id_guest` int(11) NOT NULL,
  `id_visitor` int(11) NOT NULL,
  `score_guest` int(11) NOT NULL DEFAULT 0,
  `score_visitor` int(11) NOT NULL DEFAULT 0,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `matches`
--

INSERT INTO `matches` (`id`, `id_guest`, `id_visitor`, `score_guest`, `score_visitor`, `date`) VALUES
(26, 7, 10, 0, 0, '2023-02-06 00:00:00'),
(27, 38, 7, 0, 0, '2023-01-11 00:00:00'),
(32, 36, 38, 0, 0, '2023-02-10 21:00:00'),
(33, 7, 6, 0, 0, '2023-02-05 19:00:00'),
(34, 35, 5, 0, 0, '2023-01-28 19:00:00'),
(36, 37, 35, 0, 0, '2023-01-20 20:00:00'),
(37, 35, 5, 0, 0, '2023-02-05 20:03:00'),
(38, 5, 35, 0, 0, '2023-02-07 20:00:00'),
(40, 9, 5, 0, 0, '2023-01-12 22:52:00'),
(41, 38, 35, 0, 0, '2022-12-12 23:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

CREATE TABLE `pays` (
  `id` int(4) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `flag` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `nom`, `flag`) VALUES
(5, 'Allemagne', 'https://www.orientation-pour-tous.fr/local/cache-gd2/03/1526e1ad6a1bbd95be35a0e249c358.jpg?1598280717'),
(6, 'Angleterre', 'https://upload.wikimedia.org/wikipedia/commons/b/be/Flag_of_England.svg'),
(7, 'Espagne', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTMT3-1bsoQZI-nd9OeLi6Pm2qADF5XmrBiZw&usqp=CAU'),
(8, 'Italie', 'https://upload.wikimedia.org/wikipedia/commons/0/03/Flag_of_Italy.svg'),
(9, 'France', 'ae5ry54'),
(10, 'Argentine', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/383px-Flag_of_Argentina.svg.png'),
(11, 'Uruguay', 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/383px-Flag_of_Uruguay.svg.png');

-- --------------------------------------------------------

--
-- Structure de la table `players`
--

CREATE TABLE `players` (
  `player_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `Age` int(11) NOT NULL,
  `position` text NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_club` int(11) NOT NULL,
  `photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `players`
--

INSERT INTO `players` (`player_id`, `name`, `Age`, `position`, `id_country`, `id_club`, `photo`) VALUES
(1, 'Federico Valverde', 24, 'midfielder', 11, 7, 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Federico-Valverde-has-now-become-high-and-mighthy-in-his-midfield-role-with-Madrid.jpg/420px-Federico-Valverde-has-now-become-high-and-mighthy-in-his-midfield-role-with-Madrid.jpg'),
(2, 'Leo Messi', 35, 'forward', 10, 36, 'https://upload.wikimedia.org/wikipedia/commons/b/b4/Lionel-Messi-Argentina-2022-FIFA-World-Cup_%28cropped%29.jpg'),
(3, 'nacho fernandez', 32, 'defender', 7, 7, 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Nacho_Fern%C3%A1ndez.jpg/315px-Nacho_Fern%C3%A1ndez.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `id_pays` int(11) NOT NULL,
  `id_club` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','any') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `id_pays`, `id_club`, `password`, `role`) VALUES
(1, 'ilyes', 7, 6, 'ige41', 'any'),
(2, 'seddik', 6, 5, 'ige43', 'admin');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `clubs`
--
ALTER TABLE `clubs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uni_team_name` (`nom`),
  ADD KEY `ind_pays` (`id_pays`);

--
-- Index pour la table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ind_guest` (`id_guest`),
  ADD KEY `ind_visitor` (`id_visitor`);

--
-- Index pour la table `pays`
--
ALTER TABLE `pays`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uni_pays` (`nom`);

--
-- Index pour la table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `FK_id_club` (`id_club`),
  ADD KEY `FK_id_country` (`id_country`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uni_user_name` (`nom`),
  ADD KEY `id_pays` (`id_pays`),
  ADD KEY `ind_user_club` (`id_club`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `clubs`
--
ALTER TABLE `clubs`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT pour la table `pays`
--
ALTER TABLE `pays`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `players`
--
ALTER TABLE `players`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `clubs`
--
ALTER TABLE `clubs`
  ADD CONSTRAINT `FK_team_pays` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`);

--
-- Contraintes pour la table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `FK_matche_guest` FOREIGN KEY (`id_guest`) REFERENCES `clubs` (`id`),
  ADD CONSTRAINT `FK_matche_visitor` FOREIGN KEY (`id_visitor`) REFERENCES `clubs` (`id`);

--
-- Contraintes pour la table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `FK_id_club` FOREIGN KEY (`id_club`) REFERENCES `clubs` (`id`),
  ADD CONSTRAINT `FK_id_country` FOREIGN KEY (`id_country`) REFERENCES `pays` (`id`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_user_club` FOREIGN KEY (`id_club`) REFERENCES `clubs` (`id`),
  ADD CONSTRAINT `FK_user_nation` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
