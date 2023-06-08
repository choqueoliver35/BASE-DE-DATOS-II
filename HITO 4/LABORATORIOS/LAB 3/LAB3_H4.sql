USE hito4_2023;

# AUDITORIA: es el hecho de poder
# monitorear todas las acciones que ocurre en una tabla

CREATE TABLE usuarios_rrhh
(
    id_usr INT PRIMARY KEY NOT NULL,
    nombres_completo VARCHAR(50) NOT NULL,
    fecha_nac DATE NOT NULL,
    correo VARCHAR(100) NOT NULL,
    passsword VARCHAR(100)
);

CREATE TABLE audit_usuarios_rrhh
(
    fecha_mod TEXT NOT NULL,
    usuario_log TEXT NOT NULL,
    hostname TEXT NOT NULL,
    accion TEXT NOT NULL,

    id_usr TEXT NOT NULL,
    nombre_completo TEXT NOT NULL,
    passsword TEXT NOT NULL
);

ALTER TABLE audit_usuarios_rrhh
    DROP COLUMN id_usr;

ALTER TABLE audit_usuarios_rrhh
    DROP COLUMN nombre_completo;

ALTER TABLE audit_usuarios_rrhh
    DROP COLUMN passsword;

ALTER TABLE audit_usuarios_rrhh
    ADD COLUMN antes_del_camnio TEXT;

ALTER TABLE audit_usuarios_rrhh
    ADD COLUMN despues_del_camnio TEXT;



INSERT INTO usuarios_rrhh(id_usr, nombres_completo, fecha_nac, correo, passsword)
VALUES(123456,'Mijail Oliver Choque Amaro','2004-02-16','mijailchoque35@gmail.com','123456');

SELECT * FROM usuarios_rrhh;

# Me permite obtener la fecha actual
SELECT CURRENT_DATE;

# Me permite obtener la fecha y hora actual
SELECT NOW();

# Me permite obtener el usuario logueado
SELECT USER();

# Me permite obtener el HOSTNAME
SELECT @@HOSTNAME;

# Me permite obtener todas las variables de la base de datos
SHOW VARIABLES;

CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
AFTER DELETE
ON usuarios_rrhh
FOR EACH ROW
BEGIN
    DECLARE id_usuario TEXT;
    DECLARE nombres TEXT;
    DECLARE usr_password TEXT;

    SET id_usuario = OLD.id_usr;
    SET nombres = OLD.nombres_completo;
    SET usr_password = OLD.passsword;

    INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, passsword)
    SELECT now(), user(), @@HOSTNAME, 'DELETE', id_usuario, nombres, usr_password;
END;

SELECT * FROM usuarios_rrhh;
SELECT * FROM audit_usuarios_rrhh;


CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh_insert
AFTER INSERT
ON usuarios_rrhh
FOR EACH ROW
BEGIN
    INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, id_usr, nombre_completo, passsword)
    SELECT now(), user(), @@HOSTNAME, 'INSERT', NEW.id_usr, NEW.nombres_completo, NEW.passsword;
END;

INSERT INTO usuarios_rrhh(id_usr, nombres_completo, fecha_nac, correo, passsword)
VALUES(697895,'ROMARIO TOLA','2004-02-08','romtol@gmail.com','128956');


CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
AFTER UPDATE
ON usuarios_rrhh
FOR EACH ROW
BEGIN
    INSERT INTO audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, accion, antes_del_camnio, despues_del_camnio )
    SELECT now(), user(), @@HOSTNAME, 'UPDATE',CONCAT('ID USR: ',OLD.id_usr,' NOMBRE COMPLETO: ',OLD.nombres_completo,' FECHA DE NACIMIENTO: ',OLD.fecha_nac,' CORREO: ',OLD.correo,' PASSWORD: ',OLD.passsword),CONCAT('ID USR: ',NEW.id_usr,' NOMBRE COMPLETO: ',NEW.nombres_completo,' FECHA DE NACIMIENTO: ',NEW.fecha_nac,' CORREO: ',NEW.correo,' PASSWORD: ',NEW.passsword);
end;

UPDATE usuarios_rrhh AS USR
SET USR.nombres_completo = 'MIJAIL CHOQUE',
    USR.correo = 'mija@gmail.com'
WHERE USR.nombres_completo LIKE '%MIJAIL%';


CREATE OR REPLACE PROCEDURE inserta_datos
(
    fecha TEXT,usuario TEXT,hostname TEXT,
    accion TEXT,antes TEXT,despues TEXT
)
BEGIN

    INSERT INTO audit_usuarios_rrhh(FECHA_MOD, USUARIO_LOG, HOSTNAME, accion,antes_del_camnio, despues_del_camnio)
    VALUES(fecha, usuario, hostname, accion, antes,despues);
END;



CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh
AFTER UPDATE
ON usuarios_rrhh
FOR EACH ROW
BEGIN
    DECLARE antes TEXT DEFAULT CONCAT('ID USR: ',OLD.id_usr,' NOMBRE COMPLETO: ',OLD.nombres_completo,' FECHA DE NACIMIENTO: ',OLD.fecha_nac,' CORREO: ',OLD.correo,' PASSWORD: ',OLD.passsword);
    DECLARE despues TEXT DEFAULT CONCAT('ID USR: ',NEW.id_usr,' NOMBRE COMPLETO: ',NEW.nombres_completo,' FECHA DE NACIMIENTO: ',NEW.fecha_nac,' CORREO: ',NEW.correo,' PASSWORD: ',NEW.passsword);

    CALL inserta_datos(NOW(),USER(),@@HOSTNAME,'UPDATE',antes,despues);
end;


SELECT * FROM usuarios_rrhh;
SELECT * FROM audit_usuarios_rrhh;
TRUNCATE audit_usuarios_rrhh;