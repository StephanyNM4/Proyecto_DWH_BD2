-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2024-05-02 01:17:28 CST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tbl_amenidades (
    id_amenidad INTEGER NOT NULL,
    amenidad    VARCHAR2(1000) NOT NULL,
    categoria   VARCHAR2(100)
);

ALTER TABLE tbl_amenidades ADD CONSTRAINT tbl_amenidades_pk PRIMARY KEY ( id_amenidad );

CREATE TABLE tbl_amenidades_x_habitacion (
    codigo_habitacion VARCHAR2(20) NOT NULL,
    id_amenidad       INTEGER NOT NULL
);

ALTER TABLE tbl_amenidades_x_habitacion ADD CONSTRAINT tbl_amenidades_x_habitacion_pk PRIMARY KEY ( codigo_habitacion,
                                                                                                    id_amenidad );

CREATE TABLE tbl_asientos (
    id_asiento          NUMBER NOT NULL,
    id_vuelo            VARCHAR2(30) NOT NULL,
    nombre_asiento      VARCHAR2(10),
    disponible          CHAR(1),
    tipo_asiento        VARCHAR2(100),
    precio_base_asiento NUMBER
);

ALTER TABLE tbl_asientos ADD CONSTRAINT tbl_asientos_pk PRIMARY KEY ( id_asiento );

CREATE TABLE tbl_boletos (
    id_boleto          NUMBER NOT NULL,
    id_asiento         NUMBER NOT NULL,
    id_vuelo           VARCHAR2(30),
    id_escala          NUMBER,
    correo_electronico VARCHAR2(100) NOT NULL,
    precio             NUMBER,
    estado_reserva     VARCHAR2(200),
    fecha_boleto       DATE
);

ALTER TABLE tbl_boletos ADD CONSTRAINT tbl_boletos_pk PRIMARY KEY ( id_boleto );

CREATE TABLE tbl_carreras (
    id_carrera       VARCHAR2(24) NOT NULL,
    id_conductor     VARCHAR2(24) NOT NULL,
    id_cliente       VARCHAR2(100) NOT NULL,
    lng_inicio       NUMBER,
    lat_inicio       NUMBER,
    ubicacion_inicio VARCHAR2(200),
    lng_final        NUMBER,
    lat_final        NUMBER,
    estado           CHAR(1),
    fecha            DATE,
    monto_total      NUMBER
);

ALTER TABLE tbl_carreras ADD CONSTRAINT tbl_carreras_pk PRIMARY KEY ( id_carrera );

CREATE TABLE tbl_clientes (
    correo_electronico   VARCHAR2(100) NOT NULL,
    nombre               VARCHAR2(100),
    apellido             VARCHAR2(100),
    telefono             VARCHAR2(50),
    contrasena_uber      VARCHAR2(100),
    contrasena_hotel     VARCHAR2(100),
    contrasena_aerolinea VARCHAR2(100),
    genero               CHAR(1),
    fecha_registro       DATE
);

ALTER TABLE tbl_clientes ADD CONSTRAINT tbl_clientes_pk PRIMARY KEY ( correo_electronico );

CREATE TABLE tbl_comentarios (
    id_comentario VARCHAR2(24) NOT NULL,
    id_carrera    VARCHAR2(24) NOT NULL,
    comentario    VARCHAR2(500),
    puntuacion    INTEGER,
    fecha         DATE
);

ALTER TABLE tbl_comentarios ADD CONSTRAINT tbl_comentarios_pk PRIMARY KEY ( id_comentario );

CREATE TABLE tbl_conductores (
    id_conductor       VARCHAR2(24) NOT NULL,
    nombre             VARCHAR2(100),
    apellido           VARCHAR2(100),
    telefono           VARCHAR2(30),
    correo             VARCHAR2(200),
    fecha_nacimiento   DATE,
    fecha_contratacion DATE,
    tipo_uber          VARCHAR2(100)
);

ALTER TABLE tbl_conductores ADD CONSTRAINT tbl_conductores_pk PRIMARY KEY ( id_conductor );

CREATE TABLE tbl_detalles_facturas (
    id_reservacion INTEGER NOT NULL,
    id_factura_dwh VARCHAR2(50) NOT NULL
);

