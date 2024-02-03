#Creation tableau1 pour energistrements de temps de l'operateur à chaque  DEBUT DE PRODUCCION par REFERENCE 
CREATE TABLE IF NOT EXISTS tableau1(
id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY ,
datetimes DATETIME NOT NULL,
reference VARCHAR(20) NOT NULL,
nom VARCHAR(20) NOT NULL,
tr DOUBLE(8,4),
arret1 DOUBLE(8,4),
arret2 DOUBLE(8,4),
nb INT,
nr INT 
);
#VERSION 2 Creation tableau1 FINAL selon la feuille excel  10/06/2016
CREATE TABLE IF NOT EXISTS tableau1(
id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY ,
datetimes DATETIME NOT NULL,
reference VARCHAR(20) NOT NULL,
nom VARCHAR(20) NOT NULL ,
tr DOUBLE (8,4) NOT NULL ,
arret1 DOUBLE(8,4) ,
arret2 DOUBLE(8,4),
nb INT,
nr INT,
tnet DOUBLE(8,4) ,
tu DOUBLE(8,4)
);




#************************Suprimer le tableau1*****************************
#DROP:commande qui permet la supression d'un tableau ou  base 
#DROP TABLE tableau1;

#************************Suprimer une ligne du tableau1*****************************
#DELETE:commande qui permet la supression d'une ligne du tableau
#DELETE FROM tableau1 WHERE nr='';
#DELETE FROM tableau1 WHERE nr IS NULL;
#DELETE FROM tableau1 WHERE id=8 OR id=7;
#************************Ajouter Valeurs tableau1*****************************
#INSERT: Addition de valeurs en précisant les colonnes ou pas  AVEC ou SANS valeurs NULL
INSERT INTO tableau1(id,datetimes,reference,nom,tr,arret1,arret2,nb,nr)
VALUES(NULL,NOW(),'ref1','henriette',6,0.5,0.5,40,3),
(NULL,NOW(),'ref2','carlos',4,0.5,1,50,3),
#(NULL,NOW(),'ref1','philippe',3,0.1,0.1,35,NULL),
(NULL,NOW(),'ref1','henriette',2,0.2,0.1,30,2),
(NULL,NOW(),'ref1','henriette',3,0.1,0.1,35,1);

INSERT INTO tableau1(id,datetimes,reference,nom,tr,arret1,arret2,nb,nr)
VALUES(NULL,NOW(),'ref2','carlos',6,0,0,45,5),
(NULL,NOW(),'ref2','henriette',4,0.5,0.5,43,2);



#INSERT: Addition de valeurs avec valeurs constantes + CALCUL D'un colonne 
INSERT INTO tableau1(id,datetimes,reference,nom,tr,arret1,arret2,nb,nr,tnet)
VALUES(NULL,NOW(),'ref2','carlos',6,0,0,45,5),
(NULL,NOW(),'ref2','henriette',4,0.5,0.5,43,2);

USE base_production;

#VERSION 2 ,  INSERT valeurs  tableau1  pour test de données avec tnet +tu  10/06/2016
INSERT INTO tableau1(id,datetimes,reference,nom,tr,arret1,arret2,nb,nr,tnet,tu)
VALUES(NULL,(NOW() - INTERVAL 2 DAY) ,'ref1','henriettte',10,4,3,50,4,0.918,0.85),
(NULL,(NOW() - INTERVAL 2 DAY),'ref1','henriettte',8,0.2,0.1,30,2,0.544,0.51),
(NULL,(NOW() - INTERVAL 2 DAY),'ref2','henriettte',7,0.1,0.1,35,1,0.63,0.6125),
(NULL,(NOW() - INTERVAL 2 DAY),'ref2','carlos',7,0.1,0.1,35,1,0.63,0.6125),
(NULL,(NOW() - INTERVAL 2 DAY),'ref3','carlos',6,1,1,40,2,1.0584,1.008);

#JOUR  Courant 
INSERT INTO tableau1(id,datetimes,reference,nom,tr,arret1,arret2,nb,nr,tnet,tu)
VALUES(NULL,(NOW() - INTERVAL 0 DAY) ,'ref1','henriettte',10,4,3,50,4,0.918,0.85),
(NULL,(NOW() - INTERVAL 0 DAY),'ref1','henriettte',8,0.2,0.1,30,2,0.544,0.51),
(NULL,(NOW() - INTERVAL 0 DAY),'ref2','henriettte',7,0.1,0.1,35,1,0.63,0.6125),
(NULL,(NOW() - INTERVAL 0 DAY),'ref2','carlos',7,0.1,0.1,35,1,0.63,0.6125),
(NULL,(NOW() - INTERVAL 0 DAY),'ref3','carlos',6,1,1,40,2,1.0584,1.008);


#************************ ALTER  :Alteration d'un tableau*****************************************
# ADDItion de columns 
ALTER  TABLE  tableau1 
ADD COLUMN tnet DOUBLE(8,4) ;
#*****************************UPDATE valeurs tableau1*********************
#UPDATE Modifier les colonnes d'une ligne  de tableau1 SELON son id 
UPDATE tableau1
SET tr=50,arret1=4,arret2=3,nb=50,nr=4
WHERE 
id=1
;
#UPDATE : modofoer tous les lignes  du tableau1 pour avoir la date plus  Mise à JOUR 
UPDATE tableau1
SET datetimes=NOW()
WHERE 
id>=1
;

UPDATE tableau1
SET reference='ref3'
WHERE 
id=5
;
#******************************DUPLICATION DE TABLEAU1 *************************************
#Copier la STRUCTURE   plus les INDEXES de le tableau
CREATE TABLE tableau11 
LIKE tableau1;
#copier seulement  la DATA  
INSERT tableau11 
SELECT * FROM tableau1;


