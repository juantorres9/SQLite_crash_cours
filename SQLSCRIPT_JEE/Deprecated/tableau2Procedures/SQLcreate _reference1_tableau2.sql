# La Sauvegarde  d'Information depuis Tableau1 vers  tableau2 selon reference1
#ETAPE 0  procedure a stocker  dans la base de production 
DELIMITER  |
CREATE PROCEDURE  procedure7()
BEGIN
	SELECT 
		SUM(tr),SUM(arret1),SUM(arret2) ,SUM(nb),SUM(nr)INTO  
		@vs_tr,@vs_arret1,@vs_arret2,@vs_nb,@vs_nr 
	FROM tableau1 
	WHERE 
		reference='ref1'
		AND 
		DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);
	BEGIN
		UPDATE tableau2 
		SET s_tr=@vs_tr, s_arret1=@vs_arret1, s_arret2= @vs_arret2, s_nb=@vs_nb, s_nr=@vs_nr
		WHERE 
		s_reference='ref1' 
		AND 
		DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);
	END;
    #calcul nt , ta ,  tf 
	BEGIN
		UPDATE tableau2 
		SET s_nt=@vs_nr+@vs_nb, s_ta=@vs_arret1+@vs_arret2, s_tf=@vs_tr-s_ta 
		WHERE 
		s_reference='ref1' 
		AND 
		DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -5 DAY);
	END;
END |

DELIMITER  ;

#********************************************EXECUTER DEPUIS JAVA*********************************
#ETAPE1 : appel du procedure pour remplir les 7 valeurs  s_tr,s_arret1,s_arret2,s_nb,s_nr  et s_nt,s_ta,s_tf
CALL procedure7();
#JOIN avec UPDATE pour actualiser les 5 parametres de  s_tf ,s_do,s_tp et s_tq  et s_trs
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
