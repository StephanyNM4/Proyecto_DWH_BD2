------------------------------------------------------------------------------------------------------------------
---------------------------------------------PRUEBA UBER----------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

------------------------ TRUNCATE TABLAS
TRUNCATE TABLE TBL_HISTORICO_UBERS;
TRUNCATE TABLE TBL_COMENTARIOS;
TRUNCATE TABLE TBL_CARRERAS;
TRUNCATE TABLE TBL_CLIENTES;
TRUNCATE TABLE TBL_CONDUCTORES;
TRUNCATE TABLE TBL_ZONAS_RESTRINGIDAS;

------------------------ CANTIDAD DE REGISTROS
SELECT 
    'TBL_ZONAS_RESTRINGIDAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
FROM TBL_ZONAS_RESTRINGIDAS
UNION ALL
    SELECT 'TBL_HISTORICO_UBERS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_HISTORICO_UBERS
UNION ALL
    SELECT 'TBL_CONDUCTORES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_CONDUCTORES
UNION ALL
    SELECT 'TBL_COMENTARIOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_COMENTARIOS
UNION ALL
    SELECT 'TBL_CARRERAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_CARRERAS
UNION ALL
    SELECT 'TBL_CLIENTES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_CLIENTES;

-----------------------------------------LOGS
SELECT ID,
    NOMBRE,
    TO_CHAR(FECHA_INICIO, 'DD/MM/YYYY HH24:MI:SS') FECHA_INICIO,
    TO_CHAR(FECHA_FINAL, 'DD/MM/YYYY HH24:MI:SS') FECHA_FINAL,
    EXITO,
    ERROR
FROM TBL_LOGS;



------------------------------------------------------------------------------------------------------------------
----------------------------------------------PRUEBA AEROLINEAS---------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------ CANTIDAD DE REGISTROS 
SELECT 'TBL_CLIENTES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_CLIENTES;
UNION ALL
SELECT 
    'TBL_ESCALAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
FROM TBL_ESCALAS
UNION ALL
    SELECT 'TBL_VUELOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_VUELOS
UNION ALL
    SELECT 'TBL_ASIENTOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_ASIENTOS
UNION ALL
    SELECT 'TBL_BOLETOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_BOLETOS
UNION ALL
    SELECT 'TBL_FACTURA_BOLETOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_FACTURA_BOLETOS
UNION ALL
    SELECT 'TBL_SEGUIMIENTOS_EQUIPAJE' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_SEGUIMIENTOS_EQUIPAJE
UNION ALL
    SELECT 'TBL_EQUIPAJES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_EQUIPAJES
UNION ALL
    SELECT 'TBL_EQUIPAJES_POR_BOLETO' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_EQUIPAJES_POR_BOLETO
UNION ALL
    SELECT 'TBL_FACTURAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_FACTURAS
UNION ALL
    SELECT 'TBL_SERVICIOS_POR_BOLETO' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_SERVICIOS_POR_BOLETO
UNION ALL
    SELECT 'TBL_SERVICIOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_SERVICIOS;


------------------------ EXTRACCIONES
BEGIN
    PKG_ETLS_AEROLINEA.P_ETL_VUELOS;
    PKG_ETLS_AEROLINEA.P_ETL_ASIENTOS;
    PKG_ETLS_AEROLINEA.P_ETL_ESCALAS;
    PKG_ETLS_AEROLINEA.P_ETL_CLIENTES;
    PKG_ETLS_AEROLINEA.P_ETL_BOLETOS;
    PKG_ETLS_AEROLINEA.P_ETL_FACTURAS;
    PKG_ETLS_AEROLINEA.P_ETL_BOLETO_POR_FACTURA;
    PKG_ETLS_AEROLINEA.P_ETL_SERVICIOS;
    PKG_ETLS_AEROLINEA.P_ETL_SERVICIOS_POR_BOLETO;
    PKG_ETLS_AEROLINEA.P_ETL_EQUIPAJES;
    PKG_ETLS_AEROLINEA.P_ETL_EQUIPAJES_POR_BOLETO;
END;

-----------------------------------------LOGS
SELECT ID,
    NOMBRE,
    TO_CHAR(FECHA_INICIO, 'DD/MM/YYYY HH24:MI:SS') FECHA_INICIO,
    TO_CHAR(FECHA_FINAL, 'DD/MM/YYYY HH24:MI:SS') FECHA_FINAL,
    EXITO,
    ERROR
FROM TBL_LOGS;



------------------------------------------------------------------------------------------------------------------
---------------------------------------------PRUEBA HOTELES-------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----------------------------------------- CONTEO REGISTROS
SELECT 
    'TBL_SERVICIOS_X_HOTEL' AS tabla, 
    COUNT(*) AS cantidad_registros 
FROM TBL_SERVICIOS_X_HOTEL
UNION ALL
    SELECT 'TBL_POLITICAS_X_HOTEL' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_POLITICAS_X_HOTEL
UNION ALL
    SELECT 'TBL_EVALUACIONES_X_HOTEL' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_EVALUACIONES_X_HOTEL
UNION ALL
    SELECT 'TBL_AMENIDADES_X_HABITACION' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_AMENIDADES_X_HABITACION
UNION ALL
    SELECT 'TBL_DETALLES_FACTURAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_DETALLES_FACTURAS
UNION ALL
    SELECT 'TBL_FACTURAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_FACTURAS
UNION ALL
    SELECT 'TBL_RESERVACIONES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_RESERVACIONES
UNION ALL
    SELECT 'TBL_SERVICIOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_SERVICIOS
UNION ALL
    SELECT 'TBL_POLITICAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_POLITICAS
UNION ALL
    SELECT 'TBL_HABITACIONES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_HABITACIONES
UNION ALL
    SELECT 'TBL_AMENIDADES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_AMENIDADES
UNION ALL
    SELECT 'TBL_HOTELES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_HOTELES
UNION ALL
    SELECT 'TBL_CLIENTES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM TBL_CLIENTES;

--------------------------------------- EXTRACCIONES 
BEGIN
    pkg_etls_hoteles.SP_ETL_SERVICIOS;
    pkg_etls_hoteles.SP_ETL_POLITICAS;
    pkg_etls_hoteles.SP_ETL_AMENIDADES;
    pkg_etls_hoteles.SP_ETL_HOTELES;
    pkg_etls_hoteles.SP_ETL_HABITACIONES;
    pkg_etls_hoteles.SP_ETL_SERVICIOS_POR_HOTEL;
    pkg_etls_hoteles.SP_ETL_POLITICAS_POR_HOTEL;
    pkg_etls_hoteles.SP_ETL_AMENIDADES_X_HABITACION;
    pkg_etls_hoteles.SP_ETL_CLIENTES;
    pkg_etls_hoteles.SP_ETL_RESERVACIONES;
    pkg_etls_hoteles.SP_ETL_FACTURAS;
    pkg_etls_hoteles.SP_ETL_DETALLES_FACTURAS;
    pkg_etls_hoteles.SP_ETL_EVALUACIONES;
END;


-----------------------------------------LOGS
SELECT ID,
    NOMBRE,
    TO_CHAR(FECHA_INICIO, 'DD/MM/YYYY HH24:MI:SS') FECHA_INICIO,
    TO_CHAR(FECHA_FINAL, 'DD/MM/YYYY HH24:MI:SS') FECHA_FINAL,
    EXITO,
    ERROR
FROM TBL_LOGS;
