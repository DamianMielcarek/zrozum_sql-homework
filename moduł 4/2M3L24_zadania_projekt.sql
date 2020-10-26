-- 2M3L24_zadania_projekt.sql
-- Moduł 3 Data Definition Language – PROJEKT

-- 1. Stwórz nowy schemat o nazwie expense_tracker.
CREATE SCHEMA expense_tracker;


-- 2. W schemacie expense_tracker na podstawie dołączonego diagramu ERD. Stwórz wszystkie
-- tabele projektowe, według dołączonego opisu. Na tym etapie nie tworzymy kluczy obcych
-- FOREIGN KEY.

-- Pamiętaj o wykorzystaniu IF EXISTS / IF NOT EXISTS. Wszystkie operacje powinny się
-- znaleźć w 1 skrypcie. Kilkukrotne uruchomienie tego samego skrypty powinno dawać ten
-- sam rezultat (utworzenie tabel). Hint: DROP IF EXISTS + CREATE IF NOT EXISTS

-- Tabela: bank_account_owner
-- Kolumny:
--  id_ba_own, typ całkowity, klucz główny
--  owner_name, typ tekstowy 50 znaków, not null
--  owner_desc, typ tekstowy 250 znaków
--  user_login, typ całkowity, not null
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.bank_account_owner;
CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_owner (
	id_ba_own		integer			PRIMARY KEY
,	owner_name		varchar(50)		NOT NULL
,	owner_desc		varchar(250)
,	user_login		integer			NOT NULL
,	active			varchar(1)		NOT NULL	DEFAULT 1
,	insert_date		timestamp		DEFAULT current_timestamp
,	update_date		timestamp		DEFAULT current_timestamp
);


-- Tabela: bank_account_types
-- Kolumny:
--  id_ba_type, typ całkowity, klucz główny
--  ba_type, typ tekstowy 50 znaków, not null
--  ba_desc, typ tekstowy 250 znaków
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  is_common_account, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu
-- znakowego wartość domyślna 0, dla prawdy fałsz ustaw fałsz, , not null
--  id_ba_own, typ całkowity
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.bank_account_types;
CREATE TABLE IF NOT EXISTS expense_tracker.bank_account_types (
	id_ba_type			integer			PRIMARY KEY
,	ba_type				varchar(50)		NOT NULL
,	ba_desc				varchar(250)
,	active				varchar(1)		NOT NULL	DEFAULT 1
,	is_common_account	varchar(1)		NOT NULL	DEFAULT 0
,	id_ba_own			integer
,	insert_date			timestamp		DEFAULT current_timestamp
,	update_date			timestamp		DEFAULT current_timestamp
);


-- Tabela: transactions
-- Kolumny:
--  id_transaction, typ całkowity, klucz główny
--  id_trans_ba, typ całkowity
--  id_trans_cat, typ całkowity
--  id_trans_subcat, typ całkowity
--  id_trans_type, typ całkowity
--  id_user, typ całkowity
--  transaction_date, typ daty (sama data), wartość domyślna current_date (spowoduje
-- wstawianie aktualnej daty w momencie wstawiania wierszy)
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
-- Przykład: transaction_date DATE DEFAULT current_date
--  transaction_value, typ zmiennoprzecinkowy (numeric, 9 znaków, do 2 znaków po
-- przecinku)
--  transaction_description, typ tekstowy (nieograniczony)
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.transactions;
CREATE TABLE IF NOT EXISTS expense_tracker.transactions (
	id_transaction			integer			PRIMARY KEY
,	id_trans_ba				integer
,	id_trans_cat			integer
,	id_trans_subcat			integer
,	id_trans_type			integer
,	id_user					integer
,	transaction_date		date			DEFAULT current_date
,	transaction_value		numeric(9,2)
,	transaction_description	TEXT
,	insert_date				timestamp		DEFAULT current_timestamp
,	update_date				timestamp		DEFAULT current_timestamp
);


