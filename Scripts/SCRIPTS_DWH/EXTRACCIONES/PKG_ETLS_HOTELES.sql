--- EXTRACCIONES DE LA BASE DE DATOS HOTELES 

--------------------- ENCABEZADO DEL PAQUETE 
CREATE OR REPLACE PACKAGE PKG_ETLS_HOTELES IS

--------------------- ETLs INFORMACIÓN INCREMENTAL
    --PROCEDURE SP_ETL_RESERVACIONES;
    --PROCEDURE SP_ETL_FACTURAS; -- TAMBIÉN LLENA LA TABLA DETALLES_FACTURA
    --PROCEDURE SP_ETL_EVALUACIONES;
    
--------------------- ETLs INFORMACIÓN VOLÁTIL
    PROCEDURE SP_ETL_SERVICIOS; --TAMBIÉN INSERTA EN LA TABLA TIPOS_SERVICIOS
    PROCEDURE SP_ETL_AMENIDADES;
    PROCEDURE SP_ETL_POLITICAS; 
    PROCEDURE SP_ETL_HOTELES;-- TAMBIÉN LLENA LAS TABLAS POLITICAS_X_HOTEL Y SERVICIOS_X_HOTEL
    --PROCEDURE SP_ETL_HABITACIONES; -- TAMBIEN LLENA LA TABLA AMENIDADES_X_HABITACION
    --PROCEDURE SP_ETL_TIPOS_EMPLEADOS;
    --PROCEDURE SP_ETL_EMPLEADOS;
    --PROCEDURE SP_ETL_CLIENTES;
    
END PKG_ETLS_HOTELES;

--------------------- CUERPO DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY PKG_ETLS_HOTELES IS
--------------------- ETLs INFORMACIÓN INCREMENTAL
--------------------- ETLs INFORMACIÓN VOLÁTIL
--------------------- ETL SERVICIOS
    PROCEDURE SP_ETL_SERVICIOS
    AS
        V_INICIO_ETL DATE := SYSDATE;
    BEGIN
        --LLENAR TABLAS TEMPORALES CON LA INFO EXTRAIDA DE SQL SERVER
        INSERT INTO tipos_servicios SELECT * FROM tipos_servicios@SQLSERVER_BD;
        INSERT into servicios SELECT * FROM servicios@SQLSERVER_BD;
        
        INSERT INTO tbl_servicios (
            tbl_servicios.servicio,
            tbl_servicios.id_servicio_hotel,
            tbl_servicios.tipo_servicio
        )
        SELECT 
            S.servicio,
            S.id_servicio,
            T.tipo_servicio
        FROM servicios S
        INNER JOIN tipos_servicios T
        ON (S.id_tipo = T.id_tipo);
        
        COMMIT;
        
        --GUARDAR LOG
        P_INSERT_LOG(
            P_nombre => $$PLSQL_UNIT,
            P_fecha_inicio => V_INICIO_ETL,
            P_nombre_base => 'HOTELES',
            P_exito => 'SUCCESS',
            P_error => NULL
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('OCURRIÓ UN ERROR AL EXTRAER LOS SERVICIOS DE LOS HOTELES.');
            ROLLBACK;
            
            --GUARDAR LOG
            P_INSERT_LOG(
                P_nombre => $$PLSQL_UNIT,
                P_fecha_inicio => V_INICIO_ETL,
                P_nombre_base => 'HOTELES',
                P_exito => 'FAIL',
                P_error => SQLERRM
            );
    END SP_ETL_SERVICIOS;

--------------------- ETL AMENIDADES
    PROCEDURE SP_ETL_AMENIDADES
    AS
        V_INICIO_ETL DATE := SYSDATE;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_amenidades';
    
        --LLENAR TABLAS TEMPORALES CON LA INFO EXTRAIDA DE SQL SERVER
        INSERT INTO amenidades SELECT * FROM amenidades@SQLSERVER_BD;
        INSERT into categorias_amenidades SELECT * FROM categorias_amenidades@SQLSERVER_BD;
        
        INSERT INTO tbl_amenidades (
            id_amenidad,
            amenidad,
            categoria
        )
        SELECT id_amenidad, amenidad, categoria 
        FROM amenidades A
        INNER JOIN categorias_amenidades C
        ON (A.id_categoria = C.id_categoria);
        
        COMMIT;
        
        --GUARDAR LOG
        P_INSERT_LOG(
            P_nombre => $$PLSQL_UNIT,
            P_fecha_inicio => V_INICIO_ETL,
            P_nombre_base => 'HOTELES',
            P_exito => 'SUCCESS',
            P_error => NULL
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('OCURRIÓ UN ERROR AL EXTRAER LAS AMENIDADES DE LAS HABITACIONES.');
            ROLLBACK;
            
            --GUARDAR LOG
            P_INSERT_LOG(
                P_nombre => $$PLSQL_UNIT,
                P_fecha_inicio => V_INICIO_ETL,
                P_nombre_base => 'HOTELES',
                P_exito => 'FAIL',
                P_error => SQLERRM
            );
            
    END SP_ETL_AMENIDADES;
    
--------------------- ETL POLÍTICAS
    PROCEDURE SP_ETL_POLITICAS
    AS
        V_INICIO_ETL DATE := SYSDATE;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_politicas';
        
        INSERT INTO tbl_politicas (
            id_politica,
            politica
        )
        SELECT * 
        FROM politicas@SQLSERVER_BD;
        
        COMMIT;
        
        --GUARDAR LOG
        P_INSERT_LOG(
            P_nombre => $$PLSQL_UNIT,
            P_fecha_inicio => V_INICIO_ETL,
            P_nombre_base => 'HOTELES',
            P_exito => 'SUCCESS',
            P_error => NULL
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('OCURRIÓ UN ERROR AL EXTRAER LAS POLITICAS.');
            ROLLBACK;
            
            --GUARDAR LOG
            P_INSERT_LOG(
                P_nombre => $$PLSQL_UNIT,
                P_fecha_inicio => V_INICIO_ETL,
                P_nombre_base => 'HOTELES',
                P_exito => 'FAIL',
                P_error => SQLERRM
            );
            
    END SP_ETL_POLITICAS;
END PKG_ETLS_HOTELES;