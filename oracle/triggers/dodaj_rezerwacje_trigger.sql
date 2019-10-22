CREATE OR REPLACE TRIGGER dodaj_rezerwacje_trigger
AFTER INSERT ON REZERWACJE
FOR EACH ROW -- Wywolywane przy zmianie pojedynczego wiersza. Zapewnia dostep
             -- do NEW
BEGIN
    INSERT INTO REZERWACJE_LOG (NR_REZERWACJI, DATA, STATUS)
    VALUES (:NEW.NR_REZERWACJI, CURRENT_DATE, :NEW.STATUS);
END;