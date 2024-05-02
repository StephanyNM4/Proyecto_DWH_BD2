-----PROCEDIMIENTOS FACTURACION HOTELES


----COMPILAR ACTUALIZACION O INSERCION DE CLIENTES DWH
-------------------------EXTRACCION (ACTUALIZACION O INSERT) CLIENTES
CREATE OR REPLACE PROCEDURE P_INSERT_CLIENTE(P_CORREO_ELECTRONICO VARCHAR2,
                                            P_nombre VARCHAR2,
                                            P_apellido VARCHAR2,
                                            P_telefono NUMBER,
                                            P_contrasena_uber VARCHAR2:= NULL,
                                            P_contrasena_aerolinea VARCHAR2 := NULL,
                                            P_contrasena_hotel VARCHAR2:= NULL,
                                            P_genero VARCHAR2:= NULL,
                                            P_fecha_registro DATE) AS
    --VARIABLES
    V_CANTIDAD_CLIENTE NUMBER;
BEGIN
    SELECT COUNT(1)
    INTO V_CANTIDAD_CLIENTE
    FROM TBL_CLIENTES
    WHERE CORREO_ELECTRONICO = P_CORREO_ELECTRONICO;
    
    --YA EXISTE
    IF(V_CANTIDAD_CLIENTE>0) THEN
        IF(P_CONTRASENA_UBER IS NOT NULL) THEN
            UPDATE tbl_clientes
            SET
                contrasena_uber = P_CONTRASENA_UBER
            WHERE correo_electronico = P_CORREO_ELECTRONICO;
        END IF;
        
        IF(P_CONTRASENA_AEROLINEA IS NOT NULL) THEN
            UPDATE tbl_clientes
            SET
                CONTRASENA_AEROLINEA  = P_CONTRASENA_AEROLINEA 
            WHERE correo_electronico = P_CORREO_ELECTRONICO;
        END IF;
        
        IF(P_CONTRASENA_HOTEL IS NOT NULL) THEN
            UPDATE tbl_clientes
            SET
                CONTRASENA_HOTEL  = P_CONTRASENA_HOTEL
            WHERE correo_electronico = P_CORREO_ELECTRONICO;
        END IF;
        
        IF(P_GENERO IS NOT NULL) THEN
            UPDATE tbl_clientes
            SET
                GENERO  = P_GENERO
            WHERE correo_electronico = P_CORREO_ELECTRONICO;
        END IF;
    --NO EXISTE
    ELSE
        INSERT INTO tbl_clientes (
        correo_electronico,
        nombre,
        apellido,
        telefono,
        contrasena_uber,
        contrasena_aerolinea,
        contrasena_hotel,
        genero,
        fecha_registro
    ) VALUES (
        P_CORREO_ELECTRONICO,
        P_nombre,
        P_apellido,
        P_telefono,
        P_contrasena_uber,
        P_contrasena_aerolinea,
        P_contrasena_hotel,
        P_genero,
        P_fecha_registro 
    );
    END IF; 
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR=> '|| SQLERRM);
END;
----COMPILAR ETL_LOG DWH
CREATE OR REPLACE PROCEDURE P_INSERT_LOG(P_nombre VARCHAR2,
    P_fecha_inicio DATE,
    P_nombre_base VARCHAR2,
    P_exito VARCHAR,
    P_error VARCHAR) AS
BEGIN
    INSERT INTO tbl_logs (
        nombre,
        fecha_inicio,
        fecha_final,
        nombre_base,
        exito,
        error
    ) VALUES (
        P_nombre,
        P_fecha_inicio,
        SYSDATE,
        P_nombre_base,
        P_exito,
        P_error
    );
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: '|| SQLERRM);
END;

