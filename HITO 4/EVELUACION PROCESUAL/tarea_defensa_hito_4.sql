CREATE DATABASE tarea_defensa_hito_4;
USE tarea_defensa_hito_4;

#EJERCICIO 9
CREATE TABLE departamento
(
    id_dep INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50)
);

CREATE TABLE provincia
(
    id_prov INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    id_dep INT,

    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep)
);

CREATE TABLE persona
(
    id_per INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellidos VARCHAR(50),
    fecha_nac DATE,
    edad INT,
    email VARCHAR(20),
    id_dep INT,
    id_prov INT,
    Sexo CHAR(1),

    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia(id_prov)
);

CREATE TABLE proyecto
(
    id_proy INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proy VARCHAR(100),
    tipo_proy VARCHAR(30)
);

CREATE TABLE detalle_proyecto
(
    id_dp INT PRIMARY KEY AUTO_INCREMENT,
    id_per INT,
    id_proy INT,

    FOREIGN KEY (id_proy) REFERENCES proyecto(id_proy),
    FOREIGN KEY (id_per) REFERENCES persona(id_per)
);






#EJERCICIO 10
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




CREATE OR REPLACE FUNCTION sumarFibonacci(n INT)
RETURNS INT
BEGIN
    DECLARE serie TEXT;
    DECLARE suma INT DEFAULT 0;
    DECLARE numero INT;

    SET serie = serieFibonacci(n);

    WHILE serie != '' DO
        SET numero = CAST(SUBSTRING_INDEX(serie, ',', 1) AS UNSIGNED);
        SET suma = suma + numero;
        SET serie = SUBSTRING(serie FROM LOCATE(',', serie) + 1);
    END WHILE;

    RETURN suma;
END;

SET @n = 3;
SELECT @n;

SELECT serieFibonacci(@n) AS Fibonacci; #46 es el limite
SELECT sumarFibonacci(@n) AS sumFibonacci;




#EJERCICIO 11
# 1. nombres y apellidos concatenados
# 2. la edad
# 3. fecha de nacimiento.
# 4. Nombre del proyecto

#datos insertados
INSERT INTO departamento (nombre) VALUES
    ('Departamento A'),
    ('Departamento B'),
    ('Departamento C');

INSERT INTO provincia (nombre, id_dep) VALUES
    ('Provincia A', 1),
    ('Provincia B', 2),
    ('Provincia C', 1);


INSERT INTO persona (nombre, apellidos, fecha_nac, edad, email, id_dep, id_prov, Ssexo) VALUES
    ('Persona 1', 'Apellido 1', '1990-01-01', 31, 'persona1@example.com', 1, 1, 'M'),
    ('Persona 2', 'Apellido 2', '1995-02-02', 26, 'persona2@example.com', 2, 2, 'F'),
    ('Persona 3', 'Apellido 3', '1985-03-03', 36, 'persona3@example.com', 3, 3, 'M');


INSERT INTO proyecto (nombre_proy, tipo_proy) VALUES
    ('Proyecto 1', 'Tipo 1'),
    ('Proyecto 2', 'Tipo 2'),
    ('Proyecto 3', 'Tipo 1');

INSERT INTO detalle_proyecto (id_per, id_proy) VALUES
    (1, 1),
    (2, 2),
    (3, 3);



CREATE OR REPLACE VIEW  muestra_personas_del_sexo_Femenino AS
    SELECT CONCAT(p.nombre, ' ', p.apellidos) AS FULLNAME,
       p.edad,
       p.fecha_nac,
       pr.nombre_proy AS nombre_proyecto
    FROM persona p
        JOIN provincia pv ON p.id_prov = pv.id_prov
        JOIN departamento d ON pv.id_dep = d.id_dep
        JOIN detalle_proyecto dp ON p.id_per = dp.id_per
        JOIN proyecto pr ON dp.id_proy = pr.id_proy
    WHERE p.Ssexo = 'F'
      AND d.nombre = 'El Alto'
      AND p.fecha_nac = '2000-10-10';

SELECT * FROM muestra_personas_del_sexo_Femenino;


#EJERCICIO 12
ALTER TABLE proyecto
ADD COLUMN estado VARCHAR(50);

CREATE OR REPLACE TRIGGER proyecto_insert_trigger
BEFORE INSERT ON proyecto
FOR EACH ROW
BEGIN
    IF NEW.tipo_proy = 'EDUCACION' OR NEW.tipo_proy = 'FORESTACIÓN' OR NEW.tipo_proy = 'CULTURA' THEN
        SET NEW.estado = 'ACTIVO';
    ELSE
        SET NEW.estado = 'INACTIVO';
    END IF;
END;

INSERT INTO proyecto(NOMBRE_PROY, TIPO_PROY)
VALUES('CULTURA AYMARA','CULTURA');
INSERT INTO proyecto(NOMBRE_PROY, TIPO_PROY)
VALUES('BALONCESTO','DEPORTES');


CREATE OR REPLACE TRIGGER proyecto_update_trigger
BEFORE UPDATE ON proyecto
FOR EACH ROW
BEGIN
    IF NEW.tipo_proy = 'EDUCACION' OR NEW.tipo_proy = 'FORESTACIÓN' OR NEW.tipo_proy = 'CULTURA' THEN
        SET NEW.estado = 'ACTIVO';
    ELSE
        SET NEW.estado = 'INACTIVO';
    END IF;
END;


#EJERCICIO 13
CREATE OR REPLACE TRIGGER calculaEdad
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
    SET NEW.edad = YEAR(CURDATE()) - YEAR(NEW.fecha_nac);
    IF MONTH(CURDATE()) < MONTH(NEW.fecha_nac) OR
       (MONTH(CURDATE()) = MONTH(NEW.fecha_nac) AND DAY(CURDATE()) < DAY(NEW.fecha_nac)) THEN
        SET NEW.edad = NEW.edad - 1;
    END IF;
END;

INSERT INTO persona(nombre, apellidos, fecha_nac,email, id_dep, id_prov, Ssexo)
VALUES ('Sergio', 'Mendoza', '2003-06-08', 'persona3@example.com', 2, 2, 'M');


#EJERCICIO 14
CREATE TABLE copia_persona (
    nombres VARCHAR(20),
    apellidos VARCHAR(50),
    fecha_nac DATE,
    edad INT,
    email VARCHAR(20),
    id_dep INT,
    id_prov INT,
    Ssexo CHAR(1)
);

CREATE OR REPLACE TRIGGER insert_copia_persona
AFTER INSERT ON persona
FOR EACH ROW
BEGIN
    INSERT INTO copia_persona (nombres, apellidos, fecha_nac, edad, email, id_dep, id_prov, Ssexo)
    VALUES (NEW.nombre, NEW.apellidos, NEW.fecha_nac, NEW.edad, NEW.email, NEW.id_dep, NEW.id_prov, NEW.Ssexo);
END;

INSERT INTO persona(nombre, apellidos, fecha_nac ,email, id_dep, id_prov, Ssexo)
VALUES ('Mijail','Choque','2004-02-16','mijailchoque35@gmail.com',1,1,'M');

#EJERCICIO 15
CREATE OR REPLACE VIEW copia_persona_vista AS
SELECT * FROM copia_persona;

SELECT * FROM copia_persona_vista;

SELECT * FROM proyecto;






