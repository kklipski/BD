--wazne zalozenie! wynik (gole_gospodarz, gole_gosc) musi byc podany przy wprowadzaniu nowego rekordu do relacji mecz! o integralnosc wprowadzonych danych musi zadbac uzytkownik (zgodnosc danych w relacjach mecz i zdarzenie)!

--nalozone dodatkowe ograniczenie: w meczu co najwyzej 3 czerwone kartki!

--zalozenie: wprowadzone rekordy do relacji rozegrala, mecz, zdarzenie nie sa juz pozniej modyfikowane (zaklada sie poprawnosc wprowadzonych danych; ewentualne zmiany nie beda uwzglenione; istnieje natomiast mozliwosc usuwania rekordow z tych relacji, co mozna wykorzystac, aby wprowadzic "modyfikacje" okrezna droga)

--zalozenie: zaklada sie, ze uzytkownik przy wprowadzaniu rekordu do relacji mecz poda odpowiednia date rozegrania (zgodna z datami rozegrania innych meczow oraz mieszczaca sie w ramach czasowych trwajacego sezonu)

--zalozenie: do relacji historyczny_mistrz i historyczny_krol_strzelcow rekordy sa wstawiane automatycznie na koniec sezonu; zakladam, ze uzytkownik nie bedzie tu niczego mieszal

create or replace PROCEDURE WstawZdarzenie
(p_nr_meczu IN NUMBER, p_minuta IN NUMBER, p_typ_zdarzenia IN VARCHAR2, p_id_zawodnika IN NUMBER) IS
  zla_nazwa EXCEPTION;
  brak_zgodnosci EXCEPTION;
  rekord_istnieje EXCEPTION;
  zmienna1 int;
  zmienna2 int;
  zmienna3 int;
BEGIN
  select count(*) into zmienna1 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.minuta = p_minuta and typ_zdarzenia = p_typ_zdarzenia and id_zawodnika = p_id_zawodnika;
  IF (zmienna1 = 1) THEN RAISE rekord_istnieje;
  END IF;
  IF (p_typ_zdarzenia = 'GOL') THEN
    select count(*) into zmienna1 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'CZERWONA KARTKA' and z.minuta < p_minuta;
    IF(p_minuta >= 0 and p_minuta <= 90 and zmienna1 = 0) THEN
      INSERT INTO zdarzenie VALUES (p_nr_meczu, p_minuta, p_typ_zdarzenia, p_id_zawodnika);
    ELSE RAISE brak_zgodnosci;
    END IF;
  ELSIF (p_typ_zdarzenia = 'ASYSTA') THEN
    select count(*) into zmienna1 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'CZERWONA KARTKA' and z.minuta < p_minuta;
    IF (p_minuta >= 0 and p_minuta <= 90 and zmienna1 = 0) THEN
      INSERT INTO zdarzenie VALUES (p_nr_meczu, p_minuta, p_typ_zdarzenia, p_id_zawodnika);
    ELSE RAISE brak_zgodnosci;
    END IF;
  ELSIF (p_typ_zdarzenia = 'ZOLTA KARTKA') THEN
    select count(*) into zmienna1 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'ZOLTA KARTKA';
    select count(*) into zmienna2 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'CZERWONA KARTKA' and z.minuta < p_minuta;
    IF (p_minuta >= 0 and p_minuta <= 90 and zmienna1 <= 1 and zmienna2 = 0) THEN
      INSERT INTO zdarzenie VALUES (p_nr_meczu, p_minuta, p_typ_zdarzenia, p_id_zawodnika);
      select count(*) into zmienna1 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'ZOLTA KARTKA';
      select count(*) into zmienna2 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'CZERWONA KARTKA';
      IF (zmienna1 = 2 and zmienna2 = 0) THEN
    	INSERT INTO zdarzenie VALUES (p_nr_meczu, p_minuta, 'CZERWONA KARTKA', p_id_zawodnika);
      END IF;
    ELSE RAISE brak_zgodnosci;
    END IF;
  ELSIF (p_typ_zdarzenia = 'CZERWONA KARTKA') THEN
    select count(*) into zmienna1 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.typ_zdarzenia = 'CZERWONA KARTKA';
    select count(*) into zmienna2 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.typ_zdarzenia = 'CZERWONA KARTKA';
    select count(*) into zmienna3 from zdarzenie z where z.nr_meczu = p_nr_meczu and z.id_zawodnika = p_id_zawodnika and z.minuta > p_minuta;
    IF (p_minuta >= 0 and p_minuta <= 90 and zmienna1 <= 2 and zmienna2 = 0 and zmienna3 = 0) THEN
      INSERT INTO zdarzenie VALUES (p_nr_meczu, p_minuta, p_typ_zdarzenia, p_id_zawodnika);
    ELSE RAISE brak_zgodnosci;
    END IF;
  ELSE RAISE zla_nazwa;
END IF;
EXCEPTION
  WHEN zla_nazwa THEN dbms_output.put_line('Zly typ zdarzenia! Dozwolone typy zdarzen: GOL, ASYSTA, ZOLTA KARTKA, CZERWONA KARTKA.');
  WHEN brak_zgodnosci THEN NULL; /* dbms_output.put_line('Dane niezgodne z danymi w innych tabelach lub niezgodne z zalozeniami projektowymi!'); */
  WHEN rekord_istnieje THEN dbms_output.put_line('Takie zdarzenie juz istnieje!');
END WstawZdarzenie;

CREATE OR REPLACE PROCEDURE WstawMecz
(p_data_rozegrania IN DATE, p_gole_gospodarz IN NUMBER, p_gole_gosc IN NUMBER) IS
  d_nr_meczu mecz.nr_meczu%TYPE;
  zmienna int;
BEGIN
  select count(*) into zmienna from mecz;
  IF (zmienna = 0) THEN d_nr_meczu := 1;
  ELSE 
  select MAX(nr_meczu) into d_nr_meczu from mecz;
  d_nr_meczu := d_nr_meczu + 1;
  END IF;
  INSERT INTO mecz VALUES (d_nr_meczu, p_data_rozegrania, p_gole_gospodarz, p_gole_gosc);
END;

CREATE OR REPLACE PROCEDURE WstawRozegrala
(p_id_gospodarza IN NUMBER, p_id_goscia IN NUMBER) IS
zle_druzyny EXCEPTION;
d_nr_meczu rozegrala.nr_meczu%TYPE;
zmienna int;
BEGIN
  select count(*) into zmienna from rozegrala where id_gospodarza = p_id_gospodarza AND id_goscia = p_id_goscia;
  IF (zmienna = 1 OR p_id_gospodarza = p_id_goscia) THEN
    RAISE zle_druzyny;
  ELSE
    select count(*) into zmienna from rozegrala;
    IF (zmienna = 0) THEN d_nr_meczu := 1;
    ELSE
    select MAX(nr_meczu) into d_nr_meczu from rozegrala;
    d_nr_meczu := d_nr_meczu + 1;
    END IF;
    INSERT INTO rozegrala VALUES (d_nr_meczu, p_id_gospodarza, p_id_goscia);
  END IF;
EXCEPTION
  WHEN zle_druzyny THEN 
  dbms_output.put_line('Podano zle druzyny!');
END;