--------------------------------------------------EXTRACCION VOLATIL CLIENTES
        CREATE OR REPLACE PROCEDURE P_ETL_CLIENTES
        AS
                V_GENERO VARCHAR2(1);
                V_INICIO_ETL DATE := SYSDATE;
        BEGIN

            INSERT INTO CLIENTES SELECT * FROM CLIENTES@SQLSERVER_BD;
            INSERT INTO PERSONAS SELECT * FROM PERSONAS@SQLSERVER_BD;
            INSERT INTO GENEROS SELECT * FROM GENEROS@SQLSERVER_BD;

                FOR REGISTRO IN (
                    SELECT B.correo,
                            B.nombre,
                            B.apellido,
                            B.telefono,
                            A.contrasenia,
                            C.genero,
                            A.fecha_registro
                    FROM CLIENTES A
                    INNER JOIN PERSONAS B
                    ON (A.ID_CLIENTE = B.ID_PERSONA)
                    INNER JOIN GENEROS C
                    ON (B.ID_GENERO = C.ID_GENERO)) LOOP
                
                    V_GENERO := SUBSTR(REGISTRO.genero, 1, 1);
                    P_INSERT_CLIENTE(P_CORREO_ELECTRONICO=>REGISTRO.correo, 
                                        P_nombre =>REGISTRO.nombre ,
                                        P_apellido =>REGISTRO.apellido ,
                                        P_telefono =>REGISTRO.telefono ,
                                        P_contrasena_aerolinea =>REGISTRO.contrasenia ,
                                        P_GENERO => V_GENERO,
                                        P_fecha_registro =>REGISTRO.fecha_registro );
                
                END LOOP;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE CLIENTES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HABITACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HABITACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_CLIENTES;

----------------------------------------------EXTRACCION VOLATIL HOTELES
CREATE OR REPLACE PROCEDURE P_ETL_HOTELES
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN

                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;
                INSERT INTO POLITICAS_SUCURSAL SELECT * FROM POLITICAS_SUCURSAL@SQLSERVER_BD;
                INSERT INTO CIUDADES SELECT * FROM CIUDADES@SQLSERVER_BD;
                INSERT INTO PAISES SELECT * FROM PAISES@SQLSERVER_BD;


                INSERT INTO tbl_hoteles (
                    id_hotel,
                    nombre,
                    descripcion,
                    correo,
                    sitio_web,
                    telefono_principal,
                    pais,
                    ciudad
                ) SELECT 
                    A.id_hotel,
                    A.nombre,
                    A.descripcion,
                    A.correo,
                    A.sitio_web,
                    A.telefono,
                    E.nombre_pais,
                    D.nombre_ciudad
                FROM HOTELES A
                INNER JOIN SUCURSALES B 
                ON (A.ID_HOTEL = B.ID_HOTEL)
                INNER JOIN DIRECCIONES C
                ON (B.ID_DIRECCION = C.ID_DIRECCION)
                INNER JOIN CIUDADES D 
                ON (D.ID_CIUDAD = C.ID_CIUDAD)
                INNER JOIN PAISES E 
                ON (C.ID_PAIS = E.ID_PAIS);
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE HOTELES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HOTELES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HOTELES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_HOTELES; 

----------------------------------------------EXTRACCION VOLATIL HABITACIONES :'D
CREATE OR REPLACE PROCEDURE P_ETL_HABITACIONES
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_habitaciones';
                
                INSERT INTO HABITACIONES SELECT * FROM HABITACIONES@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;

                INSERT INTO tbl_habitaciones (
                    codigo_habitacion,
                    id_hotel,
                    precio,
                    limite_personas,
                    cantidad_camas,
                    descripcion,
                    disponible
                ) SELECT * 
                    A.id_habitacion,
                    b.id_hotel,
                    A.precio,
                    A.limite_personas,
                    A.cantidad_camas,
                    A.descripcion,
                    A.disponible
                FROM HABITACIONES A
                INNER JOIN SUCURSALES B
                ON (A.ID_SUCURSAL = B.ID_SUCURSAL);
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE HABITACIONES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HABITACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HABITACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_HABITACIONES; 
        
