CREATE OR REPLACE PROCEDURE GENERUJ_DRUZYNA IS 
TYPE TABSTR IS TABLE OF VARCHAR2(250);
	id_druzyny NUMBER(2);
    nazwa TABSTR;
    qname NUMBER(2);
BEGIN
nazwa := TABSTR('1. FC Koeln', 'Bayer Leverkusen', 'Bayern Monachium', 'Borussia Dortmund', 'Borussia Moenchengladbach',
'Eintracht Frankfurt', 'FC Augsburg', 'FC Ingolstadt', 'FC Schalke 04', 'Hamburger SV', 'Hertha BSC', 'Mainz 05', 'RB Lipsk',
'SC Freiburg', 'SV Darmstadt', 'TSG Hoffenheim', 'VfL Wolfsburg', 'Werder Brema');
qname := nazwa.count;

	FOR i IN 1..qname LOOP
		id_druzyny := i;
		INSERT INTO druzyna VALUES (id_druzyny, nazwa(i), 0, 0, 0, 0);
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkie druzyny.');
    
END GENERUJ_DRUZYNA;





CREATE OR REPLACE PROCEDURE GENERUJ_HISTORYCZNY_MISTRZ IS 
TYPE TABSTR IS TABLE OF VARCHAR2(250);
	rok NUMBER(4);
    id_druzyny NUMBER(2);
    qname NUMBER(4);
BEGIN
qname := 2017;

	FOR i IN 1950..qname LOOP
		rok := i;
        id_druzyny := dbms_random.value(1,18);
		INSERT INTO historyczny_mistrz VALUES (rok, id_druzyny);
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkich historycznych mistrzow.');
    
END GENERUJ_HISTORYCZNY_MISTRZ;





create or replace PROCEDURE GENERUJ_HIST_KROL_STRZELCOW IS 
TYPE TABSTR IS TABLE OF VARCHAR2(250);
    rok NUMBER(4);
    los_id_zawodnika NUMBER(3);
    qname1 NUMBER(4);
    qname2 NUMBER(4);
    qname3 NUMBER(4);
    qname4 NUMBER(4);
    gole NUMBER(2);
    imie TABSTR;
    los_wiek NUMBER(3);
    los_imie VARCHAR2(20);
    los_nazwisko VARCHAR(20);
    los_narodowosc VARCHAR(30);
    nazwisko TABSTR;
    narodowosc TABSTR;
    pozycja TABSTR;
    los_pozycja VARCHAR(20);
    cond NUMBER(3);
    var1 NUMBER(3);
    var2 NUMBER(3);
