-- DML HOTELES 
--USE MASTER
use hoteles;
GO 

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

--Insertar datos en la tabla POLITICAS
INSERT INTO politicas (politica)
VALUES
    ('Hora de inicio de check-in: 3:00 PM; Hora de finalizaci�n del check-in: 1:00 AM'),
    ('El check-in temprano est� sujeto a disponibilidad'),
    ('El check-in temprano est� disponible por un cargo adicional'),
    ('El check-in tard�o est� sujeto a disponibilidad'),
    ('Edad m�nima para hacer el check-in: 18 a�os'),
    ('Check-out antes del mediod�a'),
    ('El check-out tard�o est� sujeto a disponibilidad'),
    ('Se aplicar� un cargo por check-out tard�o'),
    ('Check-out express disponible'),
    ('Instrucciones especiales de check-in: El personal de recepci�n recibir� a los hu�spedes a su llegada. Para obtener m�s detalles, por favor contacta al establecimiento utilizando la informaci�n en la confirmaci�n de la reserva.'),
    ('Esta propiedad no permite cambios de nombre en las reservas. El nombre en la reserva debe coincidir con el nombre del hu�sped que est� haciendo el check-in y aloj�ndose en la propiedad; se requiere identificaci�n con foto. La tarjeta de cr�dito utilizada para hacer la reserva debe ser presentada por el titular de la tarjeta al hacer el check-in junto con una identificaci�n con foto que coincida. Cualquier otro acuerdo debe ser coordinado con la propiedad antes de la llegada.'),
    ('Renovaciones y cierres: Las siguientes instalaciones est�n cerradas de forma estacional cada a�o. Estar�n cerradas del 1 de septiembre al 15 de junio: Piscina'),
    ('M�todos de acceso: Recepci�n atendida'),
    ('Mascotas: No se permiten mascotas (los animales de servicio son bienvenidos y est�n exentos de tarifas)'),
    ('Ni�os y camas adicionales: Los ni�os son bienvenidos. Los ni�os pueden alojarse gratis utilizando las camas existentes en la habitaci�n de los padres o tutores. Camas supletorias disponibles por EUR 35.0 por noche. Cunas gratuitas disponibles bajo petici�n en el establecimiento.');
GO

-- Insertar datos en la tabla hoteles
INSERT INTO hoteles (nombre, telefono, correo, descripcion, sitio_web)
VALUES
    ('Hotel A', '123456789', 'info@hotela.com', 'Descripci�n del Hotel A', 'www.hotela.com'),
    ('Hotel B', '987654321', 'info@hotelb.com', 'Descripci�n del Hotel B', 'www.hotelb.com');
GO

-- Insertar datos en la tabla sucursales
INSERT INTO sucursales (reembolsable, descripcion, telefono, correo, id_hotel, id_direccion)
VALUES
    (1, 'Sucursal 1 del Hotel A', '111111111', 'info@sucursal1-hotela.com', 1, 1), -- Asignando la sucursal al Hotel A
    (0, 'Sucursal 2 del Hotel A', '222222222', 'info@sucursal2-hotela.com', 1, 2), -- Asignando la sucursal al Hotel A
    (1, 'Sucursal 1 del Hotel B', '333333333', 'info@sucursal1-hotelb.com', 2, 3), -- Asignando la sucursal al Hotel B
    (0, 'Sucursal 2 del Hotel B', '444444444', 'info@sucursal2-hotelb.com', 2, 4); -- Asignando la sucursal al Hotel B
GO

-- Insertar datos en la tabla POLITICAS_SUCURSAL
INSERT INTO politicas_sucursal (id_sucursal, id_politica)
VALUES
    -- Asignar pol�ticas a la Sucursal 1 del Hotel A
    (1, 1), (1, 2), (1, 6), (1, 8), (1, 14),
    
    -- Asignar pol�ticas a la Sucursal 2 del Hotel A
    (2, 1), (2, 5), (2, 6), (2, 10), (2, 15),
    
    -- Asignar pol�ticas a la Sucursal 1 del Hotel B
    (3, 3), (3, 4), (3, 6), (3, 8), (3, 13),
    
    -- Asignar pol�ticas a la Sucursal 2 del Hotel B
    (4, 3), (4, 4), (4, 7), (4, 11), (4, 15);
GO

