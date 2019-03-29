/* na potrzeby wykonania zadania zwiekszono ilosc generowanych meczow do 306, zwiekszono maksymalna mozliwa liczbe strzelonych bramek
na mecz przez druzyne (do 99), zwiekszono ilosc generowanych kartek na mecz do 100 */

-- operacje byly przeprowadzane na bazie lokalnej, wiec koszty wykonania operacji moga sie roznic

drop index mecz_idx1;
create index mecz_idx1 on mecz(nr_meczu, data_rozegrania);

drop index rozegrala_idx1;
create index rozegrala_idx1 on rozegrala(nr_meczu, id_gospodarza);

drop index rozegrala_idx2;
create index rozegrala_idx2 on rozegrala(nr_meczu, id_goscia);

drop index rozegrala_idx3;
create index rozegrala_idx3 on rozegrala(id_gospodarza, id_goscia);

drop index zdarzenie_idx1;
create index zdarzenie_idx1 on zdarzenie(nr_meczu, typ_zdarzenia);

drop index zdarzenie_idx2;
create index zdarzenie_idx2 on zdarzenie(nr_meczu, id_zawodnika);

drop index zawodnik_idx1;
create index zawodnik_idx1 on zawodnik(id_zawodnika, imie, nazwisko);

drop index zawodnik_idx2;
create index zawodnik_idx2 on zawodnik(id_zawodnika, id_druzyny);

drop index druzyna_idx1;
create index druzyna_idx1 on druzyna(id_druzyny, nazwa);

drop index hm_idx1;
create index hm_idx1 on historyczny_mistrz(rok, id_druzyny);

drop index hks_idx1;
create index hks_idx1 on historyczny_krol_strzelcow(rok, id_zawodnika);

alter index mecz_idx1 visible;
alter index rozegrala_idx1 visible;
alter index rozegrala_idx2 visible;
alter index rozegrala_idx3 visible;
alter index zdarzenie_idx1 visible;
alter index zdarzenie_idx2 visible;
alter index zawodnik_idx1 visible;
alter index zawodnik_idx2 visible;
alter index druzyna_idx1 visible;
alter index hm_idx1 visible;
alter index hks_idx1 visible;

alter index mecz_idx1 invisible;
alter index rozegrala_idx1 invisible;
alter index rozegrala_idx2 invisible;
alter index rozegrala_idx3 invisible;
alter index zdarzenie_idx1 invisible;
alter index zdarzenie_idx2 invisible;
alter index zawodnik_idx1 invisible;
alter index zawodnik_idx2 invisible;
alter index druzyna_idx1 invisible;
alter index hm_idx1 invisible;
alter index hks_idx1 invisible;

execute dbms_stats.gather_table_stats ('klipski','mecz');
execute dbms_stats.gather_table_stats ('klipski','rozegrala');
execute dbms_stats.gather_table_stats ('klipski','zawodnik');
execute dbms_stats.gather_table_stats ('klipski','zdarzenie');
execute dbms_stats.gather_table_stats ('klipski','druzyna');
execute dbms_stats.gather_table_stats ('klipski','historyczny_mistrz');
execute dbms_stats.gather_table_stats ('klipski','historyczny_krol_strzelcow');

-- hash join

select count(*) from zawodnik z join zdarzenie zd on (z.id_zawodnika = zd.id_zawodnika) where wiek >= 20 and wiek <= 40;    -- 67948

explain plan for
select nr_meczu, minuta, typ_zdarzenia, z.id_zawodnika, imie, nazwisko from zawodnik z join zdarzenie zd on (z.id_zawodnika = zd.id_zawodnika) where wiek >= 20 and wiek <= 40;
select * from table (dbms_xplan.display);

-- uzyskany plan zapytan: hash join, cost: 79

explain plan for
select /*+ use_merge(z, zd)*/ nr_meczu, minuta, typ_zdarzenia, z.id_zawodnika, imie, nazwisko from zawodnik z join zdarzenie zd on (z.id_zawodnika = zd.id_zawodnika) where wiek >= 20 and wiek <= 40;
select * from table (dbms_xplan.display);

-- cost: 540

explain plan for
select /*+ use_nl(z, zd)*/ nr_meczu, minuta, typ_zdarzenia, z.id_zawodnika, imie, nazwisko from zawodnik z join zdarzenie zd on (z.id_zawodnika = zd.id_zawodnika) where wiek >= 20 and wiek <= 40;
select * from table (dbms_xplan.display);

-- cost: 37545

-- nested loops

explain plan for
select rok, hks.id_zawodnika, imie, nazwisko, hks.gole from historyczny_krol_strzelcow hks join zawodnik z on (hks.id_zawodnika = z.id_zawodnika) where hks.gole < 5;
select * from table (dbms_xplan.display);

-- uzyskany plan zapytan: nested loops, cost: 5

explain plan for
select /*+ use_merge(hks, z)*/ rok, hks.id_zawodnika, imie, nazwisko, hks.gole from historyczny_krol_strzelcow hks join zawodnik z on (hks.id_zawodnika = z.id_zawodnika) where hks.gole < 5;
select * from table (dbms_xplan.display);

-- cost: 8

explain plan for
select /*+ use_hash(hks, z)*/ rok, hks.id_zawodnika, imie, nazwisko, hks.gole from historyczny_krol_strzelcow hks join zawodnik z on (hks.id_zawodnika = z.id_zawodnika) where hks.gole < 5;
select * from table (dbms_xplan.display);

-- cost: 7

-- merge join (warunek zlaczenia zawiera nierownosci)

explain plan for
select nr_meczu, minuta, typ_zdarzenia, z.id_zawodnika, imie, nazwisko 
from zawodnik z join zdarzenie zd on (z.id_zawodnika > zd.id_zawodnika) where wiek >= 20 and wiek <= 40;
select * from table (dbms_xplan.display);

-- uzyskany plan zapytan: merge join, cost: 741

explain plan for
select /*+ use_hash(z, zd)*/ nr_meczu, minuta, typ_zdarzenia, z.id_zawodnika, imie, nazwisko 
from zawodnik z join zdarzenie zd on (z.id_zawodnika > zd.id_zawodnika) where wiek >= 20 and wiek <= 40;
select * from table (dbms_xplan.display);

-- nie da sie uzyskac planu hash join, ze wzgledu na zastosowanie nierownosci w warunku zlaczenia

explain plan for
select /*+ use_nl(z, zd)*/ nr_meczu, minuta, typ_zdarzenia, z.id_zawodnika, imie, nazwisko 
from zawodnik z join zdarzenie zd on (z.id_zawodnika > zd.id_zawodnika) where wiek >= 20 and wiek <= 40;
select * from table (dbms_xplan.display);

-- cost: 37545
