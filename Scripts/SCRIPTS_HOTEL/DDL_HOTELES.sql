
CREATE DATABASE hoteles4;
GO
USE hoteles4;
GO

CREATE TABLE paises(
	id_pais INT IDENTITY PRIMARY KEY,
	nombre_pais VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE ciudades(
	id_ciudad INT IDENTITY PRIMARY KEY,
	nombre_ciudad VARCHAR(50) NOT NULL,
	id_pais INT NOT NULL,

	CONSTRAINT fk_ciudad_pais FOREIGN KEY (id_pais) REFERENCES paises (id_pais),
	CONSTRAINT uq_ciudad UNIQUE(nombre_ciudad, id_pais)
);
GO

CREATE TABLE direcciones(
	id_direccion INT IDENTITY PRIMARY KEY,
	referencia VARCHAR(50),
	id_ciudad INT NOT NULL

	CONSTRAINT fk_direccion_ciudad FOREIGN KEY (id_ciudad) REFERENCES ciudades(id_ciudad),
	CONSTRAINT uq_direccion UNIQUE(referencia, id_ciudad)
);
GO

CREATE TABLE estados_civiles(
	id_estado_civil INT IDENTITY PRIMARY KEY,
	estado_civil VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE generos(
	id_genero INT IDENTITY PRIMARY KEY,
	genero VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE personas(
	id_persona INT IDENTITY PRIMARY KEY,
	nombre  VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	no_identidad VARCHAR(100) UNIQUE NOT NULL,
	correo VARCHAR(50),
	telefono VARCHAR(50),
	id_estado_civil INT NOT NULL,
	id_genero INT NOT NULL,
	id_direccion INT NOT NULL,

	CONSTRAINT fk_persona_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES estados_civiles(id_estado_civil),
	CONSTRAINT fk_persona_genero FOREIGN KEY (id_genero) REFERENCES generos(id_genero),
	CONSTRAINT fk_persona_direccion FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion)
);
GO

CREATE TABLE periodos_tiempo(
	id_periodo INT IDENTITY PRIMARY KEY,
	periodo VARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE turnos(
	id_turno INT IDENTITY PRIMARY KEY,
	hora_inicio TIME NOT NULL,
	hora_fin TIME NOT NULL,
	id_periodo INT NOT NULL,

	CONSTRAINT fk_turno_periodo FOREIGN KEY (id_periodo) REFERENCES periodos_tiempo(id_periodo),
	CONSTRAINT uq_periodo UNIQUE (hora_inicio, hora_fin, id_periodo)
);
GO

CREATE TABLE cargos(
	id_cargo INT IDENTITY PRIMARY KEY,
	cargo VARCHAR(100) UNIQUE NOT NULL
); 
GO

CREATE TABLE empleados(
	id_empleado INT IDENTITY PRIMARY KEY,
	codigo VARCHAR(50) UNIQUE NOT NULL,
	fecha_ingreso DATE NOT NULL DEFAULT GETDATE(),
	id_persona INT NOT NULL,

	CONSTRAINT fk_empleado_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);
GO

CREATE TABLE contratos(
	id_contrato INT IDENTITY PRIMARY KEY,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	salario_neto DECIMAL(10,2),
	id_cargo INT NOT NULL,
	id_empleado INT NOT NULL,

	CONSTRAINT fk_contrato_empleado FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
	CONSTRAINT fk_contrato_tipo FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo),
	CONSTRAINT uq_contrato UNIQUE (fecha_inicio, fecha_fin, id_empleado)
);
GO

CREATE TABLE deducciones_bonificaciones(
	id_ded_bon INT IDENTITY PRIMARY KEY,
	descripcion VARCHAR(50) UNIQUE NOT NULL,
	factor DECIMAL(5,2),
	porcentaje DECIMAL(5,2)
);
GO

CREATE TABLE ded_bon_contratos(
	id INT IDENTITY PRIMARY KEY,
	id_ded_bon INT NOT NULL,
	id_contrato INT NOT NULL,

	CONSTRAINT fk_ded_bon FOREIGN KEY (id_ded_bon) REFERENCES deducciones_bonificaciones(id_ded_bon),
	CONSTRAINT fk_contrato_d FOREIGN KEY (id_contrato) REFERENCES contratos(id_contrato),
	CONSTRAINT uq_ded_bon_contrato_c UNIQUE (id_ded_bon, id_contrato)
);
GO

CREATE TABLE contratos_turnos(
	id INT IDENTITY PRIMARY KEY,
	id_contrato INT NOT NULL,
	id_turno INT NOT NULL,

	CONSTRAINT fk_contrato_h FOREIGN KEY (id_contrato) REFERENCES contratos(id_contrato),
	CONSTRAINT fk_turno_c FOREIGN KEY (id_turno) REFERENCES turnos(id_turno),
	CONSTRAINT uq_turno_contrato UNIQUE (id_contrato, id_turno)
);
GO

CREATE TABLE clientes(
	id_cliente INT IDENTITY PRIMARY KEY,
	fecha_registro VARCHAR(20) NOT NULL DEFAULT FORMAT(GETDATE(), 'dd/MM/yy'),
	usuario VARCHAR(50) UNIQUE NOT NULL,
	contrasenia VARCHAR(50) NOT NULL,
	id_persona INT NOT NULL,

	CONSTRAINT fk_cliente_persona FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);
GO

CREATE TABLE hoteles(
	id_hotel INT IDENTITY PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	correo VARCHAR(50) NOT NULL,
	descripcion VARCHAR(500),
	sitio_web VARCHAR(100)
);
GO

CREATE TABLE sucursales(
	id_sucursal INT IDENTITY PRIMARY KEY,
	reembolsable BIT,
	descripcion VARCHAR(500),
	telefono VARCHAR(50),
	correo VARCHAR(50),
	id_hotel INT NOT NULL,
	id_direccion INT NOT NULL,

	CONSTRAINT fk_sucursal_hotel FOREIGN KEY (id_hotel) REFERENCES hoteles(id_hotel),
	CONSTRAINT fk_sucursal_direccion FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion),
	CONSTRAINT uq_sucursale UNIQUE (id_direccion, id_hotel)
);
GO

CREATE TABLE empleados_sucursales(
	id INT IDENTITY PRIMARY KEY,
	id_empleado INT NOT NULL,
	id_sucursal INT NOT NULL

	CONSTRAINT fk_empleado_sucursal FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
	CONSTRAINT fk_sucursal_empleado FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
	CONSTRAINT uq_empleadoss UNIQUE (id_empleado, id_sucursal)
);
GO

CREATE TABLE politicas(
	id_politica INT IDENTITY PRIMARY KEY,
	politica VARCHAR(500) UNIQUE NOT NULL,
);
GO

CREATE TABLE politicas_sucursal(
	id INT IDENTITY PRIMARY KEY,
	id_sucursal INT NOT NULL,
	id_politica INT NOT NULL,

	CONSTRAINT fk_sucursal_p FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
	CONSTRAINT fk_politica_s FOREIGN KEY (id_politica) REFERENCES politicas(id_politica),	
	CONSTRAINT uq_politica_sucursal UNIQUE (id_sucursal, id_politica)
);
GO

CREATE TABLE tipos_servicios(
	id_tipo INT IDENTITY PRIMARY KEY,
	tipo_servicio VARCHAR(100) UNIQUE NOT NULL
);
GO

CREATE TABLE servicios(
	id_servicio VARCHAR(50) PRIMARY KEY,
	servicio VARCHAR(100) NOT NULL,
	descripcion VARCHAR(500),
	id_tipo INT NOT NULL,

	CONSTRAINT fk_servicio_tipo FOREIGN KEY (id_tipo) REFERENCES tipos_servicios(id_tipo),
	CONSTRAINT uq_servicio UNIQUE (servicio, id_tipo)
);
GO

CREATE TABLE servicios_sucursales(
	id INT IDENTITY PRIMARY KEY,
	id_servicio VARCHAR(50) NOT NULL,
	id_sucursal INT NOT NULL,

	CONSTRAINT fk_servicio_s FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio),
	CONSTRAINT fk_sucursale_s FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
	CONSTRAINT uq_servicio_sucursale UNIQUE (id_servicio, id_sucursal)
);
GO

