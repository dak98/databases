CREATE OR REPLACE TRIGGER zmien_status_trigger2
AFTER UPDATE ON REZERWACJE
FOR EACH ROW
BEGIN
    IF :OLD.STATUS = 'A' AND :NEW.STATUS != 'A'
    THEN
        UPDATE wycieczki
        SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC - 1
        WHERE ID_WYCIECZKI = :NEW.ID_WYCIECZKI;
    END IF;

    IF :OLD.STATUS != 'A' AND :NEW.STATUS = 'A'
    THEN
        UPDATE wycieczki
        SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC + 1
        WHERE ID_WYCIECZKI = :NEW.ID_WYCIECZKI;
    END IF;
END;