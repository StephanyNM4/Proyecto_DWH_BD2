use hoteles4;
GO 

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

INSERT INTO servicios (id_servicio, servicio, descripcion, id_tipo)
VALUES
    ('H_001','Estación de carga para autos eléctricos en el lugar', 'Estación de carga para autos eléctricos en el lugar', 1),
    ('H_002','Traslado de área (con cargo adicional)', 'Traslado de área (con cargo adicional)', 1),
    ('H_003','Estacionamiento en el lugar (EUR 27 por día)', 'Estacionamiento en el lugar (EUR 27 por día)', 1),
    ('H_004','Estacionamiento limitado en el lugar', 'Estacionamiento limitado en el lugar', 1),
    ('H_005','Estacionamiento accesible para sillas de ruedas disponible', 'Estacionamiento accesible para sillas de ruedas disponible', 1),
    ('H_006','Desayuno completo diario disponible de 7:00 a. m. a 11:00 a. m. por una tarifa: EUR 27 por persona', 'Desayuno completo diario disponible de 7:00 a. m. a 11:00 a. m. por una tarifa: EUR 27 por persona', 2),
    ('H_007','2 cafeterías', '2 cafeterías', 2),
    ('H_008','3 restaurantes', '3 restaurantes', 2),
    ('H_009','Bar/salón', 'Bar/salón', 2),
    ('H_010','Bar de aperitivos/deli', 'Bar de aperitivos/deli', 2),
    ('H_011','Disponible en todas las habitaciones: WiFi gratuito', 'Disponible en todas las habitaciones: WiFi gratuito', 3),
    ('H_012','Disponible en algunas áreas públicas: WiFi gratuito', 'Disponible en algunas áreas públicas: WiFi gratuito', 3),
    ('H_013','Gimnasio disponible las 24 horas', 'Gimnasio disponible las 24 horas', 4),
    ('H_014','Piscina al aire libre de temporada', 'Piscina al aire libre de temporada', 4),
    ('H_015','Compras', 'Compras', 4),
    ('H_016','Cuna gratuita', 'Cuna gratuita', 5),
    ('H_017','Servicio de niñera en la habitación (con cargo adicional)', 'Servicio de niñera en la habitación (con cargo adicional)', 5),
    ('H_018','Servicio de lavandería', 'Servicio de lavandería', 5),
    ('H_019','Habitaciones insonorizadas', 'Habitaciones insonorizadas', 5),
    ('H_020','Recepción disponible las 24 horas', 'Recepción disponible las 24 horas', 7),
    ('H_021','Tienda de regalos/periódicos', 'Tienda de regalos/periódicos', 7),
    ('H_022','Conservación de equipaje', 'Conservación de equipaje', 7),
    ('H_023','Caja de seguridad en la recepción', 'Caja de seguridad en la recepción', 7),
    ('H_024','Servicios de conserjería', 'Servicios de conserjería', 8),
    ('H_025','Servicio de limpieza en seco/lavandería', 'Servicio de limpieza en seco/lavandería', 8),
    ('H_026','Servicio de limpieza diario', 'Servicio de limpieza diario', 8),
    ('H_027','Personal multilingüe', 'Personal multilingüe', 8),
    ('H_028','Botones/portero', 'Botones/portero', 8),
    ('H_029','Asistencia turística y para la compra de entradas', 'Asistencia turística y para la compra de entradas', 8),
    ('H_030','Servicios para bodas', 'Servicios para bodas', 8),
    ('H_031','Centro de negocios', 'Centro de negocios', 9),
    ('H_032','Estación de computadoras', 'Estación de computadoras', 9),
    ('H_033','Centro de conferencias', 'Centro de conferencias', 9),
    ('H_034','Salas de reuniones', 'Salas de reuniones', 9),
    ('H_035','Jardín', 'Jardín', 10),
    ('H_036','Tumbonas de piscina', 'Tumbonas de piscina', 10),
    ('H_037','Terraza', 'Terraza', 10),
    ('H_038','Ascensor', 'Ascensor', 11),
    ('H_039','Accesible en silla de ruedas (puede tener limitaciones)', 'Accesible en silla de ruedas (puede tener limitaciones)', 11),
    ('H_040','Centro de negocios accesible en silla de ruedas', 'Centro de negocios accesible en silla de ruedas', 11),
    ('H_041','Gimnasio accesible en silla de ruedas', 'Gimnasio accesible en silla de ruedas', 11),
    ('H_042','Salón accesible en silla de ruedas', 'Salón accesible en silla de ruedas', 11),
    ('H_043','Estacionamiento accesible en silla de ruedas', 'Estacionamiento accesible en silla de ruedas', 11),
    ('H_044','Ruta de acceso accesible en silla de ruedas', 'Ruta de acceso accesible en silla de ruedas', 11),
    ('H_045','Piscina accesible en silla de ruedas', 'Piscina accesible en silla de ruedas', 11),
    ('H_046','Baño público accesible en silla de ruedas', 'Baño público accesible en silla de ruedas', 11),
    ('H_047','Mostrador de registro accesible en silla de ruedas', 'Mostrador de registro accesible en silla de ruedas', 11),
    ('H_048','Restaurante accesible en silla de ruedas', 'Restaurante accesible en silla de ruedas', 11),
    ('H_049','Aromaterapia', 'Aromaterapia', 12),
    ('H_050','Exfoliación corporal', 'Exfoliación corporal', 12),
    ('H_051','Envolturas corporales', 'Envolturas corporales', 12),
    ('H_052','Envolturas de desintoxicación', 'Envolturas de desintoxicación', 12),
    ('H_053','Faciales', 'Faciales', 12),
    ('H_054','Masajes con piedras calientes', 'Masajes con piedras calientes', 12),
    ('H_055','Manicuras/pedicuras', 'Manicuras/pedicuras', 12),
    ('H_056','Arquitectura tradicional', 'Arquitectura tradicional', 13),
    ('H_057','Opciones de comida vegana', 'Opciones de comida vegana', 13),
    ('H_058','Opciones de comida vegetariana', 'Opciones de comida vegetariana', 13),
    ('H_059','Piscina al aire libre, servicio de niñera, camas/cunas adicionales, lavandería', 'Piscina al aire libre, servicio de niñera, camas/cunas adicionales, lavandería', 13);
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