CREATE TABLE evaluaciones_hotel (
	id_evaluacion INT IDENTITY PRIMARY KEY,
    limpieza INT DEFAULT 5,
    servicio_y_personal INT DEFAULT 5,
    condiciones_propiedad INT DEFAULT 5,
    cuidado_medio_ambiente INT DEFAULT 5,
    calificacion_promedio AS ROUND((limpieza + servicio_y_personal + condiciones_propiedad + cuidado_medio_ambiente) / 4.0, 2),
	fecha_evaluacion DATE NOT NULL,
	id_cliente INT NOT NULL,
	id_sucursal INT NOT NULL,
	sugerencias VARCHAR(1000)

	CONSTRAINT fk_evaluacion_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	CONSTRAINT fk_evaluacion_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);
GO

CREATE TABLE favoritos_de_clientes(
	id INT IDENTITY PRIMARY KEY,
	id_cliente INT NOT NULL,
	id_sucursal INT NOT NULL,

	CONSTRAINT fk_favorito_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	CONSTRAINT fk_favorito_csucursal FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal),
	CONSTRAINT uq_favorito UNIQUE (id_cliente, id_sucursal)
);

CREATE TABLE habitaciones(
	id_habitacion INT IDENTITY PRIMARY KEY,
	codigo VARCHAR(50) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	limite_personas INT NOT NULL,
	cantidad_camas INT NOT NULL,
	id_sucursal INT NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	disponible BIT NOT NULL DEFAULT 1

	CONSTRAINT uq_habitacion UNIQUE (codigo, id_sucursal),
	CONSTRAINT fk_habitacion_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);
