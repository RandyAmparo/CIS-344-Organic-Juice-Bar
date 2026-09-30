DROP DATABASE IF EXISTS organic_juice_bar;
CREATE DATABASE organic_juice_bar;
USE organic_juice_bar;

CREATE TABLE customer(
customer_id INT PRIMARY KEY, 
customer_name VARCHAR(45) NOT NULL, 
phone VARCHAR(12)
);
CREATE TABLE stores(
store_zip VARCHAR(10) PRIMARY KEY,
store_street_address VARCHAR(45)NOT NULL
);
CREATE TABLE menu(
item_id INT PRIMARY KEY,
item_name VARCHAR(45) NOT NULL,
category VARCHAR(45) NOT NULL,
price DECIMAL(6,2) NOT NULL
);
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
store_zip VARCHAR(10) NOT NULL,

FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
FOREIGN KEY (store_zip) REFERENCES stores(store_zip)
);
CREATE TABLE order_items(
order_id INT ,
item_id INT NOT NULL,
quantity INT NOT NULL DEFAULT 1,

FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (item_id) REFERENCES menu(item_id)
);

INSERT INTO customer (customer_id, customer_name, phone)
VALUES
	(111, "Randy", "3214567890"),
    (112, "Andy", "9871234578"),
    (113, "Brandy", "4563214783");
    
INSERT INTO stores (store_zip, store_street_address)
VALUES
	("10028", "1486 Third Avenue"),
    ("10024", "2345 Broadway");
    
INSERT INTO menu (item_id, item_name, category, price)
VALUES
	(11, "Daily Detox", "Healthy", 9.00),
    (12, "Alpha Beets", "Healthy", 7.00),
    (13, "Tropical Lust", "Sweet", 9.00),
    (14, "Apple", "Sweet", 10.00)
    ;
INSERT INTO orders (order_id, customer_id, order_date, store_zip)
VALUES
    (1001, 111, "2026-09-29", "10028"),
    (1002, 112, "2026-09-29", "10024"),
    (1003, 113, "2026-09-30", "10024"),
    (1004, 111, "2026-09-30", "10028");
    
INSERT INTO order_items (order_id, item_id, quantity)
VALUES
    (1001, 11, 2),
    (1001, 11, 1),
    (1001, 14, 1),
    (1002, 13, 1),
    (1002, 12, 2),
    (1003, 12, 1);
    
SELECT * FROM customer;
SELECT * FROM stores;
SELECT * FROM menu;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    m.item_name,
    oi.quantity,
    m.price,
    (oi.quantity * m.price) AS item_total
FROM orders AS o
JOIN customer AS c
    ON o.customer_id = c.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN menu AS m
    ON oi.item_id = m.item_id
ORDER BY o.order_id;

SELECT
    o.order_id,
    c.customer_name,
    SUM(oi.quantity * m.price) AS order_total
FROM orders AS o
JOIN customer AS c
    ON o.customer_id = c.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN menu AS m
    ON oi.item_id = m.item_id
GROUP BY o.order_id, c.customer_name
ORDER BY o.order_id;