--Insertar datos en la tabla POLITICAS
INSERT INTO politicas (politica)
VALUES
    ('Hora de inicio de check-in: 3:00 PM; Hora de finalización del check-in: 1:00 AM'),
    ('El check-in temprano está sujeto a disponibilidad'),
    ('El check-in temprano está disponible por un cargo adicional'),
    ('El check-in tardío está sujeto a disponibilidad'),
    ('Edad mínima para hacer el check-in: 18 años'),
    ('Check-out antes del mediodía'),
    ('El check-out tardío está sujeto a disponibilidad'),
    ('Se aplicará un cargo por check-out tardío'),
    ('Check-out express disponible'),
    ('Instrucciones especiales de check-in: El personal de recepción recibirá a los huéspedes a su llegada. Para obtener más detalles, por favor contacta al establecimiento utilizando la información en la confirmación de la reserva.'),
    ('Esta propiedad no permite cambios de nombre en las reservas. El nombre en la reserva debe coincidir con el nombre del huésped que está haciendo el check-in y alojándose en la propiedad; se requiere identificación con foto. La tarjeta de crédito utilizada para hacer la reserva debe ser presentada por el titular de la tarjeta al hacer el check-in junto con una identificación con foto que coincida. Cualquier otro acuerdo debe ser coordinado con la propiedad antes de la llegada.'),
    ('Renovaciones y cierres: Las siguientes instalaciones están cerradas de forma estacional cada año. Estarán cerradas del 1 de septiembre al 15 de junio: Piscina'),
    ('Métodos de acceso: Recepción atendida'),
    ('Mascotas: No se permiten mascotas (los animales de servicio son bienvenidos y están exentos de tarifas)'),
    ('Niños y camas adicionales: Los niños son bienvenidos. Los niños pueden alojarse gratis utilizando las camas existentes en la habitación de los padres o tutores. Camas supletorias disponibles por EUR 35.0 por noche. Cunas gratuitas disponibles bajo petición en el establecimiento.');
