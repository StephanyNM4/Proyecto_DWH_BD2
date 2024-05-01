
--------------ENCABEZADO PCKG
CREATE OR REPLACE NONEDITIONABLE PACKAGE PCK_ETLS_AEROLINEA IS 

    PROCEDURE P_ETL_VUELOS;
    PROCEDURE P_ETL_ASIENTOS;
    PROCEDURE P_ETL_ESCALAS;
    PROCEDURE P_ETL_CLIENTES;
    PROCEDURE P_ETL_BOLETOS;
    PROCEDURE P_ETL_SERVICIOS;
    PROCEDURE P_ETL_FACTURAS;
    PROCEDURE P_ETL_EQUIPAJES;

END PCK_ETLS_AEROLINEA;


--------------CUERPO PKG
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY PCK_ETLS_AEROLINEA IS 

----------------------------------------EXTRACCION INCREMENTAL DE VUELOS
        PROCEDURE P_ETL_VUELOS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
        
            ----VERIFICAMOS LA ULTIMA EXTRACCION REALIZADA
            SELECT MAX(FECHA_PARTIDA) + 1
            INTO V_FECHA_INICIO
            FROM TBL_VUELOS;
            
            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA_PARTIDA)
                INTO V_FECHA_INICIO
                FROM TBL_VUELOS@DB_LINK_AEROLINEA;
            END IF;
                
                ----------REALIZAMOS LA EXTRACCION
                WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
                    
                    ------ELIMINAMOS REGISTRO DEL DIA DE HOY;
                    DELETE FROM TBL_VUELOS
                    WHERE TRUNC(FECHA_PARTIDA) = TRUNC(V_FECHA_INICIO);
                
                    INSERT INTO tbl_vuelos (
                        id_vuelo,
                        aerolinea,
                        fecha_partida,
                        aeropuerto_partida,
                        aeropuerto_llegada,
                        numero_vuelo,
                        hora_llegada,
                        hora_partida,
                        gate,
                        tipo_vuelo,
                        descuento,
                        fecha_fin_descuento,
                        capacidad_pasajeros,
                        modelo_avion,
                        lugar_origen,
                        lugar_destino,
                        distancia
                    ) SELECT 
                        a.id_vuelo,
                        b.aerolinea,
                        a.fecha_partida,
                        c.aeropuerto,
                        cc.aeropuerto,
                        a.numero_vuelo,
                        a.hora_llegada,
                        a.hora_partida,
                        a.gate,
                        SUBSTR(d.id_tipo_vuelo, 1, 1),
                        e.descuento,
                        e.fecha_fin,
                        NULL,
                        NULL,
                        i.lugar,
                        ii.lugar,
                        h.distancia
                    FROM TBL_VUELOS@DB_LINK_AEROLINEA A
                    INNER JOIN TBL_AEROLINEAS@DB_LINK_AEROLINEA B
                    ON (A.ID_AEROLINEA = B.ID_AEROLINEA)
                    INNER JOIN TBL_AEROPUERTOS@DB_LINK_AEROLINEA C
                    ON (A.ID_AEROPUERTO_PARTIDA = C.ID_AEROPUERTO)
                    INNER JOIN TBL_AEROPUERTOS@DB_LINK_AEROLINEA CC
                    ON (A.ID_AEROPUERTO_LLEGADA = CC.ID_AEROPUERTO)
                    INNER JOIN TBL_TIPOS_VUELOS@DB_LINK_AEROLINEA D
                    ON (A.ID_TIPO_VUELO = D.ID_TIPO_VUELO)
                    LEFT JOIN TBL_OFERTAS_VUELO@DB_LINK_AEROLINEA E
                    ON (A.ID_OFERTA = E.ID_OFERTA)
                    INNER JOIN TBL_RUTAS@DB_LINK_AEROLINEA H
                    ON (A.ID_RUTA = H.ID_RUTA)
                    INNER JOIN TBL_LUGARES@DB_LINK_AEROLINEA I
                    ON (H.ID_LUGAR_ORIGEN = I.ID_LUGAR)
                    INNER JOIN TBL_LUGARES@DB_LINK_AEROLINEA II
                    ON (H.ID_LUGAR_DESTINO = II.ID_LUGAR)
                    WHERE TRUNC(A.FECHA_PARTIDA) = TRUNC(V_FECHA_INICIO);
                    V_FECHA_INICIO := V_FECHA_INICIO + 1;
                END LOOP;
                    
                -------INSERTAMOS EN LOGS
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                                
                    DBMS_OUTPUT.PUT_LINE('EXTRACCION DE VUELOS FINALIZADA');           
                    COMMIT;
                EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                    P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                            P_fecha_inicio => V_INICIO_ETL,
                            P_nombre_base => 'BASE',
                            P_exito => 'FAIL');
        END P_ETL_VUELOS;
        
