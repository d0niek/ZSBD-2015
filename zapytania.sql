# Wszystkich nauczycieli
SELECT COUNT(*) AS nauczycieli FROM nauczyciel;

# Najstarszy nauczyciel
SELECT imie, nazwisko, data_ur FROM nauczyciel WHERE data_ur = (SELECT MIN(data_ur) FROM nauczyciel);

# Najmłodszy nauczyciel
SELECT imie, nazwisko, data_ur FROM nauczyciel WHERE data_ur = (SELECT MAX(data_ur) FROM nauczyciel);

# Ilu nauczycieli prowadzi dany przedmiot
SELECT p.przedmiot, COUNT(*) AS 'nauczycieli prowadzących' FROM przedmiot p, nauczyciel_przedmiot np
WHERE p.id = np.id_przedmiot GROUP BY np.id_przedmiot;

# Ile przedmiotów prowadzi dany nauczyciel
SELECT n.imie, n.nazwisko, COUNT(*) AS 'przedmioty' FROM nauczyciel n, nauczyciel_przedmiot np
WHERE n.id = np.id_nauczyciel GROUP BY np.id_nauczyciel;

# Ile było lekcji z danym przedmiotem
SELECT p.przedmiot, COUNT(*) AS 'lekcji' FROM przedmiot p, lekcja l
WHERE p.id = l.id_przedmiot GROUP BY l.id_przedmiot;

# Ile lekcji poprowadził dany nauczyciel
SELECT n.imie, n.nazwisko, COUNT(l.id_nauczyciel) AS 'lekcji' FROM nauczyciel n, lekcja l
WHERE n.id = l.id_nauczyciel GROUP BY l.id_nauczyciel;

# Zastępstwa
SELECT n.imie, n.nazwisko, p.przedmiot, l.data FROM nauczyciel n, przedmiot p, lekcja l
WHERE (n.id = l.id_nauczyciel AND p.id = l.id_przedmiot) AND NOT EXISTS
    (SELECT * FROM nauczyciel_przedmiot WHERE id_nauczyciel = n.id AND id_przedmiot = p.id);

# Ilość danych ocen
SELECT ocena, count(*) FROM ocena GROUP BY ocena;

# Średnia wszystkich ocen
SELECT AVG(ocena) FROM ocena;

# Średnia ilość ocen na lekcji
SELECT COUNT(*) / (SELECT COUNT(*) FROM lekcja) FROM ocena;

# Nieobecni uczniowie na przedmiocie
SELECT u.imie, u.nazwisko, p.przedmiot, l.data FROM obecnosc o, uczen u, lekcja l, przedmiot p
WHERE o.id_uczen = u.id AND o.obecnosc = 'N' AND o.id_lekcja = l.id and l.id_przedmiot = p.id;

# Usprawiedliwione nieobecności
SELECT u.imie, u.nazwisko, p.przedmiot, l.data FROM obecnosc o, uczen u, lekcja l, przedmiot p
WHERE o.id_uczen = u.id AND o.obecnosc = 'N' AND o.id_lekcja = l.id and l.id_przedmiot = p.id AND o.uwaga != '';

# Lekcja na które nie postawiono żadnej oceny
SELECT p.przedmiot, l.data FROM przedmiot p, lekcja l
WHERE p.id = l.id_przedmiot and NOT EXISTS (SELECT * FROM ocena WHERE id_lekcja = l.id);

# Lekcja, na której wszyscy uczniowie z klasy dostali oceny
SELECT p.przedmiot, l.data FROM przedmiot p, lekcja l
WHERE p.id = l.id_przedmiot
    AND (SELECT COUNT(*) FROM ocena WHERE id_lekcja = l.id) = (SELECT COUNT(*) FROM uczen WHERE id_klasa = l.id_klasa)