GO


CREATE TABLE categorias_amenidades(
	id_categoria INT IDENTITY PRIMARY KEY,
	categoria VARCHAR(100) UNIQUE NOT NULL
);
GO

CREATE TABLE amenidades(
	id_amenidad INT IDENTITY PRIMARY KEY,
	amenidad VARCHAR(100),
	id_categoria INT NOT NULL,

	CONSTRAINT fk_amenidad_categoria FOREIGN KEY (id_categoria) REFERENCES categorias_amenidades(id_categoria),
	CONSTRAINT uq_amenidad UNIQUE (amenidad, id_categoria)
);
GO

CREATE TABLE amenidades_habitaciones(
	id INT IDENTITY PRIMARY KEY,
	id_amenidad INT NOT NULL,
	id_habitacion INT NOT NULL,

	CONSTRAINT fk_amenidades_h FOREIGN KEY (id_amenidad) REFERENCES amenidades(id_amenidad),
	CONSTRAINT fk_habitaciones_a FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion),
	CONSTRAINT uq_amenidad_habitacion UNIQUE (id_amenidad, id_habitacion)
);
GO

CREATE TABLE reservaciones(
	id_reservacion INT IDENTITY PRIMARY KEY,
	fecha_reservacion VARCHAR(20) NOT NULL DEFAULT FORMAT(GETDATE(), 'dd/MM/yy'),
	fecha_inicio VARCHAR(20) NOT NULL,
	fecha_fin VARCHAR(20) NOT NULL,
	id_cliente INT NOT NULL,
	id_habitacion INT NOT NULL,
	pagado BIT DEFAULT 0,
	activa BIT DEFAULT 0

	CONSTRAINT fk_reservacion_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	CONSTRAINT fk_reservacion_habitacion FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion)
);
GO

CREATE TABLE formas_de_pago(
	id_forma_pago INT IDENTITY PRIMARY KEY,
	forma_de_pago VARCHAR(100) UNIQUE NOT NULL
);
GO

CREATE TABLE facturas(
	id_factura VARCHAR(50) PRIMARY KEY,
	fecha VARCHAR(20) NOT NULL DEFAULT FORMAT(GETDATE(), 'dd/MM/yy'),
	subtotal DECIMAL(10,2) DEFAULT 0,
	impuesto DECIMAL(10,2) DEFAULT 0,
	total DECIMAL(10,2) DEFAULT 0,
	id_cliente INT NOT NULL,
	id_forma_pago INT NOT NULL,

	CONSTRAINT fk_factura_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
	CONSTRAINT fk_factura_forma_pago FOREIGN KEY (id_forma_pago) REFERENCES formas_de_pago(id_forma_pago),
);
GO

CREATE TABLE detalle_factura(
	id INT IDENTITY PRIMARY KEY,
	id_factura VARCHAR(50) NOT NULL,
	id_reservacion INT NOT NULL,

	CONSTRAINT fk_detalle_factura FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
	CONSTRAINT fk_detalle_reservacion FOREIGN KEY (id_reservacion) REFERENCES reservaciones(id_reservacion),
	CONSTRAINT  uq_factura UNIQUE (id_factura, id_reservacion)
);
GO