/* ***** Tablas ***** */

/* Tabla 'products' */
DROP TABLE IF EXISTS flower_shop.products;

CREATE TABLE flower_shop.products
(
    id smallint unsigned NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    description varchar(255) NOT NULL,
    quantity int NOT NULL DEFAULT 0,
    alert_quantity int NOT NULL DEFAULT 5,
    price decimal(10,2) NOT NULL,
    url_image varchar(255),
    PRIMARY KEY (id)
)   ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE flower_shop.products AUTO_INCREMENT = 1;
/* Tabla 'products' */

/* ***** Tablas ***** */



/* ***** Procedimientos Almacenados - 'products' ***** */

/* Procedimiento Almacenado 'add_product' */
DROP PROCEDURE IF EXISTS sp_add_product;
DELIMITER //
CREATE PROCEDURE sp_add_product
(
    IN p_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_quantity INT,
    IN p_alert_quantity INT,
    IN p_price DECIMAL(10,2),
    IN p_url_image VARCHAR(255)
)
BEGIN
    DECLARE product_count INT;

    -- Verificar si el producto ya existe.
    SELECT COUNT(*) INTO product_count FROM products WHERE name = p_name COLLATE utf8mb4_unicode_ci;
    
    -- Manejar la excepción de producto duplicado.
    IF product_count > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Producto ya existe.';
    END IF;

    -- Verificar campos nulos.
    IF p_name IS NULL OR p_description IS NULL OR p_price IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Campos obligatorios no pueden ser nulos.';
    END IF;

    -- Insertar el nuevo producto.
    INSERT INTO products (name, description, quantity, alert_quantity, price, url_image)
    VALUES (p_name, p_description, p_quantity, p_alert_quantity, p_price, p_url_image);
END //
DELIMITER ;
/* Procedimiento Almacenado 'add_product' */

/* Procedimiento Almacenado 'edit_product' */
DROP PROCEDURE IF EXISTS sp_edit_product;
DELIMITER //
CREATE PROCEDURE sp_edit_product
(
    IN p_id SMALLINT UNSIGNED,
    IN p_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_quantity INT,
    IN p_alert_quantity INT,
    IN p_price DECIMAL(10,2),
    IN p_url_image VARCHAR(255)
)
BEGIN
    DECLARE product_count INT;

    -- Verificar campos nulos.
    IF p_name IS NULL OR p_description IS NULL OR p_price IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Campos obligatorios no pueden ser nulos.';
    END IF;

    -- Actualizar el producto.
    UPDATE products
    SET name = p_name, description = p_description, quantity = p_quantity, alert_quantity = p_alert_quantity, price = p_price, url_image = p_url_image
    WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'edit_product' */

/* Procedimiento Almacenado 'delete_product' */
DROP PROCEDURE IF EXISTS sp_delete_product;
DELIMITER //
CREATE PROCEDURE sp_delete_product
(
    IN p_id SMALLINT UNSIGNED
)
BEGIN
    -- Eliminar el producto.
    DELETE FROM products WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'delete_product' */

/* Procedimiento Almacenado 'get_products' */
DROP PROCEDURE IF EXISTS sp_get_products;
DELIMITER //
CREATE PROCEDURE sp_get_products()
BEGIN
    -- Obtener todos los productos.
    SELECT * FROM products;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_products' */

/* Procedimiento Almacenado 'get_products_by_id' */
DROP PROCEDURE IF EXISTS sp_get_products_by_id;
DELIMITER //
CREATE PROCEDURE sp_get_products_by_id
(
    IN p_id SMALLINT UNSIGNED
)
BEGIN
    -- Obtener el producto por id.
    SELECT * FROM products WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado 'get_products_by_id' */

/* Procedimiento Almacenado / Transacción 'buy_product' */
DROP PROCEDURE IF EXISTS sp_buy_product;
DELIMITER //
CREATE PROCEDURE sp_buy_product
(
    IN p_id SMALLINT UNSIGNED,
    IN p_quantity INT
)
BEGIN
    DECLARE product_quantity INT;

    -- Verificar si el producto existe.
    SELECT quantity INTO product_quantity FROM products WHERE id = p_id;
    
    -- Manejar la excepción de producto no encontrado.
    IF product_quantity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Producto no encontrado.';
    END IF;

    -- Verificar si hay suficiente cantidad del producto.
    IF product_quantity < p_quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No hay suficiente cantidad del producto.';
    END IF;

    -- Actualizar la cantidad del producto.
    UPDATE products
    SET quantity = product_quantity - p_quantity
    WHERE id = p_id;
END //
DELIMITER ;
/* Procedimiento Almacenado / Transacción 'buy_product' */

/* Procedimiento Almacenado 'reorder_product_alert' */
DROP PROCEDURE IF EXISTS sp_reorder_product_alert;
DELIMITER //
CREATE PROCEDURE sp_reorder_product_alert()
BEGIN
    -- Obtener los productos que están por debajo de la cantidad de alerta.
    SELECT id, name FROM products WHERE quantity < alert_quantity;
END //
DELIMITER ;
/* Procedimiento Almacenado 'reorder_product_alert' */

/* ***** Procedimientos Almacenados - 'products' ***** */



/* ***** Inserciones - 'products' ***** */

CALL sp_add_product('Rosa Roja', 'Rosa roja hermosa', 10, 5, 8.99, 'https://www.floristeriajazmin.com/imagenes/productos/rosa_roja.jpg');
CALL sp_add_product('Girasol Brillante', 'Girasol amarillo vibrante', 10, 5, 7.50, 'https://www.floristeriajazmin.com/imagenes/productos/girasol_brillante.jpg');
CALL sp_add_product('Lirio Blanco', 'Lirio blanco elegante', 10, 5, 9.75, 'https://www.floristeriajazmin.com/imagenes/productos/lirio_blanco.jpg');
CALL sp_add_product('Tulipán Rosado', 'Tulipán rosado encantador', 10, 5, 6.99, 'https://www.floristeriajazmin.com/imagenes/productos/tulipan_rosado.jpg');
CALL sp_add_product('Margarita Blanca', 'Margarita blanca radiante', 10, 5, 5.50, 'https://www.floristeriajazmin.com/imagenes/productos/margarita_blanca.jpg');
CALL sp_add_product('Orquídea Púrpura', 'Orquídea púrpura exótica', 10, 5, 12.25, 'https://www.floristeriajazmin.com/imagenes/productos/orquidea_purpura.jpg');
CALL sp_add_product('Caléndula Amarilla', 'Caléndula amarilla alegre', 10, 5, 4.75, 'https://www.floristeriajazmin.com/imagenes/productos/calendula_amarilla.jpg');
CALL sp_add_product('Clavel Rojo', 'Clavel rojo intenso', 10, 5, 7.99, 'https://www.floristeriajazmin.com/imagenes/productos/clavel_rojo.jpg');
CALL sp_add_product('Amapola Naranja', 'Amapola naranja vibrante', 10, 5, 3.50, 'https://www.floristeriajazmin.com/imagenes/productos/amapola_naranja.jpg');
CALL sp_add_product('Dalia Rosa', 'Dalia rosa encantadora', 10, 5, 9.99, 'https://www.floristeriajazmin.com/imagenes/productos/dalia_rosa.jpg');
CALL sp_add_product('Gerbera Amarilla', 'Gerbera amarilla brillante', 10, 5, 6.25, 'https://www.floristeriajazmin.com/imagenes/productos/gerbera_amarilla.jpg');
CALL sp_add_product('Mimosa Blanca', 'Mimosa blanca suave', 10, 5, 8.50, 'https://www.floristeriajazmin.com/imagenes/productos/mimosa_blanca.jpg');
CALL sp_add_product('Peonía Rosa', 'Peonía rosa elegante', 10, 5, 11.75, 'https://www.floristeriajazmin.com/imagenes/productos/peonia_rosa.jpg');
CALL sp_add_product('Crísantemo Amarillo', 'Crísantemo amarillo radiante', 10, 5, 5.99, 'https://www.floristeriajazmin.com/imagenes/productos/crisantemo_amarillo.jpg');
CALL sp_add_product('Hortensia Azul', 'Hortensia azul encantadora', 10, 5, 10.50, 'https://www.floristeriajazmin.com/imagenes/productos/hortensia_azul.jpg');
CALL sp_add_product('Narciso Amarillo', 'Narciso amarillo brillante', 10, 5, 4.25, 'https://www.floristeriajazmin.com/imagenes/productos/narciso_amarillo.jpg');
CALL sp_add_product('Ranúnculo Rojo', 'Ranúnculo rojo intenso', 10, 5, 7.75, 'https://www.floristeriajazmin.com/imagenes/productos/ranunculo_rojo.jpg');
CALL sp_add_product('Tulipán Amarillo', 'Tulipán amarillo radiante', 10, 5, 6.50, 'https://www.floristeriajazmin.com/imagenes/productos/tulipan_amarillo.jpg');
CALL sp_add_product('Violeta Morada', 'Violeta morada suave', 10, 5, 3.99, 'https://www.floristeriajazmin.com/imagenes/productos/violeta_morada.jpg');
CALL sp_add_product('Crisantemo Blanco', 'Crisantemo blanco elegante', 10, 5, 8.25, 'https://www.floristeriajazmin.com/imagenes/productos/crisantemo_blanco.jpg');

/* ***** Inserciones - 'products' ***** */