DELIMITER  |
CREATE PROCEDURE procedure6()
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
	BEGIN
		UPDATE tableau2 
		SET s_nt=@vs_nr+@vs_nb+1   
		WHERE 
		s_reference='ref1' 
		AND 
		DATE_ADD(DATE(s_datetimes),INTERVAL 0 DAY)=DATE_ADD(DATE(NOW()),INTERVAL -4 DAY);
	END;
END |