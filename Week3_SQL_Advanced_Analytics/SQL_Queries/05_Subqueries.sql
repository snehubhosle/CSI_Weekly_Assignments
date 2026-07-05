/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench

 Objective:
 Practice SQL Subqueries to answer business questions using the
 Superstore dataset.
*/

USE superstore_db;

/*
 Query 1
 Find all orders where Sales is greater than the average Sales.
 Concept Used : Subquery
*/

SELECT
    o.Order_ID,
    o.Customer_ID,
    o.Sales,
    o.Quantity,
    o.Profit
FROM orders AS o
WHERE o.Sales >
(
    SELECT AVG(ord.Sales)
    FROM orders AS ord
)
ORDER BY o.Sales DESC;


/*
 Query 2
 Find the highest sales order for each customer.
 Concept Used : Correlated Subquery
*/

SELECT
    o.Customer_ID,
    o.Order_ID,
    o.Sales,
    o.Profit
FROM orders AS o
WHERE o.Sales =
(
    SELECT MAX(ord.Sales)
    FROM orders AS ord
    WHERE ord.Customer_ID = o.Customer_ID
)
ORDER BY o.Customer_ID;


/*
 Query 3
 Find customers who placed orders above the overall average sale.
 Concept Used : Subquery
*/

SELECT DISTINCT
    c.Customer_ID,
    c.Customer_Name
FROM customers AS c
JOIN orders AS o
    ON c.Customer_ID = o.Customer_ID
WHERE o.Sales >
(
    SELECT AVG(Sales)
    FROM orders
)
ORDER BY c.Customer_Name;

/*
 Query 4
 Find the order(s) having the highest profit.
 Concept Used : Scalar Subquery
*/

SELECT
    Order_ID,
    Customer_ID,
    Sales,
    Profit
FROM orders
WHERE Profit =
(
    SELECT MAX(Profit)
    FROM orders
);

/*
 Query 5
 Find customers whose total number of orders is greater than
 the average number of orders placed by customers.
 Concept Used : Nested Subquery
*/

SELECT
    Customer_ID,
    COUNT(Order_ID) AS total_orders
FROM orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >
(
    SELECT AVG(order_count)
    FROM
    (
        SELECT
            COUNT(Order_ID) AS order_count
        FROM orders
        GROUP BY Customer_ID
    ) AS avg_orders
)
ORDER BY total_orders DESC;

/*
 Query 6
 Find orders whose Sales is greater than the customer's own
 average order value.
 Concept Used : Correlated Subquery
*/

SELECT
    o.Order_ID,
    o.Customer_ID,
    o.Sales
FROM orders AS o
WHERE o.Sales >
(
    SELECT AVG(ord.Sales)
    FROM orders AS ord
    WHERE ord.Customer_ID = o.Customer_ID
)
ORDER BY o.Customer_ID;