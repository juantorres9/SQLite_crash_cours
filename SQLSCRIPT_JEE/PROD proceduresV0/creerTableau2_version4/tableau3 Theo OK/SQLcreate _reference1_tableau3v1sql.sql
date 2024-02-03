#VERSION 4 avec 4 causes d'arrets a travailler  11/07/2016
#*****************************La Sauvegarde  d'Information depuis Tableau2_a vers  tableau3_a selon reference1**********************************************
#ETAPE GENERAL:inserer un ensemble de lignes de REFERENCES dans le tableau3_a s'il n'existe pas la DATE ni LA REFERENCE
DELIMITER  |
CREATE PROCEDURE pro_ligne_t3_a()
BEGIN #1: le choix de tableu3_a pour creer les 4 reference si il n'existent pas avec de valeurs par default NULL sauf  t3_id,t3_date,t3_reference,t3_tr et t3_trs
	INSERT INTO tableau3_a(t3_id,t3_date,t3_reference,t3_tr,t3_trs)
	SELECT d.id3,d.date3,d.ref_total ,d.tr3 ,d.trs3 FROM (
	(SELECT NULL as id3 ,DATE(NOW())as date3,'ref_total'as ref_total,0 as tr3,1 as trs3)
	)as d
	WHERE NOT EXISTS (SELECT * FROM tableau3_a WHERE t3_date =DATE(NOW())) LIMIT 1;
END|
DELIMITER  ;
#ETAPE GENERAL :Appel procedure  pour  faire l'Insertion de references s'ils n'existent pas 
CALL pro_ligne_t3_a();

select * from tableau3_a;


use base_production ; 
#*****************************PROCEDURE 1**********************************************
#ETAPE A:Procedure à stocker  dans la base de production 
DELIMITER  |
CREATE PROCEDURE  pro1_reftotal_t3_a()
BEGIN #1: recuperation de somme de valeurs depuis tableau2_a avec 4 causes d'arret
	SELECT 
		SUM(t2_tr),SUM(t2_arret1),SUM(t2_arret2),SUM(t2_arret3),SUM(t2_arret4),SUM(t2_nb),SUM(t2_nr),SUM(t2_tnet),SUM(t2_tu)INTO  
		@t3tr,@t3arret1,@t3arret2,@t3arret3,@t3arret4,@t3nb,@t3nr,@t3tnet,@t3tu 
	FROM tableau2_a 
	WHERE 
		t2_tr >0 and
		DATE(t2_date)=DATE_ADD(DATE(NOW()),INTERVAL -0 DAY);#DATE selon tableau2_a
	BEGIN  #2:Ecriture de sommes t3_tr,t3_arret1,t3_arret2,t3_arret3,t3_arret4,t3_nb,t3_nr,t3_tnet,t3_tu sur TABLEAU3_A
		UPDATE tableau3_a 
		SET t3_tr=@t3tr, t3_arret1=@t3arret1, t3_arret2=@t3arret2, t3_arret3=@t3arret3, t3_arret4=@t3arret4, t3_nb=@t3nb, t3_nr=@t3nr, t3_tnet=@t3tnet, t3_tu=@t3tu
		WHERE 
		DATE_ADD(t3_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -0 DAY);
	END;
	BEGIN  #3 calcul t3_nt(Piéces totales) , t3_ta , t3_tf  avec les valeurs calculées precedement 
		UPDATE tableau3_a 
		SET t3_nt=@t3nr+@t3nb, t3_ta=@t3arret1+@t3arret2+@t3arret3+@t3arret4, t3_tf=@t3tr-t3_ta 
		WHERE 
		DATE_ADD(t3_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);
	END;
END |
DELIMITER  ;
#ETAPE B:Appel du procedure pour remplir les 12 valeurs  t3_tr,t3_arret1,t3_arret2 ,t3_arret3,t3_arret4, t3_nb,t3_nr, t3_tnet ,t3_tu, t3_nt,t3_ta,t3_tf
CALL  pro1_reftotal_t3_a();

#***************************************************************************************************
#ETAPE C: UPDATE pour Calculer et ecrire  les 4 parametres de  t2_do,t2_tp , t2_tq  et t2_trs sur Tableau2_a
DELIMITER  |
CREATE PROCEDURE  pro2_reftotal_t3_a()
BEGIN #1 Creation de procedure   auxiliaire a executer en dernier pour calculer   les 4 indicateurs de productivité 
    UPDATE tableau3_a
    SET 
    t3_do=t3_tf/t3_tr,
    t3_tp=t3_tnet/t3_tf,
    t3_tq=t3_tu/t3_tnet,
    #t3_trs  conditionné à l'existent de tr !=0 
    t3_trs =CASE WHEN  t3_tr =0 THEN 1 ELSE t3_do*t3_tp*t3_tq END
    WHERE
	DATE_ADD(t3_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);#DATE selon tableau3
END |
DELIMITER  ;
# ETAPED: Appel du procedure  pour calculer les4 indicateurs de productivité . 
CALL pro2_reftotal_t3_a();




    





