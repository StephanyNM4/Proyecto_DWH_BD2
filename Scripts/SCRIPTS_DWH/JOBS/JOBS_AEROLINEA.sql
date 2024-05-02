SET SERVEROUTPUT ON;
-----------------------------------------------------------------------
---------------------------CALENDARIZACION-----------------------------
-----------------------------------------------------------------------
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        SCHEDULE_NAME => 'INTERVALO_ANUAL',
        START_DATE => TRUNC(SYSDATE) +22/24,
        REPEAT_INTERVAL => 'FREQ=YEARLY; BYMONTH=12; BYMONTHDAY=31;',
        COMMENTS => 'INTERVALO ANUAL'
    );
END;

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        SCHEDULE_NAME => 'INTERVALO_SEMANAL',
        START_DATE => TRUNC(SYSDATE) +22/24,
        REPEAT_INTERVAL => 'FREQ=DAILY; BYDAY=SUN',
        COMMENTS => 'INTERVALO SEMANAL'
    );
END;

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        SCHEDULE_NAME => 'INTERVALO_DIARIO',
        START_DATE => TRUNC(SYSDATE) +22/24,
        REPEAT_INTERVAL => 'FREQ=DAILY; BYDAY=MON, TUE, WED, THU, FRI, SUN;',
        COMMENTS => 'INTERVALO DE UN MINUTO'
    );
END;

BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE(
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        START_DATE => TRUNC(SYSDATE),
        REPEAT_INTERVAL => 'FREQ=MINUTELY; INTERVAL=1',
        COMMENTS => 'INTERVALO DE UN MINUTO'
    );
END;

-----------------------------------------------------------------------
------------------------------PROGRAMAS--------------------------------
-----------------------------------------------------------------------

--------------------------------------------------------PRG_P_ETL_VUELOS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_VUELOS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_VUELOS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA VUELOS'
    );
END;

--------------------------------------------------------PRG_P_ETL_ESCALAS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_ESCALAS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_ESCALAS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA ESCALAS'
    );
END;

--------------------------------------------------------PRG_P_ETL_CLIENTES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_CLIENTES',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_CLIENTES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA CLIENTES'
    );
END;

--------------------------------------------------------PRG_P_ETL_BOLETOS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_BOLETOS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_BOLETOS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA BOLETOS'
    );
END;

--------------------------------------------------------PRG_P_ETL_FACTURAS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_FACTURAS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_FACTURAS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA FACTURAS'
    );
END;

--------------------------------------------------------PRG_P_ETL_FACTURA_BOLETOS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_FACTURA_BOLETOS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_BOLETO_POR_FACTURA; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA FACTURA_BOLETOS'
    );
END;

--------------------------------------------------------PRG_P_ETL_SERVICIOS
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_SERVICIOS',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_SERVICIOS; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA SERVICIOS'
    );
END;

--------------------------------------------------------PRG_P_ETL_SERVICIOS_POR_BOLETO
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_SERVICIOS_POR_BOLETO',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_SERVICIOS_POR_BOLETO; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA SERVICIOS_POR_BOLETO'
    );
END;

--------------------------------------------------------PRG_P_ETL_EQUIPAJES
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_EQUIPAJES',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_EQUIPAJES; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA EQUIPAJES'
    );
END;


--------------------------------------------------------PRG_P_ETL_EQUIPAJES_POR_BOLETO
BEGIN
    DBMS_SCHEDULER.CREATE_PROGRAM(
        PROGRAM_NAME => 'PRG_P_ETL_EQUIPAJES_POR_BOLETO',
        PROGRAM_TYPE => 'PLSQL_BLOCK',
        PROGRAM_ACTION => 'BEGIN PKG_ETLS_AEROLINEA.P_ETL_EQUIPAJES_POR_BOLETO; END;',
        ENABLED => TRUE,
        COMMENTS => 'PROGRAMA PARA EQUIPAJES_POR_BOLETO'
    );
END;



-----------------------------------------------------------------------
--------------------------------JOBS-----------------------------------
--------------------------------------------------------JOB_P_ETL_VUELOS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_VUELOS',
        PROGRAM_NAME => 'PRG_P_ETL_VUELOS',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA VUELOS'
    );
END;

------EXTRAEMOS ASIENTOS MANUALMENTE
BEGIN 
    PKG_ETLS_AEROLINEA.P_ETL_ASIENTOS; 
END;
--------------------------------------------------------JOB_P_ETL_ESCALAS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_ESCALAS',
        PROGRAM_NAME => 'PRG_P_ETL_ESCALAS',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA ESCALAS'
    );
END;

--------------------------------------------------------JOB_P_ETL_CLIENTES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_CLIENTES',
        PROGRAM_NAME => 'PRG_P_ETL_CLIENTES',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA CLIENTES'
    );
END;

--------------------------------------------------------JOB_P_ETL_BOLETOS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_BOLETOS',
        PROGRAM_NAME => 'PRG_P_ETL_BOLETOS',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA BOLETOS'
    );
END;

--------------------------------------------------------JOB_P_ETL_FACTURAS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_FACTURAS',
        PROGRAM_NAME => 'PRG_P_ETL_FACTURAS',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA FACTURAS'
    );
END;

--------------------------------------------------------JOB_P_ETL_FACTURA_BOLETOS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_FACTURA_BOLETOS',
        PROGRAM_NAME => 'PRG_P_ETL_FACTURA_BOLETOS',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA FACTURA_BOLETOS'
    );
END;

--------------------------------------------------------JOB_P_ETL_SERVICIOS
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_SERVICIOS',
        PROGRAM_NAME => 'PRG_P_ETL_SERVICIOS',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA SERVICIOS'
    );
END;

--------------------------------------------------------JOB_P_ETL_SERVICIOS_POR_BOLETO
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_SERVICIOS_POR_BOLETO',
        PROGRAM_NAME => 'PRG_P_ETL_SERVICIOS_POR_BOLETO',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA SERVICIOS_POR_BOLETO'
    );
END;

--------------------------------------------------------JOB_P_ETL_EQUIPAJES
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_EQUIPAJES',
        PROGRAM_NAME => 'PRG_P_ETL_EQUIPAJES',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA EQUIPAJES'
    );
END;

--------------------------------------------------------JOB_P_ETL_EQUIPAJES_POR_BOLETO
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
        JOB_NAME => 'JOB_P_ETL_EQUIPAJES_POR_BOLETO',
        PROGRAM_NAME => 'PRG_P_ETL_EQUIPAJES_POR_BOLETO',
        SCHEDULE_NAME => 'DEMOSTRACION_INTERVALO_1_MINUTO_P',
        ENABLED => TRUE,
        AUTO_DROP => FALSE,
        COMMENTS => 'JOB CON INTERVALOS PARA EQUIPAJES_POR_BOLETO'
    );
END;