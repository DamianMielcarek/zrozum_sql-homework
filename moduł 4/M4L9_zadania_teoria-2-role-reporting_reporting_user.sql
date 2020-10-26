-- M4L9_zadania_teoria-2-role-reporting_reporting_user.sql
-- Moduł 4 Data Control Language – Zadania Teoria SQL

-- 7. Będąc zalogowany na użytkownika reporting_user, spróbuj utworzyć nową tabele (dowolną) w schemacie training.
DROP TABLE IF EXISTS training.casual;
CREATE TABLE training.casual (
	id			integer		PRIMARY KEY
,	proverb		TEXT		NOT NULL	DEFAULT 'Trust, but verify.'
);


-- 9. Zaloguj się ponownie na użytkownika reporting_user, sprawdź czy możesz utworzyć nową tabelę w schemacie training oraz czy możesz taką tabelę utworzyć w schemacie public.
DROP TABLE IF EXISTS training.opposition;
CREATE TABLE training.opposition (
	id			integer
);
-- SQL Error [42501]: BŁĄD: odmowa dostępu do schematu training
--  Position: 14

DROP TABLE IF EXISTS profit;
CREATE TABLE profit (
	id			integer		PRIMARY KEY
,	tip			integer		NOT NULL	DEFAULT 0
);
