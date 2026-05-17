-- =========================================================
-- MINI ZEPTO DBMS PROJECT
-- Beginner Friendly MySQL Project
-- =========================================================

-- =========================================================
-- STEP 1 : CREATE DATABASE
-- =========================================================

CREATE DATABASE IF NOT EXISTS mini_zepto;

USE mini_zepto;


-- =========================================================
-- STEP 2 : DELETE OLD TABLES
-- =========================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;


-- =========================================================
-- STEP 3 : CREATE USERS TABLE
-- =========================================================

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);


-- =========================================================
-- STEP 4 : CREATE PRODUCTS TABLE
-- =========================================================

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(100),
    product_name VARCHAR(150) NOT NULL,
    mrp DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    selling_price DECIMAL(10,2),
    stock INT,
    weight_in_gms INT,
    out_of_stock BOOLEAN
);


-- =========================================================
-- STEP 5 : CREATE CART TABLE
-- =========================================================

CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT,

    FOREIGN KEY (user_id)
    REFERENCES users(user_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


-- =========================================================
-- STEP 6 : CREATE ORDERS TABLE
-- =========================================================

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (user_id)
    REFERENCES users(user_id)
);


-- =========================================================
-- STEP 7 : CREATE ORDER ITEMS TABLE
-- =========================================================

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


-- =========================================================
-- STEP 8 : INSERT USERS
-- =========================================================

INSERT INTO users (name, email, phone)
VALUES

('Rahul', 'rahul@gmail.com', '9876543210'),

('Priya', 'priya@gmail.com', '9123456780'),

('Aman', 'aman@gmail.com', '9988776655');


-- =========================================================
-- STEP 9 : INSERT PRODUCTS
-- =========================================================

INSERT INTO products
(category, product_name, mrp,
discount_percent, selling_price,
stock, weight_in_gms, out_of_stock)

VALUES

('Dairy', 'Milk 1L', 60, 10, 54, 100, 1000, FALSE),

('Bakery', 'Bread', 40, 5, 38, 80, 400, FALSE),

('Snacks', 'Potato Chips', 50, 20, 40, 120, 100, FALSE),

('Rice', 'Basmati Rice 5kg', 600, 12, 528, 30, 5000, FALSE),

('Beverages', 'Orange Juice', 90, 8, 82.8, 60, 1000, FALSE),

('Personal Care', 'Shampoo', 250, 18, 205, 40, 700, FALSE),

('Cleaning', 'Detergent Powder', 350, 25, 262.5, 25, 3000, FALSE),

('Fruits', 'Apple Pack', 180, 10, 162, 0, 1000, TRUE),

('Vegetables', 'Tomato 1kg', 30, 0, 30, 150, 1000, FALSE),

('Eggs', 'Egg Tray 12pcs', 90, 15, 76.5, 90, 700, FALSE);


-- =========================================================
-- STEP 10 : INSERT CART DATA
-- =========================================================

INSERT INTO cart (user_id, product_id, quantity)
VALUES

(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 1);


-- =========================================================
-- STEP 11 : INSERT ORDERS
-- =========================================================

INSERT INTO orders (user_id, total_amount)
VALUES

(1, 148.00),
(2, 114.00),
(3, 528.00);


-- =========================================================
-- STEP 12 : INSERT ORDER ITEMS
-- =========================================================

INSERT INTO order_items
(order_id, product_id, quantity, price)

VALUES

(1, 1, 2, 54),
(1, 3, 1, 40),

(2, 2, 3, 38),

(3, 4, 1, 528);


-- =========================================================
-- STEP 13 : VIEW USERS
-- =========================================================

SELECT * FROM users;


-- =========================================================
-- STEP 14 : VIEW PRODUCTS
-- =========================================================

SELECT * FROM products;


-- =========================================================
-- STEP 15 : VIEW CART
-- =========================================================

SELECT * FROM cart;


-- =========================================================
-- STEP 16 : VIEW ORDERS
-- =========================================================

SELECT * FROM orders;


-- =========================================================
-- STEP 17 : VIEW ORDER ITEMS
-- =========================================================

SELECT * FROM order_items;


-- =========================================================
-- STEP 18 : PRODUCTS IN STOCK VS OUT OF STOCK
-- =========================================================

SELECT
out_of_stock,
COUNT(*) AS total_products

FROM products

GROUP BY out_of_stock;


-- =========================================================
-- STEP 19 : TOP DISCOUNT PRODUCTS
-- =========================================================

SELECT
product_name,
mrp,
discount_percent

FROM products

ORDER BY discount_percent DESC

LIMIT 5;


-- =========================================================
-- STEP 20 : TOTAL PRODUCTS IN EACH CATEGORY
-- =========================================================

SELECT
category,
COUNT(*) AS total_products

FROM products

GROUP BY category

ORDER BY total_products DESC;


-- =========================================================
-- STEP 21 : TOTAL REVENUE BY CATEGORY
-- =========================================================

SELECT

category,

SUM(selling_price * stock)
AS total_revenue

FROM products

GROUP BY category

ORDER BY total_revenue DESC;


-- =========================================================
-- STEP 22 : MOST EXPENSIVE PRODUCT
-- =========================================================

SELECT
product_name,
mrp

FROM products

ORDER BY mrp DESC

LIMIT 1;


-- =========================================================
-- STEP 23 : AVERAGE PRODUCT PRICE
-- =========================================================

SELECT

ROUND(AVG(selling_price),2)
AS average_price

FROM products;


-- =========================================================
-- STEP 24 : PRICE PER GRAM
-- =========================================================

SELECT

product_name,
weight_in_gms,
selling_price,

ROUND(selling_price / weight_in_gms, 2)
AS price_per_gram

FROM products

WHERE weight_in_gms >= 100

ORDER BY price_per_gram;


-- =========================================================
-- STEP 25 : PRODUCT SIZE CATEGORY
-- =========================================================

SELECT

product_name,
weight_in_gms,

CASE

WHEN weight_in_gms < 1000 THEN 'Small'

WHEN weight_in_gms < 5000 THEN 'Medium'

ELSE 'Bulk'

END AS size_category

FROM products;


-- =========================================================
-- STEP 26 : USER CART DETAILS (JOIN)
-- =========================================================

SELECT

users.name,
products.product_name,
cart.quantity

FROM cart

JOIN users
ON cart.user_id = users.user_id

JOIN products
ON cart.product_id = products.product_id;


-- =========================================================
-- STEP 27 : USER ORDER DETAILS (JOIN)
-- =========================================================

SELECT

orders.order_id,
users.name,
products.product_name,
order_items.quantity,
order_items.price

FROM order_items

JOIN orders
ON order_items.order_id = orders.order_id

JOIN users
ON orders.user_id = users.user_id

JOIN products
ON order_items.product_id = products.product_id;


-- =========================================================
-- STEP 28 : TOTAL ITEMS ORDERED BY EACH USER
-- =========================================================

SELECT

users.name,

SUM(order_items.quantity)
AS total_items

FROM order_items

JOIN orders
ON order_items.order_id = orders.order_id

JOIN users
ON orders.user_id = users.user_id

GROUP BY users.name;


-- =========================================================
-- STEP 29 : SHOW ALL TABLES
-- =========================================================

SHOW TABLES;


-- =========================================================
-- STEP 30 : DESCRIBE TABLES
-- =========================================================

DESCRIBE users;

DESCRIBE products;

DESCRIBE cart;

DESCRIBE orders;

DESCRIBE order_items;



