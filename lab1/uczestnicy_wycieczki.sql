CREATE OR REPLACE TYPE osoby_wycieczki_record AS OBJECT (
    NAZWA VARCHAR2(100),
    KRAJ VARCHAR2(50),
    DATA DATE,
    IMIE VARCHAR2(50),
    NAZWISKO VARCHAR2(50),
    STATUS CHAR(1)
);

CREATE OR REPLACE TYPE osoby_wycieczki_table
IS TABLE OF osoby_wycieczki_record;

CREATE OR REPLACE FUNCTION uczestnicy_wycieczki(ID INT)
RETURN osoby_wycieczki_table
AS
    wynik osoby_wycieczki_table;
    wycieczka_nie_istnieje EXCEPTION;
    czy_istnieje INT;
BEGIN
    SELECT
        COUNT(*)
    INTO czy_istnieje
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = ID;

    IF czy_istnieje = 0
    THEN
        RAISE wycieczka_nie_istnieje;
    END IF;

    SELECT osoby_wycieczki_record(
        NAZWA,
        KRAJ,
        DATA,
        IMIE,
        NAZWISKO,
        STATUS)
    BULK COLLECT INTO wynik
    FROM wycieczki_osoby
    WHERE ID_WYCIECZKI = ID AND STATUS != 'A';

    RETURN wynik;
END;