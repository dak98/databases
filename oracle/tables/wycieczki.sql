ALTER TABLE wycieczki
ADD liczba_wolnych_miejsc INT;

ALTER TABLE wycieczki
ADD CONSTRAINT NIEUJEMNE_WOLNE_MIEJSCA CHECK
(
    liczba_wolnych_miejsc >= 0    
) ENABLE;