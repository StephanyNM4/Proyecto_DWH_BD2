CREATE OR REPLACE PROCEDURE P_INSERT_LOG(P_nombre VARCHAR2,
    P_fecha_inicio DATE,
    P_nombre_base VARCHAR2,
    P_exito VARCHAR) AS
BEGIN
    INSERT INTO tbl_logs (
        nombre,
        fecha_inicio,
        fecha_final,
        nombre_base,
        exito
    ) VALUES (
        P_nombre,
        P_fecha_inicio,
        SYSDATE,
        P_nombre_base,
        P_exito
    );
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: '|| SQLERRM);
END;

--INSERT
BEGIN
    P_INSERT_LOG(P_nombre => 'NOMBRE_PROCEDIMIENTO',
    P_fecha_inicio => SYSDATE, --CAPTURAR LA FECHA CUANDO INICIE EL ETL
    P_nombre_base => 'BASE',
    P_exito => 'SUCCESS'); --'FAIL' si falla
END;


