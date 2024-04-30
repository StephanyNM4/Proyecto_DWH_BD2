SET SERVEROUTPUT ON;
----EXTRACCION INCREMENTAL DE VUELOS
CREATE OR REPLACE PROCEDURE P_ETL_VUELOS
AS
    V_FECHA_INICIO DATE;
    V_FECHA_FIN DATE := SYSDATE - 1;
BEGIN

    ----VERIFICAMOS LA ULTIMA EXTRACCION REALIZADA
    SELECT MAX(FECHA_PARTIDA) + 1
    INTO V_FECHA_INICIO
    FROM TBL_VUELOS;
        DBMS_OUTPUT.PUT_LINE('1');

    IF (V_FECHA_INICIO IS NULL) THEN
        SELECT MIN(FECHA_PARTIDA)
        INTO V_FECHA_INICIO
        FROM TBL_VUELOS@DB_LINK_AEROLINEA;
                DBMS_OUTPUT.PUT_LINE('2');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('FECHA INICIO: ' ||V_FECHA_INICIO);
    DBMS_OUTPUT.PUT_LINE('FECHA FINNN: ' ||V_FECHA_FIN);
    
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
            DBMS_OUTPUT.PUT_LINE('3');
        
        COMMIT;
        V_FECHA_INICIO := V_FECHA_INICIO + 1;
    END LOOP;
        DBMS_OUTPUT.PUT_LINE('4');
END;


BEGIN
    P_ETL_VUELOS;
END;

---------------------EXTRACCION VOLATIL DE ASIENTOS
CREATE OR REPLACE PROCEDURE P_ETL_ASIENTOS
AS
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
        
                DBMS_OUTPUT.PUT_LINE('SE INSERTO');
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
        ROLLBACK; 
END;

BEGIN
    P_ETL_ASIENTOS;
END;


------------------INSERTAR ESCALAS
CREATE OR REPLACE PROCEDURE P_ETL_ESCALAS
AS
    V_FECHA_INICIO DATE;
    V_FECHA_FIN DATE := SYSDATE - 1;
