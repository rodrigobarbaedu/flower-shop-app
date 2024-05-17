/* ***** Tablas ***** */

/* Tabla 'transaction_log' */
DROP TABLE IF EXISTS transaction_log;
CREATE TABLE transaction_log
(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    protocol VARCHAR(50) NOT NULL,
    web_service VARCHAR(255) NOT NULL,
    operation VARCHAR(50) NOT NULL,
    section VARCHAR(50) NOT NULL,
    date_time DATETIME NOT NULL,
    user_id SMALLINT UNSIGNED NOT NULL,
    ip VARCHAR(50) NOT NULL
);
/* Tabla 'transaction_log' */

/* ***** Tablas ***** */



/* ***** Procedimientos Almacenados - 'transaction_log' ***** */

/* Procedimiento Almacenado 'add_transaction_log' */
DROP PROCEDURE IF EXISTS add_transaction_log;
DELIMITER //
CREATE PROCEDURE add_transaction_log
(
    IN p_protocol VARCHAR(50),
    IN p_web_service VARCHAR(255),
    IN p_operation VARCHAR(50),
    IN p_section VARCHAR(50),
    IN p_user_id SMALLINT UNSIGNED,
    IN p_ip VARCHAR(50)
)
BEGIN
    INSERT INTO flower_shop_transaction_log.transaction_log
    (
        protocol,
        web_service,
        operation,
        section,
        date_time,
        user_id,
        ip
    )
    VALUES
    (
        p_protocol,
        p_web_service,
        p_operation,
        p_section,
        NOW(),
        p_user_id,
        p_ip
    );
END //
DELIMITER ;
/* Procedimiento Almacenado 'add_transaction_log' */

/* Procedimiento Almacenado 'get_transaction_log' */
DROP PROCEDURE IF EXISTS get_transaction_log;
DELIMITER //
CREATE PROCEDURE get_transaction_log()
BEGIN
    SELECT * FROM flower_shop_transaction_log.transaction_log;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_transaction_log' */

/* ***** Procedimientos Almacenados - 'transaction_log' ***** */