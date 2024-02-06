
#run
sqlite3.exe ./db/TASK_APP_DB

-- display current session databses
.databases
-- attach databse on current session
ATTACH DATABASE "c:\sqlite\db\chinook.db" AS chinook;
ATTACH DATABASE "c:\sqlite\db\TEST_NAMES" AS TEST_NAMES;

ATTACH DATABASE "C:\Users\jctor\WORKSPACE-LANGUAGES\SQL-Projects\SQL_CRASH_COURS\sample_database.db" AS test;
ATTACH DATABASE "C:\Users\jctor\WORKSPACE-LANGUAGES\SQL-Projects\SQL_CRASH_COURS\sample_database.db" AS test;
-- Detacher une database dans la session prompt en utilisant son alias 
DETACH DATABASE 'main';
DETACH DATABASE 'test';
-- show all tables of an specific database
.tables
-- refer to something in an attached DB NOT Main DB
--show schema of a table
.schema 
-- visualiser la structuire d'une table  en specifiant le nom
.schema albums
.schema chinook.albums

--#INSERT NEW ENTRY WITH PARTIAL VALUES(FOR THE ONEW ALLOWED NULL)
INSERT INTO contacts (contact_id,first_name,last_name,email,phone,address,description )VALUES(99999,"johny","hallyday","hey@titi.com","555",NULL,NULL);
--OR INSERT DECLARING ONLY THE 5 NOT NULL ELEMENTS
INSERT INTO contacts (contact_id,first_name,last_name,email,phone )VALUES(77777,"johny","Presley","mario@titi.com","333");


-- #NULL VALUE
INSERT INTO contacts (contact_id,first_name,last_name,email,phone) VALUES( 1237217,"carlos" ,"torres","toto15777@gmail.fr","12452677");
--#NOT NULL VALUE
INSERT INTO contacts (contact_id,first_name,last_name,email,phone) VALUES( 99,"carlos" ,"torres","toto@gmail.fr","12345");
INSERT INTO contacts (contact_id,first_name,last_name,email,phone) VALUES( 100,"TOTO" ,"TITI","tot2o@gmail.fr","123456789");

INSERT INTO tb_task (title,priority,description) VALUES( "FAIRE MUR REPARATION",1 ,"preparer mortier \n appliquer mortier");
INSERT INTO tb_task (title,priority,description) VALUES( "INSTALLER LAMP",1 ,"");
INSERT INTO tb_task (title,priority,description) VALUES( "Faire une promenade",1 ,"aller faire un tour a montferrand tous");

--INSERT tb_task2
INSERT INTO tb_task3 (title,priority,description) VALUES( "Faire une promenade",1 ,"aller faire un tour a montferrand tous");
INSERT INTO tb_task3 (title,priority,description) VALUES( "Faire une promenade",1 ,"aller faire un tour a montferrand tous");
--"INSERT INTO tb_task3 (title,priority,description) VALUES( ?,?,?)";

INSERT INTO tb_task2 (title,priority,description) VALUES( "Faire une promenade",1 ,"aller faire un tour a montferrand tous");
INSERT INTO tb_task2 (title,priority,description) VALUES( "aller chez claude et pierre",2 ,"aller faire un tour a arc et senans");
INSERT INTO tb_task2 (title,priority,description) VALUES( "aller faire vaccin",1 ,"aller faire un vaccin au labo en couple");


INSERT INTO tb_task4 (title,priority,description,status ) VALUES( "aller faire vaccin",1 ,"aller faire un vaccin au labo en couple","finished");
INSERT INTO tb_task4 (title,priority,description,status ) VALUES( "aller faire vaccin3",2 ,"aller faire un vaccin au labo en couple2","unfinished");
-- UPDATE STATEMENT 
-- UPDATE partial entry from contact table
UPDATE contacts SET first_name ="richard" WHERE contact_id =99;


UPDATE tb_task2 SET title="Demande congé",priority=1,description="faire une demande de congé a cibest "WHERE _id=3;
-- UPDATE MULTIPLE ROWS 
UPDATE tb_task2 SET title="Demande congé2",priority=1,description="faire une demande de congé a cibest " WHERE priority=1;
--- UPDTATE
UPDATE tb_task2 SET status="HOLA",priority=2 WHERE status="finished";


--INSERT single value with primary key in autoincrement table 
INSERT INTO chinook.supplier_groups (group_name)
VALUES
   ('Domestic'),
   ('Global'),
   ('One-Time');

INSERT INTO chinook.suppliers (supplier_name, group_id)
VALUES ('HP', 2);

INSERT INTO chinook.suppliers (supplier_name, group_id)
VALUES('SOLAR-E.', 3);
-- CONSTRAINT
INSERT INTO chinook.suppliers (supplier_name, group_id)
VALUES('ABC Inc.', 4);

INSERT INTO chinook.suppliers (supplier_name, group_id)
VALUES('ABC Inc.', 40);

--#CREATION DU TABLE
CREATE TABLE contacts (
	contact_id INTEGER PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	email TEXT NOT NULL UNIQUE,
	phone TEXT NOT NULL UNIQUE
);

