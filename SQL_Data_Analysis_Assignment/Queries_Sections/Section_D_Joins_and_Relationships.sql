/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section:  D - Joins & Relationships
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
Description:
This section demonstrates SQL JOIN operations to combine data
 from multiple related tables and explains database relationships.
*/


-- Q19. INNER JOIN - Display Orders with Customer Details

SELECT
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    o.total_amount
FROM orders AS o
INNER JOIN customers AS c
        ON o.customer_id = c.customer_id
ORDER BY o.order_date;

/*
Explanation:
-`INNER JOIN` returns only matching records.
- Every order has a valid customer because of the foreign key.
*/

-- Q20. LEFT JOIN - Display All Customers with Their Orders

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_id,
    o.order_date,
    o.status,
    o.total_amount
FROM customers AS c
LEFT JOIN orders AS o
       ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

/*
Explanation:
-Shows every customer.
-Customers without orders will display `NULL` for order columns.
*/

-- Q21. JOIN Across Three Tables

SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.discount_pct
FROM orders AS o
INNER JOIN order_items AS oi
        ON o.order_id = oi.order_id
INNER JOIN products AS p
        ON oi.product_id = p.product_id
ORDER BY o.order_id;

/*
Explanation:
This query joins:
Orders-> Order Items-> Products
to display product details for every order.
*/

-- Q22. Difference Between LEFT JOIN and RIGHT JOIN

-- Answer:

/*
LEFT JOIN
Returns:
* All rows from the **left table**
* Matching rows from the right table
* If no match exists, NULL values are returned.
*/
-- Example:

SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
       ON c.customer_id = o.customer_id;
/*
Display **all customers**, even if they haven't placed any orders.
*/

/*
RIGHT JOIN
Returns:
* All rows from the **right table**
* Matching rows from the left table
*/
-- Example:

SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
        ON c.customer_id = o.customer_id;
        
/*
It will display **all orders**, even if there is no matching customer (although the foreign key prevents this in the current schema).
*/

/*
FULL OUTER JOIN
Returns:
* All rows from both tables
* Matching rows where possible
* NULL values where no match exists.
Useful when comparing two tables and identifying unmatched records from either side.
*/


-- Q23. Foreign Keys

/* 
Foreign Key Relationships

| Parent Table | Child Table | Foreign Key |
| ------------ | ----------- | ----------- |
| customers    | orders      | customer_id |
| orders       | order_items | order_id    |
| products     | order_items | product_id  |

*/

-- Demonstration Query:
INSERT INTO orders
(
    order_id,
    customer_id,
    order_date,
    status,
    total_amount
)
VALUES
(
    1015,
    999,
    '2024-09-01',
    'Pending',
    1500
);

/*
Result:
MySQL returns an error similar to:
Cannot add or update a child row:
a foreign key constraint fails
*/

/*
Explanation:
Since **customer_id = 999** does not exist in the `customers` table, the foreign key constraint prevents the insertion.
This ensures **referential integrity**, meaning every order must belong to a valid customer.
*/



/*
 ***********Display customer order summary********
*/

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    IFNULL(SUM(o.total_amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
       ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;


/*
 ********Display total quantity sold for each product********
*/

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products AS p
INNER JOIN order_items AS oi
        ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;


