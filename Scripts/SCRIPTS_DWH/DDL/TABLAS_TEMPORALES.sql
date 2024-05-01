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

CREATE GLOBAL TEMPORARY TABLE amenidades (
    id_amenidad INT,
    amenidad VARCHAR(500),
    id_categoria INT
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE categorias_amenidades (
    id_categoria INT,
    categoria VARCHAR(100)
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE habitaciones(
	id_habitacion INT,
	codigo VARCHAR(50),
	precio DECIMAL(10,2),
	limite_personas INT,
	cantidad_camas INT,
	id_sucursal INT,
	descripcion VARCHAR(100),
	disponible VARCHAR(1)
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE amenidades_habitaciones(
	id INT,
	id_amenidad INT,
	id_habitacion INT
)ON COMMIT DELETE ROWS;