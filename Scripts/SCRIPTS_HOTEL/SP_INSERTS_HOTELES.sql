--PROCEDIMIENTOS ALMACENADOS PARA LLENAR TABLAS TRANSACCIONALES 

-- OJO --
--DEBE EJECUTAR EL SCRIPT DML_HOTELES ANTES PARA TENER LOS REGISTROS NECESARIOS Y EVITAR ERRORES.
USE hoteles;
GO

--- 1000 RESERVACIONES 
CREATE PROCEDURE SP_InsertarReservaciones 
AS
BEGIN
	DECLARE @contador INT = 0;

	WHILE @contador < 1000 
	BEGIN
		INSERT INTO reservaciones (fecha_inicio, fecha_fin, id_cliente, id_habitacion)
		VALUES
			(GETDATE(), DATEADD( DAY, ROUND(RAND() * 100 + 1, 0), GETDATE()), ROUND(RAND() * 19 + 1, 0), ROUND(RAND() * 19 + 1, 0));
	SET @contador = @contador + 1;
	END;

END;
GO

--- 1000 EVALUACIONES 
CREATE PROCEDURE SP_InsertarEvaluaciones 
AS
BEGIN
	DECLARE @contador INT = 0;

	WHILE @contador < 1000 
	BEGIN
		INSERT INTO evaluaciones_hotel (limpieza, servicio_y_personal, condiciones_propiedad, 
					cuidado_medio_ambiente, fecha_evaluacion, 
					id_cliente, id_sucursal, sugerencias)
		VALUES
			(ROUND(RAND() * 4 + 1, 0),
			 ROUND(RAND() * 4 + 1, 0),
			 ROUND(RAND() * 4 + 1, 0),
			 ROUND(RAND() * 4 + 1, 0),
			 GETDATE(),
			 ROUND(RAND() * 19 + 1, 0),
			 ROUND(RAND() * 3 + 1, 0),
			 CONCAT('Sugerencia ', (@contador + 1))
			 );

	SET @contador = @contador + 1;
	END;

END;
GO

--- 1000 FACTURAS
CREATE PROCEDURE SP_InsertarFacturas 
AS
BEGIN
	DECLARE @contador INT = 1,
			@precio_reservacion DECIMAL(10,2) = 0,
			@impuesto DECIMAL(10,2) = 0,
			@id_cliente INT;

	WHILE @contador < 1001
	BEGIN
		SET @precio_reservacion = 
			(SELECT precio 
			FROM reservaciones AS r	
			INNER JOIN habitaciones AS h ON (r.id_habitacion = h.id_habitacion)
			WHERE id_reservacion = @contador);

		SET @impuesto = @precio_reservacion * 0.15;

		SET @id_cliente = 
			(SELECT id_cliente 
			FROM reservaciones
			WHERE id_reservacion = @contador);

		INSERT INTO facturas (subtotal, impuesto, total, id_cliente, id_forma_pago)
		VALUES 
			(@precio_reservacion, @impuesto, @precio_reservacion + @impuesto, @id_cliente, ROUND( RAND() * 9 + 1, 0));

		INSERT INTO detalle_factura (id_factura, id_reservacion)
		VALUES
			(@contador, @contador);

		SET @contador = @contador + 1;
	END;

END;
GO

--- EJECUTAR
BEGIN
	EXECUTE SP_InsertarEvaluaciones;
END;
GO

BEGIN
	EXECUTE SP_InsertarReservaciones;
END;
GO

BEGIN
	EXECUTE SP_InsertarFacturas;
END;
GO