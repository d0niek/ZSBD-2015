DELIMITER //

# Dodawanie ocen
DROP PROCEDURE IF EXISTS dodaj_ocene;

CREATE PROCEDURE dodaj_ocene(IN lekcja INT UNSIGNED, IN uczen INT UNSIGNED, IN ocena VARCHAR(1), IN uwaga VARCHAR(255))
BEGIN
    IF EXISTS (SELECT * FROM obecnosc o WHERE o.id_lekcja = lekcja AND o.id_uczen = uczen AND o.obecnosc = 'O') THEN
    	INSERT INTO ocena (id, id_lekcja, id_uczen, ocena, uwaga) VALUES (null, lekcja, uczen, ocena, uwaga);
        SELECT 'Ocena dodana';
    ELSE
        SELECT 'Uczeń nieobecny na podanej lekcji';
    END IF;
END;

# Zestawienie ocen ucznia
DROP PROCEDURE IF EXISTS zestawienie_ocen;

CREATE PROCEDURE zestawienie_ocen(IN uczenId INT UNSIGNED)
BEGIN
    DECLARE uImie VARCHAR(20) DEFAULT (SELECT imie FROM uczen WHERE id = uczenId);
    DECLARE uNazwisko VARCHAR(20) DEFAULT (SELECT nazwisko FROM uczen WHERE id = uczenId);

    IF uImie IS NOT NULL AND uNazwisko IS NOT NULL THEN
        SELECT CONCAT(uImie, ' ', uNazwisko) AS Uczeń;

        BEGIN
            DECLARE pDone INT DEFAULT FALSE;
            DECLARE pId INT;
            DECLARE pNazwa VARCHAR(255);
            DECLARE cPrzedmiot CURSOR FOR SELECT id, przedmiot FROM przedmiot;
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET pDone = TRUE;

            OPEN cPrzedmiot;
                przedmioty: LOOP
                    FETCH cPrzedmiot INTO pId, pNazwa;

                    IF pDone THEN
                        LEAVE przedmioty;
                    END IF;

                    BEGIN
                        DECLARE oDone INT DEFAULT FALSE;
                        DECLARE listaOcen VARCHAR(255) DEFAULT '';
                        DECLARE ocena_ VARCHAR(1);
                        DECLARE cOcena CURSOR FOR SELECT ocena FROM ocena
                            WHERE id_uczen = uczenId AND id_lekcja IN (SELECT id FROM lekcja WHERE id_przedmiot = pId);
                        DECLARE CONTINUE HANDLER FOR NOT FOUND SET oDone = TRUE;

                        OPEN cOcena;
                            oceny: LOOP
                                FETCH cOcena INTO ocena_;

                                IF oDone THEN
                                    LEAVE oceny;
                                END IF;

                                SET listaOcen = CONCAT(listaOcen, ' ', ocena_);
                            END LOOP;
                        CLOSE cOcena;

                        SELECT pNazwa as 'Przedmiot', listaOcen as 'Oceny';
                    END;
                END LOOP;
            CLOSE cPrzedmiot;
        END;
    ELSE
        SELECT 'Podany uczeń nie istenieje' AS Uczeń;
    END IF;
END;

# Zwiększenie pensji za zastępstwo
DROP PROCEDURE IF EXISTS zwiekszenie_pensji;

CREATE PROCEDURE zwiekszenie_pensji()
BEGIN
    UPDATE nauczyciel n, lekcja l, przedmiot p SET n.pensja=n.pensja*1.02
    WHERE n.id = l.id_nauczyciel AND p.id = l.id_przedmiot AND NOT EXISTS
        (SELECT * FROM nauczyciel_przedmiot WHERE id_nauczyciel = n.id AND id_przedmiot = p.id);
END;

# Funkcja ...
DROP FUNCTION IF EXISTS funkcja;

CREATE FUNCTION funkcja (value INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE result INT;

    SET result = 0;

    petla: WHILE result <= 3000 DO
        SET result = result + value;
    END WHILE petla;

    RETURN result;
END;

//

DELIMITER ;