-- Tabela: transaction_bank_accounts
-- Kolumny:
--  id_trans_ba, typ całkowity, klucz główny
--  id_ba_own, typ całkowity,
--  id_ba_typ, typ całkowity,
--  bank_account_name, typ tekstowy 50 znaków, not null
--  bank_account_desc, typ tekstowy 250 znaków
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.transaction_bank_accounts;
CREATE TABLE IF NOT EXISTS expense_tracker.transaction_bank_accounts (
	id_trans_ba			integer			PRIMARY KEY
,	id_ba_own			integer
,	id_ba_typ			integer
,	bank_account_name	varchar(50)		NOT NULL
,	bank_account_desc	varchar(250)
,	active				varchar(1)		NOT NULL	DEFAULT 1
,	insert_date			timestamp		DEFAULT current_timestamp
,	update_date			timestamp		DEFAULT current_timestamp
);


-- Tabela: transaction_category
-- Kolumny:
--  id_trans_cat, typ całkowity, klucz główny
--  category_name, typ tekstowy 50 znaków, not null
--  category_description, typ tekstowy 250 znaków
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.transaction_category;
CREATE TABLE IF NOT EXISTS expense_tracker.transaction_category (
	id_trans_cat			integer			PRIMARY KEY
,	category_name			varchar(50)		NOT NULL
,	category_description	varchar(250)
,	active					varchar(1)		NOT NULL	DEFAULT 1
,	insert_date				timestamp		DEFAULT current_timestamp
,	update_date				timestamp		DEFAULT current_timestamp
);


-- Tabela: transaction_subcategory
-- Kolumny:
--  id_trans_subcat, typ całkowity, klucz główny
--  id_trans_cat, typ całkowity
--  subcategory_name, typ tekstowy 50 znaków, not null
--  subcategory_description, typ tekstowy 250 znaków
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.transaction_subcategory;
CREATE TABLE IF NOT EXISTS expense_tracker.transaction_subcategory (
	id_trans_subcat			integer			PRIMARY KEY
,	id_trans_cat			integer
,	subcategory_name		varchar(50)		NOT NULL
,	subcategory_description	varchar(250)
,	active					varchar(1)		NOT NULL	DEFAULT 1
,	insert_date				timestamp		DEFAULT current_timestamp
,	update_date				timestamp		DEFAULT current_timestamp
);


-- Tabela: transaction_type
-- Kolumny:
--  id_trans_type, typ całkowity, klucz główny
--  transaction_type_name, typ tekstowy 50 znaków, not null
--  transaction_type_desc, typ tekstowy 250 znaków
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.transaction_type;
CREATE TABLE IF NOT EXISTS expense_tracker.transaction_type (
	id_trans_type			integer			PRIMARY KEY
,	transaction_type_name	varchar(50)		NOT NULL
,	transaction_type_desc	varchar(250)
,	active					varchar(1)		NOT NULL	DEFAULT 1
,	insert_date				timestamp		DEFAULT current_timestamp
,	update_date				timestamp		DEFAULT current_timestamp
);


-- Tabela: users
-- Kolumny:
--  id_user, typ całkowity, klucz główny
--  user_login, typ tekstowy 25 znaków, not null
--  user_name, typ tekstowy 50 znaków, not null
--  user_password, typ tekstowy 100 znaków, not null
--  password_salt, typ tekstowy 100 znaków, not null
--  active, typ tekstowy 1 znak (lub prawda / fałsz (boolean)), dla typu znakowego
-- wartość domyślna 1, dla prawdy fałsz ustaw prawdę, , not null
-- UWAGA: nie ma tego w materiałach wideo. Przeczytaj o atrybucie DEFAULT dla
-- kolumny https://www.postgresql.org/docs/12/ddl-default.html
--  insert_date, typ data i czas, wartość domyślna current_timestamp (spowoduje
-- wstawianie aktualnej daty i czasu w momencie wstawiania wierszy)
--  update_date, typ data i czas, wartość domyślna current_timestamp
DROP TABLE IF EXISTS expense_tracker.users;
CREATE TABLE IF NOT EXISTS expense_tracker.users (
	id_user			integer			PRIMARY KEY
,	user_login		varchar(25)		NOT NULL
,	user_name		varchar(50)		NOT NULL
,	user_password	varchar(100)	NOT NULL
,	password_salt	varchar(100)	NOT NULL
,	active			varchar(1)		NOT NULL	DEFAULT 1
,	insert_date		timestamp		DEFAULT current_timestamp
,	update_date		timestamp		DEFAULT current_timestamp
);
