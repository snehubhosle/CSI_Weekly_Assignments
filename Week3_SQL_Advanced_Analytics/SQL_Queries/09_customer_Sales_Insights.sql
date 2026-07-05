/*=========================================================================
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench
 
Mini Project: Customer Sales Insights 

Answer the following using SQL: 

    1. Who are the top 5 customers?  
    2. Who are the bottom 5 customers?  
    3. Which customers made only one order?  
    4. Which customers have above-average sales?  
    5. What is the highest order value per customer? 

 Objective:
 Perform customer sales analysis using advanced SQL queries.
=========================================================================*/

USE superstore_db;

-- Insight 1 : Top 5 Customers

WITH customer_sales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    c.Customer_Name,
    ROUND(cs.total_sales,2) AS total_sales
FROM customer_sales AS cs
INNER JOIN customers AS c
ON cs.Customer_ID=c.Customer_ID
ORDER BY total_sales DESC
LIMIT 5;


-- Insight 2 : Bottom 5 Customers

WITH customer_sales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    c.Customer_Name,
    ROUND(cs.total_sales,2) AS total_sales
FROM customer_sales AS cs
INNER JOIN customers AS c
ON cs.Customer_ID=c.Customer_ID
ORDER BY total_sales
LIMIT 5;

-- Insight 3 : Customers With Only One Order

SELECT
    c.Customer_Name,
    COUNT(o.Order_ID) AS total_orders
FROM customers AS c
INNER JOIN orders AS o
ON c.Customer_ID=o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(o.Order_ID)=1
ORDER BY c.Customer_Name;

-- Insight 4 : Customers With Above Average Sales

WITH customer_sales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    c.Customer_Name,
    ROUND(cs.total_sales,2) AS total_sales
FROM customer_sales AS cs
INNER JOIN customers AS c
ON cs.Customer_ID=c.Customer_ID
WHERE cs.total_sales>
(
    SELECT AVG(total_sales)
    FROM customer_sales
)
ORDER BY total_sales DESC;

-- Insight 5 : Highest Order Value Per Customer

SELECT
    c.Customer_Name,
    o.Order_ID,
    o.Sales
FROM orders AS o
INNER JOIN customers AS c
ON o.Customer_ID=c.Customer_ID
WHERE o.Sales=
(
    SELECT MAX(ord.Sales)
    FROM orders AS ord
    WHERE ord.Customer_ID=o.Customer_ID
)
ORDER BY o.Sales DESC;


-- Insight 6 : Top 5 Most Profitable Customers

SELECT
    c.Customer_Name,
    ROUND(SUM(o.Profit),2) AS total_profit
FROM customers AS c
INNER JOIN orders AS o
ON c.Customer_ID=o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY total_profit DESC
LIMIT 5;

-- Insight 7 : Customer Category Based on Sales

WITH customer_sales AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    c.Customer_Name,
    ROUND(cs.total_sales,2) AS total_sales,
    CASE
        WHEN cs.total_sales>=15000 THEN 'Platinum'
        WHEN cs.total_sales>=10000 THEN 'Gold'
        WHEN cs.total_sales>=5000 THEN 'Silver'
        ELSE 'Regular'
    END AS customer_category
FROM customer_sales AS cs
INNER JOIN customers AS c
ON cs.Customer_ID=c.Customer_ID
ORDER BY total_sales DESC;

-- Insight 8 : Region Wise Sales

SELECT
    c.Region,
    ROUND(SUM(o.Sales),2) AS total_sales,
    ROUND(SUM(o.Profit),2) AS total_profit
FROM customers AS c
INNER JOIN orders AS o
ON c.Customer_ID=o.Customer_ID
GROUP BY c.Region
ORDER BY total_sales DESC;

-- Insight 9 : Segment Wise Sales

SELECT
    c.Segment,
    ROUND(SUM(o.Sales),2) AS total_sales,
    ROUND(AVG(o.Sales),2) AS average_sales,
    ROUND(SUM(o.Profit),2) AS total_profit
FROM customers AS c
INNER JOIN orders AS o
ON c.Customer_ID=o.Customer_ID
GROUP BY c.Segment
ORDER BY total_sales DESC;

-- Insight 10 : Overall Business Summary

SELECT
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(SUM(Profit),2) AS total_profit,
    ROUND(AVG(Sales),2) AS average_order_value
FROM orders;