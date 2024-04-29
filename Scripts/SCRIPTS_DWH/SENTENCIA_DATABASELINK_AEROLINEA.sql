CREATE PUBLIC DATABASE LINK DB_LINK_AEROLINEA
CONNECT TO C##AEROLINEA IDENTIFIED BY oracle
USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.0.8)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )
';

SELECT * FROM TBL_BOLETOS@DB_LINK_AEROLINEA;
SELECT * FROM TBL_AVIONES@DB_LINK_AEROLINEA;