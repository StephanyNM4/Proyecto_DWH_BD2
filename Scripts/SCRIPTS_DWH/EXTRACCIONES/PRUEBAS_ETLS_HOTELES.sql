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

----------------------------------------- TRUNCATES
TRUNCATE TABLE TBL_SERVICIOS_X_HOTEL;
TRUNCATE TABLE TBL_POLITICAS_X_HOTEL;
TRUNCATE TABLE TBL_EVALUACIONES_X_HOTEL;
TRUNCATE TABLE TBL_AMENIDADES_X_HABITACION;
TRUNCATE TABLE TBL_DETALLES_FACTURAS;
TRUNCATE TABLE TBL_FACTURAS;
TRUNCATE TABLE TBL_RESERVACIONES;
TRUNCATE TABLE TBL_SERVICIOS;
TRUNCATE TABLE TBL_POLITICAS;
TRUNCATE TABLE TBL_HABITACIONES;
TRUNCATE TABLE TBL_AMENIDADES;
TRUNCATE TABLE TBL_HOTELES;
TRUNCATE TABLE TBL_CLIENTES;