-- Insertar datos en la tabla POLITICAS_SUCURSAL
INSERT INTO personas (nombre, apellido, no_identidad, fecha_nacimiento, correo, telefono, id_estado_civil, id_genero, id_direccion)
VALUES ('Dorian Samantha', 'Contreras Velasquez', '0801200302345', '2003-01-25', 'dcontreras@correo.com', '89756654', 1, 1, 1),
	   ('Kattherine Mayely', 'Hernandez', '0501200416400', '2002-01-26', 'khernan@correo.com', '89760331', 2, 2, 4),
	   ('Stephany Nicole', 'Matamoros', '0801200302346', '2002-01-25', 'stephm@correo.com', '89760123', 2, 2, 5),
	   ('Erick', 'Mar�n Reyes', '0702195002345', '1950-01-25', 'ereyes@correo.com',  '89123331', 2, 1, 6),
	   ('Josefo Orlando', 'Hernandez', '0801194002345', '1940-01-25', 'jhernan@correo.com', '98723331', 2, 1, 7),
	   ('Jose', 'Reyes', '0801200536789', '2005-01-20', 'jreyes@correo.com', '90823331', 2, 1, 9),
	   ('Jose Luis', 'Garcia Montero', '0804197002345', '2003-01-25', 'jgarcia@correo.com', '89764331', 2, 1, 2),
	   ('Lesvia', 'Suarez', '0801201002355', '2010-01-25', 'lsuarez@correo.com', '89765331', 2, 2, 3),
	   ('Adrian', 'Martinez', '0801200102345', '2001-01-25', 'amartinez@correo.com', '89123331', 2, 1, 6),
	   ('Saida', 'Ramos', '0801201002345', '2010-01-29', 'sramos@correo.com', '89120651', 2, 2, 8),
	   ('Nestor', 'Luque', '0801219900234', '1990-01-25', 'nluque@correo.com', '86103331', 2, 1, 10),
	   ('Daniel', 'Mu�oz', '0801219900290', '1990-02-25', 'daniel_munoz@gmail.com', '+2000111222', 3, 1, 11),
	   ('Isabella', 'Vasquez', '0801219900235', '1990-03-25', 'isabella_vasquez@gmail.com', '+2111222333', 3, 2, 12),
	   ('Samuel', 'Ram�rez', '0801219900735', '1990-11-25', 'samuel_ramirez@gmail.com', '+2222333444', 3, 1, 13),
	   ('Martina', 'Torres', '0803219900735', '1990-11-27', 'martina_torres@gmail.com', '+2333444555', 3, 2, 14),
	   ('Juan', 'Gonz�lez', '0802219900735', '1990-11-28', 'juan_gonzalez@gmail.com', '+2444555666', 3, 1, 15);
GO

INSERT INTO personas (nombre, apellido, no_identidad, fecha_nacimiento, correo, telefono, id_estado_civil, id_genero, id_direccion)
VALUES 
('Juan Pablo', 'Lopez', '0702200302345', '2003-01-25', 'juanpablo@correo.com', '89756654', 1, 1, 1),
('Maria Fernanda', 'Gutierrez', '0301200416400', '2002-01-26', 'maria@correo.com', '89760331', 2, 2, 4),
('Carlos', 'Perez', '0302200302346', '2002-01-25', 'carlos@correo.com', '89760123', 2, 2, 5),
('Ana Maria', 'Rodriguez', '0902195002345', '1950-01-25', 'ana@correo.com',  '89123331', 2, 1, 6),
('Juan Carlos', 'Sanchez', '0901194002345', '1940-01-25', 'juancarlos@correo.com', '98723331', 2, 1, 7),
('Luis', 'Martinez', '0301200536789', '2005-01-20', 'luis@correo.com', '90823331', 2, 1, 9),
('Sara', 'Hernandez', '0102197002345', '2003-01-25', 'sara@correo.com', '89764331', 2, 1, 2),
('Laura', 'Diaz', '0809201002355', '2010-01-25', 'laura@correo.com', '89765331', 2, 2, 3),
('Pedro', 'Ramirez', '0405200102345', '2001-01-25', 'pedro@correo.com', '89123331', 2, 1, 6),
('Martha', 'Lopez', '0405201002345', '2010-01-29', 'martha@correo.com', '89120651', 2, 2, 8),
('Luisa', 'Garcia', '0405219900234', '1990-01-25', 'luisa@correo.com', '86103331', 2, 1, 10),
('Miguel', 'Torres', '0405219900290', '1990-02-25', 'miguel@correo.com', '+2000111222', 3, 1, 11),
('Carmen', 'Sanchez', '0203219900235', '1990-03-25', 'carmen@correo.com', '+2111222333', 3, 2, 12),
('Manuel', 'Gonzalez', '0203219900935', '1990-11-25', 'manuel@correo.com', '+2222333444', 3, 1, 13),
('Rosa', 'Hernandez', '0203219900735', '1990-11-27', 'rosa@correo.com', '+2333444555', 3, 2, 14),
('Josefina', 'Martinez', '1803219900735', '1990-11-28', 'josefina@correo.com', '+2444555666', 3, 1, 15);
GO

