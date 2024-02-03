#Creation tableau2 pour CALCULER
CREATE TABLE IF NOT EXISTS tableau2(
id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY ,
s_datetimes DATETIME NOT NULL,
s_reference VARCHAR(20) NOT NULL,

s_tr DOUBLE(8,4),
s_arret1 DOUBLE(8,4),
s_arret2 DOUBLE(8,4),
s_nb INT,
s_nr INT ,

s_nt INT
);
#VERSION 2 Creation tableau2 FINAL selon la feuille excel avec tu + tnet  10/06/2016
CREATE TABLE IF NOT EXISTS tableau2(
t2_id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY ,
t2_date DATE NOT NULL,
t2_reference VARCHAR(20) NOT NULL,

t2_tr DOUBLE(8,4) NOT NULL,
t2_arret1 DOUBLE(8,4),
t2_arret2 DOUBLE(8,4),
t2_nb INT,
t2_nr INT ,
t2_tnet DOUBLE(8,4),
t2_tu DOUBLE(8,4),

t2_nt INT,
t2_ta DOUBLE(8,4),
t2_tf DOUBLE(8,4),

t2_do DOUBLE(8,4),
t2_tp DOUBLE(8,4),
t2_tq DOUBLE(8,4),
t2_trs DOUBLE(8,4)
);


#************************Suprimer le tableau2*****************************
#DROP:commande qui permet la supression d'un tableau ou  base 
#DROP TABLE tableau2;

#************************Suprimer une ligne du tableau2*****************************
#DELETE:commande qui permet la supression d'une ligne du tableau
#DELETE FROM tableau2 WHERE nr='';
#DELETE FROM tableau2 WHERE nr IS NULL;
DELETE FROM tableau2 WHERE id=2;
#DELETE FROM tableau3 WHERE id >=4;
#DELETE FROM tableau22 WHERE s_dates=DATE(NOW());
#************************Ajouter Valeurs tableau1*****************************
#INSERT: Addition de valeurs en précisant les colonnes ou pas  AVEC ou SANS valeurs NULL
INSERT INTO tableau2(id,s_datetimes,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr,s_nt)
VALUES(NULL,NOW(),'ref1',0,0,0,0,0,0),
(NULL,NOW(),'ref2',1,2,3,4,5,6);



INSERT INTO tableau2(id, s_datetimes, s_reference, s_tr, s_arret1, s_arret2, s_nb, s_nr, s_nt, s_ta, s_tf, s_do, s_tp, s_tq, s_trs)
SELECT * FROM (SELECT 'NULL',NOW(),'ref1',0,0,0,0,0,0,0,0,0,0,0,0) AS tmp 
WHERE NOT EXISTS (
SELECT s_datetimes FROM tableau2  WHERE 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY)) LIMIT 1;


#************************ ALTER  :Alteration d'un tableau*****************************************
# ADDItion de columns 
ALTER  TABLE  tableau2 
ADD COLUMN s_ta DOUBLE(8,4) ,
ADD COLUMN s_tf DOUBLE(8,4), 
ADD COLUMN s_do DOUBLE(8,4),
ADD COLUMN s_tp DOUBLE(8,4),
ADD COLUMN s_tq DOUBLE(8,4),
ADD COLUMN s_trs DOUBLE(8,4);

#Modification de  COLONNE
ALTER TABLE tableau22 
MODIFY  s_datetimes  DATE  NOT NULL ;

#changer le nom de la COLONNE
ALTER TABLE tableau22 
CHANGE s_datetimes s_dates DATE NOT NULL;


#******************************DUPLICATION DE TABLEAU *************************************
#Copier la STRUCTURE   plus les INDEXES de le tableau
CREATE TABLE tableau22 
LIKE tableau2;
#copier seulement  la DATA  
INSERT tableau22 
SELECT * FROM tableau2;


#*******************************INSERTION  CONDITIONNEL DE VALEURS*************************
#**********************************************INSERT INTO********************************
#INSERT: inserer une valeur dans le tableau sulement si il n'existe  pas

#Inserer  reference=ref3 SI la date n'est pa creé et  apres si la DATE est crée mais il n'y a pas de reference
INSERT INTO tableau22(id,s_dates,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),'ref3',0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS (SELECT * FROM tableau22 WHERE s_dates =DATE(NOW()))) LIMIT 1;

INSERT INTO tableau22(id,s_dates,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),'ref3',0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS(SELECT * FROM tableau22 WHERE s_dates =DATE(NOW()) AND s_reference='ref3') LIMIT 1);



#***********Inserer groupe de données  dans le systeme d'un seul coupe si l'information n'a pas été creé . 

INSERT INTO tableau2(id,s_dates,s_reference)
SELECT d.idv,d.datev,d.refv FROM (
(SELECT NULL as idv ,DATE(NOW())as datev,'ref1'as refv)
UNION ALL
(SELECT NULL,DATE(NOW()),'ref2')
UNION ALL
(SELECT NULL,DATE(NOW()),'ref3')
UNION ALL
(SELECT NULL,DATE(NOW()),'ref4')
)as d
WHERE NOT EXISTS (SELECT * FROM tableau22 WHERE s_dates =DATE(NOW())) LIMIT 4;

#*********************************************UPDATE**********************************************
UPDATE tableau22
SET s_tr=10,s_arret1=10,s_arret2=10,s_nb=10,s_nr=10
WHERE 
s_reference='ref2' 
AND 
DATE_ADD(DATE(s_dates),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY)
;