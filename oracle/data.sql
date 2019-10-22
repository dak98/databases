-- OSOBY
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Adam', 'Kowalski', '87654321', 'tel: 6623');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jan', 'Nowak', '12345678', 'tel: 2312, dzwonić po 18.00');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Michal', 'Kichal', '46391590', 'tel: 1754');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jan', 'Naj', '46329122', 'tel: 5472');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Marcin', 'Nicram', '56567134', 'tel: 5429');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jozef', 'Fezoj', '47532967', 'tel: 2348');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Zbigniew', 'Wef', '23496758', 'tel: 1465');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Zbigniew', 'Pol', '33645896', 'tel: 2468');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jakub', 'Bukaj', '654387560', 'tel: 4562');
INSERT INTO osoby (imie, nazwisko, pesel, kontakt)
VALUES('Jerzy', 'Baj', '56435464', 'tel: 6542');

-- WYCIECZKI
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wycieczka do Paryza', 'Francja', TO_DATE('2020-01-01', 'YYYY-MM-DD'),
        'Ciekawa wycieczka ...', 3);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Piekny Krakow', 'Polska', TO_DATE('2017-02-03', 'YYYY-MM-DD'),
        'Najciekawa wycieczka ...', 2);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Wieliczka', 'Polska', TO_DATE('2020-03-03', 'YYYY-MM-DD'),
        'Zadziwiająca kopalnia ...', 2);
INSERT INTO wycieczki (nazwa, kraj, data, opis, liczba_miejsc)
VALUES ('Genewa', 'Szwajcaria', TO_DATE('2020-03-03','YYYY-MM-DD'), 'CEEEEERN',
        5);

-- Rezerwacje
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3, 1, 'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4, 2, 'P');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5, 31, 'N');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3, 32, 'A');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6, 33, 'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6, 32, 'P');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (4, 33, 'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (3, 36, 'A');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (6, 29, 'Z');
INSERT INTO rezerwacje(id_wycieczki, id_osoby, status)
VALUES (5, 30, 'P');