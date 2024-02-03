
Triger when information is entered in TABLEAU 
1
SELECT ALL lignes TR WHERE DATE=2015-05 ET REF =1
UPDATE  SOMMEtr  AVEC  tr1+tr2+tr3....
close

2


DELIMITER  |
CREATE PROCEDURE procedure1()
BEGIN
	SELECT 
		SUM(tr),SUM(arret1),SUM(arret2) ,SUM(nb),SUM(nr)INTO  
		@vs_tr,@vs_arret1,@vs_arret2,@vs_nb,@vs_nr 
	FROM tableau1 
	WHERE 
		reference='ref1'
		AND 
		DATE(datetimes)=DATE_ADD(DATE(NOW()),INTERVAL -4 DAY);
	BEGIN
		UPDATE tableau2 
		SET s_tr=@vs_tr, s_arret1=@vs_arret1, s_arret2= @vs_arret2, s_nb=@vs_nb, s_nr=@vs_nr 
		WHERE 
		s_reference='ref1' 
		AND 
		DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -4 DAY);
	END;
END |

DELIMITER ;
CALL procedure1() ;
DROP PROCEDURE procedure1;


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888

DELIMITER ;
CALL procedure1() ;
DROP PROCEDURE procedure1;


#**********************UTILISATION TRIGGER*******************************************
INSERT INTO tableau2(id,s_datetimes,s_reference,s_tr,s_arret1,s_arret2,s_nb,s_nr,s_nt)
VALUES(NULL,NOW(),'ref1',NULL,NULL,NULL,NULL,NULL,NULL),
(NULL,NOW(),'ref2',1,2,3,4,5,6);