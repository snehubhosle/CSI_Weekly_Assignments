/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section: A-SQL Basics
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
*/

/* Data Validation */

-- Count total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Count total products
SELECT COUNT(*) AS total_products
FROM products;

-- Count total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- Count total order items
SELECT COUNT(*) AS total_order_items
FROM order_items;

/* Check Table Structure */
DESCRIBE customers;
DESCRIBE products;
DESCRIBE orders;
DESCRIBE order_items;

/* Check Sample Records */
SELECT *
FROM customers
LIMIT 5;
SELECT *
FROM products
LIMIT 5;
SELECT *
FROM orders
LIMIT 5;
SELECT *
FROM order_items
LIMIT 5;

/* Check Duplicates E-mails */
SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

/* Check Negative Prices */
SELECT *
FROM products
WHERE unit_price < 0;

/* Check Negative Stock */
SELECT *
FROM products
WHERE stock_qty < 0;

/* Check Invalid Discounts */
SELECT *
FROM order_items
WHERE discount_pct < 0
   OR discount_pct > 100;
   
/* Check NULL Values */
SELECT *
FROM customers
WHERE email IS NULL;

/* Verification of Foreign Keys */
SELECT
    o.order_id,
    c.first_name
FROM orders AS o
INNER JOIN customers AS c
        ON o.customer_id = c.customer_id;
        
/*Extra Validation */

-- Check Order Total
SELECT
    order_id,
    total_amount
FROM orders
ORDER BY total_amount DESC;