/* ***** Tablas ***** */

/* Tabla 'orders' */
DROP TABLE IF EXISTS flower_shop.orders;
CREATE TABLE flower_shop.orders
(
    id SMALLINT UNSIGNED NOT NULL,
    status_order ENUM('refunded', 'completed') NOT NULL DEFAULT 'completed',
    user_id SMALLINT UNSIGNED NOT NULL,
    product_id SMALLINT UNSIGNED NOT NULL,
    quantity SMALLINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, user_id, product_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/* Tabla 'orders' */

/* ***** Tablas ***** */



/* ***** Procedimientos Almacenados - 'orders' ***** */

/* Procedimiento Almacenado 'add_order' */
DROP PROCEDURE IF EXISTS sp_add_order;
DELIMITER //
CREATE PROCEDURE sp_add_order
(
    IN p_id SMALLINT UNSIGNED,
    IN p_user_id SMALLINT UNSIGNED,
    IN p_product_id SMALLINT UNSIGNED,
    IN p_quantity SMALLINT UNSIGNED
)
BEGIN
    -- Agregar un producto al carrito de compras.
    INSERT INTO orders (id, user_id, product_id, quantity) VALUES (p_id, p_user_id, p_product_id, p_quantity);
END //
DELIMITER ;
/* Procedimiento Almacenado 'add_order' */

/* Procedimiento Almacenado 'get_last_order_id' */
DROP PROCEDURE IF EXISTS sp_get_last_order_id;
DELIMITER //
CREATE PROCEDURE sp_get_last_order_id()
BEGIN
    -- Obtener el último id de la tabla 'orders', si no hay registros, se devuelve 1.
    SELECT IFNULL(MAX(id) + 1, 1) AS id FROM orders;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_last_order_id' */

/* Procedimiento Almacenado 'get_count_orders_by_user' */
DROP PROCEDURE IF EXISTS sp_get_count_orders_by_user;
DELIMITER //
CREATE PROCEDURE sp_get_count_orders_by_user
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    -- Obtener la cantidad de productos en el carrito de compras de un usuario.
    SELECT COUNT(*) AS count FROM orders WHERE user_id = p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_count_orders_by_user' */

/* Procedimiento Almacenado 'get_orders_by_id' */
DROP PROCEDURE IF EXISTS sp_get_orders_by_id;
DELIMITER //
CREATE PROCEDURE sp_get_orders_by_id
(
    IN p_id SMALLINT UNSIGNED
)
BEGIN
    -- Obtener los productos del carrito de compras de un usuario.
    SELECT * FROM orders WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_orders_by_id' */

/* Procedimiento Almacenado 'get_orders_by_user' */
DROP PROCEDURE IF EXISTS sp_get_orders_by_user;
DELIMITER //
CREATE PROCEDURE sp_get_orders_by_user
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    SELECT o.id, u.id, u.username, u.first_name, u.last_name,
           SUM(o.quantity) AS quantity, 
           SUM(p.price * o.quantity) AS total, 
           MAX(o.created_at) AS created_at
    FROM orders AS o
    INNER JOIN users AS u ON o.user_id = u.id
        INNER JOIN products AS p ON o.product_id = p.id
    GROUP BY o.id, u.id, u.username
    HAVING u.id= p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_orders_by_user' */

/* Procedimiento Almacenado 'get_orders' */
DROP PROCEDURE IF EXISTS sp_get_orders;
DELIMITER //
CREATE PROCEDURE sp_get_orders()
BEGIN
    SELECT o.id, u.id AS user_id, u.username, u.first_name, u.last_name,
           CASE 
               WHEN o.status_order = 'completed' THEN 'Completado'
               ELSE 'Reembolsado'
           END AS status_order,
           SUM(o.quantity) AS quantity, 
           SUM(p.price * o.quantity) AS total, 
           MAX(o.created_at) AS created_at
    FROM orders AS o
    INNER JOIN users AS u ON o.user_id = u.id
    INNER JOIN products AS p ON o.product_id = p.id
    GROUP BY o.id, u.id, u.username, o.status_order;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_orders' */

/* Procedimiento Almacenado 'get_status_order' */
DROP PROCEDURE IF EXISTS sp_get_status_order;
DELIMITER //
CREATE PROCEDURE sp_get_status_order
(
    IN p_order_id SMALLINT UNSIGNED
)
BEGIN
    SELECT status_order FROM orders WHERE id = p_order_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_status_order' */

/* Procedimiento Almacenado 'get_essential_order_data' */
DROP PROCEDURE IF EXISTS sp_get_essential_order_data;
DELIMITER //
CREATE PROCEDURE sp_get_essential_order_data
(
    IN p_order_id SMALLINT UNSIGNED
)
BEGIN
    SELECT orders.id, products.name, orders.quantity, products.price, (orders.quantity * products.price) AS total_price
    FROM orders AS orders
    INNER JOIN products ON orders.product_id = products.id
    WHERE orders.id = p_order_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_essential_order_data' */

/* Procedimiento Almacenado 'get_total_price_by_order' */
DROP PROCEDURE IF EXISTS sp_get_total_price_by_order;
DELIMITER //
CREATE PROCEDURE sp_get_total_price_by_order
(
    IN p_order_id SMALLINT UNSIGNED
)
BEGIN
    SELECT SUM(orders.quantity * products.price) AS total_price
    FROM orders AS orders
    INNER JOIN products ON orders.product_id = products.id
    WHERE orders.id = p_order_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_total_price_by_order' */

/* Procedimiento Almacenado 'delete_order' */
DROP PROCEDURE IF EXISTS sp_delete_order;
DELIMITER //
CREATE PROCEDURE sp_delete_order
(
    IN p_order_id SMALLINT UNSIGNED
)
BEGIN
    DELETE FROM orders WHERE id = p_order_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'delete_order' */

/* Procedimiento Almacenado 'refund_order' */
DROP PROCEDURE IF EXISTS sp_refund_order;
DELIMITER //
CREATE PROCEDURE sp_refund_order
(
    IN p_order_id SMALLINT UNSIGNED
)
BEGIN
    UPDATE orders SET status_order = 'refunded' WHERE id = p_order_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'refund_order' */

/* ***** Procedimientos Almacenados - 'orders' ***** */

/* ***** Insercion de Datos ***** */
call sp_add_order(1, 1, 1, 1);
call sp_add_order(2, 1, 2, 1);
call sp_add_order(3, 1, 3, 1);
call sp_add_order(4, 1, 4, 1);
call sp_add_order(5, 1, 5, 1);
call sp_add_order(6, 1, 6, 1);
call sp_add_order(7, 1, 7, 1);
call sp_add_order(8, 1, 8, 1);
call sp_add_order(9, 1, 9, 1);
call sp_add_order(10, 1, 10, 1);
call sp_add_order(11, 1, 11, 1);
call sp_add_order(12, 1, 12, 1);
call sp_add_order(13, 1, 13, 1);
call sp_add_order(14, 1, 14, 1);
call sp_add_order(15, 1, 15, 1);
call sp_add_order(16, 1, 16, 1);
call sp_add_order(17, 1, 17, 1);
call sp_add_order(18, 1, 18, 1);
call sp_add_order(19, 1, 19, 1);
call sp_add_order(20, 1, 20, 1);
/* ***** Insercion de Datos ***** */