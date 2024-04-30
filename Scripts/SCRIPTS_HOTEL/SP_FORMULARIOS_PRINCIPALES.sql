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
	@fecha_nac DATE,
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
			select @id_ciudad AS ID_CIUDAD, @id_estado_civil AS id_estado, @estado_civil as estado;
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
			
			INSERT INTO personas (nombre, apellido, no_identidad, fecha_nacimiento, correo, telefono, id_estado_civil, id_genero, id_direccion)
			VALUES 
				(@nombre, @apellido, @identidad, @fecha_nac, @correo, @telefono, @id_estado_civil, @id_genero, @id_direccion_recien_insertada);

			---OBTENER EL ID DE LA PERSONA RECIEN INSERTADA
			SET @id_persona_recien_insertada = SCOPE_IDENTITY();

			--- Registrar como cliente

			--- proporcionar un nombre de usuario
			SET @username = dbo.F_GenerarUsername(@nombre);

			---proporcionar una contraseña temporal
			SET @contrasenia_temporal = '12345678';

			INSERT INTO clientes (fecha_registro, usuario, contrasenia, id_persona)
			VALUES 
				(GETDATE(), @username, @contrasenia_temporal, @id_persona_recien_insertada);

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		PRINT 'TODOS LOS CAMPOS SON OBLIGATORIOS. - ' + ERROR_MESSAGE();

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH;
END;
GO

---PRUEBAS
BEGIN
	EXECUTE SP_RegistrarCliente 
		@nombre = 'Usuario de Prueba',
		@apellido = 'Apellido Prueba',
		@identidad = 'XXXXXXXXXXXX2',
		@fecha_nac = '2000-01-01',
		@correo = 'usuario@prueba.com',
		@telefono = '12345678',
		@estado_civil = 'Soltero',
		@genero = 'Masculino',
		@ciudad = 'Tegucigalpa',
		@referencia = 'Col. Suyapa';
END;
GO