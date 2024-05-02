----------------------------------------------EXTRACCION VOLATIL POLITICAS

----------------------------------------------EXTRACCION VOLATIL POLITICAS POR HOTEL
CREATE OR REPLACE PROCEDURE P_ETL_POLITICAS_POR_HOTEL
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                EXECUTE IMMEDIATE 'TRUNCATE TABLE tbl_politicas_x_hotel';
                
                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;
                INSERT INTO SUCURSALES SELECT * FROM SUCURSALES@SQLSERVER_BD;
                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;
                INSERT INTO HOTELES SELECT * FROM HOTELES@SQLSERVER_BD;

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

                
                DBMS_OUTPUT.PUT_LINE('EXTRACCION DE HABITACIONES FINALIZADA');
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
        
----------------------------------------------EXTRACCION VOLATIL HOTELES

----------------------------------------------EXTRACCION VOLATIL POLITICAS POR HOTEL 

----------------------------------------------EXTRACCION INCREMENTAL EVALUACIONES POR HOTEL

----------------------------------------------EXTRACCION VOLATIL SERVICIOS POR HOTEL 

----------------------------------------------EXTRACCION VOLATIL AMENIDADES POR HOTEL 