CREATE OR REPLACE TRIGGER dodaj_rezerwacje_trigger2
AFTER INSERT ON REZERWACJE
FOR EACH ROW
BEGIN
    UPDATE WYCIECZKI w
    SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC - 1
    WHERE w.ID_WYCIECZKI = :NEW.ID_WYCIECZKI;
END;