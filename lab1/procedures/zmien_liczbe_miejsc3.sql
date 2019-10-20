CREATE OR REPLACE PROCEDURE zmien_liczbe_miejsc3(
    ID_WYCIECZKI INT,
    LICZBA_MIEJSC INT
)
AS
    nieprawidlowa_wartosc EXCEPTION;
    wycieczka_nie_istnieje EXCEPTION;
    zbyt_malo_miejsc EXCEPTION;
    czy_istnieje INT;
    liczba_zajetych INT;
BEGIN
    IF LICZBA_MIEJSC < 0
    THEN
        RAISE nieprawidlowa_wartosc;
    END IF;

    SELECT COUNT(*)
    INTO czy_istnieje
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = zmien_liczbe_miejsc3.ID_WYCIECZKI;

    IF czy_istnieje = 0
    THEN
        RAISE wycieczka_nie_istnieje;
    END IF;

    SELECT
        w.LICZBA_MIEJSC - w.LICZBA_WOLNYCH_MIEJSC
    INTO liczba_zajetych
    FROM WYCIECZKI w
    WHERE w.ID_WYCIECZKI = zmien_liczbe_miejsc3.ID_WYCIECZKI;

    IF liczba_zajetych > LICZBA_MIEJSC
    THEN
        RAISE zbyt_malo_miejsc;
    END IF;

    UPDATE WYCIECZKI w
    SET w.LICZBA_MIEJSC = zmien_liczbe_miejsc3.LICZBA_MIEJSC
    WHERE w.ID_WYCIECZKI = zmien_liczbe_miejsc3.ID_WYCIECZKI;
END;