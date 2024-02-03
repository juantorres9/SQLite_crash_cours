#*****************************************DESCRIBE COMMANDE******************************
#USE: choisir une base de données pour travailler 
USE base_production;

#*****************************************DESCRIBE COMMANDE******************************
#DESCRIBE: Decrire un tableau 
DESCRIBE tableau1;


#******************************************SELECT COMMANDE*******************************
#SELECT : permet de récupérer les éléments d'un tableau selon les condition de recherche
SELECT * FROM tableau2;

#recuperation colonne tr
SELECT tr,nb,nr,datetimes FROM tableau1 
WHERE datetimes LIKE '2016-06-02%';

#recuperation de colonne selon la DATE 
SELECT tr ,datetimes FROM tableau1 
WHERE (
DATEDIFF('2016-06-02',DATE(datetimes))=1
);

SELECT tr ,datetimes FROM tableau1 
WHERE (
DATEDIFF(DATE(datetimes),'2016-06-03')=-1
);

#Tri de Tableau2 selon la reference specifié   ET la date actuelle 
 SELECT s_datetimes,s_tr,s_arret1 FROM tableau2 
 WHERE s_reference='ref1' 
 AND 
 DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE(NOW());


#SELECT choix UNE colonne d'une ligne  d'un tableau SELON la DATE ET REFERENCE 	avec ALIAS
SELECT SUM(tr) AS as_tr FROM tableau1 
WHERE 
reference='ref1'
AND 
DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -1 DAY);

#SELECT choix DES colonnes d'une ligne  d'un tableau SELON la DATE ET REFERENCE 	avec ALIAS
SELECT SUM(tr) , SUM(arret1) ,SUM(arret2),SUM(nb),SUM(nr) FROM tableau1 
WHERE 
reference='ref1'
AND 
DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -1 DAY);



#DATE_ADD: Permet d'additioner une INTERVALE a une DATE
SELECT tr FROM tableau1 
WHERE(
DATE(datetimes)= DATE_ADD('2016-06-01',INTERVAL 1 DAY)
); 
#DATE_ADD: Permet d'additioner une INTERVALE a une DATE
SELECT tr FROM tableau1 
WHERE(
'2016-06-01'= DATE_ADD(DATE(datetimes),INTERVAL -1 DAY)
); 


 

#******************************************UPDATE COMMANDE*******************************
#UPDATE SIMPLE : mettre ref1 dans la colonne reference pour l'id=4
UPDATE tableau1
SET  reference='ref1'
WHERE
id=4;
#UPDATE SIMPLE : modifier tr  dans la colonne reference pour l'id=4
UPDATE tableau1 
SET 
    tr = 300 
WHERE
    id = 1;

#UPDATE Modifier les colonnes d'une ligne  d'un tableau SELON la DATE ET REFERENCE 	
UPDATE tableau2
SET s_tr=0,s_arret1=0,s_arret2=0,s_nb=0,s_nr=0
WHERE 
s_reference='ref1' 
AND 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -1 DAY)
;

#UPDATE Modifier les colonnes d'une ligne  d'un tableau SELON la DATE ET REFERENCE 	avec Nommage par point .
UPDATE tableau2 
SET tableau2.s_tr=7 
WHERE 
s_reference='ref1' 
AND 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY)
;


#


#*********************************VARIABLES @*************************************
#Creation de 2 variables  qui stockent  la somme des colonnes  tr ET arret1 

SELECT SUM(tr) ,SUM(arret1) INTO  @vs_tr,@vs_arret1 
FROM tableau1 
WHERE 
reference='ref1';

SELECT @vs_tr,@vs_arret1;


#*********************************PROCEDURE*************************************
#Creation de 2 variables  qui stockent  la somme des colonnes  tr ET arret1 
DELIMITER  |
CREATE PROCEDURE procedure1()
BEGIN
	SELECT tr FROM tableau1
    WHERE nom='henriette';
END |

DELIMITER ;
CALL procedure1() ;
DROP PROCEDURE procedure1;



#*********************************JOIN*************************************
SELECT tableau2.s_nt,
	   tableau2.s_tf,
       tableau3.heure_piece
FROM tableau2
	INNER JOIN tableau3
		ON tableau2.s_reference=tableau3.reference_tc

WHERE 
s_reference='ref1' 
AND 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);
;


#JOIN avec UPDATE pour actualiser les parametres de  do,tp et tq selon reference 1 

