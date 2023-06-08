CREATE DATABASE hito4_2023;
USE hito4_2023;
 #LAB 1
#
# CREATE TRIGGER calculaCuadradoCuboRaiz
#      BEFORE INSERT
#      ON numeros
#      FOR EACH ROW
#      BEGIN
#          SET NEW.campo = POWER(NEW.campo, 2);
#      END;

# CREATE TRIGGER test_DeleteTrigger
#     BEFORE DELETE ON numeros
#     FOR EACH ROW
#     BEGIN
#         insert into numerosBackUp values(OLD. numero);
#     END;

CREATE TABLE numeros
(
    numero BIGINT PRIMARY KEY NOT NULL,
    cuadrado BIGINT,
    cubo BIGINT,
    raiz_cuadrada REAL
);

INSERT INTO numeros (numero) VALUES (2);




CREATE OR REPLACE TRIGGER tr_completa_datos
    BEFORE INSERT
    ON numeros
    FOR EACH ROW
    BEGIN
        DECLARE valor_cuadrado BIGINT;
        DECLARE valor_cubo BIGINT;
        DECLARE valor_raiz_cuadrado REAL;

        SET valor_cuadrado = POWER(NEW.numero,2);
        SET valor_cubo = POWER(NEW.numero,3);
        SET valor_raiz_cuadrado = SQRT(NEW.numero);

        SET NEW.cuadrado = valor_cuadrado;
        SET NEW.cubo = valor_cubo;
        SET NEW.raiz_cuadrada = valor_raiz_cuadrado;

    END;

INSERT INTO numeros (numero) VALUES (4);
INSERT INTO numeros (numero) VALUES (2);

TRUNCATE TABLE numeros;
SELECT * FROM numeros;

#nota mental no olvidarse estos comandos
# SHOW TABLES;
#
# DESCRIBE numeros;

ALTER TABLE numeros
ADD COLUMN suma_total REAL;

CREATE OR REPLACE TRIGGER tr_completa_datos
    BEFORE INSERT
    ON numeros
    FOR EACH ROW
    BEGIN

        DECLARE valor_cuadrado BIGINT;
        DECLARE valor_cubo BIGINT;
        DECLARE valor_raiz_cuadrado REAL;
        DECLARE suma REAL;

        SET valor_cuadrado = POWER(NEW.numero,2);
        SET valor_cubo = POWER(NEW.numero,3);
        SET valor_raiz_cuadrado = SQRT(NEW.numero);
        SET suma = valor_cuadrado + valor_cubo + valor_raiz_cuadrado + NEW.numero;

        SET NEW.cuadrado = valor_cuadrado;
        SET NEW.cubo = valor_cubo;
        SET NEW.raiz_cuadrada = valor_raiz_cuadrado;

        SET NEW.suma_total = suma;
    END;


CREATE TABLE usuarios
(
    id_us INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    correo VARCHAR(100) NOT NULL,
    passsword VARCHAR(100)
);



CREATE OR REPLACE TRIGGER tr_generando_pasos
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        SET NEW.passsword = LOWER(CONCAT(SUBSTR(NEW.nombres,1,2),SUBSTR(NEW.apellidos,1,2),NEW.edad));
    END;

TRUNCATE TABLE usuarios;
INSERT INTO usuarios(nombres, apellidos, edad, correo)
VALUES ('Mijail','Choque',19,'mijailchoque35@gmail.com');

SELECT * FROM usuarios;