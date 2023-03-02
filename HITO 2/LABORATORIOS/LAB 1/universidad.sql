SHOW DATABASES;

CREATE DATABASE HITO_2;
USE HITO_2;
DROP DATABASE EJEMPLO;

CREATE TABLE estudiante
(
    nombre varchar(100),
    apellido varchar(100)
);

INSERT INTO estudiante(nombre,apellido)
    VALUES ('HAROLD','AREVALO'),('MIJAIL','CHOQUE');

SELECT * FROM estudiante;

CREATE DATABASE Universidad;

USE Universidad;

--AUTO_INCREMEN ES IGUAL A  IDENTITY

CREATE TABLE Estudiante
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL,
    email VARCHAR(50) NOT NULL
);

DESCRIBE Estudiante;

INSERT INTO Estudiante(nombres, apellidos, edad, fono, email)
    VALUES ('Nombre 1','Apellido 1',10,1111,'user1@gmail.com'),
           ('Nombre 2','Apellido 2',10,1111,'user2@gmail.com'),
           ('Nombre 3','Apellido 2',10,1111,'user3@gmail.com');

SELECT * FROM estudiante;

select last_insert_id();

ALTER TABLE Estudiante
DROP COLUMN direccion;


ALTER TABLE Estudiante
ADD COLUMN direccion VARCHAR(100) DEFAULT ('EL ALTO');


DESCRIBE estudiante;

ALTER TABLE Estudiante
ADD COLUMN fax VARCHAR(10),
ADD COLUMN genero varchar(10);


SELECT * FROM estudiante
WHERE estudiante.nombres = 'Nombre 3';

SELECT est.nombre,
       est.apellido,
       est.edad
FROM estudiante AS est
WHERE est.edad > 18;



SELECT * FROM estudiante as est
WHERE est.id_est % 2 = 0;

SELECT * FROM estudiante as est
WHERE est.id_est % 2 != 0;

DROP TABLE Estudiante;


CREATE TABLE Estudiantes
(
    id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Materias
(
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_mat VARCHAR(100) NOT NULL,
    cod_mat VARCHAR(100) NOT NULL
);

CREATE TABLE Inscripcion
(
    id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_est INTEGER NOT NULL,
    id_mat INTEGER NOT NULL,

    FOREIGN KEY (id_est) REFERENCES Estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES Materias(id_mat)
);



