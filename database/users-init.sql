/* ***** Tablas ****** */

/* Tabla 'users' */
DROP TABLE IF EXISTS flower_shop.users;

CREATE TABLE flower_shop.users
(
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    username varchar(20) NOT NULL,
    password char(102) NOT NULL,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    email varchar(50) NOT NULL,
    physical_address varchar(255) NOT NULL,
    phone varchar(20),
    start_time varchar(30),
    end_time varchar(30) NULL,
    user_type tinyint NOT NULL,
    PRIMARY KEY (id)
)   ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE flower_shop.users AUTO_INCREMENT = 1;
/* Tabla 'users' */

/* ***** Tablas ****** */



/* ***** Procedimientos Almacenados - 'users' ***** */

/* Procedimiento Almacenado 'add_user' */
DROP PROCEDURE IF EXISTS sp_add_user;
DELIMITER //
CREATE PROCEDURE sp_add_user
(
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(102),
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_physical_address VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_start_time VARCHAR(30),
    IN p_end_time VARCHAR(30),
    IN p_user_type TINYINT
)
BEGIN
	DECLARE user_count INT;
    DECLARE hashed_password VARCHAR(255);
    SET hashed_password = SHA2(p_password, 256);

    -- Verificar si el usuario ya existe.
    SELECT COUNT(*) INTO user_count FROM flower_shop.users WHERE username = p_username COLLATE utf8mb4_unicode_ci;
    
    -- Manejar la excepción de usuario duplicado.
    IF user_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Usuario ya existe.';
    END IF;

    -- Verificar campos nulos.
    IF p_username IS NULL OR p_password IS NULL OR p_user_type IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Campos obligatorios no pueden ser nulos.';
    END IF;

    -- Insertar el nuevo usuario.
    INSERT INTO users (username, password, first_name, last_name, email, physical_address, phone, start_time, end_time, user_type)
    VALUES (p_username, hashed_password, p_first_name, p_last_name, p_email, p_physical_address, p_phone, p_start_time, p_end_time, p_user_type);
END //
DELIMITER ;
/* Procedimiento Almacenado 'add_user' */

/* Procedimiento Almacenado 'edit_user' */
DROP PROCEDURE IF EXISTS sp_edit_user;
DELIMITER //
CREATE PROCEDURE sp_edit_user
(
    IN p_id SMALLINT UNSIGNED,
    IN p_username VARCHAR(20),
    IN p_password VARCHAR(102),
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(50),
    IN p_physical_address VARCHAR(255),
    IN p_phone VARCHAR(20),
    IN p_start_time VARCHAR(30),
    IN p_end_time VARCHAR(30),
    IN p_user_type TINYINT
)
BEGIN
    DECLARE user_count INT;
    DECLARE hashed_password VARCHAR(255);
    SET hashed_password = SHA2(p_password, 256);

    -- Verificar campos nulos.
    IF p_username IS NULL OR p_password IS NULL OR p_user_type IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Campos obligatorios no pueden ser nulos.';
    END IF;

    -- Actualizar el usuario.
    UPDATE users
    SET username = p_username, password = hashed_password, first_name = p_first_name, last_name = p_last_name, email = p_email, physical_address = p_physical_address, phone = p_phone, start_time = p_start_time, end_time = p_end_time, user_type = p_user_type
    WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'edit_user' */

/* Procedimiento Almacenado 'delete_user' */
DROP PROCEDURE IF EXISTS sp_delete_user;
DELIMITER //
CREATE PROCEDURE sp_delete_user
(
    IN p_id SMALLINT UNSIGNED
)
BEGIN
    -- Eliminar el usuario.
    DELETE FROM users WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'delete_user' */

/* Procedimiento Almacenado 'verify_identity' */
DROP PROCEDURE IF EXISTS sp_verify_identity;
DELIMITER //
CREATE PROCEDURE sp_verify_identity
(
    IN p_username VARCHAR(20), 
    IN p_plain_text_password VARCHAR(20)
)
BEGIN
	DECLARE stored_password VARCHAR(255);
	SELECT password INTO stored_password
    FROM flower_shop.users
	WHERE username = p_username COLLATE utf8mb4_unicode_ci;
	IF stored_password IS NOT NULL AND stored_password = SHA2(p_plain_text_password, 256) THEN
		SELECT id, username, stored_password, first_name, last_name, email, physical_address, phone, start_time, end_time, user_type
        FROM flower_shop.users
		WHERE username = p_username COLLATE utf8mb4_unicode_ci;
	ELSE
		SELECT NULL;
	END IF;
END //
DELIMITER ;
/* Procedimiento Almacenado 'verify_identity' */

/* Procedimiento Almacenado 'get_users' */
DROP PROCEDURE IF EXISTS sp_get_users;
DELIMITER //
CREATE PROCEDURE sp_get_users()
BEGIN
    -- Obtener todos los usuarios.
    SELECT * FROM users;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_users' */

/* Procedimiento Almacenado 'get_users_by_id' */
DROP PROCEDURE IF EXISTS sp_get_users_by_id;
DELIMITER //
CREATE PROCEDURE sp_get_users_by_id
(
    IN p_id SMALLINT UNSIGNED
)
BEGIN
    -- Obtener un usuario por su id.
    SELECT * FROM users WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_users_by_id' */

/* ***** Procedimientos Almacenados - 'users' ******/



/* ***** Inserciones - 'users' ***** */

/* Usuarios Tipo 'Administrador' */
CALL sp_add_user("administrador-1", "admin-1", "John", "Doe", "johndoe@mail.com", "Calle 1 # 2-3", "1234567890", "07:00", "15:00", 1);
CALL sp_add_user("administrador-2", "admin-2", "Anna", "Collins", "annacollins@mail.com", "Calle 2 # 2-3", "1234567890", "07:00", "15:00", 1);
CALL sp_add_user("administrador-3", "admin-3", "Peter", "Smith", "petersmith@mail.com", "Calle 3 # 2-3", "1234567890", "07:00", "15:00", 1);
/* Usuarios Tipo 'Administrador' */

/* Usuarios Tipo 'Cliente' */
CALL sp_add_user("cliente-1", "cliente-1", "Jane", "Doe", "janedoe@mail.com", "Calle 1 # 2-3", "1234567890", "07:00", "15:00", 0);
CALL sp_add_user("cliente-2", "cliente-2", "Mary", "Collins", "marycollins@mail.com", "Calle 2 # 2-3", "1234567890", "07:00", "15:00", 0);
CALL sp_add_user("cliente-3", "cliente-3", "Robert", "Smith", "robertsmith@mail.com", "Calle 3 # 2-3", "1234567890", "07:00", "15:00", 0);
/* Usuarios Tipo 'Cliente' */

/* ***** Inserciones - 'users' ******/