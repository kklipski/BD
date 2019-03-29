# BD: projekt

### Treść zadania
Należy stworzyć bazę ligi piłkarskiej.

### Pliki
W katalogu [baza-danych](baza-danych) znajdują się:
- logiczny i relacyjny model bazy danych - katalog [model](baza-danych/model),
- skrypty służące do utworzenia tabel ([tabele.sql](baza-danych/tabele.sql)), triggerów ([triggery.sql](baza-danych/triggery.sql)) oraz procedur ([procedury.sql](baza-danych/procedury.sql)),
- skypt do utworzenia generatorów, które wypełnią utworzoną bazę danych przykładowymi danymi - [generatory.sql](baza-danych/generatory.sql),
- przykładowe zapytania do stworzonej bazy danych - [zapytania.sql](baza-danych/zapytania.sql),
- pliki SQL będące swoistą dokumentacją eksperymentów z optymalizacją zapytań do rozpatrywanej bazy danych - [optymalizacja_indeksy.sql](baza-danych/optymalizacja_indeksy.sql) i [hinty.sql](baza-danych/hinty.sql).

W katalogu [java](java) znajduje się z kolei prosta aplikacja konsolowa napisana w Javie - wykonuje ona przykładowe nieskomplikowane zapytania do danej bazy danych z użyciem JDBC.

### Źródła
1. http://elektron.elka.pw.edu.pl/~pwasiewi/bd.html

*Migrated from Bitbucket.*
