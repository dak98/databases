CREATE OR REPLACE TRIGGER zmien_liczbe_miejsc_trigger
BEFORE UPDATE OF LICZBA_MIEJSC ON WYCIECZKI -- AFTER tutaj nie dziala ze
                                            -- wzgledu na zmiane w :NEW
FOR EACH ROW
BEGIN
    SELECT
        :NEW.LICZBA_MIEJSC - (:OLD.LICZBA_MIEJSC - :OLD.LICZBA_WOLNYCH_MIEJSC)
    INTO :NEW.LICZBA_WOLNYCH_MIEJSC
    FROM DUAL;
END;