GO

-- Insertar datos en la tabla hoteles
INSERT INTO hoteles (nombre, telefono, correo, descripcion, sitio_web)
VALUES
    ('Hotel A', '123456789', 'info@hotela.com', 'Descripción del Hotel A', 'www.hotela.com'),
    ('Hotel B', '987654321', 'info@hotelb.com', 'Descripción del Hotel B', 'www.hotelb.com');
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
    -- Asignar políticas a la Sucursal 1 del Hotel A
    (1, 1), (1, 2), (1, 6), (1, 8), (1, 14),
    
    -- Asignar políticas a la Sucursal 2 del Hotel A
    (2, 1), (2, 5), (2, 6), (2, 10), (2, 15),
    
    -- Asignar políticas a la Sucursal 1 del Hotel B
    (3, 3), (3, 4), (3, 6), (3, 8), (3, 13),
    
    -- Asignar políticas a la Sucursal 2 del Hotel B
    (4, 3), (4, 4), (4, 7), (4, 11), (4, 15);
GO

-- Insertar datos en la tabla POLITICAS_SUCURSAL
INSERT INTO personas (nombre, apellido, no_identidad, correo, telefono, id_estado_civil, id_genero, id_direccion)
VALUES
	('Dorian Samantha', 'Contreras Velasquez', '0801200302345', 'dcontreras@correo.com', '89756654', 1, 1, 1),
	('Kattherine Mayely', 'Hernandez', '0501200416400', 'khernan@correo.com', '89760331', 2, 2, 4),
	('Stephany Nicole', 'Matamoros', '0801200302346', 'stephm@correo.com', '89760123', 2, 2, 5),
	('Erick', 'Marín Reyes', '0702195002345', 'ereyes@correo.com',  '89123331', 2, 1, 6),
	('Josefo Orlando', 'Hernandez', '0801194002345', 'jhernan@correo.com', '98723331', 2, 1, 7),
	('Jose', 'Reyes', '0801200536789', 'jreyes@correo.com', '90823331', 2, 1, 9),
	('Jose Luis', 'Garcia Montero', '0804197002345', 'jgarcia@correo.com', '89764331', 2, 1, 2),
	('Lesvia', 'Suarez', '0801201002355', 'lsuarez@correo.com', '89765331', 2, 2, 3),
	('Adrian', 'Martinez', '0801200102345', 'amartinez@correo.com', '89123331', 2, 1, 6),
	('Saida', 'Ramos', '0801201002345', 'sramos@correo.com', '89120651', 2, 2, 8),
    ('Nestor', 'Luque', '0801219900234', 'nluque@correo.com', '86103331', 2, 1, 10),
	('Daniel', 'Muñoz', '0801219900290', 'daniel_munoz@gmail.com', '+2000111222', 3, 1, 11),
	('Isabella', 'Vasquez', '0801219900235', 'isabella_vasquez@gmail.com', '+2111222333', 3, 2, 12),
	('Samuel', 'Ramírez', '0801219900735', 'samuel_ramirez@gmail.com', '+2222333444', 3, 1, 13),
	('Martina', 'Torres', '0803219900735', 'martina_torres@gmail.com', '+2333444555', 3, 2, 14),
    ('Juan', 'González', '0802219900735', 'juan_gonzalez@gmail.com', '+2444555666', 3, 1, 15);
GO

