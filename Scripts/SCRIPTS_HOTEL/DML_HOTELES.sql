-- DML HOTELES 

INSERT INTO categorias_amenidades (categoria)
VALUES
    ('Servicios de la habitación'),
    ('Baño'),
    ('Dormitorio'),
    ('Entretenimiento'),
    ('Amigable para familias'),
    ('Comida y bebida'),
    ('Internet'),
    ('Más');
GO

INSERT INTO amenidades (amenidad, id_categoria)
VALUES
    ('Artículos de tocador de diseñador', 2),
    ('Artículos de tocador ecológicos', 2),
    ('Secador de pelo', 2),
    ('Baño privado', 2),
    ('Ducha', 2),
    ('Toallas', 2),
    ('Sábanas', 3),
    ('Cortinas opacas', 3),
    ('Aire acondicionado con control de clima', 3),
    ('Edredón de plumas', 3),
    ('Cunas/ camas infantiles gratuitas', 3),
    ('Menú de almohadas', 3),
    ('Camas supletorias (con cargo adicional)', 3),
    ('Televisor plasma de 32 pulgadas', 4),
    ('Películas de pago', 4),
    ('Canales de TV premium', 4),
    ('Canales por satélite', 4),
    ('Servicio de cuidado infantil en la habitación (con cargo adicional)', 5),
    ('Servicio de habitaciones las 24 horas', 6),
    ('Hervidor eléctrico', 6),
    ('Minibar (puede aplicarse cargo adicional)', 6),
    ('WiFi gratuito', 7),
    ('Habitaciones comunicadas disponibles', 8),
    ('Limpieza diaria', 8),
    ('Escritorio', 8),
    ('Interruptores de ahorro de energía', 8),
    ('Plancha/tabla de planchar', 8),
    ('Espacio de trabajo para laptop', 8),
    ('Caja fuerte compatible con laptop', 8),
    ('Bombillas LED', 8),
    ('Teléfono', 8),
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
    ('Servicios para huéspedes'),
    ('Servicios empresariales'),
    ('Exteriores'),
    ('Accesibilidad'),
    ('Spa'),
    ('Idiomas hablados'),
    ('Más');
GO

INSERT INTO servicios (servicio, descripcion, id_tipo)
VALUES
    ('Estación de carga para autos eléctricos en el lugar', 'Estación de carga para autos eléctricos en el lugar', 1),
    ('Traslado de área (con cargo adicional)', 'Traslado de área (con cargo adicional)', 1),
    ('Estacionamiento en el lugar (EUR 27 por día)', 'Estacionamiento en el lugar (EUR 27 por día)', 1),
    ('Estacionamiento limitado en el lugar', 'Estacionamiento limitado en el lugar', 1),
    ('Estacionamiento accesible para sillas de ruedas disponible', 'Estacionamiento accesible para sillas de ruedas disponible', 1),
    ('Desayuno completo diario disponible de 7:00 a. m. a 11:00 a. m. por una tarifa: EUR 27 por persona', 'Desayuno completo diario disponible de 7:00 a. m. a 11:00 a. m. por una tarifa: EUR 27 por persona', 2),
    ('2 cafeterías', '2 cafeterías', 2),
    ('3 restaurantes', '3 restaurantes', 2),
    ('Bar/salón', 'Bar/salón', 2),
    ('Bar de aperitivos/deli', 'Bar de aperitivos/deli', 2),
    ('Disponible en todas las habitaciones: WiFi gratuito', 'Disponible en todas las habitaciones: WiFi gratuito', 3),
    ('Disponible en algunas áreas públicas: WiFi gratuito', 'Disponible en algunas áreas públicas: WiFi gratuito', 3),
    ('Gimnasio disponible las 24 horas', 'Gimnasio disponible las 24 horas', 4),
    ('Piscina al aire libre de temporada', 'Piscina al aire libre de temporada', 4),
    ('Compras', 'Compras', 4),
    ('Cuna gratuita', 'Cuna gratuita', 5),
    ('Servicio de niñera en la habitación (con cargo adicional)', 'Servicio de niñera en la habitación (con cargo adicional)', 5),
    ('Servicio de lavandería', 'Servicio de lavandería', 5),
    ('Habitaciones insonorizadas', 'Habitaciones insonorizadas', 5),
    ('Recepción disponible las 24 horas', 'Recepción disponible las 24 horas', 7),
    ('Tienda de regalos/periódicos', 'Tienda de regalos/periódicos', 7),
    ('Conservación de equipaje', 'Conservación de equipaje', 7),
    ('Caja de seguridad en la recepción', 'Caja de seguridad en la recepción', 7),
    ('Servicios de conserjería', 'Servicios de conserjería', 8),
    ('Servicio de limpieza en seco/lavandería', 'Servicio de limpieza en seco/lavandería', 8),
    ('Servicio de limpieza diario', 'Servicio de limpieza diario', 8),
    ('Personal multilingüe', 'Personal multilingüe', 8),
    ('Botones/portero', 'Botones/portero', 8),
    ('Asistencia turística y para la compra de entradas', 'Asistencia turística y para la compra de entradas', 8),
    ('Servicios para bodas', 'Servicios para bodas', 8),
    ('Centro de negocios', 'Centro de negocios', 9),
    ('Estación de computadoras', 'Estación de computadoras', 9),
    ('Centro de conferencias', 'Centro de conferencias', 9),
    ('Salas de reuniones', 'Salas de reuniones', 9),
    ('Jardín', 'Jardín', 10),
    ('Tumbonas de piscina', 'Tumbonas de piscina', 10),
    ('Terraza', 'Terraza', 10),
    ('Ascensor', 'Ascensor', 11),
    ('Accesible en silla de ruedas (puede tener limitaciones)', 'Accesible en silla de ruedas (puede tener limitaciones)', 11),
    ('Centro de negocios accesible en silla de ruedas', 'Centro de negocios accesible en silla de ruedas', 11),
    ('Gimnasio accesible en silla de ruedas', 'Gimnasio accesible en silla de ruedas', 11),
    ('Salón accesible en silla de ruedas', 'Salón accesible en silla de ruedas', 11),
    ('Estacionamiento accesible en silla de ruedas', 'Estacionamiento accesible en silla de ruedas', 11),
    ('Ruta de acceso accesible en silla de ruedas', 'Ruta de acceso accesible en silla de ruedas', 11),
    ('Piscina accesible en silla de ruedas', 'Piscina accesible en silla de ruedas', 11),
    ('Baño público accesible en silla de ruedas', 'Baño público accesible en silla de ruedas', 11),
    ('Mostrador de registro accesible en silla de ruedas', 'Mostrador de registro accesible en silla de ruedas', 11),
    ('Restaurante accesible en silla de ruedas', 'Restaurante accesible en silla de ruedas', 11),
    ('Aromaterapia', 'Aromaterapia', 12),
    ('Exfoliación corporal', 'Exfoliación corporal', 12),
    ('Envolturas corporales', 'Envolturas corporales', 12),
    ('Envolturas de desintoxicación', 'Envolturas de desintoxicación', 12),
    ('Faciales', 'Faciales', 12),
    ('Masajes con piedras calientes', 'Masajes con piedras calientes', 12),
    ('Manicuras/pedicuras', 'Manicuras/pedicuras', 12),
    ('Arquitectura tradicional', 'Arquitectura tradicional', 13),
    ('Opciones de comida vegana', 'Opciones de comida vegana', 13),
    ('Opciones de comida vegetariana', 'Opciones de comida vegetariana', 13),
    ('Piscina al aire libre, servicio de niñera, camas/cunas adicionales, lavandería', 'Piscina al aire libre, servicio de niñera, camas/cunas adicionales, lavandería', 13);
