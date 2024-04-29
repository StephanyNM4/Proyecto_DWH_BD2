-- DML HOTELES 

INSERT INTO categorias_amenidades (categoria)
VALUES
    ('Servicios de la habitaci�n'),
    ('Ba�o'),
    ('Dormitorio'),
    ('Entretenimiento'),
    ('Amigable para familias'),
    ('Comida y bebida'),
    ('Internet'),
    ('M�s');
GO

INSERT INTO amenidades (amenidad, id_categoria)
VALUES
    ('Art�culos de tocador de dise�ador', 2),
    ('Art�culos de tocador ecol�gicos', 2),
    ('Secador de pelo', 2),
    ('Ba�o privado', 2),
    ('Ducha', 2),
    ('Toallas', 2),
    ('S�banas', 3),
    ('Cortinas opacas', 3),
    ('Aire acondicionado con control de clima', 3),
    ('Edred�n de plumas', 3),
    ('Cunas/ camas infantiles gratuitas', 3),
    ('Men� de almohadas', 3),
    ('Camas supletorias (con cargo adicional)', 3),
    ('Televisor plasma de 32 pulgadas', 4),
    ('Pel�culas de pago', 4),
    ('Canales de TV premium', 4),
    ('Canales por sat�lite', 4),
    ('Servicio de cuidado infantil en la habitaci�n (con cargo adicional)', 5),
    ('Servicio de habitaciones las 24 horas', 6),
    ('Hervidor el�ctrico', 6),
    ('Minibar (puede aplicarse cargo adicional)', 6),
    ('WiFi gratuito', 7),
    ('Habitaciones comunicadas disponibles', 8),
    ('Limpieza diaria', 8),
    ('Escritorio', 8),
    ('Interruptores de ahorro de energ�a', 8),
    ('Plancha/tabla de planchar', 8),
    ('Espacio de trabajo para laptop', 8),
    ('Caja fuerte compatible con laptop', 8),
    ('Bombillas LED', 8),
    ('Tel�fono', 8),
    ('Cesto de reciclaje', 8),
    ('Habitaciones insonorizadas', 8);
GO

INSERT INTO tipos_servicios (tipo_servicio)
VALUES
    ('Estacionamiento y transporte'),
    ('Comida y bebida'),
    ('Internet'),
    ('Actividades'),
    ('Amigable para familias'),
    ('Comodidades'),
    ('Servicios para hu�spedes'),
    ('Servicios empresariales'),
    ('Exteriores'),
    ('Accesibilidad'),
    ('Spa'),
    ('Idiomas hablados'),
    ('M�s');
GO

