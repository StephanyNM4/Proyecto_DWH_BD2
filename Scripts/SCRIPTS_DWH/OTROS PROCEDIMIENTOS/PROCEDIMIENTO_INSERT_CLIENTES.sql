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
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR=> '|| SQLERRM);
END;

--INSERT PARA UBER
BEGIN
    P_INSERT_CLIENTE(P_CORREO_ELECTRONICO=> 'tommy_matamoros@gmail.com',
                    P_nombre => 'Tommy',
                    P_apellido =>'Matamoros',
                    P_telefono => '+111222333',
                    P_contrasena_uber => '1234',
                    P_fecha_registro => to_date('12/10/24', 'DD/MM/YY'));
    
END;

--INSERT HOTEL
BEGIN
    P_INSERT_CLIENTE(P_CORREO_ELECTRONICO=> 'tommy_matamoros@gmail.com',
                    P_nombre => 'Tommy',
                    P_apellido =>'Matamoros',
                    P_telefono => '+111222333',
                    P_contrasena_hotel => '8910',
                    P_GENERO => 'F',
                    P_fecha_registro => to_date('12/10/24', 'DD/MM/YY'));
    
END;

--INSERT AEROLINEA
BEGIN
    P_INSERT_CLIENTE(P_CORREO_ELECTRONICO=> 'tommy_matamoros@gmail.com',
                    P_nombre => 'Tommy',
                    P_apellido =>'Matamoros',
                    P_telefono => '+111222333',
                    P_contrasena_aerolinea => '10112',
                    P_GENERO => 'F',
                    P_fecha_registro => to_date('12/10/24', 'DD/MM/YY'));
    
END;