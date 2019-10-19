CREATE OR REPLACE FUNCTION rezerwacje_osoby(ID INT)
RETURN osoby_wycieczki_table
AS
    wynik osoby_wycieczki_table;
    osoba_nie_istnieje EXCEPTION;
    czy_istnieje INT;
BEGIN
    SELECT
        COUNT(*)
    INTO czy_istnieje
    FROM OSOBY o
    WHERE o.ID_OSOBY = ID;

    IF czy_istnieje = 0
    THEN
        RAISE osoba_nie_istnieje;
    END IF;

    SELECT osoby_wycieczki_record(
        w.NAZWA,
        w.KRAJ,
        w.DATA,
        o.IMIE,
        o.NAZWISKO,
        r.STATUS)
    BULK COLLECT INTO wynik
    FROM WYCIECZKI w
    JOIN REZERWACJE r on w.ID_WYCIECZKI = r.ID_WYCIECZKI
    JOIN OSOBY o on r.ID_OSOBY = o.ID_OSOBY
    WHERE o.ID_OSOBY = ID;

    RETURN wynik;
END;