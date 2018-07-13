CREATE OR REPLACE TRIGGER GOL
AFTER INSERT ON ZDARZENIE
FOR EACH ROW
WHEN (new.typ_zdarzenia = 'GOL')
BEGIN
    UPDATE zawodnik z set z.gole = z.gole + 1 WHERE z.id_zawodnika = :new.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER USUN_ZDARZENIE_GOL
BEFORE DELETE ON ZDARZENIE
FOR EACH ROW
WHEN (old.typ_zdarzenia = 'GOL')
BEGIN
    UPDATE zawodnik z set z.gole = z.gole - 1 WHERE z.id_zawodnika = :old.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER ASYSTA
AFTER INSERT ON ZDARZENIE
FOR EACH ROW
WHEN (new.typ_zdarzenia = 'ASYSTA')
BEGIN
    UPDATE zawodnik z set z.asysty = z.asysty + 1 WHERE z.id_zawodnika = :new.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER USUN_ZDARZENIE_ASYSTA
BEFORE DELETE ON ZDARZENIE
FOR EACH ROW
WHEN (old.typ_zdarzenia = 'ASYSTA')
BEGIN
    UPDATE zawodnik z set z.asysty = z.asysty - 1 WHERE z.id_zawodnika = :old.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER ZOLTA_KARTKA
AFTER INSERT ON ZDARZENIE
FOR EACH ROW
WHEN (new.typ_zdarzenia = 'ZOLTA KARTKA')
BEGIN
  UPDATE zawodnik z set z.zolte_kartki = z.zolte_kartki + 1 WHERE z.id_zawodnika = :new.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER USUN_ZDARZENIE_ZOLTA_KARTKA
BEFORE DELETE ON ZDARZENIE
FOR EACH ROW
WHEN (old.typ_zdarzenia = 'ZOLTA KARTKA')
BEGIN
    UPDATE zawodnik z set z.zolte_kartki = z.zolte_kartki - 1 WHERE z.id_zawodnika = :old.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER CZERWONA_KARTKA
AFTER INSERT ON ZDARZENIE
FOR EACH ROW
WHEN (new.typ_zdarzenia = 'CZERWONA KARTKA')
BEGIN
  UPDATE zawodnik z set z.czerwone_kartki = z.czerwone_kartki + 1 WHERE z.id_zawodnika = :new.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER USUN_ZDARZENIE_CZERWONA_KARTKA
BEFORE DELETE ON ZDARZENIE
FOR EACH ROW
WHEN (old.typ_zdarzenia = 'CZERWONA_KARTKA')
BEGIN
    UPDATE zawodnik z set z.czerwone_kartki = z.czerwone_kartki - 1 WHERE z.id_zawodnika = :old.id_zawodnika;
END;

CREATE OR REPLACE TRIGGER KONIEC_SEZONU
BEFORE INSERT ON MECZ
FOR EACH ROW
WHEN (new.nr_meczu = 307)
DECLARE
    zmienna1 druzyna.id_druzyny%TYPE;
    zmienna2 zawodnik.id_zawodnika%TYPE;
    zmienna3 zawodnik.gole%TYPE;
BEGIN
    select id_druzyny into zmienna1 from druzyna d where punkty = (select MAX(punkty) from druzyna);
    INSERT INTO historyczny_mistrz VALUES (mistrz_seq.nextval, zmienna1);
    select id_zawodnika into zmienna2 from zawodnik z where gole = (select MAX(gole) from zawodnik);
    select gole into zmienna3 from zawodnik z where gole = (select MAX(gole) from zawodnik);
    INSERT INTO historyczny_krol_strzelcow VALUES (krol_strzelcow_seq.nextval, zmienna2, zmienna3);
END;

create or replace TRIGGER PORZADKI
AFTER INSERT ON HISTORYCZNY_KROL_STRZELCOW
FOR EACH ROW
DECLARE
    d_data_rozegrania mecz.data_rozegrania%TYPE;
    d_gole_gospodarz mecz.gole_gospodarz%TYPE;
    d_gole_gosc mecz.gole_gosc%TYPE;
    zmienna int;
BEGIN
    select count(*) into zmienna from mecz;
    IF (zmienna = 307) THEN
      select data_rozegrania, gole_gospodarz, gole_gosc into d_data_rozegrania, d_gole_gospodarz, d_gole_gosc from mecz where nr_meczu = 307;
      UPDATE zawodnik set gole = 0, asysty = 0, zolte_kartki = 0, czerwone_kartki = 0;
      UPDATE druzyna set rozegrane_mecze = 0, bramki_strzelone = 0, bramki_stracone = 0, punkty = 0;
      DELETE FROM zdarzenie;
      DELETE FROM rozegrala;
      DELETE FROM mecz;
      WstawMecz(d_data_rozegrania, d_gole_gospodarz, d_gole_gosc);
    ELSE null;
    END IF;