BEGIN
qname1 := 1950;
qname2 := 1992;
qname3 := 1993;
qname4 := 2017;
imie := TABSTR ('Piotr', 'Krzysztof', 'Andrzej', 'Tomasz', 'Jan', 'Pawel', 'Michal', 'Marcin', 'Stanislaw', 'Marek', 'Maximilian', 
'Alexander', 'Paul', 'Leon', 'Ben', 'Lukas', 'Lucas', 'Luca', 'Luka', 'Louis', 'Luis', 'Elias', 'Jonas', 'Enzo', 'Mathis', 'Ethan', 
'Hugo', 'Matheo', 'Nathan', 'Theo', 'Noah', 'Matteo', 'Thomas', 'Jakub', 'Tomas', 'David', 'Adam', 'Matej', 'Ondrej', 'Cristobal',
'Vojtech', 'Filip', 'William', 'Noah', 'Lucas', 'Oscar', 'Victor', 'Malthe', 'Emil', 'Frederik', 'Oliver', 'Magnus', 'Tobias',
'Simon', 'Sebastian', 'Felix', 'Julian', 'Pedro', 'Rodrigo', 'Alex', 'Fabio', 'Miguel', 'Estevan', 'Julio', 'Nathan', 'Arthur',
'Mohamed', 'Milan', 'Mathis', 'So', 'Minato', 'Ichika', 'Itsuki', 'Tatsuki', 'Ren', 'Hinata', 'Haruta', 'Asahi', 'Haruki', 'Tomoharu',
'Sota', 'Yuma', 'Arata', 'Ryo', 'Yuto', 'Haruto', 'Haruhito', 'Kanata', 'Hayato', 'Taichi', 'Aron', 'Viktor', 'Jon', 'Arnar', 'Daniel',
'Guomundur', 'Kristjan', 'Kristian', 'Christian', 'Gunnar', 'Dagur', 'Sigurour', 'Liam', 'Mason', 'Jacob', 'Michael', 'James',
'Daan', 'Sem', 'Tim', 'Jayden', 'Thomas', 'Thijs', 'Jesse', 'Ruben', 'Lars', 'Yusuf', 'Arda', 'Mehmet', 'Mustafa', 'Ahmet', 'Emirhan',
'Enes', 'Furkan', 'Muhammed', 'Ali', 'Nazar', 'Danylo', 'Maksym', 'Wladyslaw', 'Mykyta', 'Artem', 'Kyrylo', 'Jehor', 'Illja', 'Andrij',
'Martin', 'Pablo', 'Alejandro', 'Alvaro', 'Adrian', 'Mateo', 'Benjamin', 'Vicente', 'Matias', 'Martin', 'Joaquin', 'Diego',	'Nicolas',
'Jose');
nazwisko := TABSTR('Mueller', 'Schmidt', 'Schneider', 'Fischer', 'Meyer', 'Weber', 'Schulz', 'Wagner', 'Becker', 'Hoffmann', 'Nowak',
'Kowalski', 'Wisniewski', 'Wojcik', 'Kowalczyk', 'Kaminski', 'Lewandowski', 'Zielinski', 'Szymanski', 'Wozniak', 'Dabrowski',
'Kozlowski', 'Jankowski', 'Mazur', 'Kwiatkowski', 'Wojciechowski', 'Krawczyk', 'Kaczmarek', 'Piotrowski', 'Piecyk', 'Brewer', 'Johnson',
'Smith', 'Thompson', 'Carlsson', 'Eriksson', 'Granat', 'Cologna', 'Masny', 'Mikulic', 'Pesic', 'Vujovic', 'Kim', 'Gim', 'Lee', 'Yi', 'Rhee',
'Park', 'Pak', 'Choi', 'Jung', 'Jeong', 'Chung', 'Cheong', 'Asakura', 'Harada', 'Carvajal', 'Martinez', 'Torres', 'Daquin', 'Benes',
'Bystron', 'Czech', 'Masny', 'Pospichal', 'Sudek', 'Tichy', 'Johansen', 'Larsen', 'Rasmussen', 'Soerensen', 'Winckler', 'Borisavljevic',
'Blagojevic', 'Dragosavljevic', 'Jovanovic', 'Milosevic', 'Spasojevic', 'Berezowski', 'Bojczuk', 'Czubaj', 'Danysz', 'Dziuba', 'Feszczuk',
'Franko', 'Klyczko', 'Kurylowicz', 'Einarsson', 'Jonsson', 'Vilhjalmsson', 'Hjalmarsson', 'Arnarson', 'Bjarnarson', 'Hallsson', 'Bryndisarson',
'Asgrimsson', 'Angerer', 'Bieler', 'Braun', 'Bursche', 'Ebeling', 'Engel', 'Heckman', 'Heckmann', 'Jauch', 'Kastner', 'Klimke', 'Krause',
'Kuegelgen', 'Langer', 'Luft', 'Neumann', 'Neumayer', 'Nitsche', 'Pringsheim', 'Radke', 'Remus', 'Schoch', 'Schroedinger', 'Schymura',
'Szulc', 'Wanke', 'Winckler', 'Witt', 'Zimmermann');
narodowosc := TABSTR('Niemcy', 'Polska', 'Dania', 'Czechy', 'Francja', 'Szwajcaria', 'Liechtenstein', 'Slowacja', 'Slowenia', 'Francja',
'Austria', 'Brazylia', 'Belgia', 'Japonia', 'Islandia', 'Stany Zjednoczone', 'Holandia', 'Turcja', 'Szwecja', 'Ukraina', 'Hiszpania',
'Chile', 'Korea Poludniowa', 'Chorwacja', 'Serbia', 'Argentyna', 'Wybrzeze Kosci Sloniowej', 'Gabon', 'Jamajka');
pozycja := TABSTR('Napastnik', 'Pomocnik', 'Obronca', 'Bramkarz');
select count(*) into cond from zawodnik;
cond := cond + 1;

        FOR i IN qname1..qname2 LOOP
                rok := i;
		los_id_zawodnika := cond;
           	cond := cond + 1;
                gole := dbms_random.value(1,50);
        	los_pozycja := pozycja(dbms_random.value(1,pozycja.count));
            	var1 := 16+(2017-rok);
            	var2 := 40+(2017-rok);
 	        los_wiek := dbms_random.value(var1,var2);
        	los_imie := imie(dbms_random.value(1,imie.count));
     		los_nazwisko := nazwisko(dbms_random.value(1,nazwisko.count));
                los_narodowosc := narodowosc(dbms_random.value(1,narodowosc.count));
                INSERT INTO zawodnik(id_zawodnika, imie, nazwisko, pozycja, wiek, narodowosc, gole, asysty, zolte_kartki, czerwone_kartki) 
                VALUES (los_id_zawodnika, los_imie, los_nazwisko, los_pozycja, los_wiek, los_narodowosc, 0, 0, 0, 0);
                INSERT INTO historyczny_krol_strzelcow VALUES (rok, los_id_zawodnika, gole);
        END LOOP;

	FOR i IN qname3..qname4 LOOP
		rok := i;
        	los_id_zawodnika := dbms_random.value(1,630);
            	var1 := (2017 - rok) + 16;
                select z.wiek into var2 from zawodnik z where z.id_zawodnika = los_id_zawodnika;
		WHILE (var2 < var1) LOOP
                    los_id_zawodnika := dbms_random.value(1,630);
                    select z.wiek into var2 from zawodnik z where z.id_zawodnika = los_id_zawodnika;
                END LOOP;
		gole := dbms_random.value(1,50);
		INSERT INTO historyczny_krol_strzelcow VALUES (rok, los_id_zawodnika, gole);
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkich historycznych krolow strzelcow.');

