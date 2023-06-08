CREATE DATABASE defensa_hit4_2023;#notacion anderscorp
USE defensa_hit4_2023;


CREATE TABLE departamento
(
    id_dep INT PRIMARY KEY,
    nombre VARCHAR(50)
);

CREATE TABLE provincia
(
    id_prov INT PRIMARY KEY,
    nombre VARCHAR(50),
    id_dep INT,

    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep)
);

CREATE TABLE persona
(
    id_per INT PRIMARY KEY,
    nombre VARCHAR(20),
    apellidos VARCHAR(50),
    fecha_nac DATE,
    edad INT,
    email VARCHAR(20),
    id_dep INT,
    id_prov INT,
    Ssexo CHAR(1),

    FOREIGN KEY (id_dep) REFERENCES departamento(id_dep),
    FOREIGN KEY (id_prov) REFERENCES provincia(id_prov)
);

CREATE TABLE proyecto
(
    id_proy INT PRIMARY KEY,
    nombre_proy VARCHAR(100),
    tipo_proy VARCHAR(30)
);

CREATE TABLE detalle_proyecto
(
    id_dp INT PRIMARY KEY,
    id_per INT,
    id_proy INT,

    FOREIGN KEY (id_proy) REFERENCES proyecto(id_proy),
    FOREIGN KEY (id_per) REFERENCES persona(id_per)
);


INSERT INTO departamento (id_dep, nombre) VALUES
    (1,'Departamento A'),
    (2,'Departamento B'),
    (3,'Departamento C');

INSERT INTO provincia (id_prov, nombre, id_dep) VALUES
    (1,'Provincia A', 1),
    (2,'Provincia B', 2),
    (3,'Provincia C', 1);

