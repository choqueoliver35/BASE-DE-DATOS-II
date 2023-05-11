CREATE DATABASE defensa_hito3_2023;
USE defensa_hito3_2023;



SELECT elimina_consonantes_y_numeros('BASE DE DATOS II 2023');

CREATE TABLE CLIENTES
(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    fulname VARCHAR(20),
    last_name VARCHAR(20),
    age INT,
    genero CHAR
);

INSERT INTO CLIENTES(fulname, last_name, age, genero)
VALUES('Nombre 1','Apellido 1',18,'M'),
      ('Nombre 2','Apellido 2',19,'F'),
      ('Nombre 3','Apellido 3',21,'F');


CREATE OR REPLACE FUNCTION edadMax()
RETURNS INT
BEGIN
    DECLARE R INT DEFAULT 0;

    SELECT MAX(C.age)
    FROM CLIENTES C
    INTO R;
    RETURN R;
END;

SELECT edadMax();

CREATE OR REPLACE FUNCTION paresImpares()
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE num INT DEFAULT edadMax();
    DECLARE cont INT DEFAULT 0;
    DECLARE numipar INT DEFAULT edadMax();

        dbaII: LOOP
        IF cont > num THEN
            LEAVE dbaII;
        END IF;
            IF num % 2 = 0 THEN
                SET R = CONCAT(R,cont,',');
                SET cont = cont + 2;
            ELSE
                SET R = CONCAT(R,numipar,',');
                SET numipar = numipar - 2;
                SET cont = cont + 2;
            END IF;
            ITERATE dbaII;
        END LOOP;
    RETURN R;
END;

SELECT paresImpares();



CREATE OR REPLACE FUNCTION serieFibonacci(n INT)
RETURNS TEXT
BEGIN
    DECLARE a INT DEFAULT 1;
    DECLARE b INT DEFAULT 0;
    DECLARE c INT DEFAULT 0;
    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;

    WHILE (n > cont) DO
        SET R = CONCAT(R,c,',');
        SET c = a + b;
        SET a = b;
        SET b = c;
        SET cont = cont + 1;
    END WHILE;
    RETURN R;
END;

SELECT serieFibonacci(7);



CREATE OR REPLACE FUNCTION serieFibonacciv2(n INT)
RETURNS TEXT
BEGIN
    DECLARE a INT DEFAULT 1;
    DECLARE b INT DEFAULT 0;
    DECLARE c INT DEFAULT 0;
    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 1;

    dbaII: LOOP
        IF n < cont THEN
            LEAVE dbaII;
        END IF;
        SET R = CONCAT(R,c,',');
        SET c = a + b;
        SET a = b;
        SET b = c;
        SET cont = cont + 1;
        ITERATE dbaII;
    END LOOP;
    RETURN R;
END;

SELECT serieFibonacciv2(7);


CREATE OR REPLACE FUNCTION invertir(CAD VARCHAR(100))
RETURNS TEXT
BEGIN

    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 0;
    DECLARE PUNTERO CHAR;
    DECLARE A INT DEFAULT CHAR_LENGTH(CAD);


    WHILE (cont <= char_length(CAD)) DO
        SET PUNTERO = SUBSTR(CAD,-cont,1);
        SET R = CONCAT(R,PUNTERO);
        SET cont = cont + 1;
    END WHILE;
    RETURN R;
END;

SELECT invertir('DBA II 2023');
SELECT reverse('HOLA');

CREATE OR REPLACE FUNCTION elimina_consonantes_y_numeros(cadena VARCHAR(20))
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE cont INT DEFAULT 1;
    DECLARE PUNTERO CHAR;

    WHILE cont <= char_length(cadena) DO
        SET PUNTERO = SUBSTR(cadena,cont,1);
        CASE
            WHEN PUNTERO = 'A' THEN SET R = CONCAT(R,PUNTERO);
            WHEN PUNTERO = 'E' THEN SET R = CONCAT(R,PUNTERO);
            WHEN PUNTERO = 'I' THEN SET R = CONCAT(R,PUNTERO);
            WHEN PUNTERO = 'O' THEN SET R = CONCAT(R,PUNTERO);
            WHEN PUNTERO = 'U' THEN SET R = CONCAT(R,PUNTERO);
            WHEN PUNTERO = '' THEN SET R = CONCAT(R,' ');
            ELSE SET R = R;
        END CASE;
        SET cont = cont + 1;
    END WHILE;

    IF R = '' THEN
        SET R = 'no hay vocales';
    end if;
    RETURN R;
END;


SELECT elimina_consonantes_y_numeros('BASE DE DATOS');

