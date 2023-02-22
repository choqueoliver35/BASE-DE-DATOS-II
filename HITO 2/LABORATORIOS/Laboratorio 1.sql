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
