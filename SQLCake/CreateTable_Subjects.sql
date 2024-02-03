USE base1;
CREATE TABLE IF NOT EXISTS subjects(
id 		INT UNSIGNED NOT NULL AUTO_INCREMENT,
matiere VARCHAR(40)  NOT NULL,
note    INT UNSIGNED NOT NULL,
student_id INT(7) NOT NULL ,
PRIMARY KEY(id),
CONSTRAINT fk_student_id FOREIGN KEY(student_id) REFERENCES students(id)
);

#-----------Adition de données
INSERT INTO subjects (id,matiere,note,student_id)
VALUES(NULL,'Anglais',18,1),
(NULL,'Informatique',20,1),
(NULL,'BasesDonnee',18,2),
(NULL,'OrienteObjet',18,2);


SELECT * FROM  subjects WHERE  student_id=1 GROUP BY student_id;
SELECT id FROM students WHERE id>0;