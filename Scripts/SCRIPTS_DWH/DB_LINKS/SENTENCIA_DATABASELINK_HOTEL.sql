--- 'SQLSERVER_ODBC' es el identificador que se utiliza para conectar el 
--- datawarehouse a un controlador ODBC que permite la conexi�n con el gestor SQL Server.
--- Se debe realizar la configuraci�n del Database Gateway previamente para poder establecer la conexi�n.
--- puede guiarse de este v�deo - https://youtu.be/ASVM4Vj9gdI?si=Gg4_35qOw7p9iZ-l :)

--- DATABASE LINK TO SQL SERVER
CREATE DATABASE LINK SQLSERVER_BD 
CONNECT TO "proyecto_bd2" IDENTIFIED BY "1234"
USING 'SQLSERVER_ODBC';