CREATE GLOBAL TEMPORARY TABLE tipos_servicios (
    id_tipo INT,
    tipo_servicio VARCHAR(100)
) ON COMMIT DELETE ROWS;
        
CREATE GLOBAL TEMPORARY TABLE servicios (
    id_servicio VARCHAR(50),
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

CREATE GLOBAL TEMPORARY TABLE sucursales(
	id_sucursal INT,
	reembolsable VARCHAR(1),
	descripcion VARCHAR(500),
	telefono VARCHAR(50),
	correo VARCHAR(50),
	id_hotel INT,
	id_direccion INT
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE politicas_sucursal(
	id INT,
	id_sucursal INT,
	id_politica INT
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE hoteles(
	id_hotel INT,
	nombre VARCHAR(50),
	telefono VARCHAR(50),
	correo VARCHAR(50),
	descripcion VARCHAR(500),
	sitio_web VARCHAR(100)
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE servicios_sucursales(
	id INT,
	id_servicio VARCHAR(50),
	id_sucursal INT
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE direcciones(
	id_direccion INT,
	referencia VARCHAR(50),
	id_ciudad INT
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE paises(
	id_pais INT,
	nombre_pais VARCHAR(50)
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE ciudades(
	id_ciudad INT,
	nombre_ciudad VARCHAR(50),
	id_pais INT
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE politicas(
	id_politica INT,
	politica VARCHAR(500)
)ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE clientes(
	id_cliente INT,
	fecha_registro VARCHAR(20),
	usuario VARCHAR(50),
	contrasenia VARCHAR(50),
	id_persona INT
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE personas(
	id_persona INT,
	nombre  VARCHAR(100),
	apellido VARCHAR(100),
	no_identidad VARCHAR(100),
	correo VARCHAR(50),
	telefono VARCHAR(50),
	id_estado_civil INT,
	id_genero INT,
	id_direccion INT
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE generos(
	id_genero INT,
	genero VARCHAR(50)
) ON COMMIT DELETE ROWS;


CREATE GLOBAL TEMPORARY TABLE reservaciones(
	id_reservacion INT,
	fecha_reservacion VARCHAR(20),
	fecha_inicio VARCHAR(20),
	fecha_fin VARCHAR(20),
	id_cliente INT,
	id_habitacion INT,
	pagado CHAR(1),
	activa CHAR(1)
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE facturas(
	id_factura VARCHAR(50),
	fecha VARCHAR(20),
	subtotal DECIMAL(10,2),
	impuesto DECIMAL(10,2),
	total DECIMAL(10,2),
	id_cliente INT,
	id_forma_pago INT NOT NULL
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE detalle_factura(
	id INT,
	id_factura VARCHAR(50),
	id_reservacion INT
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE formas_de_pago(
	id_forma_pago INT,
	forma_de_pago VARCHAR(100)
) ON COMMIT DELETE ROWS;

CREATE GLOBAL TEMPORARY TABLE evaluaciones_hotel (
	id_evaluacion INT,
    limpieza INT,
    servicio_y_personal INT,
    condiciones_propiedad INT,
    cuidado_medio_ambiente INT,
    calificacion_promedio INT,
	fecha_evaluacion VARCHAR(20),
	id_cliente INT,
	id_sucursal INT,
	sugerencias VARCHAR(1000)
) ON COMMIT DELETE ROWS;