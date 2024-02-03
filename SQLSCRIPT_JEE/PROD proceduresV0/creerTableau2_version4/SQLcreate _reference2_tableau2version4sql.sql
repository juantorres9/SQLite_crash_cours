#VERSION 4 avec 4 causes d'arrets a travailler  11/07/2016
#*****************************La Sauvegarde  d'Information depuis Tableau1_a vers  tableau2_a selon reference2**********************************************
#ETAPE A:Procedure à stocker  dans la base de production 
DELIMITER  |
CREATE PROCEDURE  pro1_ref2_t2_a()
BEGIN #1: recuperation de somme de valeurs depuis tableau1_a avec 4 causes d'arret
	SELECT 
		SUM(tr),SUM(arret1),SUM(arret2),SUM(arret3),SUM(arret4),SUM(nb),SUM(nr),SUM(tnet),SUM(tu)INTO  
		@t2tr,@t2arret1,@t2arret2,@t2arret3,@t2arret4,@t2nb,@t2nr,@t2tnet,@t2tu 
	FROM tableau1_a 
	WHERE 
		reference='ref2'
		AND 
		DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -0 DAY);#DATE selon tableau1_a
	BEGIN  #2:Ecriture de sommes t2_tr,t2_arret1,t2_arret2,t2_arret3,t2_arret4,t2_nb,t2_nr,t2_tnet,t2_tu sur TABLEAU2_A
		UPDATE tableau2_a 
		SET t2_tr=@t2tr, t2_arret1=@t2arret1, t2_arret2=@t2arret2, t2_arret3=@t2arret3, t2_arret4=@t2arret4, t2_nb=@t2nb, t2_nr=@t2nr, t2_tnet=@t2tnet, t2_tu=@t2tu
		WHERE 
		t2_reference='ref2' 
		AND 
		DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -0 DAY);
	END;
	BEGIN  #3 calcul t2_nt(Piéces totales) , t2_ta , t2_tf  avec les valeurs calculées precedement 
		UPDATE tableau2_a 
		SET t2_nt=@t2nr+@t2nb, t2_ta=@t2arret1+@t2arret2+@t2arret3+@t2arret4, t2_tf=@t2tr-t2_ta 
		WHERE 
		t2_reference='ref2' 
		AND 
		DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);
	END;
END |
DELIMITER  ;
#ETAPE B:Appel du procedure pour remplir les 12 valeurs  t2_tr,t2_arret1,t2_arret2 ,t2_arret3,t2_arret4, t2_nb,t2_nr,   t2_tnet ,t2_tu,   	t2_nt,t2_ta,t2_tf
CALL  pro1_ref2_t2_a();

#***************************************************************************************************
#ETAPE C: UPDATE pour Calculer et ecrire  les 4 parametres de  t2_do,t2_tp , t2_tq  et t2_trs sur Tableau2_a

DELIMITER  |
CREATE PROCEDURE  pro2_ref2_t2_a()
BEGIN #1 Creation de procedure   auxiliaire a executer en dernier pour calculer   les 4 indicateurs de productivité 
    UPDATE tableau2_a
    SET 
    t2_do=t2_tf/t2_tr,
    t2_tp=t2_tnet/t2_tf,
    t2_tq=t2_tu/t2_tnet,
    #t2_trs  conditionné à l'existent de tr !=0 
    t2_trs =CASE WHEN  t2_tr =0 THEN 1 ELSE t2_do*t2_tp*t2_tq END
    WHERE
    t2_reference='ref2' 
	AND 
	DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);#DATE selon tableau2
END |
DELIMITER  ;
# ETAPE D: Appel du procedure  pour calculer les4 indicateurs de productivité . 
CALL pro2_ref2_t2_a();




    





