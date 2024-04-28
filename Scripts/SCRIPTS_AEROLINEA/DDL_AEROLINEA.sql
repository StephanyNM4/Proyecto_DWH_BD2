-- Generated by Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   at:        2024-04-22 14:27:26 CST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tbl_aerolineas (
    id_aerolinea NUMBER NOT NULL,
    aerolinea    VARCHAR2(30)
);

ALTER TABLE tbl_aerolineas ADD CONSTRAINT tbl_aerolinea_pk PRIMARY KEY ( id_aerolinea );

CREATE TABLE tbl_aeropuertos (
    id_aeropuerto NUMBER NOT NULL,
    aeropuerto    VARCHAR2(500)
);

ALTER TABLE tbl_aeropuertos ADD CONSTRAINT tbl_aeropuertos_pk PRIMARY KEY ( id_aeropuerto );

CREATE TABLE tbl_asientos (
    id_asiento      NUMBER NOT NULL,
    id_tipo_asiento NUMBER NOT NULL,
    id_vuelo        VARCHAR2(30) NOT NULL,
    nombre_asiento  VARCHAR2(10),
    disponible      CHAR(1)
);

ALTER TABLE tbl_asientos ADD CONSTRAINT tbl_asientos_pk PRIMARY KEY ( id_asiento );

CREATE TABLE tbl_aviones (
    id_avion            NUMBER NOT NULL,
    id_aerolinea        NUMBER NOT NULL,
    id_modelo           NUMBER NOT NULL,
    capacidad_pasajeros NUMBER
);

ALTER TABLE tbl_aviones ADD CONSTRAINT tbl_aviones_pk PRIMARY KEY ( id_avion );

CREATE TABLE tbl_boletos (
    id_boleto  NUMBER NOT NULL,
    id_asiento NUMBER NOT NULL,
    id_cliente NUMBER NOT NULL,
    id_vuelo   VARCHAR2(30),
    id_escala  NUMBER,
    id_reserva NUMBER,
    precio     NUMBER
);

ALTER TABLE tbl_boletos ADD CONSTRAINT tbl_boletos_pk PRIMARY KEY ( id_boleto );

CREATE TABLE tbl_clientes (
    id_cliente     NUMBER NOT NULL,
    fecha_registro DATE
);

ALTER TABLE tbl_clientes ADD CONSTRAINT tbl_clientes_pk PRIMARY KEY ( id_cliente );

CREATE TABLE tbl_empleados (
    id_empleado      NUMBER NOT NULL,
    id_tipo_empleado NUMBER NOT NULL
);

ALTER TABLE tbl_empleados ADD CONSTRAINT tbl_empleados_pk PRIMARY KEY ( id_empleado );