GO

INSERT INTO formas_de_pago (forma_de_pago)
VALUES
    ('Tarjeta de crédito'),
    ('Tarjeta de débito'),
    ('Efectivo'),
    ('Transferencia bancaria'),
    ('Pago móvil'),
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
    ('León', 3),
    ('Masaya', 3),
    ('San José', 4),
    ('Liberia', 4),
    ('Limón', 4),
    ('Ciudad de Panamá', 5),
    ('Colón', 5),
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
    ('321 Calle de la Revolución, Zona 4', 2),  -- Quetzaltenango
    ('456 Avenida Central, Colonia Escalón', 3),-- San Salvador
    ('789 Boulevard del Hipódromo, Zona Rosa', 3),-- San Salvador
    ('123 Calle de las Orquídeas, Colonia San Benito', 3),-- San Salvador
    ('987 Avenida Bolívar, Distrito 1', 4),     -- Managua
    ('654 Avenida de las Palmeras, Distrito 2', 4),-- Managua
    ('321 Calle del Lago, Distrito 3', 4),      -- Managua
    ('456 Avenida Central, Barrio Amón', 5),    -- San José
    ('789 Paseo Colón, Barrio La California', 5),-- San José
    ('123 Avenida Segunda, Barrio Otoya', 5),   -- San José
    ('987 Calle 50, Bella Vista', 6),           -- Ciudad de Panamá
    ('654 Avenida Balboa, Punta Paitilla', 6),  -- Ciudad de Panamá
    ('321 Calle Uruguay, Casco Antiguo', 6),    -- Ciudad de Panamá
    ('456 Boulevard Haciena, Belmopan', 7),     -- Belmopan
    ('789 Avenida Independence, Belama Phase 2', 7),-- Belmopan
    ('123 Calle Flores, San Pedro', 7),         -- Belmopan
    ('987 Calle Morazán, Barrio Concepción', 8),-- Tegucigalpa
    ('654 Avenida Kennedy, Colonia Miramontes', 8),-- Tegucigalpa
    ('321 Avenida Los Próceres, Colonia Kennedy', 8);-- Tegucigalpa
GO


-- Insertar datos en la tabla estados_civiles
INSERT INTO estados_civiles (estado_civil)
VALUES
    ('Casado'),   
    ('Soltero'),
	('En unión libre');
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