--- EXTRACCIONES DE LA BASE DE DATOS HOTELES 

--------------------- ENCABEZADO DEL PAQUETE 
CREATE OR REPLACE PACKAGE PKG_ETLS_HOTELES IS

--------------------- ETLs INFORMACIÓN INCREMENTAL
    PROCEDURE SP_ETL_RESERVACIONES;
    PROCEDURE SP_ETL_FACTURAS;
    PROCEDURE SP_ETL_DETALLES_FACTURAS;
    PROCEDURE SP_ETL_EVALUACIONES;
    
--------------------- ETLs INFORMACIÓN VOLÁTIL
    PROCEDURE SP_ETL_SERVICIOS; --TAMBIÉN INSERTA EN LA TABLA TIPOS_SERVICIOS
    PROCEDURE SP_ETL_AMENIDADES;
    PROCEDURE SP_ETL_POLITICAS; 
    PROCEDURE SP_ETL_HOTELES;-- TAMBIÉN LLENA LAS TABLAS POLITICAS_X_HOTEL Y SERVICIOS_X_HOTEL
    PROCEDURE SP_ETL_HABITACIONES; -- TAMBIEN LLENA LA TABLA AMENIDADES_X_HABITACION
    PROCEDURE SP_ETL_POLITICAS_POR_HOTEL;
    PROCEDURE SP_ETL_SERVICIOS_POR_HOTEL;
    PROCEDURE SP_ETL_AMENIDADES_X_HABITACION;
    PROCEDURE SP_ETL_CLIENTES;
    
END PKG_ETLS_HOTELES;

--------------------- CUERPO DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY PKG_ETLS_HOTELES IS
--------------------- ETLs INFORMACIÓN INCREMENTAL
--------------------- ETL RESERVACIONES
    PROCEDURE SP_ETL_RESERVACIONES
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := TRUNC(SYSDATE) - 1;
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
                SELECT MIN( TO_DATE(FECHA_RESERVACION, 'DD/MM/YY'))
                INTO V_FECHA_INICIO
                FROM RESERVACIONES;
            END IF;
            
            DELETE FROM TBL_RESERVACIONES
            WHERE TRUNC(FECHA_RESERVACION) = TRUNC(V_FECHA_INICIO);
        
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
                
                DBMS_OUTPUT.PUT_LINE('ESTAMOS AQUI. ' || V_FECHA_INICIO || ' ' || V_FECHA_fin);
                
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
                    TO_DATE(A.fecha_inicio, 'DD/MM/YY'),
                    TO_DATE(A.fecha_fin, 'DD/MM/YY'),
                    D.precio,
                    TO_DATE(A.fecha_reservacion, 'DD/MM/YY')
                FROM RESERVACIONES A
                    INNER JOIN CLIENTES B 
                    ON (A.ID_CLIENTE = B.ID_CLIENTE)
                    INNER JOIN PERSONAS C 
                    ON (B.ID_CLIENTE = C.ID_PERSONA)
                    INNER JOIN HABITACIONES D 
                    ON (A.ID_HABITACION = D.ID_HABITACION)
                WHERE TRUNC(TO_DATE(A.fecha_reservacion, 'DD/MM/YY')) = TRUNC(V_FECHA_INICIO);
                
                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
            COMMIT;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE RESERVACIONES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_RESERVACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTEL',
                                P_exito => 'SUCCESS',
                                P_error => '');
    
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_RESERVACIONES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END SP_ETL_RESERVACIONES;
--------------------- ETL FACTURAS
    PROCEDURE SP_ETL_FACTURAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := TRUNC(SYSDATE) - 1;
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
                SELECT MIN(TO_DATE(FECHA,'DD/MM/YY'))
                INTO V_FECHA_INICIO
                FROM FACTURAS;
            END IF;
            
            DELETE FROM TBL_FACTURAS
            WHERE TRUNC(FECHA_FACTURA) = TRUNC(V_FECHA_INICIO);
        
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
                    TO_DATE(A.fecha, 'DD/MM/YY'),
                    NULL,
                    A.impuesto,
                    A.total,
                    B.forma_de_pago
                FROM FACTURAS A
                INNER JOIN FORMAS_DE_PAGO B
                ON (A.ID_FORMA_PAGO = B.ID_FORMA_PAGO)
                WHERE TRUNC(TO_DATE(A.FECHA, 'DD/MM/YY')) = TRUNC(V_FECHA_INICIO); 

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
        END SP_ETL_FACTURAS;
