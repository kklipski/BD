--dropping tables & sequences

drop table druzyna cascade constraints;
drop table historyczny_mistrz cascade constraints;
drop table zawodnik cascade constraints;
drop table zdarzenie cascade constraints;
drop table mecz cascade constraints;
drop table rozegrala cascade constraints;
drop table historyczny_krol_strzelcow cascade constraints;
drop sequence mistrz_seq;
drop sequence krol_strzelcow_seq;
drop sequence zawodnik_seq;

--creating tables

create table druzyna 
(
id_druzyny int primary key NOT NULL CHECK (id_druzyny > 0 AND id_druzyny < 19),
nazwa varchar(50) NOT NULL UNIQUE,   
rozegrane_mecze int default 0 NOT NULL, 
bramki_strzelone int default 0 NOT NULL,
bramki_stracone int default 0 NOT NULL,
punkty int default 0 NOT NULL);

create table historyczny_mistrz
(
rok int primary key NOT NULL,
id_druzyny int NOT NULL,
constraint fk_druzyna_1
FOREIGN KEY (id_druzyny)
REFERENCES druzyna(id_druzyny)
);

create table zawodnik
(
id_zawodnika int primary key NOT NULL,
imie varchar(50) NOT NULL,
nazwisko varchar(50) NOT NULL,
id_druzyny int,
pozycja varchar(50) NOT NULL,
numer_koszulki int CHECK (numer_koszulki > 0 AND numer_koszulki < 100),
wiek int CHECK (wiek > 15),
narodowosc varchar(50) NOT NULL,
gole int default 0,
asysty int default 0,
zolte_kartki int default 0,
czerwone_kartki int default 0,
constraint fk_druzyna_2
FOREIGN KEY (id_druzyny)
REFERENCES druzyna(id_druzyny),
constraint uc_zawodnik UNIQUE (id_druzyny, numer_koszulki)
);

create table mecz
(
nr_meczu int primary key NOT NULL CHECK (nr_meczu > 0 AND nr_meczu < 308),
data_rozegrania date NOT NULL,
gole_gospodarz int default 0 NOT NULL,
gole_gosc int default 0 NOT NULL
);

create table zdarzenie
(
nr_meczu int NOT NULL,
minuta int NOT NULL,
typ_zdarzenia varchar(20) NOT NULL,
id_zawodnika int NOT NULL,
constraint pk_zdarzenie 
primary key (nr_meczu, minuta, typ_zdarzenia, id_zawodnika),
constraint fk_mecz_1
FOREIGN KEY (nr_meczu)
REFERENCES mecz(nr_meczu),
constraint fk_zawodnik_1
FOREIGN KEY (id_zawodnika)
REFERENCES zawodnik(id_zawodnika)
);

create table rozegrala
(
nr_meczu int NOT NULL,
id_gospodarza int NOT NULL,
id_goscia int NOT NULL,
constraint pk_rozegrala
primary key (nr_meczu, id_gospodarza, id_goscia),
constraint fk_mecz_2
FOREIGN KEY (nr_meczu)
REFERENCES mecz(nr_meczu),
constraint fk_druzyna_3
FOREIGN KEY (id_gospodarza)
REFERENCES druzyna(id_druzyny),
constraint fk_druzyna_4
FOREIGN KEY (id_goscia)
REFERENCES druzyna(id_druzyny)
);

create table historyczny_krol_strzelcow
(
rok int primary key NOT NULL,
id_zawodnika int NOT NULL,
gole int NOT NULL,
constraint fk_zawodnik_2
FOREIGN KEY (id_zawodnika)
REFERENCES zawodnik(id_zawodnika)
)
;

--creating sequences

CREATE SEQUENCE mistrz_seq START WITH 2018 INCREMENT BY 1;
CREATE SEQUENCE krol_strzelcow_seq START WITH 2018 INCREMENT BY 1;
CREATE SEQUENCE zawodnik_seq START WITH 631 INCREMENT BY 1;

commit;