INSERT INTO personas (nombre, apellido, no_identidad, correo, telefono, id_estado_civil, id_genero, id_direccion)
VALUES 
	('Juan Pablo', 'Lopez', '0702200302345', 'juanpablo@correo.com', '89756654', 1, 1, 1),
	('Maria Fernanda', 'Gutierrez', '0301200416400', 'maria@correo.com', '89760331', 2, 2, 4),
	('Carlos', 'Perez', '0302200302346', 'carlos@correo.com', '89760123', 2, 2, 5),
	('Ana Maria', 'Rodriguez', '0902195002345', 'ana@correo.com',  '89123331', 2, 1, 6),
	('Juan Carlos', 'Sanchez', '0901194002345', 'juancarlos@correo.com', '98723331', 2, 1, 7),
	('Luis', 'Martinez', '0301200536789', 'luis@correo.com', '90823331', 2, 1, 9),
	('Sara', 'Hernandez', '0102197002345', 'sara@correo.com', '89764331', 2, 1, 2),
	('Laura', 'Diaz', '0809201002355', 'laura@correo.com', '89765331', 2, 2, 3),
	('Pedro', 'Ramirez', '0405200102345', 'pedro@correo.com', '89123331', 2, 1, 6),
	('Martha', 'Lopez', '0405201002345', 'martha@correo.com', '89120651', 2, 2, 8),
	('Luisa', 'Garcia', '0405219900234', 'luisa@correo.com', '86103331', 2, 1, 10),
	('Miguel', 'Torres', '0405219900290', 'miguel@correo.com', '+2000111222', 3, 1, 11),
	('Carmen', 'Sanchez', '0203219900235', 'carmen@correo.com', '+2111222333', 3, 2, 12),
	('Manuel', 'Gonzalez', '0203219900935', 'manuel@correo.com', '+2222333444', 3, 1, 13),
	('Rosa', 'Hernandez', '0203219900735', 'rosa@correo.com', '+2333444555', 3, 2, 14),
	('Josefina', 'Martinez', '1803219900735', 'josefina@correo.com', '+2444555666', 3, 1, 15);
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
VALUES
	(GETDATE(), '2030-12-20', 20000, 1, 1),
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
INSERT INTO periodos_tiempo (periodo) 
	VALUES ('Fin de semana.'), ('Lun-Vie');
GO

--Inserciones en la tabla de turnos
INSERT INTO turnos (hora_inicio, hora_fin, id_periodo)
VALUES 
	('06:00:00', '14:00:00', 1),
	('14:00:00', '22:00:00', 1),
	('22:00:00', '06:00:00', 1),
	('06:00:00', '14:00:00', 2),
	('14:00:00', '22:00:00', 2),
	('22:00:00', '06:00:00', 2);
GO

INSERT INTO contratos_turnos (id_contrato, id_turno)
VALUES 
	(1,1), (2,2), (3,3), (4,4),
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

--Insertar datos en la tabla de clientes
INSERT INTO clientes (fecha_registro, usuario, contrasenia, id_persona)
VALUES 
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'isabella', 'contraseña20', 13),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'samuel', 'contraseña21', 14),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'martina', 'contraseña22', 15),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'juan', 'contraseña23', 16),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'juanpablo', '1234', 17),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'mafer', '1234', 18),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'carlosperez', '1234', 19),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'anamaria', '1234', 20),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'juanca', '1234', 21),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'luism', '1234', 22),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'saraher', '1234', 23),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'lauradiaz', '1234', 24),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'pedro', '1234', 25),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'martha', '1234', 26),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'luisa', '1234', 27),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'miguel', '1234', 28),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'carmen', '1234', 29),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'manuel', '1234', 30),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'rosa', '1234', 31),
	(FORMAT(GETDATE(), 'dd/MM/yy'), 'josefina', '1234', 32);
GO

--Registros para la tabla favoritos_de_clientes
INSERT INTO favoritos_de_clientes (id_cliente, id_sucursal)
VALUES
	(1,1), (1,2), (2,3), (4,1), (1,4), (5,1), (3,2), (10,2), (11,4), (12,4);
