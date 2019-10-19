CREATE VIEW wycieczki_osoby
AS SELECT
    w.ID_WYCIECZKI,
    w.NAZWA,
    w.KRAJ,
    w.DATA,
    o.IMIE,
    o.NAZWISKO,
    r.STATUS
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o ON r.ID_OSOBY = o.ID_OSOBY;

CREATE VIEW wycieczki_osoby_potwierdzone
AS SELECT
    KRAJ,
    DATA,
    NAZWA,
    IMIE,
    NAZWISKO,
    STATUS
FROM wycieczki_osoby
WHERE STATUS = 'P' OR STATUS = 'Z';

CREATE VIEW wycieczki_przyszle
AS SELECT
    KRAJ,
    DATA,
    NAZWA,
    IMIE,
    NAZWISKO,
    STATUS
FROM wycieczki_osoby
WHERE DATA > CURRENT_DATE;

CREATE VIEW wycieczki_miejsca
AS SELECT UNIQUE
    w.KRAJ,
    w.DATA,
    w.NAZWA,
    w.LICZBA_MIEJSC,
    w.LICZBA_MIEJSC - (SELECT count(*)
                       FROM WYCIECZKI wy
                       JOIN REZERWACJE re ON wy.ID_WYCIECZKI = re.ID_WYCIECZKI
                       JOIN OSOBY os ON re.ID_OSOBY = os.ID_OSOBY
                       WHERE STATUS != 'A' AND w.ID_WYCIECZKI = wy.ID_WYCIECZKI)
        as WOLNE_MIEJSCA
FROM WYCIECZKI w
LEFT OUTER JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI;

CREATE VIEW dostepne_wycieczki
AS SELECT
    *
FROM wycieczki_miejsca w
WHERE w.DATA >= CURRENT_DATE AND w.WOLNE_MIEJSCA > 0;

CREATE VIEW rezerwacje_do_anulowana
AS SELECT
    r.NR_REZERWACJI,
    w.KRAJ,
    w.DATA,
    w.NAZWA,
    o.IMIE,
    o.NAZWISKO
FROM WYCIECZKI w
JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
JOIN OSOBY o on r.ID_OSOBY = o.ID_OSOBY
WHERE w.DATA > CURRENT_DATE AND w.DATA - CURRENT_DATE <= 7 AND r.STATUS = 'N';