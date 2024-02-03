# La Sauvegarde  d'Information depuis Tableau1 vers  tableau2 selon reference1
#ETAPE 0  procedure a stocker  dans la base de production 
DELIMITER  |
CREATE PROCEDURE  procedure2_ref3_t2()
BEGIN  #1: recuperation de somme de valeurs depuis tableau1
	SELECT 
		SUM(tr),SUM(arret1),SUM(arret2) ,SUM(nb),SUM(nr),SUM(tnet),SUM(tu)INTO  
		@t2tr,@t2arret1,@t2arret2,@t2nb,@t2nr,@t2tnet,@t2tu 
	FROM tableau1 
	WHERE 
		reference='ref3'
		AND 
		DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);#DATE selon tableau1
	BEGIN  #2:ecriture de sommes t2_tr,t2_arret1,t2_arret2,t2_nb,t2_nr,t2_tnet,t2_tu
		UPDATE tableau2 
		SET t2_tr=@t2tr, t2_arret1=@t2arret1, t2_arret2=@t2arret2, t2_nb=@t2nb, t2_nr=@t2nr, t2_tnet=@t2tnet, t2_tu=@t2tu
		WHERE 
		t2_reference='ref3' 
		AND 
		DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -0 DAY);
	END;
    #calcul nt , ta ,  tf 	
	BEGIN
		UPDATE tableau2 
		SET t2_nt=@t2nr+@t2nb, t2_ta=@t2arret1+@t2arret2, t2_tf=@t2tr-t2_ta 
		WHERE 
		t2_reference='ref3' 
		AND 
		DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);
	END;
END |
DELIMITER ;


#********************************************EXECUTER DEPUIS JAVA*********************************
#ETAPE1 : appel du procedure pour remplir les 7 valeurs  t2_tr,t2_arret1,t2_arret2,t2_nb,t2_nr,   t2_tnet ,t2_tu,   	t2_nt,t2_ta,t2_tf
CALL  procedure2_ref3_t2()
#UPDATE pour Calculer et ecrire  les 5 parametres de  t2_do,t2_tp , t2_tq  et t2_trs sur Tableau2
#Une mise a jour  sequentielle reference1-reference2 et reference3 
DELIMITER  |
CREATE PROCEDURE  procedure3_ref3_t2()
BEGIN
#actualisation  reference 2
BEGIN
    UPDATE tableau2
    SET 
    t2_do=t2_tf/t2_tr,
    t2_tp=t2_tnet/t2_tf,
    t2_tq=t2_tu/t2_tnet,
    #t2_trs  conditionné à l'existent de tr !=0 
    t2_trs =CASE WHEN  t2_tr =0 THEN 1 ELSE t2_do*t2_tp*t2_tq END
    WHERE
    t2_reference='ref3' 
	AND 
	DATE_ADD(t2_date,INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL 0 DAY);#DATE selon tableau2
END;
END |
DELIMITER  ;

CALL procedure3_ref3_t2();




    





