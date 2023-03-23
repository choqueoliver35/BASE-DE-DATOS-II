CREATE DATABASE HITO_2_VISTAS;
USE HITO_2_VISTAS;

CREATE TABLE Usuarios
(
    id_usuario INTEGER AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    email VARCHAR(100)  NOT NULL
);

INSERT INTO Usuarios(nombres, apellidos, edad, email)
VALUES ('nombre 1','apellido 1',20,'nombre1@gamil.com'),
       ('nombre 2','apellido 2',30,'nombre2@gamil.com'),
       ('nombre 3','apellido 3',40,'nombre3@gamil.com');

SELECT * FROM Usuarios;

/*MOSTRAR LOS USUARIOS MAYORES A 30*/
CREATE VIEW mayoresA30 AS
    SELECT * FROM Usuarios AS US
    WHERE US.edad > 30;


#tambien se puede usar en ves de ALTER el CREATE OR REPLACE

ALTER VIEW mayoresA30 AS
    SELECT US.nombres,
           US.apellidos,
           US.edad,
           US.email
        FROM Usuarios AS US
    WHERE US.edad > 30;

SELECT * FROM mayoresA30 AS M30;

#MODIFICAR LA VISTA ANTERIOR
#para wue  uestre los siguientes campos
#FULL NAME = Nombre y apellido
#EDAD_USUARIO
#EMAIL_USUARIO

ALTER VIEW mayoresA30 AS
    SELECT CONCAT(US.nombres,' ', US.apellidos) AS FULLNAME,
           US.edad AS EDAD_USUARIO,
           US.email AS EMAIL_USUARIO
    FROM Usuarios AS US
    WHERE US.edad > 30;


#A LA VISTA CREADA ANTERIOR MENTE MOSTRAR AQUELLOS
#USUARIOS QUE EN SU APELLIDO TENGAN EL NUMERO 3


#CREATE OR REPLACE o
ALTER VIEW mayoresA30 AS
    SELECT CONCAT(US.nombres,' ', US.apellidos) AS FULLNAME,
           US.edad AS EDAD_USUARIO,
           US.email AS EMAIL_USUARIO
    FROM Usuarios AS US
    WHERE US.edad > 30;



SELECT US.FULLNAME
FROM mayoresA30 AS US
WHERE US.FULLNAME LIKE '%3%';


DROP VIEW mayoresA30;