END GENERUJ_HIST_KROL_STRZELCOW;





create or replace PROCEDURE GENERUJ_ZAWODNIK IS 
TYPE TABSTR IS TABLE OF VARCHAR2(250);
    id_zawodnika NUMBER(4);
    imie TABSTR;
    los_imie VARCHAR2(20);
    los_nazwisko VARCHAR(20);
    los_narodowosc VARCHAR(30);
    nazwisko TABSTR;
    id_druzyny NUMBER(2);
    pozycja VARCHAR2(10);
    numer_koszulki NUMBER(2);
    wiek NUMBER(2);
    narodowosc TABSTR;
    qname NUMBER(4);
    qname2 NUMBER(2);
BEGIN
imie := TABSTR ('Piotr', 'Krzysztof', 'Andrzej', 'Tomasz', 'Jan', 'Pawel', 'Michal', 'Marcin', 'Stanislaw', 'Marek', 'Maximilian', 
'Alexander', 'Paul', 'Leon', 'Ben', 'Lukas', 'Lucas', 'Luca', 'Luka', 'Louis', 'Luis', 'Elias', 'Jonas', 'Enzo', 'Mathis', 'Ethan', 
'Hugo', 'Matheo', 'Nathan', 'Theo', 'Noah', 'Matteo', 'Thomas', 'Jakub', 'Tomas', 'David', 'Adam', 'Matej', 'Ondrej', 'Cristobal',
'Vojtech', 'Filip', 'William', 'Noah', 'Lucas', 'Oscar', 'Victor', 'Malthe', 'Emil', 'Frederik', 'Oliver', 'Magnus', 'Tobias',
'Simon', 'Sebastian', 'Felix', 'Julian', 'Pedro', 'Rodrigo', 'Alex', 'Fabio', 'Miguel', 'Estevan', 'Julio', 'Nathan', 'Arthur',
'Mohamed', 'Milan', 'Mathis', 'So', 'Minato', 'Ichika', 'Itsuki', 'Tatsuki', 'Ren', 'Hinata', 'Haruta', 'Asahi', 'Haruki', 'Tomoharu',
'Sota', 'Yuma', 'Arata', 'Ryo', 'Yuto', 'Haruto', 'Haruhito', 'Kanata', 'Hayato', 'Taichi', 'Aron', 'Viktor', 'Jon', 'Arnar', 'Daniel',
'Guomundur', 'Kristjan', 'Kristian', 'Christian', 'Gunnar', 'Dagur', 'Sigurour', 'Liam', 'Mason', 'Jacob', 'Michael', 'James',
'Daan', 'Sem', 'Tim', 'Jayden', 'Thomas', 'Thijs', 'Jesse', 'Ruben', 'Lars', 'Yusuf', 'Arda', 'Mehmet', 'Mustafa', 'Ahmet', 'Emirhan',
'Enes', 'Furkan', 'Muhammed', 'Ali', 'Nazar', 'Danylo', 'Maksym', 'Wladyslaw', 'Mykyta', 'Artem', 'Kyrylo', 'Jehor', 'Illja', 'Andrij',
'Martin', 'Pablo', 'Alejandro', 'Alvaro', 'Adrian', 'Mateo', 'Benjamin', 'Vicente', 'Matias', 'Martin', 'Joaquin', 'Diego',	'Nicolas',
'Jose');
nazwisko := TABSTR('Mueller', 'Schmidt', 'Schneider', 'Fischer', 'Meyer', 'Weber', 'Schulz', 'Wagner', 'Becker', 'Hoffmann', 'Nowak',
'Kowalski', 'Wisniewski', 'Wojcik', 'Kowalczyk', 'Kaminski', 'Lewandowski', 'Zielinski', 'Szymanski', 'Wozniak', 'Dabrowski',
'Kozlowski', 'Jankowski', 'Mazur', 'Kwiatkowski', 'Wojciechowski', 'Krawczyk', 'Kaczmarek', 'Piotrowski', 'Piecyk', 'Brewer', 'Johnson',
'Smith', 'Thompson', 'Carlsson', 'Eriksson', 'Granat', 'Cologna', 'Masny', 'Mikulic', 'Pesic', 'Vujovic', 'Kim', 'Gim', 'Lee', 'Yi', 'Rhee',
'Park', 'Pak', 'Choi', 'Jung', 'Jeong', 'Chung', 'Cheong', 'Asakura', 'Harada', 'Carvajal', 'Martinez', 'Torres', 'Daquin', 'Benes',
'Bystron', 'Czech', 'Masny', 'Pospichal', 'Sudek', 'Tichy', 'Johansen', 'Larsen', 'Rasmussen', 'Soerensen', 'Winckler', 'Borisavljevic',
'Blagojevic', 'Dragosavljevic', 'Jovanovic', 'Milosevic', 'Spasojevic', 'Berezowski', 'Bojczuk', 'Czubaj', 'Danysz', 'Dziuba', 'Feszczuk',
'Franko', 'Klyczko', 'Kurylowicz', 'Einarsson', 'Jonsson', 'Vilhjalmsson', 'Hjalmarsson', 'Arnarson', 'Bjarnarson', 'Hallsson', 'Bryndisarson',
'Asgrimsson', 'Angerer', 'Bieler', 'Braun', 'Bursche', 'Ebeling', 'Engel', 'Heckman', 'Heckmann', 'Jauch', 'Kastner', 'Klimke', 'Krause',
'Kuegelgen', 'Langer', 'Luft', 'Neumann', 'Neumayer', 'Nitsche', 'Pringsheim', 'Radke', 'Remus', 'Schoch', 'Schroedinger', 'Schymura',
'Szulc', 'Wanke', 'Winckler', 'Witt', 'Zimmermann');
narodowosc := TABSTR('Niemcy', 'Polska', 'Dania', 'Czechy', 'Francja', 'Szwajcaria', 'Liechtenstein', 'Slowacja', 'Slowenia', 'Francja',
'Austria', 'Brazylia', 'Belgia', 'Japonia', 'Islandia', 'Stany Zjednoczone', 'Holandia', 'Turcja', 'Szwecja', 'Ukraina', 'Hiszpania',
'Chile', 'Korea Poludniowa', 'Chorwacja', 'Serbia', 'Argentyna', 'Wybrzeze Kosci Sloniowej', 'Gabon', 'Jamajka');
qname := 1;
qname2 := 1;

	FOR i IN 1..18 LOOP
        id_druzyny := i;
        FOR j IN 1..5 LOOP
            id_zawodnika := qname;
            qname := qname + 1;
            id_druzyny := i;
            pozycja := 'Bramkarz';
            numer_koszulki := qname2;
            qname2 := qname2 + 1;
            wiek := dbms_random.value(16,40);
            los_imie := imie(dbms_random.value(1,imie.count));
            los_nazwisko := nazwisko(dbms_random.value(1,nazwisko.count));
            los_narodowosc := narodowosc(dbms_random.value(1,narodowosc.count));
            INSERT INTO zawodnik VALUES (id_zawodnika, los_imie, los_nazwisko,
            id_druzyny, pozycja, numer_koszulki, wiek, los_narodowosc, 0, 0, 0, 0);
        END LOOP;
        FOR j IN 1..10 LOOP
            id_zawodnika := qname;
            qname := qname + 1;
            id_druzyny := i;
            pozycja := 'Obronca';
            numer_koszulki := qname2;
            qname2 := qname2 + 1;
            wiek := dbms_random.value(16,40);
            los_imie := imie(dbms_random.value(1,imie.count));
            los_nazwisko := nazwisko(dbms_random.value(1,nazwisko.count));
            los_narodowosc := narodowosc(dbms_random.value(1,narodowosc.count));
            INSERT INTO zawodnik VALUES (id_zawodnika, los_imie, los_nazwisko,
            id_druzyny, pozycja, numer_koszulki, wiek, los_narodowosc, 0, 0, 0, 0);
        END LOOP;
        FOR j IN 1..15 LOOP
            id_zawodnika := qname;
            qname := qname + 1;
            id_druzyny := i;
            pozycja := 'Pomocnik';
            numer_koszulki := qname2;
            qname2 := qname2 + 1;
            wiek := dbms_random.value(16,40);
            los_imie := imie(dbms_random.value(1,imie.count));
            los_nazwisko := nazwisko(dbms_random.value(1,nazwisko.count));
            los_narodowosc := narodowosc(dbms_random.value(1,narodowosc.count));
            INSERT INTO zawodnik VALUES (id_zawodnika, los_imie, los_nazwisko,
            id_druzyny, pozycja, numer_koszulki, wiek, los_narodowosc, 0, 0, 0, 0);
        END LOOP;
        FOR j IN 1..5 LOOP
            id_zawodnika := qname;
            qname := qname + 1;
            id_druzyny := i;
            pozycja := 'Napastnik';
            numer_koszulki := qname2;
            qname2 := qname2 + 1;
            wiek := dbms_random.value(16,40);
            los_imie := imie(dbms_random.value(1,imie.count));
            los_nazwisko := nazwisko(dbms_random.value(1,nazwisko.count));
            los_narodowosc := narodowosc(dbms_random.value(1,narodowosc.count));
            INSERT INTO zawodnik VALUES (id_zawodnika, los_imie, los_nazwisko,
            id_druzyny, pozycja, numer_koszulki, wiek, los_narodowosc, 0, 0, 0, 0);
        END LOOP;
        qname2 := 1;
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkich zawodnikow.');

