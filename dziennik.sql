CREATE DATABASE IF NOT EXISTS `zsbd_dziennik` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `zsbd_dziennik`;


DROP TABLE IF EXISTS `klasa`;
CREATE TABLE IF NOT EXISTS `klasa` (
    `id` int(11) NOT NULL,
    `id_wychowawca` int(11) NOT NULL,
    `klasa` varchar(30) COLLATE utf8_bin NOT NULL,
    `start` year(4) NOT NULL,
    `koniec` year(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `lekcja`;
CREATE TABLE IF NOT EXISTS `lekcja` (
    `id` int(11) NOT NULL,
    `id_nauczyciel` int(11) NOT NULL,
    `id_przedmiot` int(11) NOT NULL,
    `id_klasa` int(11) NOT NULL,
    `data` datetime NOT NULL,
    `temat` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `nauczyciel`;
CREATE TABLE IF NOT EXISTS `nauczyciel` (
    `id` int(11) NOT NULL,
    `imie` varchar(20) COLLATE utf8_bin NOT NULL,
    `nazwisko` varchar(30) COLLATE utf8_bin NOT NULL,
    `data_ur` date NOT NULL,
    `data_zat` date NOT NULL,
    `pensja` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `nauczyciel_przedmiot`;
CREATE TABLE IF NOT EXISTS `nauczyciel_przedmiot` (
    `id_nauczyciel` int(11) NOT NULL,
    `id_przedmiot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `obecnosc`;
CREATE TABLE IF NOT EXISTS `obecnosc` (
    `id` int(11) NOT NULL,
    `id_lekcja` int(11) NOT NULL,
    `id_uczen` int(11) NOT NULL,
    `obecnosc` enum('O','S','N') COLLATE utf8_bin NOT NULL,
    `uwaga` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `ocena`;
CREATE TABLE IF NOT EXISTS `ocena` (
    `id` int(11) NOT NULL,
    `id_lekcja` int(11) NOT NULL,
    `id_uczen` int(11) NOT NULL,
    `ocena` enum('6','5','4','3','2','1') COLLATE utf8_bin NOT NULL,
    `uwaga` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `przedmiot`;
CREATE TABLE IF NOT EXISTS `przedmiot` (
    `id` int(11) NOT NULL,
    `przedmiot` varchar(50) COLLATE utf8_bin NOT NULL,
    `opis` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '"Brak opisu"'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

DROP TABLE IF EXISTS `uczen`;
CREATE TABLE IF NOT EXISTS `uczen` (
    `id` int(11) NOT NULL,
    `id_klasa` int(11) NOT NULL,
    `imie` varchar(20) COLLATE utf8_bin NOT NULL,
    `nazwisko` varchar(30) COLLATE utf8_bin NOT NULL,
    `data_ur` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


INSERT INTO `klasa` (`id`, `id_wychowawca`, `klasa`, `start`, `koniec`) VALUES
(1, 1, 'Technik Informatyk', 2015, 2019),
(2, 4, 'Automatyka Przemysłowa', 2015, 2019);

INSERT INTO `lekcja` (`id`, `id_nauczyciel`, `id_przedmiot`, `id_klasa`, `data`, `temat`) VALUES
(1, 1, 3, 1, '2015-09-01 09:00:00', 'Lekcja organizacyjna'),
(2, 2, 1, 2, '2015-09-01 09:00:00', 'Lekcja pierwsza'),
(3, 3, 2, 1, '2015-09-01 10:00:00', 'Lekcja organizacyjna'),
(4, 4, 3, 2, '2015-09-01 10:00:00', 'Zwierzęta wodne'),
(5, 5, 4, 2, '2015-09-01 11:00:00', 'Wprowadzenie do przedmiotu'),
(6, 1, 3, 1, '2015-10-08 09:00:00', 'Zwirzęta wodne'),
(7, 2, 1, 2, '2015-10-08 09:00:00', 'Pan Tadeusz'),
(8, 3, 2, 2, '2015-10-08 10:00:00', 'Funkcja liniowa'),
(9, 4, 3, 2, '2015-10-08 10:00:00', 'Zwierzęta wodne 2'),
(10, 5, 4, 1, '2015-10-08 11:00:00', 'Pierwsza wojna'),
(11, 1, 3, 1, '2015-11-25 09:00:00', 'Zwierzęta londowe'),
(12, 2, 1, 2, '2015-11-25 09:00:00', 'Sprawdzian'),
(13, 3, 2, 1, '2015-11-25 10:00:00', 'Grafy'),
(14, 4, 3, 2, '2015-11-25 10:00:00', 'Biologia komórki'),
(15, 3, 4, 2, '2015-11-25 11:00:00', 'Czas po wojnie'),
(16, 1, 3, 1, '2015-12-12 09:00:00', 'Krew'),
(17, 2, 1, 1, '2015-12-12 09:00:00', 'Lalka'),
(18, 3, 2, 2, '2015-12-12 10:00:00', 'Sprawdzian'),
(19, 4, 3, 2, '2015-12-12 10:00:00', 'Krew'),
(20, 5, 4, 1, '2015-12-12 11:00:00', 'Druga wojna światowa');

INSERT INTO `nauczyciel` (`id`, `imie`, `nazwisko`, `data_ur`, `data_zat`, `pensja`) VALUES
(1, 'Paweł', 'Pawłowski', '1975-09-28', '2015-08-20', 2800),
(2, 'Katarzyna', 'Gawrysiak', '1978-11-25', '2015-08-11', 2500),
(3, 'Piotr', 'Chojnacki', '1978-07-15', '2015-08-14', 2800),
(4, 'Jarosław', 'Szewczyk', '1974-04-08', '2015-09-11', 2500),
(5, 'Robert', 'Pacholak', '1974-01-22', '2015-08-27', 2600);

INSERT INTO `nauczyciel_przedmiot` (`id_nauczyciel`, `id_przedmiot`) VALUES
(1, 3),
(2, 1),
(2, 3),
(3, 2),
(4, 3),
(5, 4);

INSERT INTO `obecnosc` (`id`, `id_lekcja`, `id_uczen`, `obecnosc`, `uwaga`) VALUES
(1, 1, 1, 'O', ''),
(2, 1, 2, 'O', ''),
(3, 1, 3, 'O', ''),
(4, 1, 4, 'O', ''),
(5, 1, 5, 'O', ''),
(6, 2, 6, 'O', ''),
(7, 2, 7, 'O', ''),
(8, 2, 8, 'O', ''),
(9, 2, 9, 'O', ''),
(10, 3, 1, 'O', ''),
(11, 3, 2, 'O', ''),
(12, 3, 3, 'O', ''),
(13, 3, 4, 'O', ''),
(14, 3, 5, 'O', ''),
(15, 4, 6, 'O', ''),
(16, 4, 7, 'O', ''),
(17, 4, 8, 'O', ''),
(18, 4, 9, 'O', ''),
(19, 5, 6, 'O', ''),
(20, 5, 7, 'O', ''),
(21, 5, 8, 'S', ''),
(22, 5, 9, 'O', ''),
(23, 6, 1, 'N', 'Usprawiedliwione'),
(24, 6, 2, 'O', ''),
(25, 6, 3, 'O', ''),
(26, 6, 4, 'O', ''),
(27, 6, 5, 'O', ''),
(28, 7, 7, 'N', 'Usprawiedliwione'),
(29, 7, 8, 'O', ''),
(30, 7, 6, 'O', ''),
(31, 7, 9, 'S', ''),
(33, 8, 6, 'O', ''),
(34, 8, 7, 'O', ''),
(35, 8, 8, 'O', ''),
(36, 8, 9, 'O', ''),
(37, 9, 6, 'O', ''),
(38, 9, 7, 'O', ''),
(39, 9, 8, 'N', 'Pomoc na świetlicy, usprawiedliwiony'),
(40, 9, 9, 'O', ''),
(41, 10, 1, 'O', ''),
(42, 10, 2, 'O', ''),
(43, 10, 3, 'O', ''),
(44, 10, 4, 'N', ''),
(45, 10, 5, 'N', ''),
(46, 11, 1, 'O', ''),
(47, 11, 2, 'O', ''),
(48, 11, 3, 'O', ''),
(49, 11, 4, 'O', ''),
(50, 11, 5, 'O', ''),
(51, 12, 6, 'O', ''),
(52, 12, 7, 'O', ''),
(53, 12, 8, 'N', ''),
(54, 12, 9, 'O', ''),
(55, 13, 1, 'S', ''),
(56, 13, 2, 'S', ''),
(57, 13, 3, 'N', ''),
(58, 13, 4, 'O', ''),
(59, 13, 5, 'O', ''),
(60, 14, 6, 'O', ''),
(61, 14, 7, 'O', ''),
(62, 14, 8, 'N', ''),
(63, 14, 9, 'O', ''),
(64, 15, 6, 'O', ''),
(65, 15, 7, 'O', ''),
(66, 15, 8, 'N', ''),
(67, 15, 9, 'O', ''),
(68, 16, 1, 'O', ''),
(69, 16, 2, 'O', ''),
(70, 16, 3, 'O', ''),
(71, 16, 4, 'O', ''),
(72, 16, 5, 'O', ''),
(73, 17, 1, 'O', ''),
(74, 17, 2, 'O', ''),
(75, 17, 3, 'S', ''),
(76, 17, 4, 'S', ''),
(77, 17, 5, 'S', ''),
(78, 18, 6, 'O', ''),
(79, 18, 7, 'O', ''),
(80, 18, 8, 'O', ''),
(81, 18, 9, 'O', ''),
(82, 19, 6, 'O', ''),
(83, 19, 7, 'O', ''),
(84, 19, 8, 'N', 'Wizyta w dyrektora'),
(85, 19, 9, 'O', ''),
(86, 20, 1, 'O', ''),
(87, 20, 2, 'O', ''),
(88, 20, 3, 'O', ''),
(89, 20, 4, 'O', ''),
(90, 20, 5, 'O', '');

INSERT INTO `ocena` (`id`, `id_lekcja`, `id_uczen`, `ocena`, `uwaga`) VALUES
(1, 4, 8, '4', ''),
(2, 4, 6, '4', ''),
(3, 5, 9, '3', ''),
(4, 5, 8, '2', ''),
(5, 5, 7, '4', ''),
(6, 6, 4, '4', ''),
(7, 6, 3, '4', ''),
(8, 6, 2, '4', ''),
(9, 6, 5, '3', ''),
(10, 7, 7, '4', ''),
(11, 8, 8, '4', ''),
(12, 8, 6, '4', ''),
(13, 8, 7, '3', ''),
(14, 8, 9, '2', ''),
(15, 10, 1, '4', ''),
(16, 10, 3, '4', ''),
(17, 11, 2, '4', ''),
(18, 11, 3, '3', ''),
(19, 11, 4, '5', ''),
(20, 12, 6, '1', ''),
(21, 12, 7, '4', ''),
(22, 12, 9, '5', ''),
(23, 14, 7, '2', ''),
(24, 14, 9, '4', ''),
(25, 15, 6, '4', ''),
(26, 15, 7, '2', ''),
(27, 15, 9, '2', ''),
(28, 16, 1, '3', ''),
(29, 16, 2, '5', ''),
(30, 16, 3, '4', ''),
(31, 16, 4, '5', ''),
(32, 16, 5, '4', ''),
(33, 17, 1, '4', ''),
(34, 17, 2, '4', ''),
(35, 17, 3, '4', ''),
(36, 17, 4, '4', ''),
(37, 17, 5, '5', ''),
(38, 18, 6, '5', ''),
(39, 18, 7, '3', ''),
(40, 18, 8, '3', ''),
(41, 18, 9, '5', ''),
(42, 19, 6, '2', ''),
(43, 19, 7, '3', ''),
(44, 20, 1, '5', ''),
(45, 20, 3, '5', ''),
(46, 20, 4, '5', ''),
(47, 1, 1, '5', ''),
(48, 1, 1, '4', ''),
(49, 1, 1, '2', ''),
(50, 1, 1, '5', '');

INSERT INTO `przedmiot` (`id`, `przedmiot`, `opis`) VALUES
(1, 'Język Polski', '"Brak opisu"'),
(2, 'Matematyka', '"Brak opisu"'),
(3, 'Biologia', '"Brak opisu"'),
(4, 'Historia', '"Brak opisu"');

INSERT INTO `uczen` (`id`, `id_klasa`, `imie`, `nazwisko`, `data_ur`) VALUES
(1, 1, 'Karol', 'Perkowski', '1999-10-14'),
(2, 1, 'Łukasz', 'Begiert', '1999-05-26'),
(3, 1, 'Dominik', 'Gara', '1999-07-27'),
(4, 1, 'Dawid', 'Ratajczyk', '1999-04-08'),
(5, 1, 'Kamil', 'Wojtasik', '1999-10-14'),
(6, 2, 'Karolina', 'Chaładyniak', '1999-03-23'),
(7, 2, 'Tomek', 'Kaczmarek', '1999-11-11'),
(8, 2, 'Krzysztof', 'Kuncki', '1999-10-14'),
(9, 2, 'Mateusz', 'Adamkiewicz', '1999-07-17');


ALTER TABLE `klasa`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_wychowawca` (`id_wychowawca`);

ALTER TABLE `lekcja`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_nauczyciel` (`id_nauczyciel`,`id_przedmiot`,`id_klasa`),
    ADD KEY `id_przedmiot` (`id_przedmiot`),
    ADD KEY `id_klasa` (`id_klasa`);

ALTER TABLE `nauczyciel`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `nauczyciel_przedmiot`
    ADD KEY `id_nauczyciel` (`id_nauczyciel`,`id_przedmiot`),
    ADD KEY `id_nauczyciel_2` (`id_nauczyciel`),
    ADD KEY `id_przedmiot` (`id_przedmiot`);

ALTER TABLE `obecnosc`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_lekcja` (`id_lekcja`),
    ADD KEY `id_uczen` (`id_uczen`);

ALTER TABLE `ocena`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_lekcja` (`id_lekcja`),
    ADD KEY `id_uczen` (`id_uczen`);

ALTER TABLE `przedmiot`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `przedmiot` (`przedmiot`);

ALTER TABLE `uczen`
    ADD PRIMARY KEY (`id`),
    ADD KEY `id_klasa` (`id_klasa`);


ALTER TABLE `klasa`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;

ALTER TABLE `lekcja`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;

ALTER TABLE `nauczyciel`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;

ALTER TABLE `obecnosc`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=91;

ALTER TABLE `ocena`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=51;

ALTER TABLE `przedmiot`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;

ALTER TABLE `uczen`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;


ALTER TABLE `klasa`
    ADD CONSTRAINT `klasa_ibfk_1` FOREIGN KEY (`id_wychowawca`) REFERENCES `nauczyciel` (`id`) ON UPDATE CASCADE;

ALTER TABLE `lekcja`
    ADD CONSTRAINT `lekcja_ibfk_1` FOREIGN KEY (`id_nauczyciel`) REFERENCES `nauczyciel` (`id`) ON UPDATE CASCADE,
    ADD CONSTRAINT `lekcja_ibfk_2` FOREIGN KEY (`id_przedmiot`) REFERENCES `przedmiot` (`id`) ON UPDATE CASCADE,
    ADD CONSTRAINT `lekcja_ibfk_3` FOREIGN KEY (`id_klasa`) REFERENCES `klasa` (`id`) ON UPDATE CASCADE;

ALTER TABLE `nauczyciel_przedmiot`
    ADD CONSTRAINT `nauczyciel_przedmiot_ibfk_1` FOREIGN KEY (`id_nauczyciel`) REFERENCES `nauczyciel` (`id`) ON UPDATE CASCADE,
    ADD CONSTRAINT `nauczyciel_przedmiot_ibfk_2` FOREIGN KEY (`id_przedmiot`) REFERENCES `przedmiot` (`id`) ON UPDATE CASCADE;

ALTER TABLE `obecnosc`
    ADD CONSTRAINT `obecnosc_ibfk_1` FOREIGN KEY (`id_lekcja`) REFERENCES `lekcja` (`id`) ON UPDATE CASCADE,
    ADD CONSTRAINT `obecnosc_ibfk_2` FOREIGN KEY (`id_uczen`) REFERENCES `uczen` (`id`) ON UPDATE CASCADE;

ALTER TABLE `ocena`
    ADD CONSTRAINT `ocena_ibfk_1` FOREIGN KEY (`id_lekcja`) REFERENCES `lekcja` (`id`) ON UPDATE CASCADE,
    ADD CONSTRAINT `ocena_ibfk_2` FOREIGN KEY (`id_uczen`) REFERENCES `uczen` (`id`) ON UPDATE CASCADE;

ALTER TABLE `uczen`
    ADD CONSTRAINT `uczen_ibfk_1` FOREIGN KEY (`id_klasa`) REFERENCES `klasa` (`id`) ON UPDATE CASCADE;