INSERT INTO servicios (servicio, descripcion, id_tipo)
VALUES
    ('Estaci�n de carga para autos el�ctricos en el lugar', 'Estaci�n de carga para autos el�ctricos en el lugar', 1),
    ('Traslado de �rea (con cargo adicional)', 'Traslado de �rea (con cargo adicional)', 1),
    ('Estacionamiento en el lugar (EUR 27 por d�a)', 'Estacionamiento en el lugar (EUR 27 por d�a)', 1),
    ('Estacionamiento limitado en el lugar', 'Estacionamiento limitado en el lugar', 1),
    ('Estacionamiento accesible para sillas de ruedas disponible', 'Estacionamiento accesible para sillas de ruedas disponible', 1),
    ('Desayuno completo diario disponible de 7:00 a. m. a 11:00 a. m. por una tarifa: EUR 27 por persona', 'Desayuno completo diario disponible de 7:00 a. m. a 11:00 a. m. por una tarifa: EUR 27 por persona', 2),
    ('2 cafeter�as', '2 cafeter�as', 2),
    ('3 restaurantes', '3 restaurantes', 2),
    ('Bar/sal�n', 'Bar/sal�n', 2),
    ('Bar de aperitivos/deli', 'Bar de aperitivos/deli', 2),
    ('Disponible en todas las habitaciones: WiFi gratuito', 'Disponible en todas las habitaciones: WiFi gratuito', 3),
    ('Disponible en algunas �reas p�blicas: WiFi gratuito', 'Disponible en algunas �reas p�blicas: WiFi gratuito', 3),
    ('Gimnasio disponible las 24 horas', 'Gimnasio disponible las 24 horas', 4),
    ('Piscina al aire libre de temporada', 'Piscina al aire libre de temporada', 4),
    ('Compras', 'Compras', 4),
    ('Cuna gratuita', 'Cuna gratuita', 5),
    ('Servicio de ni�era en la habitaci�n (con cargo adicional)', 'Servicio de ni�era en la habitaci�n (con cargo adicional)', 5),
    ('Servicio de lavander�a', 'Servicio de lavander�a', 5),
    ('Habitaciones insonorizadas', 'Habitaciones insonorizadas', 5),
    ('Recepci�n disponible las 24 horas', 'Recepci�n disponible las 24 horas', 7),
    ('Tienda de regalos/peri�dicos', 'Tienda de regalos/peri�dicos', 7),
    ('Conservaci�n de equipaje', 'Conservaci�n de equipaje', 7),
    ('Caja de seguridad en la recepci�n', 'Caja de seguridad en la recepci�n', 7),
    ('Servicios de conserjer�a', 'Servicios de conserjer�a', 8),
    ('Servicio de limpieza en seco/lavander�a', 'Servicio de limpieza en seco/lavander�a', 8),
    ('Servicio de limpieza diario', 'Servicio de limpieza diario', 8),
    ('Personal multiling�e', 'Personal multiling�e', 8),
    ('Botones/portero', 'Botones/portero', 8),
    ('Asistencia tur�stica y para la compra de entradas', 'Asistencia tur�stica y para la compra de entradas', 8),
    ('Servicios para bodas', 'Servicios para bodas', 8),
    ('Centro de negocios', 'Centro de negocios', 9),
    ('Estaci�n de computadoras', 'Estaci�n de computadoras', 9),
    ('Centro de conferencias', 'Centro de conferencias', 9),
    ('Salas de reuniones', 'Salas de reuniones', 9),
    ('Jard�n', 'Jard�n', 10),
    ('Tumbonas de piscina', 'Tumbonas de piscina', 10),
    ('Terraza', 'Terraza', 10),
    ('Ascensor', 'Ascensor', 11),
    ('Accesible en silla de ruedas (puede tener limitaciones)', 'Accesible en silla de ruedas (puede tener limitaciones)', 11),
    ('Centro de negocios accesible en silla de ruedas', 'Centro de negocios accesible en silla de ruedas', 11),
    ('Gimnasio accesible en silla de ruedas', 'Gimnasio accesible en silla de ruedas', 11),
    ('Sal�n accesible en silla de ruedas', 'Sal�n accesible en silla de ruedas', 11),
    ('Estacionamiento accesible en silla de ruedas', 'Estacionamiento accesible en silla de ruedas', 11),
    ('Ruta de acceso accesible en silla de ruedas', 'Ruta de acceso accesible en silla de ruedas', 11),
    ('Piscina accesible en silla de ruedas', 'Piscina accesible en silla de ruedas', 11),
    ('Ba�o p�blico accesible en silla de ruedas', 'Ba�o p�blico accesible en silla de ruedas', 11),
    ('Mostrador de registro accesible en silla de ruedas', 'Mostrador de registro accesible en silla de ruedas', 11),
    ('Restaurante accesible en silla de ruedas', 'Restaurante accesible en silla de ruedas', 11),
    ('Aromaterapia', 'Aromaterapia', 12),
    ('Exfoliaci�n corporal', 'Exfoliaci�n corporal', 12),
    ('Envolturas corporales', 'Envolturas corporales', 12),
    ('Envolturas de desintoxicaci�n', 'Envolturas de desintoxicaci�n', 12),
    ('Faciales', 'Faciales', 12),
    ('Masajes con piedras calientes', 'Masajes con piedras calientes', 12),
    ('Manicuras/pedicuras', 'Manicuras/pedicuras', 12),
    ('Arquitectura tradicional', 'Arquitectura tradicional', 13),
    ('Opciones de comida vegana', 'Opciones de comida vegana', 13),
    ('Opciones de comida vegetariana', 'Opciones de comida vegetariana', 13),
    ('Piscina al aire libre, servicio de ni�era, camas/cunas adicionales, lavander�a', 'Piscina al aire libre, servicio de ni�era, camas/cunas adicionales, lavander�a', 13);
GO

INSERT INTO formas_de_pago (forma_de_pago)
VALUES
    ('Tarjeta de cr�dito'),
    ('Tarjeta de d�bito'),
    ('Efectivo'),
    ('Transferencia bancaria'),
    ('Pago m�vil'),
    ('Cheque'),
    ('Vale de regalo'),
    ('Bitcoin'),
    ('Criptomoneda'),
    ('Otro');
GO

INSERT INTO generos (genero)
VALUES
    ('Masculino'),
    ('Femenino');
GO

INSERT INTO generos (genero)
VALUES
    ('Masculino'),
    ('Femenino');
