CREATE OR REPLACE PROCEDURE zmien_status_rezerwacji2(
    ID_REZERWACJI INT,
    STATUS REZERWACJE.STATUS%TYPE -- CHAR(1) tutaj nie działa :-(
)
AS
    niepoprawny_status EXCEPTION;
    rezerwacja_nie_istnieje EXCEPTION;
    zmiana_niemozliwa EXCEPTION;
    brak_wolnych_miejsc EXCEPTION;
    aktualny_status REZERWACJE.STATUS%TYPE;
    czy_istnieje INT;
    wycieczka INT;
BEGIN
    -- Zmiana na 'N' nie ma sensu
    IF STATUS = 'N'
    THEN
        RAISE zmiana_niemozliwa;
    END IF;

    SELECT COUNT(*)
    INTO czy_istnieje
    FROM REZERWACJE r
    WHERE NR_REZERWACJI = ID_REZERWACJI;

    IF czy_istnieje = 0
    THEN
        RAISE rezerwacja_nie_istnieje;
    END IF;

    SELECT
        r.STATUS
    INTO aktualny_status
    FROM REZERWACJE r
    WHERE NR_REZERWACJI = ID_REZERWACJI;

    SELECT
        ID_WYCIECZKI
    INTO wycieczka
    FROM REZERWACJE r
    WHERE r.NR_REZERWACJI = ID_REZERWACJI;

    IF aktualny_status = 'A'
    THEN
        SELECT
            LICZBA_WOLNYCH_MIEJSC
        INTO czy_istnieje
        FROM WYCIECZKI
        WHERE ID_WYCIECZKI = wycieczka;

        IF czy_istnieje <= 0
        THEN
            RAISE brak_wolnych_miejsc;
        END IF;
    END IF;

    UPDATE REZERWACJE r
    SET r.STATUS = zmien_status_rezerwacji2.STATUS
    WHERE NR_REZERWACJI = ID_REZERWACJI;

    IF aktualny_status = 'A' AND STATUS != 'A'
    THEN
        UPDATE wycieczki
        SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC - 1
        WHERE ID_WYCIECZKI = wycieczka;
    END IF;

    IF aktualny_status != 'A' AND STATUS = 'A'
    THEN
        UPDATE wycieczki
        SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC + 1
        WHERE ID_WYCIECZKI = wycieczka;
    END IF;

    INSERT INTO rezerwacje_log(NR_REZERWACJI, DATA, STATUS)
    VALUES (ID_REZERWACJI, CURRENT_DATE, STATUS);

    COMMIT;
END;