-- M4L9_zadania_teoria-1-role-postgres.sql
-- Moduł 4 Data Control Language – Zadania Teoria SQL

-- 1. Korzystając ze składni CREATE ROLE, stwórz nowego użytkownika o nazwie user_training z możliwością zalogowania się do bazy danych i hasłem silnym :) (coś wymyśl).
DROP ROLE IF EXISTS user_training;
CREATE ROLE user_training WITH LOGIN PASSWORD 'us€rTr@1n1ng';


-- 2. Korzystając z atrybutu AUTHORIZATION dla składni CREATE SCHEMA. Utwórz schemat training, którego właścicielem będzie użytkownik user_training.
DROP SCHEMA IF EXISTS training CASCADE;
CREATE SCHEMA training AUTHORIZATION user_training;


-- 3. Będąc zalogowany na super użytkowniku postgres, spróbuj usunąć rolę (użytkownika) user_training.
DROP ROLE IF EXISTS user_training;
--SQL Error [2BP01]: BŁĄD: rola "user_training" nie może być usunięta ponieważ istnieją zależne od niej obiekty
--  Detail: właściciel schemat training


-- 4. Przekaż własność nad utworzonym dla / przez użytkownika user_training obiektami na role postgres. Następnie usuń role user_training.
REASSIGN OWNED BY user_training TO postgres;
DROP OWNED BY user_training;
DROP ROLE user_training;


-- 5. Utwórz nową rolę reporting_ro, która będzie grupą dostępów, dla użytkowników warstwy analitycznej o następujących przywilejach.
--  Dostęp do bazy danych postgres
--  Dostęp do schematu training
--  Dostęp do tworzenia obiektów w schemacie training
--  Dostęp do wszystkich uprawnień dla wszystkich tabel w schemacie training
CREATE ROLE reporting_ro;
GRANT CONNECT ON DATABASE postgres TO reporting_ro;
GRANT USAGE, CREATE ON SCHEMA training TO reporting_ro;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA training TO reporting_ro;


-- 6. Utwórz nowego użytkownika reporting_user z możliwością logowania się do bazy danych i haśle silnym :) (coś wymyśl). Przypisz temu użytkownikowi role reporting ro;
DROP ROLE IF EXISTS reporting_user;
CREATE ROLE reporting_user WITH LOGIN PASSWORD 'r€port1ngUs€r';
GRANT reporting_ro TO reporting_user;


-- 7. Będąc zalogowany na użytkownika reporting_user, spróbuj utworzyć nową tabele (dowolną) w schemacie training.
-- Zadanie 7. w pliku M4L9_zadania_teoria-2-role-reporting_reporting_user.sql


-- 8. Zabierz uprawnienia roli reporting_ro do tworzenia obiektów w schemacie training;
REVOKE CREATE ON SCHEMA training FROM reporting_ro;


-- 9. Zaloguj się ponownie na użytkownika reporting_user, sprawdź czy możesz utworzyć nową tabelę w schemacie training oraz czy możesz taką tabelę utworzyć w schemacie public.
-- Zadanie 9. w pliku M4L9_zadania_teoria-2-role-reporting_reporting_user.sql