----------------------------------------------EXTRACCION INCREMENTAL RESERVACIONES :'D
        CREATE OR REPLACE PROCEDURE P_ETL_RESERVACIONES
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
            INSERT INTO RESERVACIONES SELECT * FROM RESERVACIONES@SQLSERVER_BD;
            INSERT INTO CLIENTES SELECT * FROM CLIENTES@SQLSERVER_BD;
            INSERT INTO PERSONAS SELECT * FROM PERSONAS@SQLSERVER_BD;
            INSERT INTO HABITACIONES SELECT * FROM HABITACIONES@SQLSERVER_BD;
            
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT MAX(FECHA_RESERVACION) + 1
            INTO V_FECHA_INICIO
            FROM TBL_RESERVACIONES;
            
            -----EN CASO DE QUE NO SE HAYA REALIZADO NINGUNA EXTRACCION, 
            -----EXTRAE LA INFORMACION DESDE LA FECHA MINIMA
            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA_RESERVACION)
                INTO V_FECHA_INICIO
                FROM FACTURAS;
            END IF;
            
            DELETE FROM TBL_RESERVACIONES
            WHERE TRUNC(FECHA_RESERVACION) = TRUNC(V_FECHA_INICIO);
        
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
            
                INSERT INTO tbl_reservaciones (
                    id_reservacion,
                    codigo_habitacion,
                    correo_cliente,
                    fecha_inicio,
                    fecha_fin,
                    precio,
                    fecha_reservacion
                ) SELECT
                    A.id_reservacion,
                    A.id_habitacion,
                    C.correo,
                    A.fecha_inicio,
                    A.fecha_fin,
                    D.precio,
                    A.fecha_reservacion
                FROM RESERVACIONES A
                INNER JOIN CLIENTES B 
                ON (A.ID_CLIENTE = B.ID_CLIENTE)
                INNER JOIN PERSONAS C 
                ON (B.ID_CLIENTE = C.ID_PERSONA)
                INNER JOIN HABITACIONES D 
                ON (A.ID_HABITACION = D.ID_HABITACION);


                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE RESERVACIONES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_RESERVACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_RESERVACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_RESERVACIONES;


----------------------------------------------EXTRACCION INCREMENTAL FACTURAS :'D
        CREATE OR REPLACE PROCEDURE P_ETL_FACTURAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN

        INSERT INTO FACTURAS SELECT * FROM FACTURAS@SQLSERVER_BD;
        INSERT INTO FORMAS_DE_PAGO SELECT * FROM FORMAS_DE_PAGO@SQLSERVER_BD;

            -----VERIFICAMOS LA ULTIMA EXTRACCION DE FACTURAS
            SELECT MAX(FECHA_FACTURA) + 1
            INTO V_FECHA_INICIO
            FROM TBL_FACTURAS;
            
            -----EN CASO DE QUE NO SE HAYA REALIZADO NINGUNA EXTRACCION, 
            -----EXTRAE LA INFORMACION DESDE LA FECHA MINIMA
            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA)
                INTO V_FECHA_INICIO
                FROM FACTURAS;
            END IF;
            
            DELETE FROM TBL_FACTURAS
            WHERE TRUNC(FECHA) = TRUNC(V_FECHA_INICIO);
        
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
            
                INSERT INTO tbl_facturas (
                    id_factura_dwh,
                    id_factura_aerolinea,
                    id_factura_hotel,
                    fecha_factura,
                    impuesto_porcentaje,
                    impuesto_valor,
                    total,
                    metodo_pago
                ) SELECT
                    A.id_factura,
                    NULL,
                    A.id_factura,
                    A.fecha,
                    NULL,
                    A.impuesto,
                    A.total,
                    B.forma_de_pago
                FROM FACTURAS A
                INNER JOIN FORMAS_DE_PAGO B
                ON (A.ID_FORMA_PAGO = B.ID_FORMA_PAGO)
                WHERE TRUNC(A.FECHA) = TRUNC(V_FECHA_INICIO); 

                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE FACTURAS FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_FACTURAS',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_FACTURAS',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_FACTURAS;

