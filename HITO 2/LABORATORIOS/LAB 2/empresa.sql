SHOW DATABASES;

CREATE DATABASE EMPRESA;
USE EMPRESA;
DROP DATABASE EMPRESA;

CREATE TABLE Empleado
(
    id_emp INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,

    NIT INTEGER,
    id_area INTEGER,

    FOREIGN KEY (id_area) REFERENCES Area(id_area)
);


CREATE TABLE Empresa
(
    NIT INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_emp VARCHAR(100) NOT NULL

);

CREATE TABLE Area
(
    id_area INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
    area_de_trabajo VARCHAR(100) not null
);

SELECT * FROM Empresa;
SELECT * FROM Area;
SELECT * FROM Empleado;

INSERT INTO Empleado(nombre,NIT,id_area)
VALUES('Juan',1,1),('Harold',1,2),('Rolando',1,3);

INSERT INTO Area(area_de_trabajo)
VALUES('Servicios Estudiantiles'),('Gerencia'),('Marketing');

INSERT INTO Empresa(nombre_emp)
VALUES('UNIFRANZ');

/*mostrar rolando en que empresa y en que area trabaja*/
SELECT E.nombre_emp, A.area_de_trabajo
FROM  Empleado AS EMP INNER JOIN Empresa AS E ON EMP.NIT = E.NIT
    INNER JOIN Area AS A ON EMP.id_area = A.id_area
WHERE EMP.nombre = 'Rolando';

