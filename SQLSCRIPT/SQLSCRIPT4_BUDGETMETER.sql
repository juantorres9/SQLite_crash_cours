-- Creation ou ouverture d'une DB depuis la consoleT
$sqlite3 testDB.db
$sqlite3 ./DB/BUDGET_APP_DB
-- display current session databses
.databases
-- attach databse on current session et creer une symlink
ATTACH DATABASE "c:\sqlite\db\chinook.db" AS chinook;
ATTACH DATABASE "C:\Users\jctor\EXTERNAL-PROGRAMS\sqlite-tools-win32-x86-3380500\sqlite-tools-win32-x86-3380500\BUDGET_APP_DB" AS BUDGET;

-- show all tables of an specific database
.tables
-- refer to something in an attached DB NOT Main DB
--show schema of a table
.schema 
-- visualiser la structuire d'une table  en specifiant le nom
.schema tb_budget_history
.schema chinook.albums
.schema tb_budget_history
.schema tb_monthly_tables

-- SORTIR DE SQLITE CLIENT
.exit

CREATE TABLE IF NOT EXISTS tb_budget_history (
    _id INTEGER PRIMARY KEY ,
	name TEXT NOT NULL,
	comment TEXT,
	unixtime INTEGER NOT NULL,
	amount REAL NOT NULL
);

-- NEW VERSION
CREATE TABLE IF NOT EXISTS tb_budget_history (
    _id INTEGER PRIMARY KEY ,
	name TEXT NOT NULL,
             year_month TEXT NOT NULL,
	comment TEXT,
	unixtime INTEGER NOT NULL,
             humain_tc0_isotime TEXT NOT NULL,
	amount REAL NOT NULL
);

-- TABLE MENSUEL: YEAR_MONTH  2022-12 , 2002-05
CREATE TABLE IF NOT EXISTS tb_monthly_tables (
    _id INTEGER PRIMARY KEY ,
	year_month TEXT UNIQUE NOT NULL,
	comment TEXT
);

INSERT INTO tb_monthly_tables (year_month,comment) VALUES( "2020-12","expenses done for groceries ");
INSERT INTO tb_monthly_tables (year_month,comment) VALUES( "2020-05","GOOD WORKER ");
INSERT INTO tb_monthly_tables (year_month,comment) VALUES( "2020-04","HARD WORKER MOTH  ");
INSERT INTO tb_monthly_tables (year_month,comment) VALUES( "2020-06","MONTH TITLE2 CHRISTMAS ");

INSERT INTO tb_budget_history (name,comment,unixtime,amount) VALUES( "supermarket payment","expenses done for groceries " ,1644166613607, 0.0);
INSERT INTO tb_budget_history (name,comment,unixtime,amount) VALUES( "supermarket payment","expenses done for groceries " ,1612926265000, 2.0);
INSERT INTO tb_budget_history (name,comment,unixtime,amount) VALUES( "supermarket payment3","" ,1612926265000, 4.0);
INSERT INTO tb_budget_history (name,unixtime,amount) VALUES( "supermarket payment4" ,1612926265000, 2.0);
INSERT INTO tb_budget_history (name,year_month,comment,unixtime,humain_tc0_isotime,amount) VALUES( "supermarket payment","2020-05","expenses done for groceries " ,1612926265000,"2020-05-22T06:00:00Z", 2.0);
INSERT INTO tb_budget_history (name,year_month,comment,unixtime,humain_tc0_isotime,amount) VALUES( "university expense","2020-04","expensesfor UNIVERSDITY " ,1612926265020,"2020-04-22T06:00:00Z", 3.0);
INSERT INTO tb_budget_history (name,year_month,comment,unixtime,humain_tc0_isotime,amount) VALUES( "car expense","2020-04","expensesfor car " ,1612926265070,"2020-04-22T07:00:00Z", 5.0);
INSERT INTO tb_budget_history (name,year_month,comment,unixtime,humain_tc0_isotime,amount) VALUES( "car expense3","2020-04","expensesfor car and plane " ,1612926265092,"2020-04-23T07:00:00Z", 5.0);
SELECT rowid,name,comment,unixtime,amount FROM tb_budget_history;


SELECT name,comment,unixtime,amount FROM tb_budget_history WHERE _id=1 LIMIT 1;
SELECT * FROM tb_budget_history;
SELECT * FROM tb_monthly_tables ;

--INNER JOIN AND WHERE
SELECT tb_monthly_tables.comment,tb_budget_history.name,tb_budget_history.amount,tb_budget_history.year_month
 FROM tb_monthly_tables 
     INNER JOIN tb_budget_history ON tb_monthly_tables.year_month = tb_budget_history.year_month
 WHERE tb_monthly_tables.year_month = '2020-05';
 
SELECT tb_monthly_tables.comment,tb_budget_history.name,tb_budget_history.amount,tb_budget_history.year_month
 FROM tb_monthly_tables 
     INNER JOIN tb_budget_history ON tb_monthly_tables.year_month = tb_budget_history.year_month
 WHERE tb_monthly_tables.year_month = "2020-04";

SELECT tb_monthly_tables.comment,tb_budget_history.name,tb_budget_history.amount,tb_budget_history.year_month FROM tb_monthly_tables INNER JOIN tb_budget_history WHERE tb_monthly_tables.year_month = tb_budget_history.year_month;
--OUTER JOIN
SELECT tb_monthly_tables.comment,tb_budget_history.name,tb_budget_history.amount,tb_budget_history.year_month FROM tb_monthly_tables LEFT OUTER JOIN tb_budget_history ON tb_monthly_tables.year_month ="2020-05";


SELECT * FROM tb_monthly_tables 
    LEFT OUTER JOIN tb_budget_history ON tb_monthly_tables.year_month =tb_budget_history.year_month
 WHERE tb_monthly_tables.year_month = "2020-05";

-- DROP UNE TABLE
DROP TABLE tb_budget_history;

-- DELETE ROW

DELETE FROM tb_budget_history WHERE _id=2;
