/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section: A-SQL Basics (SELECT, Constraints, Primary Keys)
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
Description:
 This section covers basic SQL queries, primary keys, constraints,
 and data validation.
*/

-- Q1. Write a query to display all columns and rows from the customer's table. 
SELECT *
FROM customers;
/* Description : "SELECT*" is used because the question specifically asks for all columns 
and normally, avoid "SELECT*" in production code.*/

-- Q2. Retrieve only the first_name, last_name, and city of all customers
SELECT
    c.first_name,
    c.last_name,
    c.city
FROM customers AS c;

-- Q3. List all unique categories available in the products table
SELECT DISTINCT
    p.category
FROM products AS p
ORDER BY p.category ASC;

-- Q4. Identify the Primary Key of each table
/* 
Table	       Primary Key
customers	   customer_id
products	   product_id
orders	       order_id
order_items	   item_id 
*/

-- Q5. Constraints on the email column

/* The email column has two constraints: 1. UNIQUE
                                         2. NOT NULL
This means: Every customer must have an email address.
			No two customers can have the same email.
*/

-- Query for Demonstration: attempt to insert a duplicate email

INSERT INTO customers
(
    customer_id,
    first_name,
    last_name,
    email,
    city,
    state,
    join_date,
    is_premium
)
VALUES
(
    109,
    'Rahul',
    'Patil',
    'aarav.s@email.com',
    'Nagpur',
    'Maharashtra',
    '2024-09-01',
    TRUE
);

/* Result

MySQL returns an error similar to:

Duplicate entry 'aarav.s@email.com'
for key 'customers.email'
*/

/*
Explanation: The insert fails because the UNIQUE constraint does not allow duplicate email addresses.
*/

-- Q6. Insert a product with negative price
INSERT INTO products
(
    product_id,
    product_name,
    category,
    brand,
    unit_price,
    stock_qty
)
VALUES
(
    209,
    'Gaming Mouse',
    'Electronics',
    'Logitech',
    -50,
    20
);

/*Result: 
MySQL rejects the insert because of the CHECK constraint: CHECK (unit_price > 0)
*/

/*
Explanation: The CHECK constraint ensures that the product price is always greater than zero,
 maintaining valid business data.
*/


-- Display the total number of records in each table

SELECT 'Customers' AS table_name, COUNT(*) AS total_records
FROM customers

UNION ALL

SELECT 'Products', COUNT(*)
FROM products

UNION ALL

SELECT 'Orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'Order Items', COUNT(*)
FROM order_items;