--Insertar datos en la tabla empleados 
INSERT INTO empleados (codigo, fecha_ingreso, id_persona) 
VALUES 
--Empleados de la sucursal 1A
('E1A1', '1995-01-25', 1),
('E1A2', '1995-01-25', 2),
('E1A3', '1995-01-25', 3),
('E1A4', '1995-01-25', 4),
--Empleados de la sucursal 2A
('E2A1', '1995-01-26', 5),
('E2A2', '1995-01-26', 6),
('E2A3', '1995-01-26', 7),
('E2A4', '1995-01-26', 8),
--Empleados de la sucursal 1B
('E1B1', '1995-01-30', 9),
('E1B2', '1995-01-30', 10),
('E1B3', '1995-01-30', 11),
('E1B4', '1995-01-30', 12),
--Empleados de la sucursal 2B
('E2B1', '1995-01-31', 13),
('E2B2', '1995-01-31', 14),
('E2B3', '1995-01-31', 15),
('E2B4', '1995-01-31', 16);
GO

--Inserciones en la tabla de contratos.
INSERT INTO contratos (fecha_inicio, fecha_fin, salario_neto, id_cargo, id_empleado)
VALUES (GETDATE(), '2030-12-20', 20000, 1, 1),
       (GETDATE(), '2030-12-20', 20000, 2, 2),
	   (GETDATE(), '2030-12-20', 20000, 3, 3),
	   (GETDATE(), '2030-12-20', 20000, 4, 4),
	   (GETDATE(), '2030-12-20', 20000, 5, 5),
	   (GETDATE(), '2030-12-20', 20000, 6, 6),
	   (GETDATE(), '2030-12-20', 20000, 1, 7),
	   (GETDATE(), '2030-12-20', 20000, 2, 8),
	   (GETDATE(), '2030-12-20', 20000, 1, 9),
	   (GETDATE(), '2030-12-20', 20000, 2, 10),
	   (GETDATE(), '2030-12-20', 20000, 3, 11),
	   (GETDATE(), '2030-12-20', 20000, 4, 12),
	   (GETDATE(), '2030-12-20', 20000, 5, 13),
	   (GETDATE(), '2030-12-20', 20000, 6, 14),
	   (GETDATE(), '2030-12-20', 20000, 1, 15),
	   (GETDATE(), '2030-12-20', 20000, 2, 16);
GO

--Insertar datos en la tabla periodos_tiempo
INSERT INTO periodos_tiempo (periodo) VALUES ('Fin de semana.'), ('Lun-Vie');
GO

--Inserciones en la tabla de turnos
INSERT INTO turnos (hora_inicio, hora_fin, id_periodo)
VALUES ('06:00:00', '14:00:00', 1),
	   ('14:00:00', '22:00:00', 1),
	   ('22:00:00', '06:00:00', 1),
	   ('06:00:00', '14:00:00', 2),
	   ('14:00:00', '22:00:00', 2),
	   ('22:00:00', '06:00:00', 2);
GO

INSERT INTO contratos_turnos (id_contrato, id_turno)
VALUES (1,1), (2,2), (3,3), (4,4),
	   (5,5), (6,6), (7,1), (8,2),
	   (9,3), (10,4), (11,5), (12,6),
	   (13,1), (14,2), (15,3), (16,4);
GO

-- Insertar datos en la tabla deducciones_bonificaciones
INSERT INTO deducciones_bonificaciones (descripcion, factor, porcentaje)
VALUES
    ('Aguinaldo', 1.0, 0.2),   
    ('Seguro', -1.0, 0.1),
	('Catoceavo', 1.0, 0.15);
GO

-- Insertar datos en la tabla DED_BON_CONTRATOS
INSERT INTO ded_bon_contratos (id_ded_bon, id_contrato)
VALUES
    (1,1),   
    (2,3),
	(3,6);
GO

-- Insertar datos en la tabla empleados_sucursales
INSERT INTO empleados_sucursales (id_empleado, id_sucursal)
VALUES
    (1,1), (2,1), (3,1), (4,1),
	(5,2), (6,2), (7,2), (8,2),
	(9,3), (10,3), (11,3), (12,3),
	(13,4), (14,4), (15,4), (16,4);
GO