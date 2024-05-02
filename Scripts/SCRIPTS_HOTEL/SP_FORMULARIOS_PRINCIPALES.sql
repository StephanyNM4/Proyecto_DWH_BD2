--- PROCEMIENTOS ALMACENADOS PARA FORMULARIOS PRINCIPALES DEL SISTEMA DE UN HOTEL ---

---Funcion para generar nombre de usuario
CREATE FUNCTION F_GenerarUsername(
	@nombre VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @username VARCHAR(100) = null,
			@cantidad_coincidencia INT,
			@coincidencia BIT = 1;
	 
	WHILE @coincidencia != 0 
	BEGIN
		SET @username = REPLACE(LOWER(@nombre), ' ', '');
		
		SET @cantidad_coincidencia = (
			SELECT COUNT(usuario)
			FROM clientes 
			WHERE usuario = @username
		); 

		IF @cantidad_coincidencia = 0
		BEGIN
			SET @coincidencia = 0; 
		END;
		ELSE
		BEGIN
			WHILE @coincidencia != 0	
			BEGIN
				DECLARE @contador INT = 0;
				SET @username = CONCAT(LOWER(@nombre), @contador);

				SET @cantidad_coincidencia = (
					SELECT COUNT(usuario)
					FROM clientes 
					WHERE usuario = @username
				); 

				IF @cantidad_coincidencia = 0
				BEGIN
					SET @coincidencia = 0; 
				END;

			END;
		END; 
	END;

	RETURN @username;
END;
GO

---Este procedimiento se usará para el formulario de registro. Una vez registrado, se le proporcionará un usuario y una contraseña temporal.
CREATE PROCEDURE SP_RegistrarCliente 
	@nombre VARCHAR(100),
	@apellido VARCHAR(100),
	@identidad VARCHAR(20),
	@correo VARCHAR(50),
	@telefono VARCHAR(20),
	@estado_civil VARCHAR(20),
	@genero VARCHAR(20),
	@ciudad VARCHAR(20),
	@referencia VARCHAR(500)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @id_ciudad INT,
					@id_direccion_recien_insertada INT,
					@id_persona_recien_insertada INT,
					@id_estado_civil INT,
					@id_genero INT,
					@username VARCHAR(20),
					@contrasenia_temporal VARCHAR(20);

			--OBTENER EL ID DEL ESTADO CIVIL REFERENCIADO
			SET @id_estado_civil = (
				SELECT id_estado_civil 
				FROM estados_civiles
				WHERE estado_civil = @estado_civil
			);

			--OBTENER EL ID DE LA CIUDAD REFERENCIADA
			SET @id_ciudad = (
				SELECT MAX(id_ciudad) 
				FROM ciudades
				WHERE nombre_ciudad = @ciudad
			);
			
			--OBTENER EL ID DEL GENERO REFERENCIADO
			SET @id_genero = (
				SELECT id_genero 
				FROM generos
				WHERE genero = @genero
			);

			INSERT INTO direcciones (referencia, id_ciudad)
			VALUES
				(@referencia, @id_ciudad);

			---OBTENER EL ID DE LA DIRECCIÓN RECIEN INSERTADA
			SET @id_direccion_recien_insertada = SCOPE_IDENTITY();
			
			INSERT INTO personas (nombre, apellido, no_identidad, correo, telefono, id_estado_civil, id_genero, id_direccion)
			VALUES 
				(@nombre, @apellido, @identidad, @correo, @telefono, @id_estado_civil, @id_genero, @id_direccion_recien_insertada);

			---OBTENER EL ID DE LA PERSONA RECIEN INSERTADA
			SET @id_persona_recien_insertada = SCOPE_IDENTITY();

			--- Registrar como cliente

			--- proporcionar un nombre de usuario
			SET @username = dbo.F_GenerarUsername(@nombre);

			---proporcionar una contraseña temporal
			SET @contrasenia_temporal = '12345678';

			INSERT INTO clientes (fecha_registro, usuario, contrasenia, id_persona)
			VALUES 
				(FORMAT(GETDATE(), 'dd/MM/yy'), @username, @contrasenia_temporal, @id_persona_recien_insertada);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		PRINT 'TODOS LOS CAMPOS SON OBLIGATORIOS. - ' + ERROR_MESSAGE();

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH;
END;
GO

--- Después de registrarse el usuario deberá cambiar su contraseña. Para eso es este procedimiento.
CREATE PROCEDURE SP_CambiarContraseña
	@id_cliente INT,
	@contrasenia_anterior VARCHAR(50),
	@contrasenia_nueva VARCHAR(50),
	@contrasenia_nueva_confirmar VARCHAR(50)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @cant_coincidencias INT = 0;
			
			--VERIFICAR QUE ES EL USUARIO CORRESPONDE A LA CONTRASEÑA
			SET @cant_coincidencias = (
				SELECT COUNT(*)
				FROM clientes 
				WHERE id_cliente = @id_cliente AND contrasenia = @contrasenia_anterior
			);

			IF @cant_coincidencias > 0
				BEGIN
					--- VERIFICAR QUE ESCRIBIÓ BIEN LA CONTRASEÑA NUEVA 
					IF @contrasenia_nueva = @contrasenia_nueva_confirmar
						BEGIN
							UPDATE clientes SET contrasenia = @contrasenia_nueva WHERE id_cliente = @id_cliente;
						END;
					ELSE
						BEGIN
							PRINT 'ERROR - LA NUEVA CONTRASEÑA NO COINCIDE CON LA CONFIRMACIÓN.';
						END;
				END;
			ELSE 
				BEGIN
					PRINT 'ERROR - EL USUARIO NO COINCIDE CON LA CONTRASEÑA PROPORCIONADA';
				END;

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT 'ERROR AL CAMBIAR LA CONTRASEÑA';
		ROLLBACK;
	END CATCH
END;
GO

--- Procedimiento para iniciar sesión en le sistema.
CREATE PROCEDURE SP_IniciarSesion
	@usuario VARCHAR(100),
	@contrasenia VARCHAR(100)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @cant_coincidencias INT = 0;

			SET @cant_coincidencias = (
				SELECT COUNT(*) 
				FROM clientes 
				WHERE usuario = @usuario AND contrasenia = @contrasenia
			);

			IF @cant_coincidencias > 0
				BEGIN
					SELECT 'INICIO EXITOSO.' AS Estado;
				END
			ELSE
				BEGIN
					SELECT 'FALLÓ AL INICIAR SESIÓN...' AS Estado;
				END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT 'ERROR AL INICIAR SESIÓN.';
	END CATCH
END;
GO

--- Este procedimiento se utilizara para realizar una reservaciones.
CREATE PROCEDURE SP_HacerReservacion
	@fecha_inicio DATE,
	@fecha_fin DATE,
	@id_cliente INT,
	@id_habitacion INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO reservaciones (fecha_inicio, fecha_fin, id_cliente, id_habitacion)
			VALUES 
				(@fecha_inicio, @fecha_fin, @id_cliente, @id_habitacion);
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		PRINT 'ERROR AL REGISTRAR RESERVACIÓN - ' + ERROR_MESSAGE();
		ROLLBACK;
	END CATCH
END;
GO

--- Procedimiento para que un cliente pague todas sus reservaciones pendientes, este se ejecutará en un formulario que se abrirá
--- inmediatamente después de que el cliente haga sus reservaciones, las cuales tendran el campo pagado en 0.
--- En caso de ocurrir un error, se eliminan las reservaciones, practicamente el cliente debera repetir todo el proceso en el sistema.
CREATE PROCEDURE SP_PagarReservaciones 
	@id_cliente INT,
	@forma_de_pago VARCHAR(200)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @id_forma_pago INT = (
				SELECT id_forma_pago
				FROM formas_de_pago
				WHERE forma_de_pago = @forma_de_pago
			);

			DECLARE @id_factura_recien_insertada INT,
					@id_reservacion INT,
					@cantidad_reservaciones INT;
			
			--- CANTIDAD DE RESERVACIONES
			SET @cantidad_reservaciones = (
				SELECT COUNT(*)
				FROM reservaciones 
				WHERE id_cliente = @id_cliente AND pagado = 0
			);

			--- CURSOR CON LAS RESERVACIONES INACTIVAS DEL CLIENTE.
			DECLARE c_reservaciones CURSOR FOR 
				SELECT id_reservacion
				FROM reservaciones 
				WHERE id_cliente = @id_cliente AND pagado = 0
			;

			OPEN c_reservaciones;
			FETCH NEXT FROM c_reservaciones INTO @id_reservacion;

			--- CREAR LA FACTURA PARA EL CLIENTE
			IF @cantidad_reservaciones > 0
				BEGIN
					INSERT INTO facturas (id_cliente, id_forma_pago)
					VALUES
					(@id_cliente, @id_forma_pago);

					--CREAR DETALLE DE FACTURA CON TODAS SUS RESERVACIONES
					SET @id_factura_recien_insertada = SCOPE_IDENTITY();

					WHILE @@FETCH_STATUS = 0
						BEGIN
							--AGREGAR RESERVACION AL DETALLE DE LA FACTURA
							INSERT INTO detalle_factura(id_factura, id_reservacion)
							VALUES
								(@id_factura_recien_insertada, @id_reservacion);

							---MARCAR RESERVACIÓN COMO PAGADA Y ACTIVA
							UPDATE reservaciones SET activa = 1, pagado = 1 WHERE id_reservacion = @id_reservacion;

							FETCH NEXT FROM c_reservaciones INTO @id_reservacion;
						END;
				END;
			ELSE
				BEGIN
					PRINT 'NO DEBE';
				END;

		CLOSE c_reservaciones;
		DEALLOCATE c_reservaciones;

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT 'ERROR AL REALIZAR PAGO. SE ELIMINARÁ LA RESERVACIÓN. / ' + ERROR_MESSAGE();
		ROLLBACK;

		OPEN c_reservaciones;
		FETCH NEXT FROM c_reservaciones INTO @id_reservacion;

		WHILE @@FETCH_STATUS = 0
			BEGIN
				--ELIMINAR DETALLE
				DELETE FROM detalle_factura WHERE id_reservacion = @Id_reservacion;

				---ELIMINAR RESERVACION
				DELETE FROM reservaciones WHERE id_cliente = @id_cliente AND pagado = 0;

				FETCH NEXT FROM c_reservaciones INTO @id_reservacion;
			END;

		CLOSE c_reservaciones;
		DEALLOCATE c_reservaciones;
	END CATCH;
END;
GO

---Procedimiento para Evaluar un hotel.
CREATE PROCEDURE SP_EvaluarHotel
	@limpieza INT = 3,
    @servicio_y_personal INT = 3,
    @condiciones_propiedad INT = 3,
    @cuidado_medio_ambiente INT = 3,
	@id_cliente INT,
	@id_sucursal INT,
	@sugerencias VARCHAR(1000) = '...'
AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @fecha_evaluacion DATE;
			SET @fecha_evaluacion = GETDATE();

			INSERT INTO evaluaciones_hotel(limpieza, servicio_y_personal, condiciones_propiedad, cuidado_medio_ambiente, fecha_evaluacion, id_cliente, id_sucursal, sugerencias)
			VALUES
				(@limpieza, @servicio_y_personal, @condiciones_propiedad, @cuidado_medio_ambiente, @fecha_evaluacion, @id_cliente, @id_sucursal, @sugerencias);
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		PRINT 'ERROR AL GUARDAR LA EVALUACIÓN.';
	END CATCH
END;
GO

---PRUEBAS
BEGIN
	EXECUTE SP_RegistrarCliente 
		@nombre = 'Usuario de Prueba',
		@apellido = 'Apellido Prueba',
		@identidad = 'XXXXXXXXXXXX2',
		@correo = 'usuario@prueba.com',
		@telefono = '12345678',
		@estado_civil = 'Soltero',
		@genero = 'Masculino',
		@ciudad = 'Tegucigalpa',
		@referencia = 'Col. Suyapa 2';
END;
GO

select * from direcciones;

BEGIN
	EXECUTE SP_HacerReservacion 
		@fecha_inicio = '2024-04-30',
		@fecha_fin = '2024-05-05',
		@id_cliente = 21,
		@id_habitacion = 1;
END;
GO

BEGIN
	EXECUTE SP_PagarReservaciones 
		@id_cliente = 5,
		@forma_de_pago = 'Efectivo'
END;
GO

BEGIN
	EXECUTE SP_EvaluarHotel
		@limpieza = 5,
		@servicio_y_personal = 5,
		@condiciones_propiedad = 5,
		@cuidado_medio_ambiente = 5,
		@id_cliente = 1,
		@id_sucursal = 1,
		@sugerencias  = 'Ninguna. Excelente servicio.'
END;
GO

BEGIN
	EXECUTE SP_CambiarContraseña
		@id_cliente = 1,
		@contrasenia_anterior = 'contraseña20',
		@contrasenia_nueva = '12345',
		@contrasenia_nueva_confirmar = '12345'
END;
GO

BEGIN
	EXECUTE SP_IniciarSesion
		@usuario = 'samuel',
		@contrasenia = 'contraseña21'
END;
GO