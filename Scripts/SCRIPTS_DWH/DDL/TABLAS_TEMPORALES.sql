CREATE GLOBAL TEMPORARY TABLE tipos_servicios (
    id_tipo INT,
    tipo_servicio VARCHAR(100)
) ON COMMIT DELETE ROWS;
        
CREATE GLOBAL TEMPORARY TABLE servicios (
    id_servicio INT,
    servicio VARCHAR(500),
    descripcion VARCHAR(500),
    id_tipo INT
) ON COMMIT DELETE ROWS;