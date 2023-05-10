#lenguaje procedural:
#es basicamente la programcion a nivel BDA
#llevar la programacion a bda;
 #LAB 1
CREATE DATABASE hito3_2023;
USE hito3_2023;

SET @usuario = 'GUEST';
SET @locacion = 'EL ALTO';
SET @HITO_3 = 'ADMIN';

SELECT @usuario;
SELECT @locacion;



CREATE OR REPLACE FUNCTION vartarea(usuario TEXT, usuarionew TEXT)
RETURNS TEXT
    BEGIN
        RETURN @usuario;
    END;

SELECT vartarea();

SHOW variables;

CREATE OR REPLACE FUNCTION mostrar()
RETURNS VARCHAR(50)
    BEGIN
        DECLARE RESP VARCHAR(50);
        IF( @HITO_3 = 'ADMIN')THEN
            SET RESP = 'Usuario ADMIN';
        ELSE
            SET RESP = 'Usuario INVITADO';

        END IF;

        RETURN RESP;
    END;

SELECT mostrar();




CREATE OR REPLACE FUNCTION mostrar1()
RETURNS VARCHAR(50)
    BEGIN
        DECLARE RESP VARCHAR(50);
        CASE
            WHEN  ( @HITO_3 = 'ADMIN') THEN SET RESP = 'Usuario ADMIN';
            ELSE SET RESP = 'Usuario INVITADO';
        END CASE;
        RETURN RESP;
    END;

SELECT mostrar1();


#generar los pimeros 10 numeros naturales;

CREATE OR REPLACE FUNCTION numeros_naturales(limite INT)
    RETURNS TEXT
    BEGIN
        DECLARE R TEXT DEFAULT '';
        DECLARE i INT DEFAULT 1;

        WHILE i <= limite DO
            SET R = CONCAT(R,i,',');
            SET i= i + 1;
        END WHILE;
    RETURN R;
END;



SELECT numeros_naturales(5);

CREATE OR REPLACE FUNCTION numeros_naturales_V2(limite INT)
    RETURNS TEXT
    BEGIN
        DECLARE R TEXT DEFAULT '';
        DECLARE i INT DEFAULT 2;

        WHILE i <= limite DO
            SET R = CONCAT(R,i,',');
            SET i= i + 2;
        END WHILE;
    RETURN R;
END;


SELECT numeros_naturales(10);


CREATE OR REPLACE FUNCTION numeros_naturales_V3(limite INT)
    RETURNS TEXT
    BEGIN
        DECLARE R TEXT DEFAULT '';
        DECLARE i INT DEFAULT 2;
        DECLARE j INT DEFAULT 1;

        DECLARE a INT DEFAULT 2;

        WHILE j <= limite DO
            SET R = CONCAT(R,i,',',j,',');
            SET i = i + 2;
            SET j = j + 2;
        END WHILE;
    RETURN R;
END;

SELECT numeros_naturales_V3(10);


CREATE OR REPLACE FUNCTION numeros_naturales_V4(limite INT)
    RETURNS TEXT
    BEGIN
        DECLARE R TEXT DEFAULT '';
        DECLARE i INT DEFAULT 2;
        DECLARE j INT DEFAULT 1;

        DECLARE a INT DEFAULT 2;

        WHILE j <= limite DO
            IF (a % 2 = 0) THEN
                SET R = CONCAT(R,i,',');
                SET i = i + 2;
                SET a = a - 1;
            END IF;

            IF (a % 2 != 0) THEN
                SET R = CONCAT(R,j,',');
                SET j = j + 2;
                SET a = a + 1;
            END IF;

        END WHILE;
    RETURN R;
END;

SELECT numeros_naturales_V4(10);


CREATE OR REPLACE FUNCTION numeros_naturales_V5(limite INT)
    RETURNS TEXT
    BEGIN
        DECLARE R TEXT DEFAULT '';
        DECLARE i INT DEFAULT 2;
        DECLARE j INT DEFAULT 1;

        DECLARE a INT DEFAULT 1;

        WHILE j <= limite DO
            IF (a % 2 = 0) THEN
                SET R = CONCAT(R,j,',');
                SET j = j + 2;
            END IF;

            IF (a % 2 != 0) THEN

                SET R = CONCAT(R,i,',');
                SET i = i + 2;
            END IF;

            SET a = a + 1;
        END WHILE;
    RETURN R;
END;

SELECT numeros_naturales_V5(10);