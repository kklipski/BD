/* na potrzeby wykonania zadania zwiekszono ilosc wygenerowanych historycznych krolow strzelcow do 1000 (przewidziano rezultaty od 1950 
do 2950 roku; uznalem to za lepsze rozwiazanie, niz generowanie rezultatow dla rozgrywek z epoki sredniowiecza; co prawda stwierdzenie 
'historyczny' staje sie teraz delikatnym naduzyciem, ale na potrzeby zadania mozna uznac, ze jest rok 2951); celem takiej modyfikacji
bylo uzyskanie tabeli o rozmiarze rzedu 1000 rekordow */

-- operacje byly przeprowadzane na bazie lokalnej, wiec koszty wykonania operacji moga sie roznic

select count(*) from historyczny_krol_strzelcow;     -- 1001

drop index hks_idx1;
create index hks_idx1 on historyczny_krol_strzelcow(id_zawodnika);

drop index hks_idx2;
create index hks_idx2 on historyczny_krol_strzelcow(gole);

drop index hks_idx3;
create index hks_idx3 on historyczny_krol_strzelcow(rok, id_zawodnika);

drop index hks_idx4;
create index hks_idx4 on historyczny_krol_strzelcow(rok, gole);

drop index hks_idx5;
create index hks_idx5 on historyczny_krol_strzelcow(id_zawodnika, gole);

drop index hks_idx6;
create index hks_idx6 on historyczny_krol_strzelcow(rok, id_zawodnika, gole);

alter index hks_idx1 visible;
alter index hks_idx2 invisible;
alter index hks_idx3 visible;
alter index hks_idx4 invisible;
alter index hks_idx5 invisible;
alter index hks_idx6 invisible;

EXECUTE DBMS_STATS.GATHER_TABLE_STATS ('klipski','historyczny_krol_strzelcow');

/* eksperyment przeprowadzony przy aktywnych indeksach 1 i 3 (jedynie) - dotycza one bezposrednio atrybutu uzywanego w warunku w klauzuli 
WHERE w realizowanych zapytaniach */

explain plan for
select id_zawodnika, gole from HISTORYCZNY_KROL_STRZELCOW order by 1, 2;
select *
from table (dbms_xplan.display);
select count(*)/1001 from HISTORYCZNY_KROL_STRZELCOW;   -- 1

-- TABLE ACCESS FULL

explain plan for
select id_zawodnika, gole from HISTORYCZNY_KROL_STRZELCOW where id_zawodnika between 1 and 399 order by 1, 2;
select *
from table (dbms_xplan.display);
select count(*)/1001 from HISTORYCZNY_KROL_STRZELCOW where id_zawodnika between 1 and 399;   -- 0,40

-- TABLE ACCESS FULL

explain plan for
select id_zawodnika, gole from HISTORYCZNY_KROL_STRZELCOW where id_zawodnika between 1 and 299 order by 1, 2;
select *
from table (dbms_xplan.display);
select count(*)/1001 from HISTORYCZNY_KROL_STRZELCOW where id_zawodnika between 1 and 299;   -- 0,30

-- INDEX RANGE SCAN, INDEKS NR. 1

explain plan for
select id_zawodnika, gole from HISTORYCZNY_KROL_STRZELCOW where id_zawodnika between 1 and 349 order by 1, 2;
select *
from table (dbms_xplan.display);
select count(*)/1001 from HISTORYCZNY_KROL_STRZELCOW where id_zawodnika between 1 and 349;   -- 0,35

-- TABLE ACCESS FULL

/* zgodnie z poleceniem, staralem sie znalezc wartosc graniczna, przy ktorej nastepuje przejscie miedzy TABLE ACCESS FULL a INDEX RANGE SCAN;
dla wybranej tabeli i realizowanego powyzej zapytania, z projekcja wszystkich wartosci w tej tabeli oprocz jej klucza glownego oraz
z warunkiem w klauzuli WHERE nalozonym na klucz obcy tej relacji, uzyskano taka wartosc przy projekcji okolo 30 % ze wszystkich krotek
znajdujacych sie w tabeli historyczny_krol_strzelcow; wartosc ta jest zblizona do wartosci wzorcowej, podanej przez prowadzacego (40 %);

przy probach realizacji zadania uzyskiwalem wiele roznych planow zapytan, co pozwalilo mi lepiej zrozumiec mechanizm dzialania indeksow;
TABLE ACCESS FULL wystepowalo zawsze w przypadku braku nalozonych na dana tabele indeksow, po ich aktywacji plan zapytan czesto przechodzil
w FAST FULL SCAN badz FULL INDEX SCAN (przy czym analizuje tu przypadek projekcji bez selekcji); czasami i wtedy pojawial sie plan TABLE ACCESS
FULL, co najprawdopodobniej oznaczalo, ze dana tabela nie miesci sie w pamieci; w przypadku uzyskania planu FULL INDEX SCAN, wprowadzenie
selekcji do zapytania powodowalo przejscie w plan INDEX RANGE SCAN;

przy wprowadzeniu wielu indeksow (jedno- i wielowartosciowych) i zmianach warunkow w klauzuli WHERE (zmiana selekcjonowanych atrybutow), 
moglem obserwowac, jak, w zaleznosci od tych zmian, byly wybierane rozne (w danym przypadku najbardziej odpowiednie) indeksy */
