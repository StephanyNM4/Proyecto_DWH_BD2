SET SERVEROUTPUT ON;
-----------------------------------------------------------------------
------------------------------PROGRAMAS--------------------------------
-----------------------------------------------------------------------

--------------------------------------------------------PRG_P_ETL_HOTELES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_HOTELES',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_HOTELES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA HOTELES'
    );
END;

--------------------------------------------------------PRG_P_ETL_POLITICAS_POR_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_POLITICAS_POR_HOTEL',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_POLITICAS_POR_HOTEL; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA POLITICAS POR HOTEL'
    );
END;

--------------------------------------------------------PRG_P_ETL_SERVICIOS_POR_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_SERVICIOS_POR_HOTEL',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_SERVICIOS_POR_HOTEL; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA SERVICIOS POR HOTEL'
    );
END;

--------------------------------------------------------PRG_P_ETL_EVALUACICONES_POR_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_EVALUACICONES_POR_HOTEL',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_EVALUACICONES_POR_HOTEL; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA EVALUACIONES POR HOTEL'
    );
END;

--------------------------------------------------------PRG_P_ETL_AMENIDADES_X_HABITACION
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_AMENIDADES_X_HABITACION',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_AMENIDADES_X_HABITACION; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA AMENIDADES POR HABITACION'
    );
END;

--------------------------------------------------------PRG_P_ETL_CLIENTES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_CLIENTES_HOTEL',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_CLIENTES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA CLIENTES DE HOTEL'
    );
END;

--------------------------------------------------------PRG_P_ETL_HABITACIONES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_HABITACIONES',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_HABITACIONES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA HABITACIONES'
    );
END;

--------------------------------------------------------PRG_P_ETL_RESERVACIONES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_RESERVACIONES',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_RESERVACIONES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA RESERVACIONES'
    );
END;

--------------------------------------------------------PRG_P_ETL_FACTURAS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_FACTURAS_HOTEL',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_FACTURAS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA FACTURAS HOTEL'
    );
END;

--------------------------------------------------------PRG_P_ETL_DETALLES_FACTURAS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_DETALLES_FACTURAS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.P_ETL_DETALLES_FACTURAS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA DETALLE DE FACTURAS'
    );
END;


--------------------------------------------------------PRG_SP_ETL_SERVICIOS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_SP_ETL_SERVICIOS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.SP_ETL_SERVICIOS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA SERVICIOS HOTELES'
    );
END;

--------------------------------------------------------PRG_SP_ETL_AMENIDADES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_SP_ETL_AMENIDADES',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.SP_ETL_AMENIDADES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA SERVICIOS AMENIDADES'
    );
END;

--------------------------------------------------------PRG_SP_ETL_POLITICAS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_SP_ETL_POLITICAS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_HOTELES.SP_ETL_POLITICAS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA POLITICAS'
    );
END;



-----------------------------------------------------------------------
--------------------------------JOBS-----------------------------------
--------------------------------------------------------JOB_P_ETL_HOTELES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_HOTELES',
        PROGRAM_NAME => 'PRG_P_ETL_HOTELES',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA HOTELES'
    );
END;

--------------------------------------------------------JOB_P_ETL_POLITICAS_POR_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_POLITICAS_POR_HOTEL',
        PROGRAM_NAME => 'PRG_P_ETL_POLITICAS_POR_HOTEL',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA POLITICAS_POR_HOTEL'
    );
END;

--------------------------------------------------------JOB_P_ETL_SERVICIOS_POR_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_SERVICIOS_POR_HOTEL',
        PROGRAM_NAME => 'PRG_P_ETL_SERVICIOS_POR_HOTEL',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA SERVICIOS POR HOTEL'
    );
END;

--------------------------------------------------------JOB_P_ETL_EVALUACICONES_POR_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_EVALUACICONES_POR_HOTEL',
        PROGRAM_NAME => 'PRG_P_ETL_EVALUACICONES_POR_HOTEL',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA SERVICIOS POR HOTEL'
    );
END;

--------------------------------------------------------JOB_P_ETL_AMENIDADES_X_HABITACION
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_AMENIDADES_X_HABITACION',
        PROGRAM_NAME => 'PRG_P_ETL_AMENIDADES_X_HABITACION',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA AMENIDADES HABITACION'
    );
END;

--------------------------------------------------------JOB_P_ETL_CLIENTES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_CLIENTES_HOTEL',
        PROGRAM_NAME => 'PRG_P_ETL_CLIENTES_HOTEL',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA ETL_CLIENTES_HOTEL'
    );
END;

--------------------------------------------------------JOB_PRG_P_ETL_HABITACIONES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_PRG_P_ETL_HABITACIONES',
        PROGRAM_NAME => 'PRG_PRG_P_ETL_HABITACIONES',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA ETL_HABITACIONES'
    );
END;

--------------------------------------------------------JOB_P_ETL_RESERVACIONES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_RESERVACIONES',
        PROGRAM_NAME => 'PRG_P_ETL_RESERVACIONES',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA RESERVACIONES'
    );
END;

--------------------------------------------------------JOB_P_ETL_FACTURAS_HOTEL
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_FACTURAS_HOTEL',
        PROGRAM_NAME => 'PRG_P_ETL_FACTURAS_HOTEL',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA FACTURAS_HOTEL'
    );
END;

--------------------------------------------------------JOB_P_ETL_DETALLES_FACTURAS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_DETALLES_FACTURAS',
        PROGRAM_NAME => 'PRG_P_ETL_DETALLES_FACTURAS',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA DETALLES_FACTURAS'
    );
END;

--------------------------------------------------------JOB_SP_ETL_SERVICIOS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_SP_ETL_SERVICIOS',
        PROGRAM_NAME => 'PRG_SP_ETL_SERVICIOS',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA SERVICIOS HOTELES'
    );
END;

--------------------------------------------------------JOB_SP_ETL_AMENIDADES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_SP_ETL_AMENIDADES',
        PROGRAM_NAME => 'PRG_SP_ETL_AMENIDADES',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA AMENIDADES'
    );
END;

--------------------------------------------------------JOB_SP_ETL_POLITICAS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_SP_ETL_POLITICAS',
        PROGRAM_NAME => 'PRG_SP_ETL_POLITICAS',
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA POLITICAS'
    );
END;