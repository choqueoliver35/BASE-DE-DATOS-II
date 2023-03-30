CREATE DATABASE tareaHito2;
USE tareaHito2;

CREATE TABLE estudiantes
(
    id_est INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(50),
    apellidos VARCHAR(50),
    edad INT,
    gestion INT,
    fono INT,
    email VARCHAR(100),
    direccion VARCHAR(100),
    sexo VARCHAR(10)
);

CREATE TABLE materias
(
    id_mat INT AUTO_INCREMENT PRIMARY KEY,
    nombre_mat VARCHAR(100),
    cod_mat VARCHAR(100)
);

CREATE TABLE inscripcion
(
    id_ins INT AUTO_INCREMENT PRIMARY KEY ,
    semestre VARCHAR(20),
    gestion INT,
    id_est INT,
    id_mat INT,

    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email,direccion, sexo)
VALUES ('Miguel', 'Gonzales Veliz', 20, 2832115,'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino'),
       ('Sandra', 'Mavir Uria', 25, 2832116, 'sandra@gmail.com','Av. 6 de Agosto', 'femenino'),
       ('Joel', 'Adubiri Mondar', 30, 2832117, 'joel@gmail.com','Av. 6 de Agosto', 'masculino'),
       ('Andrea', 'Arias Ballesteros', 21, 2832118,'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino'),
       ('Santos', 'Montes Valenzuela', 24, 2832119,'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');


INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('Introduccion a la Arquitectura', 'ARQ-101'),
       ('Urbanismo y Diseno', 'ARQ-102'),
       ('Dibujo y Pintura Arquitectonico', 'ARQ-103'),
       ('Matematica discreta', 'ARQ-104'),
       ('Fisica Basica', 'ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion)
VALUES (1, 1, '1er Semestre', 2018),
       (1, 2, '2do Semestre', 2018),
       (2, 4, '1er Semestre', 2019),
       (2, 3, '2do Semestre', 2019),
       (3, 3, '2do Semestre', 2020),
       (3, 1, '3er Semestre', 2020),
       (4, 4, '4to Semestre', 2021),
       (5, 5, '5to Semestre', 2021);



CREATE OR REPLACE FUNCTION comparaMaterias(cod_mat VARCHAR(100), cod_mat_buscar VARCHAR(100))
    RETURNS BOOLEAN
        BEGIN
            DECLARE A BOOLEAN DEFAULT FALSE;

            IF (cod_mat = cod_mat_buscar) THEN
                SET A = TRUE;
            END IF;
            RETURN A;
        END;


SELECT E.id_est,
       E.nombres,
       E.apellidos,
       M.nombre_mat,
       M.cod_mat
FROM estudiantes AS E
    INNER JOIN inscripcion AS I on E.id_est = I.id_est
    INNER JOIN materias AS M on I.id_mat = M.id_mat
WHERE comparaMaterias(M.cod_mat,'ARQ-105');


CREATE OR REPLACE FUNCTION promedioEdades(genero_buscar VARCHAR(10), cod_mat_buscar VARCHAR(100))
    RETURNS INT
        BEGIN
            DECLARE A INT DEFAULT 0;

            SELECT AVG(E.edad)
            FROM estudiantes AS E
                INNER JOIN inscripcion AS I on E.id_est = I.id_est
                INNER JOIN materias AS M on I.id_mat = M.id_mat
            WHERE E.sexo = genero_buscar AND M.cod_mat = cod_mat_buscar
            INTO A;

            RETURN A;
        END;

SELECT promedioEdades('femenino','ARQ-104');

SELECT promedioEdades('masculino','ARQ-104');


CREATE OR REPLACE FUNCTION concatena3parametros(a VARCHAR(100), b VARCHAR(100), c INT)
    RETURNS VARCHAR(100)
        BEGIN
            DECLARE D VARCHAR(100);

            SELECT CONCAT('(',a,') (',b,') (',c,')')
            INTO D;

            RETURN D;
        END;

SELECT concatena3parametros('Pepito','pep',50);

SELECT concatena3parametros(E.nombres, E.apellidos,E.edad)
FROM estudiantes AS E;

CREATE VIEW  ARQUITECTURA_DIA_LIBRE AS
    SELECT CONCAT(E.nombres,' ',E.apellidos) AS FULLNAME,
           E.edad AS EDAD,
           I.gestion AS GESTION,
           (
               CASE
                   WHEN I.gestion = 2021 AND M.cod_mat = 'ARQ-101' THEN 'LIBRE'
                   ELSE 'NO LIBRE'
               END
           ) AS DIA_LIBRE
    FROM estudiantes AS E
        INNER JOIN inscripcion AS I on E.id_est = I.id_est
        INNER JOIN materias AS M on I.id_mat = M.id_mat;


SELECT *
FROM ARQUITECTURA_DIA_LIBRE;

CREATE TABLE Universidad
(
    id_universidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_uni VARCHAR(100),
    id_ins INT,

    FOREIGN KEY (id_ins) REFERENCES inscripcion(id_ins)
);

INSERT INTO Universidad(nombre_uni, id_ins)
VALUES ('UNIFRANZ',1),
       ('UNIFRANZ',2),
       ('UNIFRANZ',3),
       ('UNIFRANZ',4),
       ('UNIFRANZ',5),
       ('UNIFRANZ',6),
       ('UNIVALLE',7),
       ('UNIVALLE',8);

CREATE OR REPLACE VIEW PARALELO_DBA_I AS
    SELECT CONCAT(E.nombres,' ',E.apellidos) AS FULLNAME,
           E.edad AS EDAD,
           I.gestion AS GESTION,
           U.nombre_uni AS NOMBRE_UNIVESIDAD
    FROM estudiantes AS E
        INNER JOIN inscripcion AS I on E.id_est = I.id_est
        INNER JOIN materias AS M on I.id_mat = M.id_mat
        INNER JOIN Universidad U on I.id_ins = U.id_ins;

SELECT *
FROM PARALELO_DBA_I
WHERE NOMBRE_UNIVESIDAD = 'UNIVALLE';