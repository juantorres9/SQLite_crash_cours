#Creer une base de données
CREATE DATABASE base_production 
CHARACTER SET 'utf8';

#Utiliser la base courant 
USE base_production;



#CREATE USER: Creer utilisateur avec droit de modifier  , suprimer   et creer un tableau   et sans droit de suprimer la base PRODUCTION 
CREATE USER  'test1'@'localhost' IDENTIFIED BY 'test1';

#option2  creer utilisateur pour une compte specifique depuis  l'addresse  172.23.52.174
CREATE USER 'test1'@'172.23.52.174' IDENTIFIED BY 'test1'; 
CREATE USER 'admin2'@'172.23.137.37' IDENTIFIED BY 'admin2'; #compte theo 
CREATE USER 'admin2'@'172.23.137.37' IDENTIFIED BY 'admin2'; #compte moi pc remote  
CREATE USER 'admin3'@'localhost' IDENTIFIED BY 'admin3'; #compte theo 


#DROP USER :Suprimer une compte de session  pour se connecter au  SERVEUR MySQL
#option1
DROP USER 'test1'@'localhost';
#option2
DROP USER 'test1'@'172.23.52.174';


#SHOW utilisateurs  presentents dans le Serveur MySQL
SELECT * FROM  mysql.user;
SELECT host,user  FROM mysql.user;

#GRANT : assigner de privilegies  à l'utilisateur cible depuis n'immorte pas quelle addresse
GRANT ALL PRIVILEGES ON base_magasin.* TO 'test1'@'%';
GRANT ALL PRIVILEGES ON base_production.* TO 'test1'@'%';
GRANT SELECT ,INSERT  ON *.* TO 'test2'@'172.25.30.128';
GRANT ALL PRIVILEGES ON base_production.* TO 'admin3'@'%';

#SHOW : montrer les privileges pour un utilisateur
SHOW GRANTS FOR  'test1'@'localhost';
SHOW GRANTS FOR  'admin2'@'172.23.137.37';


#REVOKE:


