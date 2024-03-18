/* ***** Tablas ***** */

/* Tabla 'shopping_cart' */
DROP TABLE IF EXISTS flower_shop.shopping_cart;
CREATE TABLE flower_shop.shopping_cart
(
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    user_id smallint unsigned NOT NULL,
    product_id smallint unsigned NOT NULL,
    quantity smallint unsigned NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
)   ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE flower_shop.shopping_cart AUTO_INCREMENT = 1;
/* Tabla 'shopping_cart' */

/* ***** Tablas ***** */



/* ***** Procedimientos Almacenados - 'shopping_cart' ***** */

/* Procedimiento Almacenado 'get_shopping_cart' */
DROP PROCEDURE IF EXISTS sp_get_shopping_cart;
DELIMITER //
CREATE PROCEDURE sp_get_shopping_cart
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    -- Obtener todos los productos del carrito de compras de un usuario.
    SELECT * FROM shopping_cart WHERE user_id = p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_shopping_cart' */

/* Procedimiento Almacenado 'add_to_shopping_cart' */
DROP PROCEDURE IF EXISTS sp_add_to_shopping_cart;
DELIMITER //
CREATE PROCEDURE sp_add_to_shopping_cart
(
    IN p_user_id SMALLINT UNSIGNED,
    IN p_product_id SMALLINT UNSIGNED,
    IN p_quantity SMALLINT UNSIGNED
)
BEGIN
    DECLARE product_count INT;
    DECLARE product_quantity INT;
    DECLARE new_quantity INT;
    SET product_count = 0;
    SET product_quantity = 0;
    SET new_quantity = 0;

    -- Verificar si el producto ya existe en el carrito de compras.
    SELECT COUNT(*) INTO product_count FROM shopping_cart WHERE user_id = p_user_id AND product_id = p_product_id;
    
    -- Obtener la cantidad del producto en el carrito de compras.
    SELECT quantity INTO product_quantity FROM shopping_cart WHERE user_id = p_user_id AND product_id = p_product_id;

    -- Manejar la excepción de producto duplicado.
    IF product_count > 0 THEN
        SET new_quantity = product_quantity + p_quantity;
        UPDATE shopping_cart SET quantity = new_quantity WHERE user_id = p_user_id AND product_id = p_product_id;
    ELSE
        INSERT INTO shopping_cart (user_id, product_id, quantity) VALUES (p_user_id, p_product_id, p_quantity);
    END IF;
END //
DELIMITER ;
/* Procedimiento Almacenado 'add_to_shopping_cart' */

/* Procedimiento Almacenado 'remove_from_shopping_cart' */
DROP PROCEDURE IF EXISTS sp_remove_from_shopping_cart;
DELIMITER //
CREATE PROCEDURE sp_remove_from_shopping_cart
(
    IN p_user_id SMALLINT UNSIGNED,
    IN p_product_id SMALLINT UNSIGNED
)
BEGIN
    -- Eliminar un producto del carrito de compras.
    DELETE FROM shopping_cart WHERE user_id = p_user_id AND id = p_product_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'remove_from_shopping_cart' */

/* Procedimiento Almacenado 'clear_shopping_cart' */
DROP PROCEDURE IF EXISTS sp_clear_shopping_cart;
DELIMITER //
CREATE PROCEDURE sp_clear_shopping_cart
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    -- Eliminar todos los productos del carrito de compras de un usuario.
    DELETE FROM shopping_cart WHERE user_id = p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'clear_shopping_cart' */

/* Procedimiento Almacenado 'get_essential_data' */
DROP PROCEDURE IF EXISTS sp_get_essential_data;
DELIMITER //
CREATE PROCEDURE sp_get_essential_data
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    SELECT shopping_cart.id, products.name, shopping_cart.quantity, products.price, (shopping_cart.quantity * products.price) AS total_price
    FROM shopping_cart
    INNER JOIN products ON shopping_cart.product_id = products.id
    WHERE user_id = p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_essential_data' */

/* Procedimiento Almacenado 'get_total_price' */
DROP PROCEDURE IF EXISTS sp_get_total_price;
DELIMITER //
CREATE PROCEDURE sp_get_total_price
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    SELECT SUM(shopping_cart.quantity * products.price) AS total_price
    FROM shopping_cart
    INNER JOIN products ON shopping_cart.product_id = products.id
    WHERE user_id = p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_total_price' */

/* Procedimiento Almacenado 'get_count_shopping_cart' */
DROP PROCEDURE IF EXISTS sp_get_count_shopping_cart;
DELIMITER //
CREATE PROCEDURE sp_get_count_shopping_cart
(
    IN p_user_id SMALLINT UNSIGNED
)
BEGIN
    SELECT COUNT(*) AS count FROM shopping_cart WHERE user_id = p_user_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_count_shopping_cart' */

/* ***** Procedimientos Almacenados - 'shopping_cart' ***** */