END;

CREATE OR REPLACE TRIGGER MECZ
AFTER INSERT ON ROZEGRALA
FOR EACH ROW
DECLARE
d_gole_gospodarz mecz.gole_gospodarz%TYPE;
d_gole_gosc mecz.gole_gosc%TYPE;
BEGIN
    select gole_gospodarz, gole_gosc into d_gole_gospodarz, d_gole_gosc from mecz where nr_meczu = :new.nr_meczu;
    UPDATE druzyna d set d.rozegrane_mecze = d.rozegrane_mecze + 1 WHERE d.id_druzyny = :new.id_goscia;
    UPDATE druzyna d set d.rozegrane_mecze = d.rozegrane_mecze + 1 WHERE d.id_druzyny = :new.id_gospodarza;
    UPDATE druzyna d set d.bramki_strzelone = d.bramki_strzelone + d_gole_gospodarz WHERE d.id_druzyny = :new.id_gospodarza;
    UPDATE druzyna d set d.bramki_stracone = d.bramki_stracone + d_gole_gosc WHERE d.id_druzyny = :new.id_gospodarza;
    UPDATE druzyna d set d.bramki_strzelone = d.bramki_strzelone + d_gole_gosc WHERE d.id_druzyny = :new.id_goscia;
    UPDATE druzyna d set d.bramki_stracone = d.bramki_stracone + d_gole_gospodarz WHERE d.id_druzyny = :new.id_goscia;
    UPDATE druzyna d set d.punkty = CASE
      WHEN (d_gole_gospodarz > d_gole_gosc) THEN (d.punkty + 3)
      WHEN (d_gole_gospodarz = d_gole_gosc) THEN (d.punkty + 1)
      ELSE d.punkty
    END
    WHERE d.id_druzyny = :new.id_gospodarza;
    UPDATE druzyna d set d.punkty = CASE
      WHEN (d_gole_gospodarz < d_gole_gosc) THEN (d.punkty + 3)
      WHEN (d_gole_gospodarz = d_gole_gosc) THEN (d.punkty + 1)
      ELSE d.punkty
    END
    WHERE d.id_druzyny = :new.id_goscia;
END;

CREATE OR REPLACE TRIGGER USUN_MECZ
BEFORE DELETE ON ROZEGRALA
FOR EACH ROW
DECLARE
d_gole_gospodarz mecz.gole_gospodarz%TYPE;
d_gole_gosc mecz.gole_gosc%TYPE;
BEGIN
  select gole_gospodarz, gole_gosc into d_gole_gospodarz, d_gole_gosc from mecz where nr_meczu = :old.nr_meczu;
  UPDATE druzyna d set d.rozegrane_mecze = d.rozegrane_mecze - 1 WHERE d.id_druzyny = :old.id_goscia;
  UPDATE druzyna d set d.rozegrane_mecze = d.rozegrane_mecze - 1 WHERE d.id_druzyny = :old.id_gospodarza;
  UPDATE druzyna d set d.bramki_strzelone = d.bramki_strzelone - d_gole_gospodarz WHERE d.id_druzyny = :old.id_gospodarza;
  UPDATE druzyna d set d.bramki_stracone = d.bramki_stracone - d_gole_gosc WHERE d.id_druzyny = :old.id_gospodarza;
  UPDATE druzyna d set d.bramki_strzelone = d.bramki_strzelone - d_gole_gosc WHERE d.id_druzyny = :old.id_goscia;
  UPDATE druzyna d set d.bramki_stracone = d.bramki_stracone - d_gole_gospodarz WHERE d.id_druzyny = :old.id_goscia;
  UPDATE druzyna d set d.punkty = CASE
    WHEN (d_gole_gospodarz > d_gole_gosc) THEN (d.punkty - 3)
    WHEN (d_gole_gospodarz = d_gole_gosc) THEN (d.punkty - 1)
    ELSE d.punkty
  END
  WHERE d.id_druzyny = :old.id_gospodarza;
  UPDATE druzyna d set d.punkty = CASE
    WHEN (d_gole_gospodarz < d_gole_gosc) THEN (d.punkty - 3)
    WHEN (d_gole_gospodarz = d_gole_gosc) THEN (d.punkty - 1)
    ELSE d.punkty
  END
  WHERE d.id_druzyny = :old.id_goscia;
END;
