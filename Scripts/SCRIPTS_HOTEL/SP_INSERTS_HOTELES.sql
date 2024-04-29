--PROCEDIMIENTOS ALMACENADOS PARA LLENAR TABLAS TRANSACCIONALES 

-- OJO --
--DEBE EJECUTAR EL SCRIPT DML_HOTELES ANTES PARA TENER LOS REGISTROS NECESARIOS Y EVITAR ERRORES.
USE hoteles;
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
END;
GO

--- 1000 RESERVACIONES 
CREATE PROCEDURE SP_InsertarReservaciones 
AS
BEGIN
END;
GO

--- EJECUTAR
BEGIN
	EXECUTE SP_InsertarEvaluaciones;
END;