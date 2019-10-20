CREATE OR REPLACE PROCEDURE dodaj_rezerwacje(
    ID_WYCIECZKI INT,
    ID_OSOBY INT
)
AS
    wycieczka_nie_istnieje EXCEPTION;
    osoba_nie_istnieje EXCEPTION;
    rezerwacja_juz_istnieje EXCEPTION;
    brak_wolnych_miejsc EXCEPTION;
    termin_minal EXCEPTION;
    czy_istnieje INT;
    nr_nowej_rezerwacji INT;
BEGIN
    SELECT COUNT(*)
    INTO czy_istnieje
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = dodaj_rezerwacje.ID_WYCIECZKI;

    IF czy_istnieje = 0
    THEN
        RAISE wycieczka_nie_istnieje;
    END IF;

    SELECT COUNT(*)
    INTO czy_istnieje
    FROM OSOBY o
    WHERE o.ID_OSOBY = dodaj_rezerwacje.ID_OSOBY;

    IF czy_istnieje = 0
    THEN
        RAISE osoba_nie_istnieje;
    END IF;

    SELECT COUNT(*)
    INTO czy_istnieje
    FROM REZERWACJE r
    WHERE r.ID_WYCIECZKI = dodaj_rezerwacje.ID_WYCIECZKI
      AND r.ID_OSOBY = dodaj_rezerwacje.ID_OSOBY
      AND r.STATUS != 'A';

    IF czy_istnieje > 0
    THEN
        RAISE rezerwacja_juz_istnieje;
    END IF;

    SELECT
        w.LICZBA_MIEJSC - (SELECT COUNT(*)
                            FROM WYCIECZKI wy
                            JOIN REZERWACJE re ON wy.ID_WYCIECZKI = re.ID_WYCIECZKI
                            WHERE STATUS != 'A' AND w.ID_WYCIECZKI = wy.ID_WYCIECZKI)
    INTO czy_istnieje
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = dodaj_rezerwacje.ID_WYCIECZKI;

    IF czy_istnieje = 0
    THEN
        RAISE brak_wolnych_miejsc;
    END IF;

    SELECT
        DATA - CURRENT_DATE
    INTO czy_istnieje
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = dodaj_rezerwacje.ID_WYCIECZKI;

    IF czy_istnieje <= 0
    THEN
        RAISE termin_minal;
    END IF;

    INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
    VALUES (ID_WYCIECZKI, ID_OSOBY, 'N');

    -- Zakladajac, ze mozliwa jest tylko jedna rezerwacja na pare
    -- (wycieczka, osoba)
    SELECT
        NR_REZERWACJI
    INTO nr_nowej_rezerwacji
    FROM REZERWACJE r
    WHERE r.ID_WYCIECZKI = dodaj_rezerwacje.ID_WYCIECZKI
    AND r.ID_OSOBY = dodaj_rezerwacje.ID_OSOBY;

    INSERT INTO rezerwacje_log(NR_REZERWACJI, DATA, STATUS)
    VALUES (nr_nowej_rezerwacji, CURRENT_DATE, 'N');

    COMMIT;
END;