UPDATE tableau2
	INNER JOIN tableau3
    ON tableau2.s_reference=tableau3.reference_tc
    SET 
    tableau2.s_do=tableau2.s_tf/tableau2.s_tf,
    tableau2.s_tp=(tableau2.s_nt*tableau3.heure_piece)/tableau2.s_tf,
    tableau2.s_tq=tableau2.s_nb/tableau2.s_nt,
    
    tableau2.s_trs=tableau2.s_do*tableau2.s_tp*tableau2.s_tq
    WHERE
    s_reference='ref1' 
	AND 
	DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);
    
    

#JOIN avec UPDATE pour actualiser les parametres de  do,tp et tq 

UPDATE tableau2
	INNER JOIN tableau3
    ON tableau2.s_reference=tableau3.reference_tc
    SET 
    tableau2.s_do=tableau2.s_tf/tableau2.s_tr,
    tableau2.s_tp=(tableau2.s_nt*tableau3.heure_piece)/tableau2.s_tf,
    tableau2.s_tq=tableau2.s_nb/tableau2.s_nt,
    
    tableau2.s_trs=tableau2.s_do*tableau2.s_tp*tableau2.s_tq
    WHERE
    s_reference='ref1' 
	AND 
	DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);
      
#**********************************************CONVERT**********************************

SELECT  CONVERT(nr,DECIMAL(8,4)) FROM tableau1;

#**********************************************INSERT INTO********************************
#INSERT: inserer une valeur dans le tableau sulement si il n'existe  pas

#Inserere  reference=ref3
#1:creer la referece  'ref3' si'l n'existe pas  la DATE  
INSERT INTO tableau22(id,s_dates,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),'ref3',0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS (SELECT * FROM tableau22 WHERE s_dates =DATE(NOW()))) LIMIT 1;
#2: creer la reference 'ref3' s'il existe  DEJA la DATE 
INSERT INTO tableau22(id,s_dates,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),'ref3',0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS(SELECT * FROM tableau22 WHERE s_dates =DATE(NOW()) AND s_reference='ref3') LIMIT 1);

#Inserer reference=ref4
INSERT INTO tableau22(id,s_dates,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),'ref4',0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS (SELECT * FROM tableau22 WHERE s_dates =DATE(NOW()))) LIMIT 1;

INSERT INTO tableau22(id,s_dates,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr)
(SELECT NULL,DATE(NOW()),'ref4',0,0,0,0,0 FROM  tableau22 
WHERE NOT EXISTS(SELECT * FROM tableau22 WHERE s_dates =DATE(NOW()) AND s_reference='ref4') LIMIT 1);


#INSERT: inserer une valeur dans le tableau seulement si il n'existe  pas la DATE et LA REFERENCE
INSERT INTO tableau22(id,s_dates,s_reference)
SELECT d.idv,d.datev,d.refv FROM (
(SELECT NULL as idv ,DATE(NOW())as datev,'ref1'as refv)
UNION ALL
(SELECT NULL,DATE(NOW()),'ref2')
)as d
WHERE NOT EXISTS (SELECT * FROM tableau22 WHERE s_dates =DATE(NOW())) LIMIT 1;

#INSERT: inserer un ensemble de lignes de REFERENCES dans le tableau2 s'il n'existe pas la DATE ni LA REFERENCE

#1: le choix de tableu2 pour creer les 4 reference si il n'existent pas 
INSERT INTO tableau2(t2_id,t2_date,t2_reference,t2_trs)
SELECT d.id2,d.date2,d.reference2 ,d.trs2 FROM (
(SELECT NULL as id2 ,DATE(NOW())as date2,'ref1'as reference2,1 as trs2)
UNION ALL
(SELECT NULL as id2 ,DATE(NOW())as date2,'ref2'as reference2,1 as trs2)
UNION ALL
(SELECT NULL as id2 ,DATE(NOW())as date2,'ref3'as reference2,1 as trs2)
)as d
WHERE NOT EXISTS (SELECT * FROM tableau2 WHERE s_dates =DATE(NOW())) LIMIT 4;





#**********************************************CASE ********************************
#CASE: instruction qui permet de  essayer une condition AVANT  de executerune UPDATE    
UPDATE tableau2
SET 
t2_trs =CASE WHEN  t2_tr =0  THEN  2 ELSE t2_trs=t2_do*t2_tp*t2_tq END,
t2_do=100
WHERE
t2_reference='ref2' 
AND 
DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);#DATE selon tableau2


    
UPDATE tableau2
SET 
t2_trs =CASE WHEN  t2_tr =0  THEN  2 ELSE t2_do*t2_tp*t2_tq END
WHERE
t2_reference='ref1' 
AND 
DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);#DATE selon tableau2