INSERT INTO persona (id_per, nombre, apellidos, fecha_nac, edad, email, id_dep, id_prov, Ssexo) VALUES
    (1,'Persona 1', 'Apellido 1', '1990-01-01', 31, 'persona1@example.com', 1, 1, 'M'),
    (2,'Persona 2', 'Apellido 2', '
1995-02-02', 26, 'persona2@example.com', 2, 2, 'F'),
    (3,'Persona 3', 'Apellido 3', '1985-03-03', 36, 'persona3@example.com', 3, 3, 'M');

INSERT INTO proyecto (id_proy,nombre_proy, tipo_proy) VALUES
    (1,'Proyecto 1', 'Tipo 1'),
    (2,'Proyecto 2', 'Tipo 2'),
    (3,'Proyecto 3', 'Tipo 1');

INSERT INTO detalle_proyecto (id_dp, id_per, id_proy) VALUES
    (1,1, 1),
    (2,2, 2),
    (3,3, 3);


CREATE TABLE audit_proyecto
(
    id_audit_proy INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proy_anterior VARCHAR(100),
    nombre_proy_posterior VARCHAR(100),
    tipo_proy_anterior VARCHAR(100),
    tipo_proy_posterior VARCHAR(100),
    operacion  VARCHAR(30),
    userfield VARCHAR(30),
    hostname VARCHAR(30),
    facha VARCHAR(30)
);


CREATE OR REPLACE TRIGGER tr_insert
AFTER INSERT ON proyecto
FOR EACH ROW
BEGIN

    DECLARE antesdesp TEXT;
    SET antesdesp = 'NO EXISTE VALOR PREVIO - INSERT';
    INSERT INTO audit_proyecto(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operacion, userfield, hostname, facha)
    SELECT 'NO EXISTE VALOR PREVIO - INSERT',NEW.nombre_proy,'NO EXISTE VALOR PREVIO - INSERT',NEW.tipo_proy,'INSERT',USER(),@@HOSTNAME,NOW();

END;

CREATE OR REPLACE TRIGGER tr_update
BEFORE UPDATE ON proyecto
FOR EACH ROW
BEGIN

    INSERT INTO audit_proyecto(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operacion, userfield, hostname, facha)
    VALUES(OLD.nombre_proy,NEW.nombre_proy,OLD.tipo_proy,NEW.tipo_proy,'UPDATE',USER(),@@HOSTNAME,NOW());

END;

CREATE OR REPLACE TRIGGER tr_delete
AFTER DELETE ON proyecto
FOR EACH ROW
BEGIN
    DECLARE antesdesp TEXT;
    SET antesdesp = 'NO EXISTE VALOR PREVIO - DELETE';
    INSERT INTO audit_proyecto(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operacion, userfield, hostname, facha)
    VALUES(OLD.nombre_proy,antesdesp,OLD.tipo_proy,antesdesp,'DELETE',USER(),@@HOSTNAME,NOW());

END;


INSERT INTO proyecto(id_proy, nombre_proy, tipo_proy)
VALUES (5,'BASE DE DATOS II','SISTEMAS');

UPDATE proyecto
SET nombre_proy = 'ESTRUCTURA DE DATOS',
    tipo_proy = 'SERVIDOR DEL GOBIERNO'
WHERE id_proy = 4;

DELETE FROM proyecto WHERE  id_proy =  4;


SELECT * FROM audit_proyecto;

SHOW TRIGGERS;



CREATE OR REPLACE VIEW reporte_proyecto AS
    SELECT CONCAT(p.nombre,' ',p.apellidos) AS fullname,
           CONCAT(pr.nombre_proy, ' ', pr.tipo_proy) AS desc_proyecto,
           d.nombre AS departamento,
           (
               CASE
                   WHEN d.nombre = 'LA PAZ' THEN 'LPZ'
                   WHEN d.nombre = 'COCHABAMABA' THEN 'CBB'
                   WHEN d.nombre = 'EL ALTO' THEN 'EAT'
                   ELSE 'NO ES UN DEPARTAMENTO ADMITIDO'
               END
           ) AS codigo_dep
    FROM persona p
        JOIN provincia pv ON p.id_prov = pv.id_prov
        JOIN departamento d ON pv.id_dep = d.id_dep
        JOIN detalle_proyecto dp ON p.id_per = dp.id_per
        JOIN proyecto pr ON dp.id_proy = pr.id_proy;

SELECT * FROM reporte_proyecto;


CREATE OR REPLACE TRIGGER tr_validacion
    BEFORE INSERT ON proyecto
    FOR EACH ROW
    BEGIN


        IF(NEW.tipo_proy = 'FORESTACION' AND MONTHNAME(CURRENT_DATE) = 'June' AND DAYNAME(CURRENT_DATE) = 'Wednesday' ) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se admiten inserciones de tipo FORESTACION';
        END IF;
    end;

INSERT INTO proyecto(id_proy, nombre_proy, tipo_proy)
VALUES (7,'ARBOLES','FORESTACION');

INSERT INTO proyecto(id_proy, nombre_proy, tipo_proy)
VALUES (4,'ARBOLES','COLEGIATURA');

SELECT * FROM proyecto;



CREATE OR REPLACE FUNCTION diccionario(dia TEXT)
RETURNS TEXT
BEGIN
    DECLARE R TEXT DEFAULT '';
    CASE dia
        WHEN 'Monday' THEN SET R = 'LUNES';
        WHEN 'Tuesday' THEN SET R = 'MARTES';
        WHEN 'Wednesday' THEN SET R = 'MIERCOLES';
        WHEN 'thursday' THEN SET R = 'JUEVES';
        WHEN 'Friday' THEN SET R = 'VIERNES';
        WHEN 'Saturday' THEN SET R = 'SABADO';
        WHEN 'Sunday' THEN SET R = 'DOMINGO';
    END CASE;
    RETURN R;

end;

SELECT diccionario('Monday');
SELECT diccionario('Tuesday');
SELECT diccionario(DAYNAME(CURRENT_DATE));
SELECT diccionario('thursday');
SELECT diccionario('Friday');
SELECT diccionario('Saturday');
SELECT diccionario('Sunday');