------------------------------------------------EXTRACCION VOLATIL DE ASIENTOS
        PROCEDURE P_ETL_ASIENTOS
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_asientos';
                
                INSERT INTO tbl_asientos (
                    id_asiento,
                    id_vuelo,
                    nombre_asiento,
                    disponible,
                    tipo_asiento,
                    precio_base_asiento
                ) SELECT 
                    a.id_asiento,
                    c.id_vuelo,
                    a.nombre_asiento,
                    a.disponible,
                    b.tipo_asiento,
                    b.precio_base
                FROM TBL_ASIENTOS@DB_LINK_AEROLINEA a
                INNER JOIN TBL_TIPO_ASIENTO@DB_LINK_AEROLINEA b
                ON (A.ID_TIPO_ASIENTO = B.ID_TIPO_ASIENTO)
                INNER JOIN TBL_VUELOS@DB_LINK_AEROLINEA c
                ON (A.ID_VUELO = C.ID_VUELO);
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE ASIENTOS FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK; 
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_ASIENTOS;

-------------------------------------------------EXTRACCION INCREMENTAL ESCALAS
        PROCEDURE P_ETL_ESCALAS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT MAX(FECHA_PARTIDA) + 1
            INTO V_FECHA_INICIO
            FROM TBL_VUELOS;
            
            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA_PARTIDA)
                INTO V_FECHA_INICIO
                FROM TBL_VUELOS@DB_LINK_AEROLINEA;
            END IF;
            
            -----ELIMINAMOS ESCALAS DE HOY
            FOR REGISTRO IN (SELECT A.ID_ESCALA, B.FECHA_PARTIDA FROM TBL_ESCALAS@DB_LINK_AEROLINEA A INNER JOIN TBL_VUELOS@DB_LINK_AEROLINEA B
                                        ON (A.ID_VUELO_PADRE = B.ID_VUELO) WHERE TRUNC(B.FECHA_PARTIDA) = TRUNC(V_FECHA_INICIO)) LOOP
                DELETE FROM TBL_ESCALAS
                WHERE ID_ESCALA = REGISTRO.ID_ESCALA;
            END LOOP;
        
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
                INSERT INTO tbl_escalas (
                    id_escala,
                    id_vuelo_padre,
                    id_vuelo
                ) SELECT 
                    a.id_escala,
                    a.id_vuelo_padre,
                    a.id_vuelo
                FROM TBL_ESCALAS@DB_LINK_AEROLINEA A
                INNER JOIN TBL_VUELOS@DB_LINK_AEROLINEA B
                ON (A.ID_VUELO_PADRE = B.ID_VUELO)
                WHERE TRUNC(B.FECHA_PARTIDA) = TRUNC(V_FECHA_INICIO);
                
                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE ESCALAS FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK; 
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_ESCALAS;
        
        
------------------------------------INSERTAR LOS CLIENTES DE AEROLINEA EN DWH
        PROCEDURE P_ETL_CLIENTES
        AS
                V_GENERO VARCHAR2(1);
                V_INICIO_ETL DATE := SYSDATE;
        BEGIN
        
                FOR REGISTRO IN (
                    SELECT B.correo_electronico,
                            B.nombre,
                            B.apellido,
                            B.telefono,
                            B.contrasena,
                            C.genero,
                            A.fecha_registro
                    FROM TBL_CLIENTES@DB_LINK_AEROLINEA A
                    INNER JOIN TBL_PERSONAS@DB_LINK_AEROLINEA B
                    ON (A.ID_CLIENTE = B.ID_PERSONA)
                    INNER JOIN TBL_GENEROS@DB_LINK_AEROLINEA C
                    ON (B.ID_GENERO = C.ID_GENERO)) LOOP
                
                    V_GENERO := SUBSTR(REGISTRO.genero, 1, 1);
                    P_INSERT_CLIENTE(P_CORREO_ELECTRONICO=>REGISTRO.correo_electronico, 
                                        P_nombre =>REGISTRO.nombre ,
                                        P_apellido =>REGISTRO.apellido ,
                                        P_telefono =>REGISTRO.telefono ,
                                        P_contrasena_aerolinea =>REGISTRO.contrasena ,
                                        P_GENERO => V_GENERO,
                                        P_fecha_registro =>REGISTRO.fecha_registro );
                
                END LOOP;
                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE CLIENTES FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK; 
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_CLIENTES;

