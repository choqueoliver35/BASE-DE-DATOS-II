CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autor (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nacionalidad VARCHAR(50),
  fecha_nacimiento DATE
);



CREATE TABLE usuario (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  fecha_nacimiento DATE,
  direccion VARCHAR(100)
);

CREATE TABLE libro (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(100) NOT NULL,
  isbn VARCHAR(20),
  fecha_publicacion DATE,
  autor_id INTEGER,
  FOREIGN KEY (autor_id) REFERENCES autor(id)
);

CREATE TABLE prestamo (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  usuario_id INTEGER REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);


CREATE TABLE libro_categoria (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  libro_id INTEGER REFERENCES libro(id) ON DELETE CASCADE,
  categoria_id INTEGER REFERENCES categoria(id) ON DELETE CASCADE
);


INSERT INTO autor (nombre, nacionalidad, fecha_nacimiento) VALUES
('Gabriel Garcia Marquez', 'Colombiano', '1927-03-06'),
('Mario Vargas Llosa', 'Peruano', '1936-03-28'),
('Pablo Neruda', 'Chileno', '1904-07-12'),
('Octavio Paz', 'Mexicano', '1914-03-31'),
('Jorge Luis Borges', 'Argentino', '1899-08-24');


INSERT INTO libro (titulo, isbn, fecha_publicacion, autor_id) VALUES
('Cien años de soledad', '978-0307474728', '1967-05-30', 1),
('La ciudad y los perros', '978-8466333867', '1962-10-10', 2),
('Veinte poemas de amor y una canción desesperada', '978-0307477927', '1924-08-14', 3),
('El laberinto de la soledad', '978-9681603011', '1950-01-01', 4),
('El Aleph', '978-0307950901', '1949-06-30', 5);


INSERT INTO usuario (nombre, email, fecha_nacimiento, direccion) VALUES
('Juan Perez', 'juan.perez@gmail.com', '1985-06-20', 'Calle Falsa 123'),
('Maria Rodriguez', 'maria.rodriguez@hotmail.com', '1990-03-15', 'Av. Siempreviva 456'),
('Pedro Gomez', 'pedro.gomez@yahoo.com', '1982-12-10', 'Calle 7ma 789'),
('Laura Sanchez', 'laura.sanchez@gmail.com', '1995-07-22', 'Av. Primavera 234'),
('Jorge Fernandez', 'jorge.fernandez@gmail.com', '1988-04-18', 'Calle Real 567');



INSERT INTO prestamo (fecha_inicio, fecha_fin, libro_id, usuario_id) VALUES
('2022-01-01', '2022-01-15', 1, 1),
('2022-01-03', '2022-01-18', 2, 2),
('2022-01-05', '2022-01-20', 3, 3),
('2022-01-07', '2022-01-22', 4, 4),
('2022-01-09', '2022-01-24', 5, 5);


INSERT INTO categoria (nombre) VALUES
('Novela'),
('Poesía'),
('Ensayo'),
('Ciencia Ficción'),
('Historia');


INSERT INTO libro_categoria (libro_id, categoria_id) VALUES
(1, 1),
(1, 3),
(2, 1),
(2, 5),
(3, 2),
(4, 3),
(5, 4);


ALTER TABLE libro
ADD COLUMN paginas INTEGER DEFAULT 20;

ALTER TABLE libro
ADD COLUMN editorial VARCHAR(50) DEFAULT 'Don Bosco';

SELECT * FROM libro;


CREATE VIEW Libros_de_Autores_Argentinos AS
    SELECT L.titulo,
           A.nacionalidad,
           A.nombre
    FROM libro AS L INNER JOIN autor AS A ON L.autor_id = A.id
    WHERE A.nacionalidad LIKE '%Argentino%';

drop view libros_de_ciencia_ficcion;

CREATE VIEW Libros_de_Ciencia_Ficcion AS
    SELECT L.titulo AS LIBRO,
           C.nombre AS CATEGORIA
    FROM libro AS L INNER JOIN libro_categoria LC on L.id = LC.libro_id
    INNER JOIN categoria C on LC.categoria_id = C.id
    WHERE C.nombre = 'Ciencia Ficción';


CREATE VIEW bookContenet AS
    SELECT L.titulo AS titleBook,
           L.editorial AS editorialBook,
           L.paginas AS pagesBook,
           (
               CASE
                   WHEN l.paginas >0 AND l.paginas <=30 THEN 'CONTENIDO BASICO'
                   WHEN l.paginas >30 AND l.paginas <=80 THEN 'CONTENIDO MEDIANO'
                   WHEN l.paginas >80 AND l.paginas <=150 THEN 'CONTENIDO SUPERIOR'
                   ELSE 'CONTENIDO AVANZADO'
               END
               ) AS typeContentBook
    FROM libro AS L;

#de acuerdo a la vista creada contar cuantos libros son de contenido miedo

SELECT COUNT(typeContentBook)
FROM bookcontenet
WHERE typeContentBook = 'CONTENIDO MEDIANO';



