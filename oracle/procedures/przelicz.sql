CREATE OR REPLACE PROCEDURE przelicz
AS
BEGIN
   UPDATE WYCIECZKI w
   SET LICZBA_WOLNYCH_MIEJSC = LICZBA_MIEJSC - (SELECT COUNT(*)
                                                FROM REZERWACJE r
                                                WHERE STATUS != 'A'
                                                  AND r.ID_WYCIECZKI = w.ID_WYCIECZKI)
   WHERE 1 = 1; -- Potrzebne, aby zignorowac ostrzezenie o UPDATE dla wszystkich rekordow
END;