GO

--Insertar datos en las tabla servicios_sucursales.
INSERT INTO servicios_sucursales (id_servicio, id_sucursal)
VALUES
    ('H_001', 1), ('H_002', 1), ('H_003', 1), ('H_004', 1), ('H_005', 1),
    ('H_006', 2), ('H_007', 2), ('H_008', 2), ('H_009', 2), ('H_010', 2),
    ('H_011', 3), ('H_012', 3), ('H_013', 3), ('H_014', 3), ('H_015', 3),
    ('H_016', 4), ('H_017', 4), ('H_018', 4), ('H_019', 4), ('H_020', 4);
GO

--Inserts a la tabla de habitaciones, 5 x sucursal.
INSERT INTO habitaciones (codigo, precio, limite_personas, cantidad_camas, id_sucursal, descripcion, disponible)
VALUES
    ('HAB001', 50.00, 2, 1, 1, 'Habitación individual', 1),
    ('HAB002', 70.00, 4, 2, 1, 'Habitación doble', 1),
    ('HAB003', 100.00, 6, 3, 1, 'Habitación familiar', 1),
    ('HAB004', 60.00, 3, 2, 1, 'Habitación doble estándar', 1),
    ('HAB005', 80.00, 4, 2, 1, 'Habitación doble superior', 1),
    
    ('HAB006', 55.00, 2, 1, 2, 'Habitación individual', 1),
    ('HAB007', 75.00, 4, 2, 2, 'Habitación doble', 1),
    ('HAB008', 110.00, 6, 3, 2, 'Habitación familiar', 1),
    ('HAB009', 65.00, 3, 2, 2, 'Habitación doble estándar', 1),
    ('HAB010', 85.00, 4, 2, 2, 'Habitación doble superior', 1),
    
    ('HAB011', 60.00, 2, 1, 3, 'Habitación individual', 1),
    ('HAB012', 80.00, 4, 2, 3, 'Habitación doble', 1),
    ('HAB013', 120.00, 6, 3, 3, 'Habitación familiar', 1),
    ('HAB014', 70.00, 3, 2, 3, 'Habitación doble estándar', 1),
    ('HAB015', 90.00, 4, 2, 3, 'Habitación doble superior', 1),
    
    ('HAB016', 65.00, 2, 1, 4, 'Habitación individual', 1),
    ('HAB017', 85.00, 4, 2, 4, 'Habitación doble', 1),
    ('HAB018', 125.00, 6, 3, 4, 'Habitación familiar', 1),
    ('HAB019', 75.00, 3, 2, 4, 'Habitación doble estándar', 1),
    ('HAB020', 95.00, 4, 2, 4, 'Habitación doble superior', 1);
GO

--Inserts a la tabla de amenidades, 3 x habitación.
INSERT INTO amenidades_habitaciones (id_amenidad, id_habitacion)
VALUES
    (1, 1), (2, 1), (3, 1),
    (4, 2), (5, 2), (6, 2),
    (7, 3), (8, 3), (9, 3),
    (10, 4), (11, 4), (12, 4),
    (13, 5), (14, 5), (15, 5),
    (16, 6), (17, 6), (18, 6),
    (19, 7), (20, 7), (21, 7),
    (22, 8), (23, 8), (24, 8),
    (25, 9), (26, 9), (27, 9),
    (28, 10), (29, 10), (30, 10),
    (31, 11), (32, 11), (33, 11),
    (25, 12), (26, 12), (27, 12),
    (1, 13), (2, 13), (3, 13),
    (4, 14), (5, 14), (6, 14),
    (7, 15), (8, 15), (9, 15),
    (10, 16), (11, 16), (12, 16),
    (13, 17), (14, 17), (15, 17),
    (16, 18), (17, 18), (18, 18),
    (19, 19), (20, 19), (21, 19),
    (22, 20), (23, 20), (24, 20);
GO