ALTER TABLE tbl_detalles_facturas ADD CONSTRAINT tbl_detalles_facturas_pk PRIMARY KEY ( id_reservacion );

CREATE TABLE tbl_empleados (
    id_empleado        NUMBER NOT NULL,
    nombre             VARCHAR2(50),
    apellido           VARCHAR2(50),
    correo_electronico VARCHAR2(50),
    contrasenia        VARCHAR2(20),
    telefono           VARCHAR2(20),
    genero             VARCHAR2(20),
    estado_civil       VARCHAR2(20),
    id_tipo_empleado   NUMBER NOT NULL
);

ALTER TABLE tbl_empleados ADD CONSTRAINT tbl_empleados_pk PRIMARY KEY ( id_empleado );

CREATE TABLE tbl_equipajes (
    id_equipaje   NUMBER NOT NULL,
    tipo_equipaje VARCHAR2(100),
    peso          NUMBER,
    costo         NUMBER
);

ALTER TABLE tbl_equipajes ADD CONSTRAINT tbl_equipajes_pk PRIMARY KEY ( id_equipaje );

CREATE TABLE tbl_equipajes_por_boleto (
    id_equipaje       NUMBER NOT NULL,
    id_boleto_factura NUMBER NOT NULL
);

CREATE TABLE tbl_escalas (
    id_escala      NUMBER NOT NULL,
    id_vuelo_padre VARCHAR2(30) NOT NULL,
    id_vuelo       VARCHAR2(30) NOT NULL
);

ALTER TABLE tbl_escalas ADD CONSTRAINT tbl_escalas_pk PRIMARY KEY ( id_escala );

CREATE TABLE tbl_evaluaciones_x_hotel (
    id_evaluacion         INTEGER NOT NULL,
    id_hotel              INTEGER NOT NULL,
    correo_cliente        VARCHAR2(100) NOT NULL,
    limpieza              INTEGER,
    servicio_y_personal   INTEGER,
    condiciones_propiedad INTEGER,
    calificacion_promedio NUMBER,
    fecha_evaluacion      DATE NOT NULL
);

ALTER TABLE tbl_evaluaciones_x_hotel ADD CONSTRAINT tbl_evaluaciones_x_hotel_pk PRIMARY KEY ( id_evaluacion );

CREATE TABLE tbl_factura_boletos (
    id_boleto_factura NUMBER NOT NULL,
    id_factura_dwh    VARCHAR2(50) NOT NULL,
    id_boleto         NUMBER NOT NULL,
    subtotal          NUMBER
);

ALTER TABLE tbl_factura_boletos ADD CONSTRAINT tbl_factura_boletos_pk PRIMARY KEY ( id_boleto_factura );

CREATE TABLE tbl_facturas (
    id_factura_dwh       VARCHAR2(50) NOT NULL,
    id_factura_aerolinea VARCHAR2(50),
    id_factura_hotel     VARCHAR2(50),
    fecha_factura        DATE,
    impuesto_porcentaje  NUMBER,
    impuesto_valor       NUMBER,
    total                NUMBER,
    metodo_pago          VARCHAR2(100)
);

ALTER TABLE tbl_facturas ADD CONSTRAINT tbl_facturas_pk PRIMARY KEY ( id_factura_dwh );

CREATE TABLE tbl_habitaciones (
    codigo_habitacion VARCHAR2(20) NOT NULL,
    id_hotel          INTEGER NOT NULL,
    precio            NUMBER(10, 2),
    limite_personas   INTEGER,
    cantidad_camas    INTEGER,
    descripcion       VARCHAR2(1000),
    disponible        CHAR(1) NOT NULL
);

ALTER TABLE tbl_habitaciones ADD CONSTRAINT tbl_habitaciones_pk PRIMARY KEY ( codigo_habitacion );

CREATE TABLE tbl_historico_ubers (
    id_historico VARCHAR2(24) NOT NULL,
    id_conductor VARCHAR2(24),
    marca        VARCHAR2(100),
    color        VARCHAR2(50),
    placa        VARCHAR2(50),
    anio         INTEGER,
    fecha_inicio DATE,
    fecha_final  DATE
);

