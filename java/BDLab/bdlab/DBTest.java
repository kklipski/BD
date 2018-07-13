package bdlab;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class DBTest {
	public static class Zawodnik {
		private int id_zawodnika;

		private String imie;

		private String nazwisko;

		private int id_druzyny;

		private String pozycja;

		private int numer_koszulki;

		private int wiek;
		
		private String narodowosc;
		
		private int gole;
		
		private int asysty;
		
		private int zolte_kartki;

		private int czerwone_kartki;

		public int getId_zawodnika() {
			return id_zawodnika;
		}

		public void setId_zawodnika(int id_zawodnika) {
			this.id_zawodnika = id_zawodnika;
		}

		public String getImie() {
			return imie;
		}

		public void setImie(String imie) {
			this.imie = imie;
		}

		public String getNazwisko() {
			return nazwisko;
		}

		public void setNazwisko(String nazwisko) {
			this.nazwisko = nazwisko;
		}

		public int getId_druzyny() {
			return id_druzyny;
		}

		public void setId_druzyny(int id_druzyny) {
			this.id_druzyny = id_druzyny;
		}

		public String getPozycja() {
			return pozycja;
		}

		public void setPozycja(String pozycja) {
			this.pozycja = pozycja;
		}

		public int getNumer_koszulki() {
			return numer_koszulki;
		}

		public void setNumer_koszulki(int numer_koszulki) {
			this.numer_koszulki = numer_koszulki;
		}

		public int getWiek() {
			return wiek;
		}

		public void setWiek(int wiek) {
			this.wiek = wiek;
		}

		public String getNarodowosc() {
			return narodowosc;
		}

		public void setNarodowosc(String narodowosc) {
			this.narodowosc = narodowosc;
		}

		public int getGole() {
			return gole;
		}

		public void setGole(int gole) {
			this.gole = gole;
		}

		public int getAsysty() {
			return asysty;
		}

		public void setAsysty(int asysty) {
			this.asysty = asysty;
		}

		public int getZolte_kartki() {
			return zolte_kartki;
		}

		public void setZolte_kartki(int zolte_kartki) {
			this.zolte_kartki = zolte_kartki;
		}

		public int getCzerwone_kartki() {
			return czerwone_kartki;
		}

		public void setCzerwone_kartki(int czerwone_kartki) {
			this.czerwone_kartki = czerwone_kartki;
		}

		public Zawodnik(int id_zawodnika, String imie, String nazwisko, int id_druzyny, String pozycja, int numer_koszulki, int wiek, String narodowosc, int gole, int asysty, int zolte_kartki, int czerwone_kartki) {
			super();
			this.id_zawodnika = id_zawodnika;
			this.imie = imie;
			this.nazwisko = nazwisko;
			this.id_druzyny = id_druzyny;
			this.pozycja = pozycja;
			this.numer_koszulki = numer_koszulki;
			this.wiek = wiek;
			this.narodowosc = narodowosc;
			this.gole = gole;
			this.asysty = asysty;
			this.zolte_kartki = zolte_kartki;
			this.czerwone_kartki = czerwone_kartki;
		}

		public Zawodnik() {
		}
		
		public String toString() {
			return String.format("Zawodnik(%d, %s, %s, %d, %s, %d, %d, %s, %d, %d, %d, %d)", id_zawodnika, imie, nazwisko, id_druzyny, pozycja, numer_koszulki, wiek, narodowosc, gole, asysty, zolte_kartki, czerwone_kartki);
		}
	}

	public final static ResultSetToBean<Zawodnik> zawodnikConverter = new ResultSetToBean<Zawodnik>() {
		public Zawodnik convert(ResultSet rs) throws Exception {
			Zawodnik e = new Zawodnik();
			e.setId_zawodnika(rs.getInt("ID_ZAWODNIKA"));
			e.setImie(rs.getString("IMIE"));
			e.setNazwisko(rs.getString("NAZWISKO"));
			e.setId_druzyny(rs.getInt("ID_DRUZYNY"));
			e.setPozycja(rs.getString("POZYCJA"));
			e.setNumer_koszulki(rs.getInt("NUMER_KOSZULKI"));
			e.setWiek(rs.getInt("WIEK"));
			e.setNarodowosc(rs.getString("NARODOWOSC"));
			e.setGole(rs.getInt("GOLE"));
			e.setAsysty(rs.getInt("ASYSTY"));
			e.setZolte_kartki(rs.getInt("ZOLTE_KARTKI"));
			e.setCzerwone_kartki(rs.getInt("CZERWONE_KARTKI"));
			return e;
		}
	};

	public static void main(String[] args) {
		
		List<Zawodnik> zawodnik1 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setInt(1, 1);
					}
				}, zawodnikConverter,
						"select id_zawodnika, imie, nazwisko, id_druzyny, pozycja, numer_koszulki, wiek, narodowosc, gole, asysty, zolte_kartki, czerwone_kartki from zawodnik where id_zawodnika = ?");

		for (Zawodnik e: zawodnik1) {
			System.out.println(e);
		}
		
		System.out.println("");

		boolean result = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setInt(1, 10);
				ps.setInt(2, 1);
				return ps.executeUpdate() > 0;
			}
		}, "update zawodnik set gole = ? where id_zawodnika = ?");

		System.out.println(result ? "Udalo sie" : "Nie udalo sie");

		List<Zawodnik> zawodnik2 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setInt(1, 1);
					}
				}, zawodnikConverter,
						"select id_zawodnika, imie, nazwisko, id_druzyny, pozycja, numer_koszulki, wiek, narodowosc, gole, asysty, zolte_kartki, czerwone_kartki from zawodnik where id_zawodnika = ?");

		for (Zawodnik e: zawodnik2) {
			System.out.println(e);
		}
		
		System.out.println("");
	
		result = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setInt(1, 631);
				ps.setString(2, "Kamil");
				ps.setString(3, "Lipski");
				ps.setInt(4, 1);
				ps.setString(5, "Pomocnik");
				ps.setInt(6, 36);
				ps.setInt(7, 21);
				ps.setString(8, "Polska");
				ps.setInt(9, 0);
				ps.setInt(10, 0);
				ps.setInt(11, 0);
				ps.setInt(12, 0);
				return ps.executeUpdate() > 0;
			}
		}, "insert into zawodnik values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

		System.out.println(result ? "Udalo sie" : "Nie udalo sie");	

		List<Zawodnik> zawodnik3 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setString(1, "Kamil");
						ps.setString(2, "Lipski");
					}
				}, zawodnikConverter,
						"select * from zawodnik where imie = ? and nazwisko = ?");

		for (Zawodnik e: zawodnik3) {
			System.out.println(e);
		}
		
		System.out.println("");

		List<Zawodnik> zawodnik4 = DBManager
				.run(new Query() {
						 public void prepareQuery(PreparedStatement ps)
								 throws Exception {
						 	ps.setString(1, "Polska");
						 	ps.setInt(2, 0);
						 	ps.setInt(3, 0);
						 	ps.setInt(4, 0);
						 	ps.setInt(5, 0);
						 }
					 }, zawodnikConverter,
						"select * from zawodnik where narodowosc = ? and gole = ? and asysty = ? and zolte_kartki = ? and czerwone_kartki = ?");

		for (Zawodnik e: zawodnik4) {
			System.out.println(e);
		}
		
		System.out.println("");
	
		result = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setString(1, "Polska");
				ps.setInt(2, 0);
				ps.setInt(3, 0);
				ps.setInt(4, 0);
				ps.setInt(5, 0);
				return ps.executeUpdate() > 0;
			}
		}, "delete from zawodnik where narodowosc = ? and gole = ? and asysty = ? and zolte_kartki = ? and czerwone_kartki = ?");

		System.out.println(result ? "Udalo sie" : "Nie udalo sie");
	
		List<Zawodnik> zawodnik5 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setInt(1, 0);
						ps.setInt(2, 0);
						ps.setInt(3, 0);
						ps.setInt(4, 0);
					}
				}, zawodnikConverter,
						"select * from zawodnik where gole = ? and asysty = ? and zolte_kartki = ? and czerwone_kartki = ?");

		for (Zawodnik e: zawodnik5) {
			System.out.println(e);
		}
		
		System.out.println("");
		
		System.out.println("Zakonczono wypisywanie");
	}
}