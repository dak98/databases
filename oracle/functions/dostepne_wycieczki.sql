CREATE OR REPLACE TYPE dostepne_wycieczki_record AS OBJECT (
    ID_WYCIECZKI INT,
    NAZWA VARCHAR2(100),
    DATA DATE,
    OPIS VARCHAR2(200),
    LICZBA_WOLNYCH_MIEJSC INT
);

CREATE OR REPLACE TYPE dostepne_wycieczki_table IS TABLE OF dostepne_wycieczki_record;

CREATE OR REPLACE FUNCTION dostepne_wycieczki_fun(
    KRAJ WYCIECZKI.KRAJ%TYPE,
    DATA_OD DATE,
    DATA_DO DATE
)
RETURN dostepne_wycieczki_table
AS
    wynik dostepne_wycieczki_table;
    nieprawidlowy_przedzial_czasowy EXCEPTION;
BEGIN
    IF DATA_OD > DATA_DO
    THEN
        RAISE nieprawidlowy_przedzial_czasowy;
    END IF;

    SELECT dostepne_wycieczki_record(
        ID_WYCIECZKI,
        NAZWA,
        DATA,
        OPIS,
        LICZBA_MIEJSC - (SELECT COUNT(*)
                         FROM WYCIECZKI wy
                         JOIN REZERWACJE re ON wy.ID_WYCIECZKI = re.ID_WYCIECZKI
                         WHERE STATUS != 'A' AND w.ID_WYCIECZKI = wy.ID_WYCIECZKI)
        )
    BULK COLLECT INTO wynik
    FROM WYCIECZKI w
    WHERE w.KRAJ = dostepne_wycieczki_fun.KRAJ
      AND DATA >= DATA_OD
      AND DATA <= DATA_DO
      AND LICZBA_MIEJSC - (SELECT COUNT(*)
                          FROM WYCIECZKI wy
                          JOIN REZERWACJE re ON wy.ID_WYCIECZKI = re.ID_WYCIECZKI
                          WHERE STATUS != 'A' AND w.ID_WYCIECZKI = wy.ID_WYCIECZKI) > 0;
    RETURN wynik;
END;