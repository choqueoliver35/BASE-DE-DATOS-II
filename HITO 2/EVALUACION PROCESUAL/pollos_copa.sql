CREATE DATABASE POLLOS_COPA;
USE POLLOS_COPA;

CREATE TABLE Cliente
(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    edad INT,
    domicilio VARCHAR(100)
);

CREATE TABLE Pedido
(
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    articulo VARCHAR(100),
    costo DOUBLE,
    fecha DATE
);

CREATE TABLE detalle_pedido
(
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_pedido INT,

    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

INSERT INTO Cliente(fullname, lastname, edad, domicilio)
VALUES('Juan Pérez', 'García', 30, 'Calle 1, Colonia A, Ciudad A, Estado A, 12345, País A'),
      ('María González', 'Sánchez', 25, 'Calle 2, Colonia B, Ciudad B, Estado B, 67890, País B');

INSERT INTO Pedido(articulo, costo, fecha)
VALUES ('Mouse inalámbrico', 25.99, '2023-03-28'),
       ('Teclado USB', 39.99, '2023-03-29');

INSERT INTO detalle_pedido(id_cliente, id_pedido)
VALUES (1,1),
       (2,2);

SELECT P.*
FROM Cliente AS C
    INNER JOIN detalle_pedido AS dp on C.id_cliente = dp.id_cliente
    INNER JOIN Pedido P on dp.id_pedido = P.id_pedido
WHERE C.fullname LIKE '%Juan%';






