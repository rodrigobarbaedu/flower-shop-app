/* ***** Procedimientos Almacenados - 'orders' ***** */

/* Procedimiento Almacenado 'get_best_sales' */
DROP PROCEDURE IF EXISTS sp_get_best_sales;
DELIMITER //
CREATE PROCEDURE sp_get_best_sales()
BEGIN
    SELECT o.id, o.created_at, SUM(p.price * o.quantity) AS total_price
    FROM orders AS o
    INNER JOIN products AS p ON o.product_id = p.id
    GROUP BY o.id, o.created_at
    ORDER BY total_price DESC
    LIMIT 1;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_best_sales' */

/* Procedimiento Almacenado 'get_worst_sales' */
DROP PROCEDURE IF EXISTS sp_get_worst_sales;
DELIMITER //
CREATE PROCEDURE sp_get_worst_sales()
BEGIN
    SELECT o.id, o.created_at, SUM(p.price * o.quantity) AS total_price
    FROM orders AS o
    INNER JOIN products AS p ON o.product_id = p.id
    GROUP BY o.id, o.created_at
    ORDER BY total_price ASC
    LIMIT 1;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_worst_sales' */

/* Procedimiento Almacenado 'get_total_sales' */
DROP PROCEDURE IF EXISTS sp_get_total_sales;
DELIMITER //
CREATE PROCEDURE sp_get_total_sales()
BEGIN
    SELECT SUM(p.price * o.quantity) AS total_sales
    FROM orders AS o
    INNER JOIN products AS p ON o.product_id = p.id
    WHERE o.status_order = 'completed';
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_total_sales' */

/* ***** Procedimientos Almacenados - 'orders' ***** */