ALTER TABLE tbl_historico_ubers ADD CONSTRAINT tbl_historico_ubers_pk PRIMARY KEY ( id_historico );

CREATE TABLE tbl_hoteles (
    id_hotel           INTEGER NOT NULL,
    nombre             VARCHAR2(100) NOT NULL,
    descripcion        VARCHAR2(1000),
    correo             VARCHAR2(100),
    sitio_web          VARCHAR2(100),
    telefono_principal VARCHAR2(20),
    pais               VARCHAR2(150),
    ciudad             VARCHAR2(150)
);

CREATE UNIQUE INDEX uq_correo_hotel ON
    tbl_hoteles (
        correo
    ASC );

ALTER TABLE tbl_hoteles ADD CONSTRAINT tbl_hoteles_pk PRIMARY KEY ( id_hotel );

CREATE TABLE tbl_logs (
    id           INTEGER NOT NULL,
    nombre       VARCHAR2(100),
    fecha_inicio DATE,
    fecha_final  DATE,
    nombre_base  VARCHAR2(50),
    exito        VARCHAR2(20),
    error        VARCHAR2(200)
);

ALTER TABLE tbl_logs ADD CONSTRAINT tbl_logs_pk PRIMARY KEY ( id );

CREATE TABLE tbl_politicas (
    id_politica INTEGER NOT NULL,
    politica    VARCHAR2(1000)
);

ALTER TABLE tbl_politicas ADD CONSTRAINT tbl_politicas_pk PRIMARY KEY ( id_politica );

CREATE TABLE tbl_politicas_x_hotel (
    id_politica INTEGER NOT NULL,
    id_hotel    INTEGER NOT NULL
);

CREATE TABLE tbl_reservaciones (
    id_reservacion    INTEGER NOT NULL,
    codigo_habitacion VARCHAR2(20) NOT NULL,
    correo_cliente    VARCHAR2(100) NOT NULL,
    fecha_inicio      DATE NOT NULL,
    fecha_fin         DATE NOT NULL,
    precio            NUMBER NOT NULL,
    fecha_reservacion DATE
);

ALTER TABLE tbl_reservaciones ADD CONSTRAINT tbl_reservaciones_pk PRIMARY KEY ( id_reservacion );

CREATE TABLE tbl_seguimientos_equipaje (
    id_seguimiento  NUMBER NOT NULL,
    id_equipaje     NUMBER NOT NULL,
    latitud         VARCHAR2(50),
    estado_equipaje VARCHAR2(150)
);

ALTER TABLE tbl_seguimientos_equipaje ADD CONSTRAINT tbl_seguimientos_equipaje_pk PRIMARY KEY ( id_seguimiento );

CREATE TABLE tbl_servicios (
    id_servicio_dwh       VARCHAR2(50) NOT NULL,
    id_servicio_aerolinea VARCHAR2(50),
    id_servicio_hotel     VARCHAR2(50),
    servicio              VARCHAR2(200),
    costo                 NUMBER,
    tipo_servicio         VARCHAR2(100)
);

ALTER TABLE tbl_servicios ADD CONSTRAINT tbl_servicios_pk PRIMARY KEY ( id_servicio_dwh );

CREATE TABLE tbl_servicios_por_boleto (
    id_servicio_dwh   VARCHAR2(50) NOT NULL,
    id_boleto_factura NUMBER NOT NULL
);

CREATE TABLE tbl_servicios_x_hotel (
    id_hotel        INTEGER NOT NULL,
    id_servicio_dwh VARCHAR2(50) NOT NULL
);

ALTER TABLE tbl_servicios_x_hotel ADD CONSTRAINT tbl_servicios_x_hotel_pk PRIMARY KEY ( id_hotel,
                                                                                        id_servicio_dwh );

CREATE TABLE tbl_tipos_empleados (
    id_tipo_empleado NUMBER NOT NULL,
    tipo_empleado    VARCHAR2(50) NOT NULL,
    salario_min      NUMBER,
    salario_max      NUMBER,
    area             VARCHAR2(50)
);

ALTER TABLE tbl_tipos_empleados ADD CONSTRAINT tbl_tipos_empleados_pk PRIMARY KEY ( id_tipo_empleado );

