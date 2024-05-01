---------------------------------------------------------------INSERTA  1100 VUELOS
CREATE OR REPLACE PROCEDURE P_INSERTAR_VUELOS
AS
    V_CONT NUMBER := 0; 
BEGIN
    WHILE V_CONT <= 1100 LOOP
        INSERT INTO tbl_vuelos (
            id_vuelo,
            id_aerolinea,
            id_ruta,
            id_tipo_vuelo,
            id_aeropuerto_partida,
            id_aeropuerto_llegada,
            id_oferta,
            fecha_partida,
            numero_vuelo,
            hora_llegada,
            hora_partida,
            gate
        ) VALUES (
            SEQ_VUELOS.NEXTVAL,
            ROUND(DBMS_RANDOM.VALUE(1, 10)),
            ROUND(DBMS_RANDOM.VALUE(1, 24)),
            ROUND(DBMS_RANDOM.VALUE(1, 2)),
            ROUND(DBMS_RANDOM.VALUE(1, 30)),
            ROUND(DBMS_RANDOM.VALUE(1, 30)),
            NULL,
            SYSDATE + ROUND(DBMS_RANDOM.VALUE(-600, 50)) ,
            ROUND(DBMS_RANDOM.VALUE(1400, 8000)),
            '00:00:00',
            '00:00:00',
            ROUND(DBMS_RANDOM.VALUE(1, 300))
        );
        V_CONT := V_CONT + 1;
    END LOOP;
END;

--------------------------------------------------------------INSERTA 250 ASIENTOS EN 6 PRIMEROS VUELOS
CREATE OR REPLACE PROCEDURE P_INSERTAR_ASIENTOS
AS
    V_CONT NUMBER := 0;
    V_VUELOS NUMBER := 0;
BEGIN
    WHILE V_VUELOS <= 6 LOOP
        WHILE V_CONT <= 250 LOOP
            INSERT INTO tbl_asientos (
                id_asiento,
                id_tipo_asiento,
                id_vuelo,
                nombre_asiento,
                disponible
            ) VALUES (
                SEQ_ASIENTOS.NEXTVAL,
                ROUND(DBMS_RANDOM.VALUE(1, 3)), 
                V_VUELOS, 
                'A' || V_CONT, 
                1
            );
            V_CONT := V_CONT + 1;
        END LOOP;
    
    V_VUELOS := V_VUELOS + 1;
    V_CONT := 0;
    END LOOP;
END;

----------------------------------------------------------
-----PROCEDIMIENTO ALMACENADO QUE INSERTA 500 FACTURAS, EN LAS CUALES INSERTA 
-----UN ALEATORIO DE ENTRE 1 A 3 BOLETOS POR FATURA, GENERANDO LOS BOLETOS PARA CADA UNA,
-----CAMBIA EL ESTADO DE LOS ASIENTOS DE VUELO PARA LOS BOLETOS A COMPRAR, 
-----INSERTA EN TABLA BOLETO-FACTURA PARA RELACIONAR CADA BOLETO CON SU FACTURA
-----GENERA DE ENTRE 1 A 4 SERVICIOS ADICIONALES POR BOLETO
-----INSERTA DE ENTRE 1 A 2 EQUIPAJES POR BOLETO
-----INSERTA EN LA TABLA DE EQUIPAJES POR BOLETO PARA RELACIONAR CADA EQUIPAJE CON SU BOLETO
CREATE OR REPLACE PROCEDURE P_INSERTAR_BOLETOS
AS
    V_NUMERO NUMBER;
    V_CONT_BOLETOS_FACTURA NUMBER := 0;
    V_CONT_BOLETOS_TOTAL NUMBER := 0;
    V_PRECIO NUMBER;
    V_PRECIO_TOTAL NUMBER := 0;
    V_CLIENTE NUMBER;
    V_ID_VUELO NUMBER := 0;
    V_ID_BOLETO NUMBER;
    V_ID_FACTURA VARCHAR2(50);
    V_ID_BOLETO_FACTURA NUMBER;
    V_CONT_SERVICIOS NUMBER := 0;
    V_SERVICIOS VARCHAR2(50);
    V_CONT_EQUIPAJES NUMBER := 0;
    V_EQUIPAJES NUMBER;
    V_ID_ASIENTO NUMBER := 0;
    V_FECHA_FACTURA DATE := SYSDATE -1500;