END GENERUJ_ZAWODNIK;




create or replace PROCEDURE GENERUJ_MECZ IS 
TYPE TABSTR IS TABLE OF VARCHAR2(250);
    gen_nr_meczu NUMBER(3);
    gen_data_rozegrania DATE;
    gen_id_gospodarza NUMBER(2);
    gen_id_goscia NUMBER(2);
    gen_minuta NUMBER(2);
    gen_typ_zdarzenia TABSTR;
    los_typ_zdarzenia VARCHAR2(20);
    gen_nr_koszulki NUMBER(2);
    gen_id_zawodnika NUMBER(3);
    gen_id_druzyny NUMBER(2);
    qname1 NUMBER(3);
    qname2 NUMBER(2);
    cond NUMBER(1);
    bramki_gospodarz NUMBER(1);
    bramki_gosc NUMBER(1);
BEGIN
gen_typ_zdarzenia := TABSTR ('ZOLTA KARTKA', 'CZERWONA KARTKA');
qname1 := 100;

	FOR i IN 1..qname1 LOOP
	    bramki_gospodarz := dbms_random.value(0,9);
        bramki_gosc := dbms_random.value(0,9);
        gen_nr_meczu := i;
        gen_data_rozegrania := TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2017-08-18','J'), TO_CHAR(DATE '2018-05-12', 'J'))), 'J');
	    gen_id_gospodarza := dbms_random.value(1,18);
        gen_id_goscia := dbms_random.value(1,18);
        select count(*) into cond from rozegrala where rozegrala.id_gospodarza = gen_id_gospodarza AND rozegrala.id_goscia = gen_id_goscia;
        WHILE (cond = 1) OR (gen_id_gospodarza = gen_id_goscia) LOOP
            gen_id_gospodarza := dbms_random.value(1,18);
            gen_id_goscia := dbms_random.value(1,18);
            select count(*) into cond from rozegrala where rozegrala.id_gospodarza = gen_id_gospodarza AND rozegrala.id_goscia = gen_id_goscia;
        END LOOP;
        WstawMecz(gen_data_rozegrania, bramki_gospodarz, bramki_gosc);
        WstawRozegrala(gen_id_gospodarza, gen_id_goscia);
        FOR j IN 1..bramki_gospodarz LOOP
            gen_minuta := dbms_random.value(1,90);
            los_typ_zdarzenia := 'GOL';
            gen_id_druzyny := gen_id_gospodarza;
            gen_nr_koszulki := dbms_random.value(1,35);
            SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
            select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            WHILE (cond = 1) LOOP
                gen_nr_koszulki := dbms_random.value(1,35);
                SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
                select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            END LOOP;
            WstawZdarzenie(gen_nr_meczu, gen_minuta, los_typ_zdarzenia, gen_id_zawodnika);
            gen_nr_koszulki := dbms_random.value(1,35);
            SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
            los_typ_zdarzenia := 'ASYSTA';
            select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            WHILE (cond = 1) LOOP
                gen_nr_koszulki := dbms_random.value(1,35);
                SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
                select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            END LOOP;
            WstawZdarzenie(gen_nr_meczu, gen_minuta, los_typ_zdarzenia, gen_id_zawodnika);
        END LOOP;
        FOR j IN 1..bramki_gosc LOOP
            gen_minuta := dbms_random.value(1,90);
            los_typ_zdarzenia := 'GOL';
            gen_id_druzyny := gen_id_goscia;
            gen_nr_koszulki := dbms_random.value(1,35);
            SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
            select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            WHILE (cond = 1) LOOP
                gen_nr_koszulki := dbms_random.value(1,35);
                SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
                select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            END LOOP;
            WstawZdarzenie(gen_nr_meczu, gen_minuta, los_typ_zdarzenia, gen_id_zawodnika);
            gen_nr_koszulki := dbms_random.value(1,35);
            SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
            los_typ_zdarzenia := 'ASYSTA';
            select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            WHILE (cond = 1) LOOP
                gen_nr_koszulki := dbms_random.value(1,35);
                SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
                select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            END LOOP;
            WstawZdarzenie(gen_nr_meczu, gen_minuta, los_typ_zdarzenia, gen_id_zawodnika);
        END LOOP;
        FOR j IN 1..5 LOOP
            gen_minuta := dbms_random.value(1,90);
            los_typ_zdarzenia := gen_typ_zdarzenia(dbms_random.value(1,2));
            qname2 := dbms_random.value(1,99);
            IF MOD(qname2, 2) = 0 THEN
                gen_id_druzyny := gen_id_gospodarza;
            ELSE
                gen_id_druzyny := gen_id_goscia;
            END IF;
            gen_nr_koszulki := dbms_random.value(1,35);
            SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
            select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            WHILE (cond = 1) LOOP
                gen_nr_koszulki := dbms_random.value(1,35);
                SELECT zawodnik.id_zawodnika into gen_id_zawodnika from zawodnik where zawodnik.id_druzyny = gen_id_druzyny AND zawodnik.numer_koszulki = gen_nr_koszulki;
                select count(*) into cond from zdarzenie z where z.nr_meczu = gen_nr_meczu and z.minuta = gen_minuta and typ_zdarzenia = los_typ_zdarzenia and id_zawodnika = gen_id_zawodnika;
            END LOOP;
            WstawZdarzenie(gen_nr_meczu, gen_minuta, los_typ_zdarzenia, gen_id_zawodnika);
        END LOOP;
	END LOOP;
	DBMS_OUTPUT.put_line('Dodano wszystkie mecze.');
END GENERUJ_MECZ;
