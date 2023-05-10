
#LAB 4
CREATE OR REPLACE FUNCTION cuentaLetra(CAD VARCHAR(50), LETRA CHAR)
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT 'La letra no hay en la cadena';
    DECLARE cont INT DEFAULT 1;
    DECLARE Nveces INT DEFAULT 0;
    DECLARE PUNTERO CHAR;

    IF LOCATE(LETRA,CAD) > 0 THEN
        WHILE cont <= char_length(CAD) DO
            SET PUNTERO = SUBSTR(CAD,cont,1);
            IF PUNTERO = LETRA THEN
                SET Nveces = Nveces + 1;
            END IF;
            SET cont = cont + 1;
        END WHILE;
        SET RESP = CONCAT('La letra ',LETRA,' se repite: ',Nveces);
    END IF;
    RETURN RESP;
end;

SELECT cuentaLetra('HOLA MUNDO','I');

CREATE OR REPLACE FUNCTION cuentaVocal(CAD VARCHAR(50))
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT 'no hay vocales';
    DECLARE cont INT DEFAULT 1;
    DECLARE Nveces INT DEFAULT 0;
    DECLARE PUNTERO CHAR;


        WHILE cont <= char_length(CAD) DO
            SET PUNTERO = SUBSTR(CAD,cont,1);
            CASE PUNTERO
                WHEN 'A' THEN SET Nveces = Nveces + 1;
                WHEN 'E' THEN SET Nveces = Nveces + 1;
                WHEN 'I' THEN SET Nveces = Nveces + 1;
                WHEN 'O' THEN SET Nveces = Nveces + 1;
                WHEN 'U' THEN SET Nveces = Nveces + 1;
                ELSE SET  Nveces = Nveces;
            END CASE;
            SET cont = cont + 1;
        END WHILE;

        SET RESP = CONCAT('Cantidad de Vocales: ',Nveces);
    RETURN RESP;
end;


SELECT cuentaVocal('DBA II 2023');

#BASE DE DATOS II 2023

CREATE OR REPLACE FUNCTION cuentaPalabras(cad VARCHAR(50))
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT 'no hay vocales';
    DECLARE cont INT DEFAULT 1;
    DECLARE Nveces INT DEFAULT 1;
    DECLARE PUNTERO CHAR;

    WHILE cont <= char_length(CAD) DO
            SET PUNTERO = SUBSTR(CAD,cont,1);
            IF PUNTERO = ' ' THEN
                SET Nveces = Nveces + 1;
            END IF;
            SET cont = cont + 1;
        END WHILE;
        SET RESP = CONCAT('Cantidad de Palabras : ',Nveces);
    RETURN RESP;
end;

SELECT cuentaPalabras('DBA II 2023');


CREATE OR REPLACE FUNCTION cuenta(cad VARCHAR(50))
RETURNS TEXT
BEGIN
    DECLARE RESP TEXT DEFAULT 'no hay vocales';
    DECLARE cont INT DEFAULT 1;


    SET CONT = LOCATE(' ',CAD);
    SET CONT = LOCATE(' ',CAD,cont +1);
    SET RESP = SUBSTR(CAD,cont);
    RETURN RESP;
end;

SELECT cuenta('MIJIAL OLIVER CHOQUE AMARO');





