CREATE OR REPLACE PROCEDURE zmien_status_rezerwacji(
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

    IF aktualny_status = 'A'
    THEN
        SELECT
            LICZBA_MIEJSC - (SELECT COUNT(*)
                             FROM WYCIECZKI wy
                             JOIN REZERWACJE re ON wy.ID_WYCIECZKI = re.ID_WYCIECZKI
                             WHERE re.STATUS != 'A' AND w.ID_WYCIECZKI = wy.ID_WYCIECZKI)
        INTO czy_istnieje
        FROM WYCIECZKI w
        JOIN REZERWACJE r ON w.ID_WYCIECZKI = r.ID_WYCIECZKI
        WHERE r.NR_REZERWACJI = ID_REZERWACJI;

        IF czy_istnieje <= 0
        THEN
            RAISE brak_wolnych_miejsc;
        END IF;
    END IF;

    UPDATE REZERWACJE r
    SET r.STATUS = zmien_status_rezerwacji.STATUS
    WHERE NR_REZERWACJI = ID_REZERWACJI;

    INSERT INTO rezerwacje_log(NR_REZERWACJI, DATA, STATUS)
    VALUES (ID_REZERWACJI, CURRENT_DATE, STATUS);

    COMMIT;
END;