
CREATE OR REPLACE PROCEDURE SP_ETL_AMENIDADES_X_HABITACION
        AS
            V_INICIO_ETL DATE:= SYSDATE;
        BEGIN
                
                INSERT INTO AMENIDADES_HABITACIONES SELECT * FROM AMENIDADES_HABITACIONES@SQLSERVER_BD;
                INSERT INTO AMENIDADES_HABITACIONES SELECT * FROM AMENIDADES_HABITACIONES@SQLSERVER_BD;
                
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
    
    begin
        SP_ETL_AMENIDADES_X_HABITACION;
    end;

select * from tbl_AMENIDADES_X_HABITACION;