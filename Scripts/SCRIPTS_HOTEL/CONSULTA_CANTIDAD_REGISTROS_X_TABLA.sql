------------------------------------------- CONTEO DE REGISTROS EN BD HOTELES SQL SERVER
SELECT 
    'TBL_SERVICIOS_X_HOTEL' AS tabla, 
    COUNT(*) AS cantidad_registros 
FROM SERVICIOS_SUCURSALES
UNION ALL
    SELECT 'TBL_POLITICAS_X_HOTEL' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM POLITICAS_SUCURSAL
UNION ALL
    SELECT 'TBL_EVALUACIONES_X_HOTEL' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM EVALUACIONES_HOTEL
UNION ALL
    SELECT 'TBL_AMENIDADES_X_HABITACION' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM AMENIDADES_HABITACIONES
UNION ALL
    SELECT 'TBL_DETALLES_FACTURAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM DETALLE_FACTURA
UNION ALL
    SELECT 'TBL_FACTURAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM FACTURAS
UNION ALL
    SELECT 'TBL_RESERVACIONES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM RESERVACIONES
UNION ALL
    SELECT 'TBL_SERVICIOS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM SERVICIOS
UNION ALL
    SELECT 'TBL_POLITICAS' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM POLITICAS
UNION ALL
    SELECT 'TBL_HABITACIONES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM HABITACIONES
UNION ALL
    SELECT 'TBL_AMENIDADES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM AMENIDADES
UNION ALL
    SELECT 'TBL_HOTELES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM HOTELES
UNION ALL
    SELECT 'TBL_CLIENTES' AS tabla, 
    COUNT(*) AS cantidad_registros 
    FROM CLIENTES;