CREATE VIEW book_And_Autor AS
    SELECT CONCAT(L.titulo,' - ',L.editorial,' - ',C.nombre) AS BOOKDETAIL,
           CONCAT(A.nombre,' - ',A.nacionalidad) AS AUTORDETAIL
    FROM libro AS L INNER JOIN libro_categoria LC on L.id = LC.libro_id
    INNER JOIN categoria C on LC.categoria_id = C.id
    INNER JOIN autor A on L.autor_id = A.id;


#de acuerdo a la vista creada generar los siguinte:
#si ene el bbokdetail esta la editrial nova
#genrear un acolumna que diga "EN VENTA"
#caso contrario colocar  "EN PROCESO"

SELECT *,
(
    CASE
        WHEN b.BOOKDETAIL LIKE '%NOVA%' THEN 'EN VENTA'
        ELSE  'EN PROCESO'
    END
) AS Promocion
FROM book_And_Autor AS B;

#LAB 4;

CREATE VIEW autores_peru_historia AS
    SELECT C.nombre AS CATEGORY,
           A.nombre AS NAME,
           A.nacionalidad AS NACIONALITY
     FROM libro AS L
         INNER JOIN libro_categoria LC on L.id = LC.libro_id
         INNER JOIN categoria C on LC.categoria_id = C.id
         INNER JOIN autor A on L.autor_id = A.id
     WHERE C.nombre = 'Historia' AND A.nacionalidad = 'Peruano';

SELECT *
FROM autores_peru_historia;


CREATE OR REPLACE FUNCTION fullname()
RETURNS VARCHAR(30)
    BEGIN
        RETURN 'Mijail Choque Amaro';
    END;

SELECT fullname();

CREATE OR REPLACE FUNCTION numero()
RETURNS INTEGER
    BEGIN
        RETURN 10;
    END;

SELECT numero();


CREATE OR REPLACE FUNCTION getNombreCompleto( nombres VARCHAR(30))
RETURNS VARCHAR(30)
    BEGIN
        RETURN nombres;
    END;

SELECT getNombreCompleto('Mijail Oliver');


CREATE OR REPLACE FUNCTION getsuma( a INTEGER, b INTEGER, c INTEGER)
RETURNS INTEGER
    BEGIN

        RETURN a + b + c;
    END;

SELECT getsuma(5,8,9);



CREATE OR REPLACE FUNCTION getsuma2( a INTEGER, b INTEGER, c INTEGER)
RETURNS INTEGER
    BEGIN
        DECLARE D INTEGER;
        SET D=a+b+c;

        RETURN D;
    END;

SELECT getsuma2(5,8,9);


CREATE OR REPLACE FUNCTION operacion (a INTEGER, b INTEGER, accion VARCHAR(50))
	RETURNS INTEGER
		BEGIN
		    DECLARE R INTEGER;

			IF (accion = 'sumar') THEN
					SET R = a + b;
		    END IF;

			IF (accion = 'restar') THEN
					SET R = a - b;
			END IF;

			IF (accion = 'multiplicar') THEN
					SET R = a * b;
			END IF;

			IF (accion = 'dividir') THEN
					SET R = a * b;
			END IF;

			RETURN R;
		END;

SELECT operacion(5,5,'sumar');
SELECT operacion(5,5,'restar');
SELECT operacion(5,5,'multiplicar');
SELECT operacion(5,5,'dividir');

CREATE OR REPLACE FUNCTION operacion1(a INTEGER, b INTEGER, accion VARCHAR(50))
	RETURNS INTEGER
		BEGIN
		    DECLARE R INTEGER;

			CASE accion
                   WHEN 'sumar' THEN set R = a + b;
                   WHEN 'restar' THEN set R = a - b;
                   WHEN 'multiplicar' THEN set R = a * b;
                   WHEN 'dividir' THEN set R = a / b;
                   ELSE set R = 0;
               END CASE;

			RETURN R;
		END;

SELECT operacion1(5,5,'sumar');
SELECT operacion1(5,5,'restar');
SELECT operacion1(5,5,'multiplicar');
SELECT operacion1(5,5,'dividir');


CREATE OR REPLACE FUNCTION validar_historia_peru(C VARCHAR(30), N VARCHAR(30))
	RETURNS BOOLEAN
		BEGIN
            DECLARE VAL BOOLEAN DEFAULT FALSE;

            IF (C = 'Historia' AND N = 'Peruano') THEN
                SET VAL = TRUE;
            END IF;
		    RETURN VAL;
        END;


SELECT C.nombre AS CATEGORY,
       A.nombre AS NAME,
       A.nacionalidad AS NACIONALITY
FROM libro AS L
    INNER JOIN libro_categoria LC on L.id = LC.libro_id
    INNER JOIN categoria C on LC.categoria_id = C.id
    INNER JOIN autor A on L.autor_id = A.id
WHERE validar_historia_peru(C.nombre,A.nacionalidad) = TRUE;