--------------------- ETL DETALLES FACTURAS
    PROCEDURE SP_ETL_DETALLES_FACTURAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := TRUNC(SYSDATE) - 1;
            V_VAL_EXTRACCION NUMBER;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
        
        INSERT INTO FACTURAS SELECT * FROM FACTURAS@SQLSERVER_BD;
        INSERT INTO DETALLE_FACTURA SELECT * FROM DETALLE_FACTURA@SQLSERVER_BD;
        
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT COUNT(1)
            INTO V_VAL_EXTRACCION
            FROM TBL_DETALLES_FACTURAS;
            
            IF (V_VAL_EXTRACCION <= 0) THEN
                SELECT MIN(TO_DATE(FECHA, 'DD/MM/YY'))
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
                                    WHERE TRUNC( TO_DATE(B.FECHA, 'DD/MM/YY') ) = TRUNC(V_FECHA_INICIO)) LOOP
        
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
                                P_nombre_base => 'HOTELES',
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
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END SP_ETL_DETALLES_FACTURAS;
--------------------- ETL EVALUACIONES POR HOTEL
    PROCEDURE SP_ETL_EVALUACIONES
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
        END SP_ETL_EVALUACIONES;
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
            tbl_servicios.id_servicio_dwh,
            tbl_servicios.servicio,
            tbl_servicios.id_servicio_hotel,
            tbl_servicios.tipo_servicio
        )
        SELECT 
            S.id_servicio,
            S.servicio,
            S.id_servicio,
            T.tipo_servicio
        FROM servicios S
        INNER JOIN tipos_servicios T
        ON (S.id_tipo = T.id_tipo);
        
        COMMIT;
        
        --GUARDAR LOG
        P_INSERT_LOG(
            P_nombre => 'SP_ETL_SERVICIOS',
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
                P_nombre => 'SP_ETL_SERVICIOS',
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
            P_nombre => 'SP_ETL_AMENIDADES',
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
                P_nombre => 'SP_ETL_AMENIDADES',
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
            P_nombre => 'SP_ETL_POLITICAS',
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
                P_nombre => 'SP_ETL_POLITICAS',
                P_fecha_inicio => V_INICIO_ETL,
                P_nombre_base => 'HOTELES',
                P_exito => 'FAIL',
                P_error => SQLERRM
            );
            
    END SP_ETL_POLITICAS;
--------------------- ETL CLIENTES
    PROCEDURE SP_ETL_CLIENTES
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
                            TO_DATE(A.fecha_registro, 'DD/MM/YY') AS fecha_registro
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
                
                COMMIT;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE CLIENTES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_CLIENTES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'SUCCESS',
                                P_error => '');
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_CLIENTES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END SP_ETL_CLIENTES;
--------------------- ETL HOTELES
    PROCEDURE SP_ETL_HOTELES
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN

                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;
                INSERT INTO POLITICAS_SUCURSAL SELECT * FROM POLITICAS_SUCURSAL@SQLSERVER_BD;
                INSERT INTO CIUDADES SELECT * FROM CIUDADES@SQLSERVER_BD;
                INSERT INTO PAISES SELECT * FROM PAISES@SQLSERVER_BD;
                INSERT INTO DIRECCIONES SELECT * FROM DIRECCIONES@SQLSERVER_BD;

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
                    A.id_sucursal,
                    B.nombre,
                    A.descripcion,
                    A.correo,
                    B.sitio_web,
                    B.telefono,
                    E.nombre_pais,
                    D.nombre_ciudad
                FROM SUCURSALES A
                LEFT JOIN HOTELES B 
                ON (A.ID_HOTEL = B.ID_HOTEL)
                LEFT JOIN DIRECCIONES C
                ON (A.ID_DIRECCION = C.ID_DIRECCION)
                LEFT JOIN CIUDADES D 
                ON (D.ID_CIUDAD = C.ID_CIUDAD)
                LEFT JOIN PAISES E 
                ON (D.ID_PAIS = E.ID_PAIS);
                
                COMMIT;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE HOTELES FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HOTELES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'SUCCESS',
                                P_error => '');
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_HOTELES',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END SP_ETL_HOTELES;
--------------------- ETL HABITACIONES
    PROCEDURE SP_ETL_HABITACIONES
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
                ) SELECT  
                    A.codigo,
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
                                P_nombre_base => 'HOTELES',
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
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END SP_ETL_HABITACIONES;
-------------------- ETL POLITICAS POR HOTEL
    PROCEDURE SP_ETL_POLITICAS_POR_HOTEL
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                EXECUTE IMMEDIATE 'TRUNCATE TABLE TBL_POLITICAS_X_HOTEL';
                
                INSERT INTO POLITICAS_SUCURSAL SELECT * FROM POLITICAS_SUCURSAL@SQLSERVER_BD;

                INSERT INTO tbl_politicas_x_hotel (
                    id_politica,
                    id_hotel
                ) 
                SELECT 
                    id_politica,
                    id_sucursal
                FROM politicas_sucursal;
                                
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
                                
        END SP_ETL_POLITICAS_POR_HOTEL; 
-------------------- ETL SERVICIOS POR HOTEL
    PROCEDURE SP_ETL_SERVICIOS_POR_HOTEL
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
                                P_nombre_base => 'HOTELES',
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
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        END SP_ETL_SERVICIOS_POR_HOTEL; 
-------------------- ETL SERVICIOS POR HOTEL
    PROCEDURE SP_ETL_AMENIDADES_X_HABITACION
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                
                INSERT INTO AMENIDADES_HABITACIONES SELECT * FROM AMENIDADES_HABITACIONES@SQLSERVER_BD;
                INSERT INTO HABITACIONES SELECT * FROM HABITACIONES@SQLSERVER_BD;
                
                INSERT INTO tbl_amenidades_x_habitacion (
                    codigo_habitacion,
                    id_amenidad
                ) 
                SELECT 
                    codigo,
                    id_amenidad
                FROM
                    amenidades_habitaciones A
                    INNER JOIN habitaciones H
                    ON (A.id_habitacion = H.id_habitacion);
                    
                COMMIT;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE AMENIDADES POR HABITACION FINALIZADA');
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_AMENIDADES_X_HABITACION',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'SUCCESS',
                                P_error => '');
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => 'PKG_ETLS_HOTELES.P_ETL_AMENIDADES_X_HABITACION',
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'HOTELES',
                                P_exito => 'FAIL',
                                P_error => SQLCODE || '--' ||SQLERRM);
        
    END SP_ETL_AMENIDADES_X_HABITACION; 
END PKG_ETLS_HOTELES;