CREATE VIEW dostepne_wycieczki2
AS SELECT
    *
FROM wycieczki_miejsca2 w
WHERE w.DATA >= CURRENT_DATE AND w.LICZBA_WOLNYCH_MIEJSC > 0;