-------------------------------------------------EXTRACCION INCREMENTAL BOLETOS
        PROCEDURE P_ETL_BOLETOS
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
            -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT MAX(FECHA_BOLETO) + 1
            INTO V_FECHA_INICIO
            FROM TBL_BOLETOS;

            IF (V_FECHA_INICIO IS NULL) THEN
                SELECT MIN(FECHA_BOLETO)
                INTO V_FECHA_INICIO
                FROM TBL_BOLETOS@DB_LINK_AEROLINEA;
            END IF;
            
            DELETE FROM TBL_BOLETOS
            WHERE TRUNC(FECHA_BOLETO) = TRUNC(V_FECHA_INICIO);
        
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
                
                INSERT INTO tbl_boletos (
                    id_boleto,
                    id_asiento,
                    id_vuelo,
                    id_escala,
                    correo_electronico,
                    precio,
                    estado_reserva,
                    fecha_boleto
                ) SELECT
                    A.id_boleto,
                    B.id_asiento,
                    E.id_vuelo,
                    F.id_escala,
                    D.correo_electronico,
                    A.precio,
                    H.estado_reserva,
                    A.fecha_boleto
                FROM TBL_BOLETOS@DB_LINK_AEROLINEA A
                INNER JOIN TBL_ASIENTOS@DB_LINK_AEROLINEA B
                ON (A.ID_ASIENTO = B.ID_ASIENTO)
                INNER JOIN TBL_CLIENTES@DB_LINK_AEROLINEA C
                ON (A.ID_CLIENTE = C.ID_CLIENTE)
                INNER JOIN TBL_PERSONAS@DB_LINK_AEROLINEA D
                ON (C.ID_CLIENTE = D.ID_PERSONA)
                LEFT JOIN TBL_VUELOS@DB_LINK_AEROLINEA E
                ON (A.ID_VUELO = E.ID_VUELO)
                LEFT JOIN TBL_ESCALAS@DB_LINK_AEROLINEA F
                ON (A.ID_ESCALA = F.ID_ESCALA)
                LEFT JOIN TBL_RESERVAS@DB_LINK_AEROLINEA G
                ON (A.ID_RESERVA = G.ID_RESERVA)
                LEFT JOIN TBL_ESTADO_RESERVA@DB_LINK_AEROLINEA H
                ON (G.ID_ESTADO_RESERVA = H.ID_ESTADO_RESERVA)
                WHERE TRUNC(FECHA_BOLETO) = TRUNC(V_FECHA_INICIO);
                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE BOLETOS FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_BOLETOS;
        
-----------------------------------------------EXTRACCION VOLATIL DE SERVICIOS
        PROCEDURE P_ETL_SERVICIOS
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
        
                    INSERT INTO tbl_servicios (
                        id_servicio_aerolinea,
                        id_servicio_hotel,
                        servicio,
                        costo,
                        tipo_servicio
                    ) SELECT
                        id_servicio_adicional,
                        NULL,
                        servicio,
                        precio,
                        NULL
                    FROM TBL_SERVICIOS_ADICIONALES@DB_LINK_AEROLINEA;
        
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE SERVICIOS FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_SERVICIOS;
        
