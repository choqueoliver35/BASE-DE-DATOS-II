#LAB 3
# DBA 2023
# 2023
SELECT substr('DBAII 2023 Unifranz', 7,1);

SELECT substr('DBAII 2023 Unifranz'FROM 7 FOR 4);

SELECT substr('DBAII 2023 Unifranz'FROM -8);

SELECT substr('DBAII 2023 Unifranz'FROM 1 FOR 1);

# Base de Datos II, gestion 2023 Unifranz

SELECT LOCATE('2023','Base de Datos II, gestion 2023 Unifranz',1);
SELECT LOCATE('HOLA', 'HOLA COMO ESTAS',1);

CREATE OR REPLACE FUNCTION hallarposiscion(CAD2 TEXT, CAD1 TEXT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE LOC INT DEFAULT 0;

    SET LOC = LOCATE(CAD1,CAD2);

    IF(SELECT LOC != 0) THEN
        SET R = CONCAT('Si existe: ',LOC);
    ELSE
        SET R = CONCAT('No existe: ',LOC);
    END IF;

    RETURN R;
END;

SELECT hallarposiscion('6993499LP','LP');



CREATE OR REPLACE FUNCTION concatenanum(limite INT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    DECLARE J INT DEFAULT 0;

   WHILE J <= limite DO
       SET R = CONCAT(R,' ',J);
       SET J =  J + 2;
       end while;
    RETURN R;
END;

SELECT concatenanum(15);

CREATE OR REPLACE FUNCTION concatena_n_veses(CAD TEXT,limite INT)
RETURNS TEXT
BEGIN
    DECLARE str TEXT DEFAULT '';

     REPEAT

         SET str = CONCAT(STR,' ',CAD);
         SET limite = limite - 1;

        UNTIL  limite <= 0 END REPEAT;

    RETURN str;
end;

SELECT concatena_n_veses('dbaii',3);