

#LAB 2
CREATE OR REPLACE FUNCTION doWhile(x INT)
    RETURNS TEXT
    BEGIN
        DECLARE str TEXT DEFAULT '';

        REPEAT

            SET str = CONCAT(str,x);
            SET x = x - 1;

        UNTIL  x <= 0 END REPEAT;
    RETURN str;
END;

SELECT doWhile(10);

CREATE OR REPLACE FUNCTION serieAAandBB(x INT)
    RETURNS TEXT
    BEGIN
        DECLARE str TEXT DEFAULT '';
        DECLARE A TEXT DEFAULT ' -AA- ';
        DECLARE B TEXT DEFAULT ' -BB- ';

        REPEAT
            IF(x % 2 = 0) THEN
                SET str = CONCAT(str,x,A);
                ELSE
                SET str = CONCAT(str,x,B);
            END IF;

            SET x = x - 1;

        UNTIL  x <= 0 END REPEAT;
    RETURN str;
END;


SELECT serieAAandBB(10);

CREATE OR REPLACE FUNCTION manejo_de_loop(x INT)
    RETURNS TEXT
    BEGIN
        DECLARE str TEXT DEFAULT '';
        dbaII: LOOP
            IF x > 0 THEN
                LEAVE dbaII;
            END IF;
                SET str = CONCAT(str,x,',');
            SET x = x + 1;
            ITERATE dbaII;
        END LOOP;
        RETURN str;
    END;

SELECT manejo_de_loop(-10);


CREATE OR REPLACE FUNCTION manejo_de_loopV2(x INT)
    RETURNS TEXT
    BEGIN
        DECLARE str TEXT DEFAULT '';
        dbaII: LOOP
            IF x < 0 THEN
                LEAVE dbaII;
            END IF;
             IF(x % 2 = 0) THEN
                SET str = CONCAT(str,x,' -AA- ');
                ELSE
                SET str = CONCAT(str,x,'- BB -');
            END IF;
            SET x = x - 1;
            ITERATE dbaII;
        END LOOP;
        RETURN str;
    END;


SELECT manejo_de_loopV2(10);


SELECT manejo_de_loopV2(-10);


CREATE OR REPLACE FUNCTION tipodecliente(credit_number INT)
    RETURNS TEXT
    BEGIN

        DECLARE R TEXT DEFAULT '';
        CASE
            WHEN (credit_number > 50000) THEN SET R = 'PLATINIUM';
            WHEN (credit_number BETWEEN 10000 AND 50000) THEN SET R = 'GOLD';
            WHEN (credit_number < 0) THEN SET R = 'ESTA EN QUIEBRA';
            ELSE SET  R = 'SILVER';
        END CASE;
        RETURN  R;
    END;

SELECT tipodecliente(-10);
SELECT tipodecliente(9999);
SELECT tipodecliente(50001);
SELECT tipodecliente(100000);


#charlength nos permite determinar cuantos caracteres tiene una palabra
SELECT char_length('DBAII');

SELECT char_length('DBAII 2023');

SELECT char_length(' DBAII 2023 ');


CREATE OR REPLACE FUNCTION valida_lenght_7(pasword TEXT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    IF char_length(pasword) > 7  THEN
        SET R = 'PASSED';
    ELSE
        SET R = 'FAILED';
    END IF;
    RETURN R;
END;

SELECT valida_lenght_7('juna');

#la funcion strcmp
#compara si son dos cadenas son iguales o distindos
#si son iguales retorna 0
#si son diferentes retona -1 o 1
SELECT strcmp('dbAii','DBAII');


CREATE OR REPLACE FUNCTION valida_strcmp(cad TEXT, cad1 TEXT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    IF strcmp(cad,cad1) = 0  THEN
        SET R = 'cadenas iguales';
    ELSE
        SET R = 'cadenas distintas';
    END IF;
    RETURN R;
END;

SELECT valida_strcmp('DBAII','EDDI');
SELECT valida_strcmp('DBAII','DBAII');


#en  base a las 2 funciones anteriores determinar lo siguinete:
#recivir dso cadenas en la funcion
#si las dos funciones son iguales y ademas el length es amyor a 15 retornar el mensaje
#VALIDO
#caso contrario retornar MO VALIDO

CREATE OR REPLACE FUNCTION validacadena(cad TEXT, cad1 TEXT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE CT TEXT DEFAULT '';


    SET CT = CONCAT(cad,cad1);
    IF char_length(CT) > 15 AND strcmp(cad,cad1) = 0 THEN
        SET R = 'VALIDO';
    ELSE
        SET R = 'NO VALIDO';
    END IF;

    RETURN R;
END;

SELECT validacadena('1020engranpadora','1020engranpadora');

CREATE OR REPLACE FUNCTION validacadenaV2(cad TEXT, cad1 TEXT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE R1 INT DEFAULT 0;
    DECLARE R2 INT DEFAULT 0;


    SET R1 = char_length(cad);
    SET R2 = char_length(cad1);

    IF (R1 + R2) > 15 AND strcmp(cad,cad1) = 0 THEN
        SET R = 'VALIDO';
        ELSE
            SET R = 'NO VALIDO';

    END IF;

    RETURN R;
END;

SELECT validacadenaV2('1020engranpadora','1020engranpadora');