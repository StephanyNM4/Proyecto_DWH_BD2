--- 'SQLSERVER_ODBC' es el identificador que se utiliza para conectar el 
--- datawarehouse a un controlador ODBC que permite la conexión con el gestor SQL Server.
--- Se debe realizar la configuración del Database Gateway previamente para poder establecer la conexión.
--- puede guiarse de este vídeo - https://youtu.be/ASVM4Vj9gdI?si=Gg4_35qOw7p9iZ-l :)

--- DATABASE LINK TO SQL SERVER
CREATE DATABASE LINK SQLSERVER_BD 
CONNECT TO "proyecto_bd2" IDENTIFIED BY "1234"
USING 'SQLSERVER_ODBC';