CREATE TABLE tbl_vuelos (
    id_vuelo            VARCHAR2(30) NOT NULL,
    aerolinea           VARCHAR2(150),
    fecha_partida       DATE,
    aeropuerto_partida  VARCHAR2(200),
    aeropuerto_llegada  VARCHAR2(200),
    numero_vuelo        NUMBER,
    hora_llegada        VARCHAR2(15),
    hora_partida        VARCHAR2(15),
    gate                NUMBER,
    tipo_vuelo          CHAR(1),
    descuento           NUMBER,
    fecha_fin_descuento DATE,
    capacidad_pasajeros NUMBER,
    modelo_avion        VARCHAR2(100),
    lugar_origen        VARCHAR2(200),
    lugar_destino       VARCHAR2(200),
    distancia           NUMBER
);

ALTER TABLE tbl_vuelos ADD CONSTRAINT tbl_vuelos_pk PRIMARY KEY ( id_vuelo );

CREATE TABLE tbl_zonas_restringidas (
    id_zona_restringida VARCHAR2(24) NOT NULL,
    lng                 NUMBER,
    lat                 NUMBER,
    ubicacion_nombre    VARCHAR2(200)
);

ALTER TABLE tbl_zonas_restringidas ADD CONSTRAINT tbl_zonas_restringidas_pk PRIMARY KEY ( id_zona_restringida );

ALTER TABLE tbl_amenidades_x_habitacion
    ADD CONSTRAINT fk_amenidades_hab FOREIGN KEY ( codigo_habitacion )
        REFERENCES tbl_habitaciones ( codigo_habitacion );

ALTER TABLE tbl_amenidades_x_habitacion
    ADD CONSTRAINT fk_amenidades_hab_am FOREIGN KEY ( id_amenidad )
        REFERENCES tbl_amenidades ( id_amenidad );

ALTER TABLE tbl_detalles_facturas
    ADD CONSTRAINT fk_detalle_reservacion FOREIGN KEY ( id_reservacion )
        REFERENCES tbl_reservaciones ( id_reservacion );

ALTER TABLE tbl_evaluaciones_x_hotel
    ADD CONSTRAINT fk_evaluaciones_hotel FOREIGN KEY ( id_hotel )
        REFERENCES tbl_hoteles ( id_hotel );

ALTER TABLE tbl_politicas_x_hotel
    ADD CONSTRAINT fk_politicas_x_hotel_hotel FOREIGN KEY ( id_hotel )
        REFERENCES tbl_hoteles ( id_hotel );

ALTER TABLE tbl_politicas_x_hotel
    ADD CONSTRAINT fk_politicas_x_hotel_politica FOREIGN KEY ( id_politica )
        REFERENCES tbl_politicas ( id_politica );

ALTER TABLE tbl_reservaciones
    ADD CONSTRAINT fk_reservaciones_habit FOREIGN KEY ( codigo_habitacion )
        REFERENCES tbl_habitaciones ( codigo_habitacion );

ALTER TABLE tbl_servicios_x_hotel
    ADD CONSTRAINT fk_servicios_x_hotel_h FOREIGN KEY ( id_hotel )
        REFERENCES tbl_hoteles ( id_hotel );

ALTER TABLE tbl_empleados
    ADD CONSTRAINT fk_tipos_emp_tipo FOREIGN KEY ( id_tipo_empleado )
        REFERENCES tbl_tipos_empleados ( id_tipo_empleado );

ALTER TABLE tbl_asientos
    ADD CONSTRAINT tbl_asientos_tbl_v_fk FOREIGN KEY ( id_vuelo )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_bol_tbl_cli_fk FOREIGN KEY ( correo_electronico )
        REFERENCES tbl_clientes ( correo_electronico );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_as_fk FOREIGN KEY ( id_asiento )
        REFERENCES tbl_asientos ( id_asiento );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_es_fk FOREIGN KEY ( id_escala )
        REFERENCES tbl_escalas ( id_escala );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_vuelos_fk FOREIGN KEY ( id_vuelo )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_carreras
    ADD CONSTRAINT tbl_car_tbl_cli_fk FOREIGN KEY ( id_cliente )
        REFERENCES tbl_clientes ( correo_electronico );

