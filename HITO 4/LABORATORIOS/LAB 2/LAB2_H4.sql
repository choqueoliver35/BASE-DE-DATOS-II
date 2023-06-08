USE hito4_2023;





#no se puede modificar un registro desde un Trigger
#cuando se esta insertando
# CREATE OR REPLACE TRIGGER tr_generando_pasos
#     AFTER INSERT
#     ON usuarios
#     FOR EACH ROW
#     BEGIN
#         UPDATE usuarios SET passsword = LOWER(CONCAT(SUBSTR(nombres,1,2),SUBSTR(apellidos,1,2),edad))
#         WHERE id_us = last_insert_id();
#     END;
#
# INSERT INTO usuarios(nombres, apellidos, edad, correo,passsword)
# VALUES ('','',0,'','');
#
# INSERT INTO usuarios(nombres, apellidos, edad, correo,passsword)
# VALUES ('Harold','Salas',20,'harold2@gmail.com','');

DROP TABLE usuarios;

CREATE TABLE usuarios
(
    id_us INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombres VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    passsword VARCHAR(100),
    edad INT
);

CREATE OR REPLACE TRIGGER tr_ed_pas
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN

        SET NEW.passsword = LOWER(CONCAT(SUBSTR(NEW.nombres,1,2),SUBSTR(NEW.apellidos,1,2),SUBSTR(NEW.correo,1,2)));
        SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
    END;

INSERT INTO usuarios(nombres, apellidos, fecha_nac, correo)
VALUES ('Mijail','Choque','2004-02-16','mijailchoque35@gmail.com');

SELECT  current_date;

SELECT * FROM usuarios;

CREATE OR REPLACE TRIGGER tr_verifica_password
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
        IF (CHAR_LENGTH(NEW.passsword) < 10) THEN
            SET NEW.passsword = LOWER(CONCAT(SUBSTR(NEW.nombres,-2,2),SUBSTR(NEW.apellidos,-2,2),NEW.edad));
        end if;
    end;


DROP TRIGGER tr_ed_pas;

TRUNCATE usuarios;
INSERT INTO usuarios(nombres, apellidos, fecha_nac, correo,passsword)
VALUES ('Mijail','Choque','2004-02-16','mijailchoque35@gmail.com','ADD'),
       ('Harold','Salas','2000-10-23','harold2@gmail.com','12345678910');

SELECT * FROM usuarios;

SELECT DAYNAME(CURRENT_DATE);

CREATE TRIGGER tr_mantenimiento
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        DECLARE dia_de_la_semana TEXT DEFAULT '';
        SET dia_de_la_semana = DAYNAME(CURRENT_DATE);
        IF(dia_de_la_semana = 'WEDNESDAY') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Base de dato en MANTENIMIENTO';
        end if;
    end;

DROP TRIGGER tr_verifica_password;

INSERT INTO usuarios(nombres, apellidos, fecha_nac, correo,passsword)
VALUES ('Mijail','Choque','2004-02-16','mijailchoque35@gmail.com','ADD'),
       ('Harold','Salas','2000-10-23','harold2@gmail.com','12345678910');

ALTER TABLE usuarios
ADD COLUMN nacionalidad VARCHAR(20);

SELECT * FROM usuarios;


CREATE TRIGGER tr_valida_nacionalidad
    BEFORE INSERT
    ON usuarios
    FOR EACH ROW
    BEGIN
        CASE
            WHEN NEW.nacionalidad = 'BOLIVIA' THEN SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
            SET NEW.passsword = LOWER(CONCAT(SUBSTR(NEW.nombres,-2,2),SUBSTR(NEW.apellidos,-2,2),NEW.edad));
            WHEN NEW.nacionalidad = 'ARGENTINA' THEN SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
            SET NEW.passsword = LOWER(CONCAT(SUBSTR(NEW.nombres,-2,2),SUBSTR(NEW.apellidos,-2,2),NEW.edad));
            WHEN NEW.nacionalidad = 'PARAGUAY' THEN SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.fecha_nac, CURDATE());
            SET NEW.passsword = LOWER(CONCAT(SUBSTR(NEW.nombres,-2,2),SUBSTR(NEW.apellidos,-2,2),NEW.edad));
            ELSE
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Nacionalidad no disponible en este momento';
        END CASE;
    end;




DROP TRIGGER tr_mantenimiento;

INSERT INTO usuarios(nombres, apellidos, fecha_nac, correo,nacionalidad)
VALUES ('Mijail','Choque','2004-02-16','mijailchoque35@gmail.com','BOLIVIA');
SELECT * FROM usuarios;
INSERT INTO usuarios(nombres, apellidos, fecha_nac, correo,nacionalidad)
VALUES ('Mijail','Choque','2004-02-16','mijailchoque35@gmail.com','MEXICO');



