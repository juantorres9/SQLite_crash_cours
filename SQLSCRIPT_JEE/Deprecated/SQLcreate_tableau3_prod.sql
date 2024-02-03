CREATE TABLE IF NOT EXISTS tableau3 (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE KEY,
    reference_tc VARCHAR(20) NOT NULL,
    dmh DOUBLE(8 , 4 ),
    heure_piece DOUBLE(8 , 4 ),
    minute_piece DOUBLE(8 , 4 ),
    temps_moyen DOUBLE(8 , 4 )
);

INSERT INTO tableau3(id,reference_tc,dmh ,heure_piece,minute_piece,temps_moyen)
VALUES(NULL,'ref1',170,0.017,1.02,61.2),
(NULL,'ref2',175,0.0175,1.05,63),
(NULL,'ref12',172.5,0.01725,1.035,62.1);



SELECT * FROM tableau3;