BEGIN
        ---GENERA CANTIDAD DE BOLETOS TOTAL
        WHILE V_CONT_BOLETOS_TOTAL < 500 LOOP          
        
        -------INICIALIZACION DE VARIABLES
        V_CONT_BOLETOS_FACTURA := 0;                   ---CONTADOR PARA BOLETOS POR FACTURA
        V_NUMERO := ROUND(DBMS_RANDOM.VALUE(1, 3));   ---CANTIDAD DE BOLETOS A COMPRAR
        V_CLIENTE := ROUND(DBMS_RANDOM.VALUE(4, 20));  ----CLIENTE QUE COMPRA LOS BOLETOS
        V_PRECIO := ROUND(DBMS_RANDOM.VALUE(1000, 4000));--PRECIO BOLETO
        V_ID_FACTURA := 'A_' || SEQ_ID_FACTURAS.NEXTVAL;

        ----------------GENERA FACTURA
            INSERT INTO tbl_facturas (
                id_factura,
                id_metodo_pago,
                fecha_factura,
                impuesto_porcentaje,
                impuesto_valor,
                total
            ) VALUES (
                V_ID_FACTURA,
                ROUND(DBMS_RANDOM.VALUE(1, 2)),
                V_FECHA_FACTURA,
                15,
                NULL,
                NULL
            );
            
            ----------------------------------GENERA LOS BOLETOS POR FACTURA
            WHILE V_CONT_BOLETOS_FACTURA < V_NUMERO LOOP  
            
                ------INICIALIZACION DE VARIABLES
                V_ID_BOLETO := SEQ_ID_BOLETOS.NEXTVAL;
                V_ID_BOLETO_FACTURA := SEQ_ID_BOLETOS_FACTURAS.NEXTVAL;
                V_SERVICIOS := ROUND(DBMS_RANDOM.VALUE(1, 4));
                V_EQUIPAJES := ROUND(DBMS_RANDOM.VALUE(1, 2));
                V_CONT_SERVICIOS := 0;
                V_CONT_EQUIPAJES := 0;
                V_ID_ASIENTO := V_ID_ASIENTO + 1;
                
                -----GENERA BOLETO
                INSERT INTO tbl_boletos (
                    id_boleto,
                    id_asiento,
                    id_cliente,
                    id_vuelo,
                    id_escala,
                    id_reserva,
                    precio,
                    fecha_boleto
                ) VALUES (
                    V_ID_BOLETO,
                    V_ID_BOLETO,
                    V_CLIENTE,
                    V_ID_VUELO,
                    NULL,
                    NULL,
                    V_PRECIO,
                    V_FECHA_FACTURA
                );
            
            ----------------CAMBIAR DISPONIBILIDAD DE ASIENTO
                UPDATE tbl_asientos
                SET DISPONIBLE = 0
                WHERE id_asiento = V_ID_BOLETO;
            
                ---------------GENERA BOLETO-FACTURA
                    INSERT INTO tbl_factura_boletos (
                        id_boleto_factura,
                        id_factura,
                        id_boleto,
                        subtotal
                    ) VALUES (
                        V_ID_BOLETO_FACTURA,
                        V_ID_FACTURA,
                        V_ID_BOLETO,
                        V_PRECIO
                    );

                V_PRECIO_TOTAL := V_PRECIO_TOTAL + V_PRECIO;
                
            ---------GENERAR SERVICIOS ADICIONALES POR BOLETO
                    WHILE V_CONT_SERVICIOS < V_SERVICIOS LOOP
                        INSERT INTO tbl_servicios_por_boleto (
                            id_servicio_adicional,
                            id_boleto_factura
                        ) VALUES (
                            'A_' || ROUND(DBMS_RANDOM.VALUE(1, 30)),
                            V_ID_BOLETO_FACTURA
                        );
                        V_CONT_SERVICIOS := V_CONT_SERVICIOS + 1;
                    END LOOP;  
            
            
            ---------GENERAR EQUIPAJES POR BOLETO
                    WHILE V_CONT_EQUIPAJES < V_EQUIPAJES LOOP
                    
                        ----------EQUIPAJE
                        INSERT INTO tbl_equipajes (
                            id_equipaje,
                            id_tipo_equipaje,
                            peso_adicional,
                            costo_adicional
                        ) VALUES (
                            SEQ_ID_EQUIPAJES.NEXTVAL,
                            ROUND(DBMS_RANDOM.VALUE(1, 4)),
                            NULL,
                            NULL
                        );
                    
                    ----------EQUIPAJE POR BOLETO
                        INSERT INTO tbl_equipajes_por_boleto (
                            id_equipaje,
                            id_boleto_factura
                        ) VALUES (
                            SEQ_ID_EQUIPAJES.CURRVAL,
                            V_ID_BOLETO_FACTURA
                        );
                        
                        V_CONT_EQUIPAJES := V_CONT_EQUIPAJES + 1;
                        
                        -----CAMBIAMOS DE VUELO POR CANTIDAD DE ASIENTOS LLENA
                        IF( V_ID_ASIENTO >= 250) THEN
                            V_ID_ASIENTO := 0;
                            V_ID_VUELO := V_ID_VUELO + 1;
                        END IF;
                        
                    END LOOP; 
                
                V_FECHA_FACTURA := V_FECHA_FACTURA + 1;
                V_CONT_BOLETOS_FACTURA := V_CONT_BOLETOS_FACTURA + 1;
        END LOOP;
        
        ----------------AGREGAR PRECIOS
            UPDATE TBL_FACTURAS
            SET impuesto_valor = ROUND(V_PRECIO_TOTAL * 0.15)
            WHERE ID_FACTURA = V_ID_FACTURA;
        
            UPDATE TBL_FACTURAS
            SET TOTAL = ROUND(V_PRECIO_TOTAL + (V_PRECIO_TOTAL * 0.15))
            WHERE ID_FACTURA = V_ID_FACTURA;
        V_PRECIO_TOTAL := 0;
        V_CONT_BOLETOS_TOTAL := V_CONT_BOLETOS_TOTAL + 1;
    END LOOP;   
END;

----------------------------------------INSERTAR
BEGIN
    P_INSERTAR_VUELOS;
END;

BEGIN
    P_INSERTAR_ASIENTOS;
END;

BEGIN
    P_INSERTAR_BOLETOS;
END;

COMMIT;
