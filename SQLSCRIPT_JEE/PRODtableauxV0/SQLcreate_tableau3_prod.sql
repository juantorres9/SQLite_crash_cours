#Creation tableau3 pour CALCULER
CREATE TABLE IF NOT EXISTS tableau3(
id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY ,
ss_datetimes DATETIME NOT NULL,
ss_reference VARCHAR(20) NOT NULL,

ss_tr DOUBLE(8,4),
ss_arret1 DOUBLE(8,4),
ss_arret2 DOUBLE(8,4),
ss_nb INT,
ss_nr INT ,

ss_nt INT
);
#VERSION 2 Creation tableau3 FINAL selon la feuille excel avec tu + tnet  28/06/2016
CREATE TABLE IF NOT EXISTS tableau3_a(
t3_id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY ,
t3_date DATE NOT NULL,
t3_reference VARCHAR(20) NOT NULL,

t3_tr DOUBLE(8,4) NOT NULL,
t3_arret1 DOUBLE(8,4),
t3_arret2 DOUBLE(8,4),
t3_arret3 DOUBLE(8,4),
t3_arret4 DOUBLE(8,4),
t3_nb INT,
t3_nr INT ,
t3_tnet DOUBLE(8,4),
t3_tu DOUBLE(8,4),

t3_nt INT,
t3_ta DOUBLE(8,4),
t3_tf DOUBLE(8,4),

t3_do DOUBLE(8,4),
t3_tp DOUBLE(8,4),
t3_tq DOUBLE(8,4),
t3_trs DOUBLE(8,4)
);


#************************Suprimer le tableau3*****************************
#DROP:commande qui permet la supression d'un tableau ou  base 
#DROP TABLE tableau3;

#************************Suprimer une ligne du tableau3*****************************
#DELETE:commande qui permet la supression d'une ligne du tableau
#DELETE FROM tableau3 WHERE nr='';
#DELETE FROM tableau3 WHERE nr IS NULL;
DELETE FROM tableau3 WHERE id=2;
#DELETE FROM tableau3 WHERE id >=4;
#DELETE FROM tableau3 WHERE s_dates=DATE(NOW());
#************************Ajouter Valeurs tableau2*****************************
#INSERT: Addition de valeurs en précisant les colonnes ou pas  AVEC ou SANS valeurs NULL
INSERT INTO tableau3(id,ss_datetimes,ss_tr,ss_arret1,ss_arret2,ss_nb,ss_nr,ss_nt)
VALUES(NULL,NOW(),0,0,0,0,0,0),
(NULL,NOW(),1,2,3,4,5,6);



INSERT INTO tableau3(id, ss_datetimes, ss_tr, ss_arret1, ss_arret2, ss_nb, ss_nr, ss_nt, ss_ta, ss_tf, ss_do, ss_tp, ss_tq, ss_trs)
SELECT * FROM (SELECT 'NULL',NOW(),0,0,0,0,0,0,0,0,0,0,0,0) AS tmp 
WHERE NOT EXISTS (
SELECT Ss_datetimes FROM tableau3  WHERE 
DATE_ADD(DATE(Ss_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY)) LIMIT 1;


#************************ ALTER  :Alteration d'un tableau*****************************************
# ADDItion de columns 
ALTER  TABLE  tableau3 
ADD COLUMN ss_ta DOUBLE(8,4) ,
ADD COLUMN ss_tf DOUBLE(8,4), 
ADD COLUMN ss_do DOUBLE(8,4),
ADD COLUMN ss_tp DOUBLE(8,4),
ADD COLUMN ss_tq DOUBLE(8,4),
ADD COLUMN ss_trs DOUBLE(8,4);

#Modification de  COLONNE
ALTER TABLE tableau33 
MODIFY  ss_datetimes  DATE  NOT NULL ;

#changer le nom de la COLONNE
ALTER TABLE tableau33 
CHANGE ss_datetimes ss_dates DATE NOT NULL;


#******************************DUPLICATION DE TABLEAU *************************************
#Copier la STRUCTURE   plus les INDEXES de le tableau
CREATE TABLE tableau33 
LIKE tableau3;
#copier seulement  la DATA  
INSERT tableau33 
SELECT * FROM tableau3;


#*******************************INSERTION  CONDITIONNEL DE VALEURS*************************
#**********************************************INSERT INTO********************************
#INSERT: inserer une valeur dans le tableau sulement si il n'existe  pas

#Inserer SI la date n'est pa creé et  apres si la DATE est crée mais il n'y a pas de reference
INSERT INTO tableau33(id,ss_dates,ss_tr,ss_arret1,ss_arret2,ss_nb,ss_nr)
(SELECT NULL,DATE(NOW()),0,0,0,0,0 FROM  tableau33 
WHERE NOT EXISTS (SELECT * FROM tableau33 WHERE s_dates =DATE(NOW()))) LIMIT 1;

INSERT INTO tableau33(id,s_dates,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS(SELECT * FROM tableau33 WHERE s_dates =DATE(NOW()) AND s_reference='ref3') LIMIT 1);



#***********Inserer groupe de données  dans le systeme d'un seul coupe si l'information n'a pas été creé . 

INSERT INTO tableau3(id,ss_dates,ss_reference)
SELECT d.idv,d.datev,d.refv FROM (
(SELECT NULL as idv ,DATE(NOW())as datev,'ref1'as refv)
UNION ALL
(SELECT NULL,DATE(NOW()),'ref2')
UNION ALL
(SELECT NULL,DATE(NOW()),'ref3')
UNION ALL
(SELECT NULL,DATE(NOW()),'ref4')
)as d
WHERE NOT EXISTS (SELECT * FROM tableau33 WHERE s_dates =DATE(NOW())) LIMIT 4;

#*********************************************UPDATE**********************************************
UPDATE tableau33
SET s_tr=10,s_arret1=10,s_arret2=10,s_nb=10,s_nr=10
WHERE 
s_reference='ref2' 
AND 
DATE_ADD(DATE(s_dates),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY)
;

Select * from tableau3_a;