ALTER TABLE tbl_carreras
    ADD CONSTRAINT tbl_carreras_tbl_c_fk FOREIGN KEY ( id_conductor )
        REFERENCES tbl_conductores ( id_conductor );

ALTER TABLE tbl_comentarios
    ADD CONSTRAINT tbl_com_tbl_c_fk FOREIGN KEY ( id_carrera )
        REFERENCES tbl_carreras ( id_carrera );

ALTER TABLE tbl_detalles_facturas
    ADD CONSTRAINT tbl_d_f_tbl_f_fk FOREIGN KEY ( id_factura_dwh )
        REFERENCES tbl_facturas ( id_factura_dwh );

ALTER TABLE tbl_equipajes_por_boleto
    ADD CONSTRAINT tbl_e_p_b_tbl_e_fk FOREIGN KEY ( id_equipaje )
        REFERENCES tbl_equipajes ( id_equipaje );

ALTER TABLE tbl_equipajes_por_boleto
    ADD CONSTRAINT tbl_e_p_b_tbl_f_b_fk FOREIGN KEY ( id_boleto_factura )
        REFERENCES tbl_factura_boletos ( id_boleto_factura );

ALTER TABLE tbl_escalas
    ADD CONSTRAINT tbl_es_tbl_v_fk FOREIGN KEY ( id_vuelo_padre )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_escalas
    ADD CONSTRAINT tbl_escalas_tbl_v_fk FOREIGN KEY ( id_vuelo )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_evaluaciones_x_hotel
    ADD CONSTRAINT tbl_eva_x_hot_tbl_cli_fk FOREIGN KEY ( correo_cliente )
        REFERENCES tbl_clientes ( correo_electronico );

ALTER TABLE tbl_factura_boletos
    ADD CONSTRAINT tbl_f_b_tbl_f_fk FOREIGN KEY ( id_factura_dwh )
        REFERENCES tbl_facturas ( id_factura_dwh );

ALTER TABLE tbl_factura_boletos
    ADD CONSTRAINT tbl_factura_b_tbl_b_fk FOREIGN KEY ( id_boleto )
        REFERENCES tbl_boletos ( id_boleto );

ALTER TABLE tbl_habitaciones
    ADD CONSTRAINT tbl_habitaciones_hoteles_fk FOREIGN KEY ( id_hotel )
        REFERENCES tbl_hoteles ( id_hotel );

ALTER TABLE tbl_historico_ubers
    ADD CONSTRAINT tbl_hi_ub_tbl_c_fk FOREIGN KEY ( id_conductor )
        REFERENCES tbl_conductores ( id_conductor );

ALTER TABLE tbl_reservaciones
    ADD CONSTRAINT tbl_res_tbl_cli_fk FOREIGN KEY ( correo_cliente )
        REFERENCES tbl_clientes ( correo_electronico );

ALTER TABLE tbl_servicios_por_boleto
    ADD CONSTRAINT tbl_s_p_b_tbl_f_b_fk FOREIGN KEY ( id_boleto_factura )
        REFERENCES tbl_factura_boletos ( id_boleto_factura );

ALTER TABLE tbl_servicios_por_boleto
    ADD CONSTRAINT tbl_s_p_b_tbl_s_fk FOREIGN KEY ( id_servicio_dwh )
        REFERENCES tbl_servicios ( id_servicio_dwh );

ALTER TABLE tbl_servicios_x_hotel
    ADD CONSTRAINT tbl_s_x_h_tbl_s_fk FOREIGN KEY ( id_servicio_dwh )
        REFERENCES tbl_servicios ( id_servicio_dwh );

ALTER TABLE tbl_seguimientos_equipaje
    ADD CONSTRAINT tbl_se_e_tbl_e_fk FOREIGN KEY ( id_equipaje )
        REFERENCES tbl_equipajes ( id_equipaje );

CREATE SEQUENCE tbl_logs_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tbl_logs_id_trg BEFORE
    INSERT ON tbl_logs
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := tbl_logs_id_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            30
-- CREATE INDEX                             1
-- ALTER TABLE                             61
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