BEGIN
    -----VERIFICAMOS LA ULTIMA EXTRACCION
    SELECT MAX(FECHA_PARTIDA) + 1
    INTO V_FECHA_INICIO
    FROM TBL_VUELOS;
    
    -----
    IF (V_FECHA_INICIO IS NULL) THEN
        SELECT MIN(FECHA_PARTIDA)
        INTO V_FECHA_INICIO
        FROM TBL_VUELOS@DB_LINK_AEROLINEA;
    END IF;
    
    -----ELIMINAMOS ESCALAS
    FOR REGISTRO IN REVERSE (SELECT A.ID_ESCALA, B.FECHA_PARTIDA FROM TBL_ESCALAS@DB_LINK_AEROLINEA A INNER JOIN TBL_VUELOS@DB_LINK_AEROLINEA B
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
            id_escala,
            id_vuelo_padre,
            id_vuelo
        FROM TBL_ESCALAS@DB_LINK_AEROLINEA A
        INNER JOIN TBL_VUELOS@DB_LINK_AEROLINEA B
        ON (A.ID_VUELO_PADRE = B.ID_VUELO)
        WHERE TRUNC(B.FECHA_PARTIDA) = TRUNC(V_FECHA_INICIO);
        
        V_FECHA_INICIO := V_FECHA_INICIO + 1;
    END LOOP;
END;


---------EXTRACCION INCREMENTAL FACTURAS
CREATE SEQUENCE SEQ_FACTURAS_DWH INCREMENT BY 1 START WITH 0 MAXVALUE 1000000000 MINVALUE 0;
CREATE OR REPLACE PROCEDURE P_ETL_FACTURAS
AS
    V_FECHA_INICIO DATE;
    V_FECHA_FIN DATE := SYSDATE - 1;
BEGIN
    -----VERIFICAMOS LA ULTIMA EXTRACCION
    SELECT MAX(FECHA_FACTURA) + 1
    INTO V_FECHA_INICIO
    FROM TBL_FACTURAS;
    
    -----
    IF (V_FECHA_INICIO IS NULL) THEN
        SELECT MIN(FECHA_FACTURA)
        INTO V_FECHA_INICIO
        FROM TBL_FACTURAS@DB_LINK_AEROLINEA;
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
            SEQ_FACTURAS_DWH.NEXTVAL,
            id_factura,
            NULL,
            fecha_factura,
            impuesto_porcentaje,
            impuesto_valor,
            total,
            B.metodo_pago
        FROM TBL_FACTURAS@DB_LINK_AEROLINEA A
        INNER JOIN TBL_METODO_PAGO@DB_LINK_AEROLINEA B
        ON (A.ID_METODO_PAGO = B.ID_METODO_PAGO)
        WHERE TRUNC(A.FECHA_FACTURA) = TRUNC(V_FECHA_INICIO);
         
        COMMIT;
        V_FECHA_INICIO := V_FECHA_INICIO + 1;
    END LOOP;
END;

BEGIN
    P_ETL_FACTURAS;
END;

-------------------------EXTRACCION VOLATIL CLIENTES
CREATE OR REPLACE PROCEDURE P_ETL_CLIENTES
AS
BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_clientes';
        
        INSERT INTO tbl_clientes (
            correo_electronico,
            nombre,
            apellido,
            telefono,
            contrasena_uber,
            contrasena_hotel,
            contrasena_aerolinea,
            genero,
            fecha_registro
        ) SELECT
            B.correo_electronico,
            B.nombre,
            B.apellido,
            B.telefono,
            NULL,
            NULL,
            B.contrasena,
            SUBSTR(C.genero, 1, 1),
            A.fecha_registro
        FROM TBL_CLIENTES@DB_LINK_AEROLINEA A
        INNER JOIN TBL_PERSONAS@DB_LINK_AEROLINEA B
        ON (A.ID_CLIENTE = B.ID_PERSONA)
        INNER JOIN TBL_GENEROS@DB_LINK_AEROLINEA C
        ON (B.ID_GENERO = C.ID_GENERO);
        
        
                DBMS_OUTPUT.PUT_LINE('SE INSERTO CLIENTES');
        COMMIT;
    EXCEPTION 
        WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
        ROLLBACK; 
END;

BEGIN
    P_ETL_CLIENTES;
END;

-------------------------EXTRACCION INCREMENTAL BOLETOS
CREATE OR REPLACE PROCEDURE P_ETL_BOLETOS
AS
    V_FECHA_INICIO DATE;
    V_FECHA_FIN DATE := SYSDATE - 1;
BEGIN
    -----VERIFICAMOS LA ULTIMA EXTRACCION
    SELECT MAX(FECHA_BOLETO) + 1
    INTO V_FECHA_INICIO
    FROM TBL_BOLETOS;
    
    -----
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
        
        COMMIT;
        V_FECHA_INICIO := V_FECHA_INICIO + 1;
    END LOOP;
END;

BEGIN
    P_ETL_BOLETOS;
END;











TBL_CLIENTES
---------------------------------------IGNORAR (PRUEBAS)
SELECT * FROM TBL_VUELOS;  ---1015
SELECT * FROM TBL_ASIENTOS; -----1757
SELECT * FROM TBL_FACTURAS;  ----500
SELECT * FROM TBL_CLIENTES;  ----20
SELECT * FROM TBL_BOLETOS;  ----994
SELECT * FROM TBL_VUELOS@DB_LINK_AEROLINEA;  ---1101
SELECT * FROM TBL_ASIENTOS@DB_LINK_AEROLINEA;  -----1757
SELECT * FROM TBL_FACTURAS@DB_LINK_AEROLINEA; ----500
SELECT * FROM TBL_CLIENTES@DB_LINK_AEROLINEA;  ----20
SELECT * FROM TBL_BOLETOS@DB_LINK_AEROLINEA;  ----994


SELECT * FROM TBL_AVIONES@DB_LINK_AEROLINEA;
SELECT * FROM TBL_ESCALAS@DB_LINK_AEROLINEA;


SELECT *
FROM TBL_VUELOS@DB_LINK_AEROLINEA C
INNER JOIN TBL_AVIONES@DB_LINK_AEROLINEA A
ON (C.ID_AEROLINEA = A.ID_AEROLINEA)
LEFT JOIN (SELECT DISTINCT(ID_AEROLINEA)
            FROM TBL_AEROLINEAS@DB_LINK_AEROLINEA) B
ON (b.ID_AEROLINEA = a.ID_AEROLINEA)
INNER JOIN TBL_MODELOS_aVIONES@DB_LINK_AEROLINEA D
ON (B.ID_MODELO = D.ID_MODELO);

SELECT *
FROM TBL_AVIONES@DB_LINK_AEROLINEA A
LEFT JOIN (
    SELECT DISTINCT *
    FROM TBL_AEROLINEAS@DB_LINK_AEROLINEA
) B
ON B.ID_AEROLINEA = A.ID_AEROLINEA;

SET SERVEROUTPUT ON;
        SELECT *
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
        WHERE TRUNC(A.FECHA_PARTIDA) = TRUNC(SYSDATE);

SELECT MAX(FECHA_FACTURA) MAYOR, MIN(FECHA_FACTURA) MENOR FROM TBL_FACTURAS@DB_LINK_AEROLINEA; 

SELECT A.ID_ESCALA, B.FECHA_PARTIDA
FROM TBL_ESCALAS@DB_LINK_AEROLINEA A
INNER JOIN TBL_VUELOS@DB_LINK_AEROLINEA B
ON (A.ID_VUELO_PADRE = B.ID_VUELO)
WHERE TRUNC(B.FECHA_PARTIDA) = TRUNC(SYSDATE);

TRUNCATE TABLE TBL_VUELOS;