-----------------------------------------------EXTRACCION INCREMENTAL DETALLES FACTURAS :'D
CREATE OR REPLACE PROCEDURE P_ETL_DETALLES_FACTURAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_VAL_EXTRACCION NUMBER;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
        
        INSERT INTO FACTURAS SELECT * FROM FACTURAS@SQLSERVER_BD;
        INSERT INTO DETALLE_FACTURA SELECT * FROM DETALLE_FACTURA@SQLSERVER
        
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT COUNT(1)
            INTO V_VAL_EXTRACCION
            FROM TBL_DETALLES_FACTURAS;
            
            IF (V_VAL_EXTRACCION <= 0) THEN
                SELECT MIN(FECHA)
                INTO V_FECHA_INICIO
                FROM FACTURAS;
            ELSE      
                SELECT MAX(FECHA_FACTURA) + 1
                INTO V_FECHA_INICIO
                FROM TBL_FACTURAS;
            END IF;
            
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
            
                FOR REGISTRO IN (SELECT A.id_reservacion,
                                        A.id_factura
                                    FROM DETALLE_FACTURA A
                                    INNER JOIN FACTURAS B
                                    ON (A.ID_FACTURA = B.ID_FACTURA)
                                    WHERE TRUNC(B.FECHA) = TRUNC(V_FECHA_INICIO)) LOOP
        
                                INSERT INTO tbl_detalles_facturas (
                                        id_reservacion,
                                        id_factura_dwh
                                    ) VALUES (
                                        REGISTRO.id_reservacion,
                                        REGISTRO.id_factura
                                    );
                END LOOP;
                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE DETALLES FACTURA FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_DETALLES_FACTURAS',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;

            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_DETALLES_FACTURAS',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_DETALLES_FACTURAS;


----------------------------------------------EXTRACCION VOLATIL POLITICAS
CREATE OR REPLACE PROCEDURE SP_ETL_POLITICAS
    AS
        V_INICIO_ETL DATE := SYSDATE;
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_politicas';
        INSERT INTO politicas SELECT * FROM politicas@SQLSERVER_BD;

        INSERT INTO tbl_politicas (
            id_politica,
            politica
        ) SELECT 
            id_politica,
            politica
        FROM politicas;
        
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
            DBMS_OUTPUT.PUT_LINE('OCURRI� UN ERROR AL EXTRAER LAS POLITICAS.');
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

----------------------------------------------EXTRACCION VOLATIL POLITICAS POR HOTEL
CREATE OR REPLACE PROCEDURE P_ETL_POLITICAS_POR_HOTEL
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                
                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;
                INSERT INTO POLITICAS_SUCURSAL SELECT * FROM POLITICAS_SUCURSAL@SQLSERVER_BD;

                FOR REGISTRO IN (SELECT A.ID_POLITICA,
                                        A.ID_SUCURSAL
                                    FROM HOTELES A
                                    INNER JOIN SUCURSALES B
                                    ON (A.ID_HOTEL= B.ID_HOTEL)
                                    INNER JOIN POLITICAS_SUCURSAL C
                                    ON (B.ID_SUCURSAL = C.ID_SUCURSAL)) LOOP


                                    INSERT INTO tbl_politicas_x_hotel (
                                        id_politica,
                                        id_hotel
                                    ) VALUES (
                                        REGISTRO.ID_POLITICA,
                                        REGISTRO.ID_SUCURSAL
                                    );
                END LOOP;

                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE POLITICAS POR HOTEL FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_POLITICAS_POR_HOTEL',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_POLITICAS_POR_HOTEL',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_POLITICAS_POR_HOTEL; 
        

