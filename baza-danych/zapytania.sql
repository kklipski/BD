--having

--zapytanie zwraca nazwe druzyny i liczbe zdobytych przez nia tytulow mistrzowskich w kolejnosci malejacej, przy czym uwzgledniane sa tylko te druzyny, ktore zostaly mistrzem wiecej niz 2 razy

SELECT nazwa, count(rok) as tytuly
from druzyna natural join historyczny_mistrz
group by nazwa
having count(rok) > 2
order by tytuly desc;

--group by

--zapytanie zwraca nazwe druzyny i liczbe zdobytych przez jej zawodnikow czerwonych kartek w malejacej kolejnosci

select nazwa, sum(czerwone_kartki) as liczba_czerwonych_kartek
from zawodnik natural join druzyna
group by nazwa
order by liczba_czerwonych_kartek desc, nazwa asc;

--podzapytania

--zapytanie (jest to podzapytanie skorelowane) zwraca imie, nazwisko i liczbê goli kazdego zawodnika, ktory zdobyl wiecej bramek niz srednia ilosc goli przypadajaca na jednego zawodnika w jego druzynie

select imie, nazwisko, gole
from zawodnik z
where gole > 
	(select avg(gole) from zawodnik
	where id_druzyny = z.id_druzyny);

--funkcje obliczajace

--zapytanie oblicza srednia liczbe zdobytych goli przypadajaca na kazda z druzyn

select avg(bramki_strzelone) as srednia_liczba_goli
from druzyna;