----------------------------------------------EXTRACCION INCREMENTAL FACTURAS
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
                SELECT MIN(FECHA_FACTURA)
                INTO V_FECHA_INICIO
                FROM TBL_FACTURAS@DB_LINK_AEROLINEA;
            END IF;
            
            DELETE FROM TBL_FACTURAS
            WHERE TRUNC(FECHA_FACTURA) = TRUNC(V_FECHA_INICIO);
        
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
            
                INSERT INTO tbl_facturas (
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
                    A.fecha_factura,
                    A.impuesto_porcentaje,
                    A.impuesto_valor,
                    A.total,
                    B.metodo_pago
                FROM TBL_FACTURAS@DB_LINK_AEROLINEA A
                INNER JOIN TBL_METODO_PAGO@DB_LINK_AEROLINEA B
                ON (A.ID_METODO_PAGO = B.ID_METODO_PAGO)
                WHERE TRUNC(A.FECHA_FACTURA) = TRUNC(V_FECHA_INICIO);        
                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE FACTURAS FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_FACTURAS;
        
        
-----------------------------------------------EXTRACCION INCREMENTAL EQUIPAJES 
        PROCEDURE P_ETL_EQUIPAJES
        AS
            V_FECHA_INICIO DATE;
            V_FECHA_FIN DATE := SYSDATE - 1;
            V_VAL_EXTRACCION NUMBER;
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                    -----VERIFICAMOS LA ULTIMA EXTRACCION
            SELECT COUNT(1)
            INTO V_VAL_EXTRACCION
            FROM TBL_FACTURA_BOLETOS;
            
            IF (V_VAL_EXTRACCION <= 0) THEN
                SELECT MIN(FECHA_FACTURA)
                INTO V_FECHA_INICIO
                FROM TBL_FACTURAS@DB_LINK_AEROLINEA;
            ELSE      
                SELECT MAX(FECHA_FACTURA) + 1
                INTO V_FECHA_INICIO
                FROM TBL_FACTURAS;
            END IF;
            
            WHILE V_FECHA_INICIO <= V_FECHA_FIN LOOP
        
                        INSERT INTO tbl_equipajes (
                            id_equipaje,
                            tipo_equipaje,
                            peso,
                            costo
                        ) SELECT
                            A.id_equipaje,
                            B.tipo_equipaje,
                            SUM(A.PESO_ADICIONAL + B.PESO),
                            SUM(A.COSTO_ADICIONAL + B.COSTO)
                        FROM TBL_EQUIPAJES@DB_LINK_AEROLINEA A
                        INNER JOIN TBL_TIPOS_EQUIPAJE@DB_LINK_AEROLINEA B
                        ON (A.ID_TIPO_EQUIPAJE = B.ID_TIPO_EQUIPAJE)
                        INNER JOIN TBL_EQUIPAJES_POR_BOLETO@DB_LINK_AEROLINEA C
                        ON (A.ID_EQUIPAJE = C.ID_EQUIPAJE)
                        INNER JOIN TBL_FACTURA_BOLETOS@DB_LINK_AEROLINEA D
                        ON (C.ID_BOLETO_FACTURA = D.ID_BOLETO_FACTURA)
                        INNER JOIN TBL_FACTURAS@DB_LINK_AEROLINEA E
                        ON (D.ID_FACTURA = E.ID_FACTURA)
                        WHERE TRUNC(E.FECHA_FACTURA) = TRUNC(V_FECHA_INICIO)
                        GROUP BY A.id_equipaje, B.tipo_equipaje;
                                
                V_FECHA_INICIO := V_FECHA_INICIO + 1;
            END LOOP;
            
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE EQUIPAJES FINALIZADA');
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'SUCCESS');
                COMMIT;
            EXCEPTION 
                WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
                ROLLBACK;
                P_INSERT_LOG(P_nombre => $$PLSQL_UNIT,
                                P_fecha_inicio => V_INICIO_ETL,
                                P_nombre_base => 'BASE',
                                P_exito => 'FAIL');
        END P_ETL_EQUIPAJES;


END PCK_ETLS_AEROLINEA;