----------------------------------------------EXTRACCION VOLATIL EVALUACIONES POR HOTEL
CREATE OR REPLACE PROCEDURE P_ETL_EVALUACIONES_POR_HOTEL
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                
                INSERT INTO EVALUACIONES_HOTEL SELECT * FROM EVALUACIONES_HOTEL@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;
                INSERT INTO CLIENTES SELECT * FROM CLIENTES@SQLSERVER_BD;
                INSERT INTO PERSONAS SELECT * FROM PERSONAS@SQLSERVER_BD;

                INSERT INTO tbl_evaluaciones_x_hotel (
                    id_evaluacion,
                    id_hotel,
                    correo_cliente,
                    limpieza,
                    servicio_y_personal,
                    condiciones_propiedad,
                    calificacion_promedio,
                    fecha_evaluacion
                ) SELECT 
                    A.id_evaluacion,
                    B.id_hotel,
                    D.correo,
                    A.limpieza,
                    A.servicio_y_personal,
                    A.condiciones_propiedad,
                    A.calificacion_promedio,
                    A.fecha_evaluacion
                FROM EVALUACIONES_HOTEL A
                INNER JOIN SUCURSALES B 
                ON (A.ID_SUCURSAL = B.ID_SUCURSAL)
                INNER JOIN CLIENTES C 
                ON (A.ID_CLIENTE = C.ID_CLIENTE)
                INNER JOIN PERSONAS D 
                ON (C.ID_CLIENTE = D.ID_PERSONA);
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE EVALUACIONES POR HOTEL FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_EVALUACIONES_POR_HOTEL',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_EVALUACIONES_POR_HOTEL',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_EVALUACIONES_POR_HOTEL; 

----------------------------------------------EXTRACCION VOLATIL SERVICIOS POR HOTEL 

CREATE OR REPLACE PROCEDURE P_ETL_SERVICIOS_POR_HOTEL
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                
                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;
                INSERT INTO SERVICIOS_SUCURSALES SELECT * FROM SERVICIOS_SUCURSALES@SQLSERVER_BD;

                FOR REGISTRO IN (SELECT C.ID_SERVICIO,
                                        C.ID_SUCURSAL
                                    FROM HOTELES A
                                    INNER JOIN SUCURSALES B
                                    ON (A.ID_HOTEL= B.ID_HOTEL)
                                    INNER JOIN SERVICIOS_SUCURSALES C
                                    ON (B.ID_SUCURSAL = C.ID_SUCURSAL)) LOOP


                                    INSERT INTO tbl_servicios_x_hotel (
                                        id_hotel,
                                        id_servicio_dwh
                                    ) VALUES (
                                        REGISTRO.ID_SUCURSAL,
                                        REGISTRO.ID_SERVICIO
                                    );
                END LOOP;


                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE EVALUACIONES POR HOTEL FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_SERVICIOS_POR_HOTEL',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_SERVICIOS_POR_HOTEL',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END P_ETL_SERVICIOS_POR_HOTEL; 

----------------------------------------------EXTRACCION VOLATIL AMENIDADES
    CREATE OR REPLACE PROCEDURE SP_ETL_AMENIDADES
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
            DBMS_OUTPUT.PUT_LINE('OCURRI� UN ERROR AL EXTRAER LAS AMENIDADES DE LAS HABITACIONES.');
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

----------------------------------------------EXTRACCION VOLATIL AMENIDADES POR HABITACION 
CREATE OR REPLACE PROCEDURE P_ETL_AMENIDADES_X_HABITACION
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                
                INSERT INTO AMENIDADES_HABITACIONES SELECT * FROM AMENIDADES_HABITACIONES@SQLSERVER_BD;

                
                INSERT INTO tbl_amenidades_x_habitacion (
                    codigo_habitacion,
                    id_amenidad
                ) SELECT 
                    id_habitacion,
                    id_amenidad
                FROM AMENIDADES_HABITACIONES;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE AMENIDADES POR HABITACION FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_AMENIDADES_X_HABITACION',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_AMENIDADES_X_HABITACION',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        
    END P_ETL_AMENIDADES_X_HABITACION; 

