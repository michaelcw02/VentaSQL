
connect system/manager as sysdba

DROP USER test CASCADE;
CREATE USER test IDENTIFIED BY test;
GRANT DBA TO test;

connect test/test

## PRODUCCION PEDIDOS
CREATE TABLE PRODUCCION_PEDIDOS (
    CODIGO_CLIENTE VARCHAR(25),
    CODIGO_PRODUCTO INT,
    CANTIDAD INT,
    FECHA DATE
);
 
CREATE OR REPLACE TRIGGER TR1_PP
BEFORE INSERT ON PRODUCCION_PEDIDOS
FOR EACH ROW
BEGIN 
    :NEW.FECHA := SYSDATE;
END;
/

CREATE OR REPLACE FUNCTION F_INSERT_PP (CC VARCHAR, CP INT, CANT INT)
RETURN INTEGER AS STATE INTEGER;
BEGIN 
    INSERT INTO PRODUCCION_PEDIDOS (CODIGO_CLIENTE, CODIGO_PRODUCTO, CANTIDAD) VALUES (CC, CP, CANT);
    STATE := 1;
    RETURN STATE;
    EXCEPTION 
        WHEN OTHERS THEN
            RETURN 0;
END;
/

CREATE OR REPLACE FUNCTION F_INSERT_PP (CC VARCHAR, CP INT, CANT INT)
RETURN INTEGER
IS
BEGIN 
    INSERT INTO PRODUCCION_PEDIDOS (CODIGO_CLIENTE, CODIGO_PRODUCTO, CANTIDAD) VALUES (CC, CP, CANT);
    RETURN 1;
    EXCEPTION 
        WHEN OTHERS THEN
            RETURN 0;
END;
/
 
CREATE OR REPLACE PROCEDURE P1_PP (CC VARCHAR, CP INT, CANT INT) IS
OK INTEGER;
BEGIN
    OK := F_INSERT_PP (CC, CP, CANT);
    IF OK = 1 THEN
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END;
/

#PROPER SELECT FOR FECHA (SELECT TO_CHAR(FECHA, 'YYYY/MM/DD - HH:MI AM') AS FECHA FROM PRODUCCION_PEDIDOS;)

## PRODUCTOS TERMINADOS
CREATE TABLE PRODUCTOS_TERMINADOS (
    CODIGO INT,
    CANTIDAD INT,
    CONSTRAINT PK_PRODUCTOS_TERMINADOS PRIMARY KEY (CODIGO)
);
 
CREATE OR REPLACE FUNCTION F_INSERT_PT(xcodigo int,xcantidad int)
RETURN INTEGER AS STATE INTEGER;
BEGIN
	INSERT INTO PRODUCTOS_TERMINADOS VALUES (xcodigo,xcantidad);
	STATE := 1;
    RETURN STATE;
    EXCEPTION 
        WHEN OTHERS THEN
            RETURN 0;
END;
/

CREATE OR REPLACE PROCEDURE P1_PT(xcodigo int,xcantidad int)
IS
OK INTEGER;
BEGIN
	OK := F_INSERT_PT(xcodigo,xcantidad);
    IF OK = 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END;
/

