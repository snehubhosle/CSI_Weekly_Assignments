/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench

 Objective:
 Create normalized business tables (Gold Layer) from the cleaned dataset
 using SELECT DISTINCT.
*/

USE superstore_db;

/*
 Step 1 : Create Customers Table
 Purpose: Store unique customer information.
*/

DROP TABLE IF EXISTS customers;

CREATE TABLE customers AS

SELECT DISTINCT

    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region
    
FROM superstore_clean;

-- Verify Customers Table
SELECT *
FROM customers
LIMIT 10;

-- Count Customers
SELECT
    COUNT(*) AS total_customers
FROM customers;

/*
 Step 2 : Create Orders Table
 Purpose:
 Store order-level transactional information.
*/

DROP TABLE IF EXISTS orders;

CREATE TABLE orders AS

SELECT DISTINCT

    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,

    Customer_ID,

    Sales,
    Quantity,
    Discount,
    Profit

FROM superstore_clean;

-- Verify Orders
SELECT *
FROM orders
LIMIT 10;

-- Count Orders
SELECT
    COUNT(*) AS total_orders
FROM orders;

/*
 Step 3 : Create Products Table
 Purpose:
 Store unique product information.
*/

DROP TABLE IF EXISTS products;

CREATE TABLE products AS

SELECT DISTINCT

    Product_ID,
    Category,
    Sub_Category,
    Product_Name

FROM superstore_clean;

-- Verify Products
SELECT *
FROM products
LIMIT 10;

-- Count Products
SELECT
    COUNT(*) AS total_products
FROM products;

/*
 Step 4: Verify Record Count of All Business Tables
*/

SELECT
    'Customers' AS table_name,
    COUNT(*) AS total_records
FROM customers

UNION ALL

SELECT
    'Orders',
    COUNT(*)
FROM orders

UNION ALL

SELECT
    'Products',
    COUNT(*)
FROM products;

/*
Step 5 : Verify Table Structures
*/

DESCRIBE customers;
DESCRIBE orders;
DESCRIBE products;

/*
Step 6 : Create Indexes (Professional Practice)
*/

-- Customers

CREATE INDEX idx_customers_customer_id
ON customers(Customer_ID);

-- Orders

CREATE INDEX idx_orders_order_id
ON orders(Order_ID);

CREATE INDEX idx_orders_customer_id
ON orders(Customer_ID);

-- Products

CREATE INDEX idx_products_product_id
ON products(Product_ID);

/*
Step 7 : Verify Indexes
*/

SHOW INDEXES FROM customers;
SHOW INDEXES FROM orders;
SHOW INDEXES FROM products;

/*
Step 8 : Verify Relationships
These queries confirm that your business tables are correctly related.
*/

SELECT
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID,
    o.Sales
FROM customers AS c
INNER JOIN orders AS o
    ON c.Customer_ID = o.Customer_ID
LIMIT 10;