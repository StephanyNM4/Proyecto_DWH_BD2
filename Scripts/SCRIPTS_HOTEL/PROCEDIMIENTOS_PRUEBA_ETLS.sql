-----PROCEDIMIENTOS FACTURACION HOTELES
---------NOTAS---------
---FECHA EN RESERVACIONES
---PRECIO EN RESERVACIONES
----------------------------------------------EXTRACCION VOLATIL HOTELES

----------------------------------------------EXTRACCION VOLATIL SUCURSALES

----------------------------------------------EXTRACCION VOLATIL HABITACIONES :D
PROCEDURE P_ETL_HABITACIONES
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_habitaciones';
                
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
                FROM HABITACIONES@SQLSERVER_BD A
                INNER JOIN SUCURSALES@SQLSERVER_BD B
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
        
----------------------------------------------EXTRACCION INCREMENTAL RESERVACIONES :D
        PROCEDURE P_ETL_RESERVACIONES
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT MAX(FECHA_RESERVACION) + 1
            INTO V_FECHA_INICIO
            FROM TBL_RESERVACIONES;
            
            -----EN CASO DE QUE NO SE HAYA REALIZADO NINGUNA EXTRACCION, 
            -----EXTRAE LA INFORMACION DESDE LA FECHA MINIMA
            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA_RESERVACION)
                INTO V_FECHA_INICIO
                FROM FACTURAS@SQLSERVER_BD;
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
                FROM RESERVACIONES@SQLSERVER_BD A
                INNER JOIN CLIENTES@SQLSERVER_BD B 
                ON (A.ID_CLIENTE = B.ID_CLIENTE)
                INNER JOIN PERSONAS@SQLSERVER_BD C 
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


----------------------------------------------EXTRACCION INCREMENTAL FACTURAS :D
        PROCEDURE P_ETL_FACTURAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
            -----VERIFICAMOS LA ULTIMA EXTRACCION DE FACTURAS
            SELECT MAX(FECHA_FACTURA) + 1
            INTO V_FECHA_INICIO
            FROM TBL_FACTURAS;
            
            -----EN CASO DE QUE NO SE HAYA REALIZADO NINGUNA EXTRACCION, 
            -----EXTRAE LA INFORMACION DESDE LA FECHA MINIMA
            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA)
                INTO V_FECHA_INICIO
                FROM FACTURAS@SQLSERVER_BD;
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
                FROM FACTURAS@SQLSERVER_BD A
                INNER JOIN FORMAS_DE_PAGO@SQLSERVER_BD B
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

-----------------------------------------------EXTRACCION INCREMENTAL DETALLES FACTURAS (FACTURAS Y RESERVACIONES) 
CREATE OR REPLACE PROCEDURE P_ETL_DETALLES_FACTURAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_VAL_EXTRACCION NUMBER;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
        
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT COUNT(1)
            INTO V_VAL_EXTRACCION
            FROM TBL_DETALLES_FACTURAS;
            
            IF (V_VAL_EXTRACCION <= 0) THEN
                SELECT MIN(FECHA)
                INTO V_FECHA_INICIO
                FROM FACTURAS@SQLSERVER_BD;
            ELSE      
                SELECT MAX(FECHA_FACTURA) + 1
                INTO V_FECHA_INICIO
                FROM TBL_FACTURAS;
            END IF;
            
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
            
                FOR REGISTRO IN (SELECT A.id_reservacion,
                                        A.id_factura
                                    FROM DETALLE_FACTURA@SQLSERVER_BD A
                                    INNER JOIN FACTURAS@SQLSERVER_BD B
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

-----------------------------------------------EXTRACCION INCREMENTAL SERVICIOS POR HOTEL