CREATE TABLE tbl_equipajes (
    id_equipaje      NUMBER NOT NULL,
    id_tipo_equipaje NUMBER NOT NULL,
    peso_adicional   NUMBER,
    costo_adicional  NUMBER
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

CREATE TABLE tbl_estado_reserva (
    id_estado_reserva NUMBER NOT NULL,
    estado_reserva    VARCHAR2(100)
);

ALTER TABLE tbl_estado_reserva ADD CONSTRAINT tbl_estado_reserva_pk PRIMARY KEY ( id_estado_reserva );

CREATE TABLE tbl_estados_equipaje (
    id_estado NUMBER NOT NULL,
    estado    VARCHAR2(100)
);

ALTER TABLE tbl_estados_equipaje ADD CONSTRAINT tbl_estados_equipaje_pk PRIMARY KEY ( id_estado );

CREATE TABLE tbl_factura_boletos (
    id_boleto_factura NUMBER NOT NULL,
    id_factura        NUMBER NOT NULL,
    id_boleto         NUMBER NOT NULL,
    subtotal          NUMBER
);

ALTER TABLE tbl_factura_boletos ADD CONSTRAINT tbl_factura_boletos_pk PRIMARY KEY ( id_boleto_factura );

CREATE TABLE tbl_facturas (
    id_factura          NUMBER NOT NULL,
    id_metodo_pago      NUMBER NOT NULL,
    fecha_factura       DATE,
    impuesto_porcentaje NUMBER,
    impuesto_valor      NUMBER,
    total               NUMBER
);

ALTER TABLE tbl_facturas ADD CONSTRAINT tbl_facturas_pk PRIMARY KEY ( id_factura );

CREATE TABLE tbl_generos (
    id_genero NUMBER NOT NULL,
    genero    VARCHAR2(50)
);

ALTER TABLE tbl_generos ADD CONSTRAINT tbl_generos_pk PRIMARY KEY ( id_genero );

CREATE TABLE tbl_lugares (
    id_lugar       NUMBER NOT NULL,
    id_lugar_padre NUMBER,
    id_tipo_lugar  NUMBER NOT NULL,
    lugar          VARCHAR2(500),
    zip            NUMBER
);

ALTER TABLE tbl_lugares ADD CONSTRAINT tbl_lugares_pk PRIMARY KEY ( id_lugar );

CREATE TABLE tbl_metodo_pago (
    id_metodo_pago NUMBER NOT NULL,
    metodo_pago    VARCHAR2(100)
);

ALTER TABLE tbl_metodo_pago ADD CONSTRAINT tbl_metodo_pago_pk PRIMARY KEY ( id_metodo_pago );

CREATE TABLE tbl_modelos_aviones (
    id_modelo NUMBER NOT NULL,
    modelo    VARCHAR2(100)
);

ALTER TABLE tbl_modelos_aviones ADD CONSTRAINT tbl_modelos_aviones_pk PRIMARY KEY ( id_modelo );

CREATE TABLE tbl_ofertas_vuelo (
    id_oferta    NUMBER NOT NULL,
    descuento    NUMBER,
    fecha_inicio DATE,
    fecha_fin    DATE
);

ALTER TABLE tbl_ofertas_vuelo ADD CONSTRAINT tbl_ofertas_vuelo_pk PRIMARY KEY ( id_oferta );

CREATE TABLE tbl_personas (
    id_persona         NUMBER NOT NULL,
    id_genero          NUMBER NOT NULL,
    nombre             VARCHAR2(30),
    apellido           VARCHAR2(30),
    correo_electronico VARCHAR2(50),
    telefono           NUMBER,
    contrasena         VARCHAR2(100)
);

ALTER TABLE tbl_personas ADD CONSTRAINT tbl_personas_pk PRIMARY KEY ( id_persona );

ALTER TABLE tbl_personas ADD CONSTRAINT tbl_personas__un UNIQUE ( correo_electronico );

CREATE TABLE tbl_reservas (
    id_reserva        NUMBER NOT NULL,
    id_estado_reserva NUMBER NOT NULL
);

ALTER TABLE tbl_reservas ADD CONSTRAINT tbl_reservas_pk PRIMARY KEY ( id_reserva );

CREATE TABLE tbl_rutas (
    id_ruta          NUMBER NOT NULL,
    id_lugar_origen  NUMBER NOT NULL,
    id_lugar_destino NUMBER NOT NULL,
    distancia        NUMBER
);

ALTER TABLE tbl_rutas ADD CONSTRAINT tbl_rutas_pk PRIMARY KEY ( id_ruta );

CREATE TABLE tbl_seguimientos_equipaje (
    id_seguimiento NUMBER NOT NULL,
    id_lugar       NUMBER NOT NULL,
    id_equipaje    NUMBER NOT NULL,
    id_estado      NUMBER NOT NULL,
    latitud        VARCHAR2(50)
);

ALTER TABLE tbl_seguimientos_equipaje ADD CONSTRAINT tbl_seguimientos_equipaje_pk PRIMARY KEY ( id_seguimiento );

CREATE TABLE tbl_servicios_adicionales (
    id_servicio_adicional NUMBER NOT NULL,
    servicio              VARCHAR2(200),
    precio                NUMBER
);

ALTER TABLE tbl_servicios_adicionales ADD CONSTRAINT tbl_servicios_adicionales_pk PRIMARY KEY ( id_servicio_adicional );

CREATE TABLE tbl_servicios_por_boleto (
    id_servicio_adicional NUMBER NOT NULL,
    id_boleto_factura     NUMBER NOT NULL
);

CREATE TABLE tbl_tipo_asiento (
    id_tipo_asiento NUMBER NOT NULL,
    tipo_asiento    VARCHAR2(50),
    precio_base     NUMBER
);

ALTER TABLE tbl_tipo_asiento ADD CONSTRAINT tbl_tipo_asiento_pk PRIMARY KEY ( id_tipo_asiento );

CREATE TABLE tbl_tipo_lugar (
    id_tipo_lugar NUMBER NOT NULL,
    tipo_lugar    VARCHAR2(500)
);

ALTER TABLE tbl_tipo_lugar ADD CONSTRAINT tbl_tipo_lugar_pk PRIMARY KEY ( id_tipo_lugar );

CREATE TABLE tbl_tipos_empleados (
    id_tipo_empleado NUMBER NOT NULL,
    tipo_empleado    VARCHAR2(200),
    salario_min      NUMBER,
    salario_maximo   NUMBER
);

ALTER TABLE tbl_tipos_empleados ADD CONSTRAINT tbl_tipos_empleados_pk PRIMARY KEY ( id_tipo_empleado );

CREATE TABLE tbl_tipos_equipaje (
    id_tipo_equipaje NUMBER NOT NULL,
    tipo_equipaje    VARCHAR2(500),
    peso             NUMBER,
    costo            NUMBER
);

ALTER TABLE tbl_tipos_equipaje ADD CONSTRAINT tbl_tipos_equipaje_pk PRIMARY KEY ( id_tipo_equipaje );

CREATE TABLE tbl_tipos_vuelos (
    id_tipo_vuelo NUMBER NOT NULL,
    tipo_vuelo    VARCHAR2(50)
);

ALTER TABLE tbl_tipos_vuelos ADD CONSTRAINT tbl_tipos_vuelos_pk PRIMARY KEY ( id_tipo_vuelo );

CREATE TABLE tbl_vuelos (
    id_vuelo              VARCHAR2(30) NOT NULL,
    id_aerolinea          NUMBER NOT NULL,
    id_ruta               NUMBER NOT NULL,
    id_tipo_vuelo         NUMBER NOT NULL,
    id_aeropuerto_partida NUMBER NOT NULL,
    id_aeropuerto_llegada NUMBER NOT NULL,
    id_oferta             NUMBER,
    fecha_partida         DATE,
    numero_vuelo          NUMBER,
    hora_llegada          VARCHAR2(15),
    hora_partida          VARCHAR2(15),
    gate                  NUMBER
);

ALTER TABLE tbl_vuelos ADD CONSTRAINT tbl_vuelos_pk PRIMARY KEY ( id_vuelo );

ALTER TABLE tbl_asientos
    ADD CONSTRAINT tbl_a_tbl_t_a_fk FOREIGN KEY ( id_tipo_asiento )
        REFERENCES tbl_tipo_asiento ( id_tipo_asiento );

ALTER TABLE tbl_asientos
    ADD CONSTRAINT tbl_asientos_tbl_v_fk FOREIGN KEY ( id_vuelo )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_aviones
    ADD CONSTRAINT tbl_av_tbl_m_a_fk FOREIGN KEY ( id_modelo )
        REFERENCES tbl_modelos_aviones ( id_modelo );

ALTER TABLE tbl_aviones
    ADD CONSTRAINT tbl_aviones_tbl_aer_fk FOREIGN KEY ( id_aerolinea )
        REFERENCES tbl_aerolineas ( id_aerolinea );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_as_fk FOREIGN KEY ( id_asiento )
        REFERENCES tbl_asientos ( id_asiento );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_c_fk FOREIGN KEY ( id_cliente )
        REFERENCES tbl_clientes ( id_cliente );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_es_fk FOREIGN KEY ( id_escala )
        REFERENCES tbl_escalas ( id_escala );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_r_fk FOREIGN KEY ( id_reserva )
        REFERENCES tbl_reservas ( id_reserva );

ALTER TABLE tbl_boletos
    ADD CONSTRAINT tbl_boletos_tbl_vuelos_fk FOREIGN KEY ( id_vuelo )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_clientes
    ADD CONSTRAINT tbl_clientes_tbl_p_fk FOREIGN KEY ( id_cliente )
        REFERENCES tbl_personas ( id_persona );

ALTER TABLE tbl_equipajes_por_boleto
    ADD CONSTRAINT tbl_e_p_b_tbl_e_fk FOREIGN KEY ( id_equipaje )
        REFERENCES tbl_equipajes ( id_equipaje );

ALTER TABLE tbl_equipajes_por_boleto
    ADD CONSTRAINT tbl_e_p_b_tbl_f_b_fk FOREIGN KEY ( id_boleto_factura )
        REFERENCES tbl_factura_boletos ( id_boleto_factura );

ALTER TABLE tbl_empleados
    ADD CONSTRAINT tbl_empl_tbl_t_e_fk FOREIGN KEY ( id_tipo_empleado )
        REFERENCES tbl_tipos_empleados ( id_tipo_empleado );

ALTER TABLE tbl_empleados
    ADD CONSTRAINT tbl_empleados_tbl_p_fk FOREIGN KEY ( id_empleado )
        REFERENCES tbl_personas ( id_persona );

ALTER TABLE tbl_equipajes
    ADD CONSTRAINT tbl_equ_tbl_ti_eq_fk FOREIGN KEY ( id_tipo_equipaje )
        REFERENCES tbl_tipos_equipaje ( id_tipo_equipaje );

ALTER TABLE tbl_escalas
    ADD CONSTRAINT tbl_es_tbl_v_fk FOREIGN KEY ( id_vuelo_padre )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_escalas
    ADD CONSTRAINT tbl_escalas_tbl_v_fk FOREIGN KEY ( id_vuelo )
        REFERENCES tbl_vuelos ( id_vuelo );

ALTER TABLE tbl_factura_boletos
    ADD CONSTRAINT tbl_fa_b_tbl_f_fk FOREIGN KEY ( id_factura )
        REFERENCES tbl_facturas ( id_factura );

ALTER TABLE tbl_facturas
    ADD CONSTRAINT tbl_fact_tbl_m_p_fk FOREIGN KEY ( id_metodo_pago )
        REFERENCES tbl_metodo_pago ( id_metodo_pago );

ALTER TABLE tbl_factura_boletos
    ADD CONSTRAINT tbl_factura_b_tbl_b_fk FOREIGN KEY ( id_boleto )
        REFERENCES tbl_boletos ( id_boleto );

ALTER TABLE tbl_lugares
    ADD CONSTRAINT tbl_lugares_tbl_lugares_fk FOREIGN KEY ( id_lugar_padre )
        REFERENCES tbl_lugares ( id_lugar );

ALTER TABLE tbl_lugares
    ADD CONSTRAINT tbl_lugares_tbl_tipo_lugar_fk FOREIGN KEY ( id_tipo_lugar )
        REFERENCES tbl_tipo_lugar ( id_tipo_lugar );

ALTER TABLE tbl_personas
    ADD CONSTRAINT tbl_personas_tbl_g_fk FOREIGN KEY ( id_genero )
        REFERENCES tbl_generos ( id_genero );

ALTER TABLE tbl_reservas
    ADD CONSTRAINT tbl_reservas_tbl_e_r_fk FOREIGN KEY ( id_estado_reserva )
        REFERENCES tbl_estado_reserva ( id_estado_reserva );

ALTER TABLE tbl_rutas
    ADD CONSTRAINT tbl_rutas_tbl_lugares_fk FOREIGN KEY ( id_lugar_destino )
        REFERENCES tbl_lugares ( id_lugar );

ALTER TABLE tbl_rutas
    ADD CONSTRAINT tbl_rutas_tbl_lugares_fkv2 FOREIGN KEY ( id_lugar_origen )
        REFERENCES tbl_lugares ( id_lugar );

ALTER TABLE tbl_servicios_por_boleto
    ADD CONSTRAINT tbl_s_p_b_tbl_f_b_fk FOREIGN KEY ( id_boleto_factura )
        REFERENCES tbl_factura_boletos ( id_boleto_factura );

ALTER TABLE tbl_servicios_por_boleto
    ADD CONSTRAINT tbl_s_p_b_tbl_s_a_fk FOREIGN KEY ( id_servicio_adicional )
        REFERENCES tbl_servicios_adicionales ( id_servicio_adicional );

ALTER TABLE tbl_seguimientos_equipaje
    ADD CONSTRAINT tbl_se_e_tbl_e_fk FOREIGN KEY ( id_equipaje )
        REFERENCES tbl_equipajes ( id_equipaje );

ALTER TABLE tbl_seguimientos_equipaje
    ADD CONSTRAINT tbl_se_eq_tbl_es_e_fk FOREIGN KEY ( id_estado )
        REFERENCES tbl_estados_equipaje ( id_estado );

ALTER TABLE tbl_seguimientos_equipaje
    ADD CONSTRAINT tbl_seg_eq_tbl_l_fk FOREIGN KEY ( id_lugar )
        REFERENCES tbl_lugares ( id_lugar );

ALTER TABLE tbl_vuelos
    ADD CONSTRAINT tbl_vuelos_tbl_a_fk FOREIGN KEY ( id_aerolinea )
        REFERENCES tbl_aerolineas ( id_aerolinea );

ALTER TABLE tbl_vuelos
    ADD CONSTRAINT tbl_vuelos_tbl_aer_fk FOREIGN KEY ( id_aeropuerto_partida )
        REFERENCES tbl_aeropuertos ( id_aeropuerto );

ALTER TABLE tbl_vuelos
    ADD CONSTRAINT tbl_vuelos_tbl_aer_fkv1 FOREIGN KEY ( id_aeropuerto_llegada )
        REFERENCES tbl_aeropuertos ( id_aeropuerto );

ALTER TABLE tbl_vuelos
    ADD CONSTRAINT tbl_vuelos_tbl_of_v_fk FOREIGN KEY ( id_oferta )
        REFERENCES tbl_ofertas_vuelo ( id_oferta );

ALTER TABLE tbl_vuelos
    ADD CONSTRAINT tbl_vuelos_tbl_rutas_fk FOREIGN KEY ( id_ruta )
        REFERENCES tbl_rutas ( id_ruta );

ALTER TABLE tbl_vuelos
    ADD CONSTRAINT tbl_vuelos_tbl_tipos_vuelos_fk FOREIGN KEY ( id_tipo_vuelo )
        REFERENCES tbl_tipos_vuelos ( id_tipo_vuelo );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            31
-- CREATE INDEX                             0
-- ALTER TABLE                             67
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
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
-- CREATE SEQUENCE                          0
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
