
#***************************Instruction complexes en SOUS-REQUETES*************************************
#Creation tableau2 en CALCULANT les  valeur totales de table1 pour UN Colonne 
#ETAPE 1
#Declarartion  et Recuperation des  Variables
SELECT SUM(tr) INTO  @vs_tr FROM tableau1 
WHERE 
reference='ref1'
AND 
DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY);
#ETAPE 2
#modification Tableau2 avec les Variables 
UPDATE tableau2 
SET s_tr=@vs_tr 
WHERE 
s_reference='ref1' 
AND 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY)
;
#*************************************************************************************
#Creation tableau2 en CALCULANT les  valeurs totales de tableau1 pour PLUSIEURS  Colonnes
#ETAPE 1
SELECT 
SUM(tr),SUM(arret1),SUM(arret2) ,SUM(nb),SUM(nr)INTO  
@vs_tr,@vs_arret1,@vs_arret2,@vs_nb,@vs_nr FROM tableau1 
WHERE 
reference='ref1'
AND 
DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY);
#ETAPE 2
#modification Tableau2 avec les Variables 
UPDATE tableau2 
SET s_tr=@vs_tr, s_arret1=@vs_arret1, s_arret2= @vs_arret2, s_nb=@vs_nb, s_nr=@vs_nr 
WHERE 
s_reference='ref1' 
AND 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY);

#ETAPE3
##presentation des Variables Calculées et  du tableau2 complet  resultant
SELECT @vs_tr,@vs_arret1,@vs_arret2,@vs_nb,@vs_nr;
SELECT * FROM tableau1;

#****************************************************************************************
#Creation tableau2 en CALCULANT les  valeurs totales de tableau1 pour PLUSIEURS  Colonnes
#Pour la REFERENCE2
#REQUET 1
DROP TEMPORARY TABLE IF EXISTS temp1;
CREATE TEMPORARY TABLE IF NOT EXISTS   temp1 AS (
SELECT 
SUM(tr) AS vs_tr ,
SUM(arret1) AS vs_arret1 
FROM tableau1 
WHERE 
reference='ref1'
AND 
DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY) ) ;

SELECT * FROM temp1;
#REQUET 3
#modification Tableau2 avec les Variables 
UPDATE tableau2 ,temp1 
SET s_tr=temp1.vs_tr, s_arret1=temp1.vs_arret1 
WHERE 
s_reference='ref1' 
AND 
DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -2 DAY);
DROP TEMPORARY TABLE IF EXISTS temp1;




#********************************PROCEDURE***************************************



