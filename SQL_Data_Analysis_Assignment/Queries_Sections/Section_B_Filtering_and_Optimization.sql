/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section: B- Filtering & Optimization (WHERE, Indexes)
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
Description:
 This section demonstrates filtering data using WHERE, BETWEEN,
 logical operators, and explains how indexes improve query performance.
 */
 
 -- Q7. Retrieve all orders with status = 'Delivered'
 
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    o.total_amount
FROM orders AS o
WHERE o.status = 'Delivered';

/* Explanation:
Filters only orders with Delivered status.
Uses table alias (o) for readability.
*/

-- Q8. Find all Electronics products with unit_price > ₹2000

SELECT
    p.product_id,
    p.product_name,
    p.brand,
    p.category,
    p.unit_price,
    p.stock_qty
FROM products AS p
WHERE p.category = 'Electronics'
  AND p.unit_price > 2000
ORDER BY p.unit_price DESC;

/*
 Explanation"
Uses multiple conditions with AND.
Sorts expensive products first.
*/

-- Q9. Customers from Maharashtra who joined in 2024

/*
Instead of using:
YEAR(join_date)=2024
Use this index-friendly query.
*/

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    c.join_date
FROM customers AS c
WHERE c.state = 'Maharashtra'
  AND c.join_date BETWEEN '2024-01-01' AND '2024-12-31';

/*
Explaination:
Using BETWEEN is more efficient than YEAR(join_date) 
because the database can use an index on the date column.

-- Q10. Orders between two dates that are NOT Cancelled

SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,
    o.total_amount
FROM orders AS o
WHERE o.order_date BETWEEN '2024-08-10' AND '2024-08-25'
  AND o.status <> 'Cancelled'
ORDER BY o.order_date;

/*
Explanation:
- BETWEEN includes both start and end dates.
- <> means Not Equal To.
*/

-- Q11. Explain idx_orders_date

-- Sample Query
SELECT
    o.order_id,
    o.order_date,
    o.total_amount
FROM orders AS o
WHERE o.order_date BETWEEN '2024-08-01' AND '2024-08-31';
/*
Answer: idx_orders_date is an index created on the order_date column.
Reason:
- Speeds up searches based on order_date.
- Reduces the number of rows scanned.
- Improves filtering and sorting performance.
Instead of scanning every row in the orders table, 
MySQL can directly locate matching records using the index.
*/


-- Q12. Is YEAR(join_date) index-friendly?

-- unOptimized Query
SELECT
    c.customer_id,
    c.first_name,
    c.join_date
FROM customers AS c
WHERE YEAR(c.join_date) = 2024;

/*
This is inefficient because: Applying the YEAR() function to the indexed column prevents 
MySQL from efficiently using the index, often resulting in a full table scan.
*/

-- Optimized Query
SELECT
    c.customer_id,
    c.first_name,
    c.join_date
FROM customers AS c
WHERE c.join_date BETWEEN '2024-01-01'
                      AND '2024-12-31';
/* 
Explanation:
This query allows MySQL to use the index because the join_date column is compared directly without applying a function.
*/


/* **Filter premium customers from Maharashtra.** */

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city,
    c.state,
    c.join_date
FROM customers AS c
WHERE c.state = 'Maharashtra'
  AND c.is_premium = TRUE
ORDER BY c.join_date;