GO

INSERT INTO paises (nombre_pais)
VALUES
    ('Guatemala'),
	('El Salvador'),
	('Nicaragua'),
	('Costa Rica'),
	('Panama'),
	('Belice'),
    ('Honduras');
GO

INSERT INTO paises (nombre_pais)
VALUES
    ('Guatemala'),
	('El Salvador'),
	('Nicaragua'),
	('Costa Rica'),
	('Panama'),
	('Belice'),
    ('Honduras');
GO

INSERT INTO ciudades (nombre_ciudad, id_pais)
VALUES
    ('Guatemala City', 1),
    ('Quetzaltenango', 1),
    ('Antigua Guatemala', 1),
    ('San Salvador', 2),
    ('Santa Ana', 2),
    ('San Miguel', 2),
    ('Managua', 3),
    ('Le�n', 3),
    ('Masaya', 3),
    ('San Jos�', 4),
    ('Liberia', 4),
    ('Lim�n', 4),
    ('Ciudad de Panam�', 5),
    ('Col�n', 5),
    ('David', 5),
    ('Belmopan', 6),
    ('Belize City', 6),
    ('San Ignacio', 6),
    ('Tegucigalpa', 7),
    ('San Pedro Sula', 7),
    ('Choloma', 7);
GO

-- Insertar datos en la tabla direcciones
INSERT INTO direcciones (referencia, id_ciudad)
VALUES
    ('123 Calle Principal, Zona 1', 1),         -- Guatemala City
    ('456 Avenida Central, Zona 2', 1),         -- Guatemala City
    ('789 Avenida Reforma, Zona 10', 1),        -- Guatemala City
    ('987 Calle del Sol, Barrio el Centro', 2), -- Quetzaltenango
    ('654 Avenida de los Volcanes, Zona 3', 2), -- Quetzaltenango
    ('321 Calle de la Revoluci�n, Zona 4', 2),  -- Quetzaltenango
    ('456 Avenida Central, Colonia Escal�n', 3),-- San Salvador
    ('789 Boulevard del Hip�dromo, Zona Rosa', 3),-- San Salvador
    ('123 Calle de las Orqu�deas, Colonia San Benito', 3),-- San Salvador
    ('987 Avenida Bol�var, Distrito 1', 4),     -- Managua
    ('654 Avenida de las Palmeras, Distrito 2', 4),-- Managua
    ('321 Calle del Lago, Distrito 3', 4),      -- Managua
    ('456 Avenida Central, Barrio Am�n', 5),    -- San Jos�
    ('789 Paseo Col�n, Barrio La California', 5),-- San Jos�
    ('123 Avenida Segunda, Barrio Otoya', 5),   -- San Jos�
    ('987 Calle 50, Bella Vista', 6),           -- Ciudad de Panam�
    ('654 Avenida Balboa, Punta Paitilla', 6),  -- Ciudad de Panam�
    ('321 Calle Uruguay, Casco Antiguo', 6),    -- Ciudad de Panam�
    ('456 Boulevard Haciena, Belmopan', 7),     -- Belmopan
    ('789 Avenida Independence, Belama Phase 2', 7),-- Belmopan
    ('123 Calle Flores, San Pedro', 7),         -- Belmopan
    ('987 Calle Moraz�n, Barrio Concepci�n', 8),-- Tegucigalpa
    ('654 Avenida Kennedy, Colonia Miramontes', 8),-- Tegucigalpa
    ('321 Avenida Los Pr�ceres, Colonia Kennedy', 8);-- Tegucigalpa
GO


-- Insertar datos en la tabla estados_civiles
INSERT INTO estados_civiles (estado_civil)
VALUES
    ('Casado'),   
    ('Soltero'),
	('En uni�n libre');
GO

-- Insertar datos en la tabla cargos
INSERT INTO cargos (cargo)
VALUES
    ('Recepcionista'),   
    ('Guardia'),
	('Gerente General'),
	('Personal de limpieza'),
	('Conserje'),
	('Propietario');
GO

-- Insertar datos en la tabla deducciones_bonificaciones
INSERT INTO deducciones_bonificaciones (descripcion, factor, porcentaje)
VALUES
    ('Aguinaldo', 1.0, 0.2),   
    ('Seguro', -1.0, 0.1),
	('Catoceavo', 1.0, 0.15);
GO

INSERT INTO dias (dia) VALUES ('DOMINGO'), ('LUNES'), ('MARTES'), ('MIERCOLES'), ('JUEVES'), ('VIERNES'), ('SABADO');