--#CREATION DU TABLE
CREATE TABLE tb_task (
	title TEXT NOT NULL,
	priority INTEGER NOT NULL,
	description TEXT
);
--#CREATION DU TABLE
CREATE TABLE IF NOT EXISTS tb_task2 (
              _id INTEGER PRIMARY KEY ,
	title TEXT NOT NULL,
	priority INTEGER NOT NULL,
	description TEXT
);

CREATE TABLE IF NOT EXISTS tb_task4 (
    _id INTEGER PRIMARY KEY ,
	title TEXT NOT NULL,
	priority INTEGER NOT NULL,
	description TEXT,
	status TEXT NOT NULL
);


-- # CREATE WITH FOREIGN KEYS
PRAGMA foreign_keys=ON;

CREATE TABLE chinook.suppliers (
    supplier_id   INTEGER PRIMARY KEY,
    supplier_name TEXT    NOT NULL,
    group_id      INTEGER NOT NULL,
    FOREIGN KEY (group_id)
       REFERENCES supplier_groups (group_id) 
);

CREATE TABLE chinook.supplier_groups (
	group_id integer PRIMARY KEY,
	group_name text NOT NULL
);

--#ALTER TABLE
--MODIFIER UNE TABLE EXISTANT POUR AJOUTER UNE COLONNE
ALTER TABLE contacts 
ADD COLUMN address TEXT;

ALTER TABLE contacts
ADD COLUMN description TEXT;

-- DROP UNE TABLE
DROP TABLE chinook.suppliers;
DROP TABLE chinook.supplier_groups;
DROP TABLE TASK_APP_DB.tb_task2;
-- AFFICHAGE DE STRUCTURE 
.schema

-- RECHERCHE SELECT  
SELECT * FROM contacts;
SELECT * FROM chinook.suppliers;
SELECT * FROM chinook.supplier_groups;
-- FAKE ROWID  incrementation by DEFAULT
SELECT rowid FROM contacts;
--IT WILL DISPLAY 99 ET 100 AS contact_id COLUMN IT WILL DO THE MAPPING entre rowid et contact_id column 

SELECT * FROM tb_task;
-- FAKE ROWID  incrementation by DEFAULT
SELECT rowid FROM tb_task;
SELECT * FROM tb_task;
-- without rowid
SELECT title,priority,description FROM tb_task;
-- with rowid
SELECT rowid,title,priority,description FROM tb_task;
SELECT rowid,title,priority,description FROM tb_task2;

SELECT title,priority,description FROM tb_task2 WHERE _id=3 LIMIT 1;

SELECT _id,title,priority,description,status FROM tb_task4 WHERE status= "unfinished";
SELECT _id,title,priority,description,status FROM tb_task4 WHERE status!= "unfinished";


SELECT _id,title,priority,description,status FROM tb_task4 WHERE status= "unfinished" ORDER BY priority DESC;
SELECT _id,title,priority,description,status FROM tb_task4 WHERE status= "unfinished" ORDER BY priority ASC;
SELECT * FROM tb_task4 WHERE status= "unfinished" ORDER BY priority ASC;


-- SELECT DISTICT from contact table to avoid DUPLICATE
--DISTICT APPLIED TO A SINGLE COLUMN(last_name)
SELECT DISTINCT last_name FROM contacts ORDER BY last_name ;

--DISTICT APPLIED TO A COUPLE UNDIVISIONAL(first_name and last_name)
SELECT DISTINCT first_name,last_name FROM contacts ORDER BY last_name  ;
-- rowid implicit alias
https://www.sqlitetutorial.net/sqlite-primary-key/


-- GROUP BY SQL
SELECT first_name,last_name,phone  
FROM contacts  
GROUP BY first_name ,last_name
ORDER BY last_name;


--GROUPE BY RETRIEVING THE UNIQUE VALUE WITH MAX PHONE NUMBER AMONG THE POSIBBLE CANDIDATES
SELECT first_name,last_name,MAX(phone) as phoneM
FROM contacts 
GROUP BY first_name ,last_name 
ORDER BY last_name;



-- activation de clès extrange -> foreign keys
PRAGMA foreign_keys=ON;
PRAGMA foreign_keys=OFF;
-- disable  enable
PRAGMA foreign_keys;

--DELETE STATEMENT
DELETE * FROM chinooK.supplier_groups WHERE supplier_name="SOLAR_E";

DELETE FROM tb_task2 WHERE _id=2;


--LEFT JOIN
SELECT artists.ArtistId,albums.AlbumId
FROM
    artists
    LEFT JOIN albums ON
     artists.ArtistId=albums.ArtistId
     ORDER BY 
     AlbumId;

--LEFT JOIN
SELECT artists.ArtistId,albums.AlbumId,COUNT(DISTINCT artists.ArtistId )
FROM
    artists
    LEFT JOIN albums ON
     artists.ArtistId=albums.ArtistId
     ORDER BY 
     AlbumId;
     

-- RIGHT JOIN --ERROR
SELECT artists.ArtistId,albums.AlbumId
FROM
    artists
    RIGHT JOIN albums ON
     artists.ArtistId=albums.ArtistId
     ORDER BY 
     AlbumId;