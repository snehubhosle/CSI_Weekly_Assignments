/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench

 Objective:
 Generate the final customer sales report using
 JOIN + CTE + Window Function.
*/

USE superstore_db;

-- Final Combined Query

WITH customer_sales AS
(
    SELECT
        o.Customer_ID,
        SUM(o.Sales) AS total_sales
    FROM orders AS o
    GROUP BY o.Customer_ID
)
SELECT
    c.Customer_ID,
    c.Customer_Name,
    ROUND(cs.total_sales,2) AS total_sales,
    RANK() OVER(ORDER BY cs.total_sales DESC) AS customer_rank
FROM customer_sales AS cs
INNER JOIN customers AS c
ON cs.Customer_ID=c.Customer_ID
ORDER BY customer_rank;


-- Final Combined Query (Detailed Version)

WITH customer_summary AS
(
    SELECT
        o.Customer_ID,
        COUNT(DISTINCT o.Order_ID) AS total_orders,
        SUM(o.Sales) AS total_sales,
        SUM(o.Profit) AS total_profit,
        AVG(o.Sales) AS average_order_value
    FROM orders AS o
    GROUP BY o.Customer_ID
)
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Segment,
    c.Region,
    cs.total_orders,
    ROUND(cs.total_sales,2) AS total_sales,
    ROUND(cs.total_profit,2) AS total_profit,
    ROUND(cs.average_order_value,2) AS average_order_value,
    RANK() OVER(ORDER BY cs.total_sales DESC) AS sales_rank,
    DENSE_RANK() OVER(ORDER BY cs.total_profit DESC) AS profit_rank
FROM customer_summary AS cs
INNER JOIN customers AS c
ON cs.Customer_ID=c.Customer_ID
ORDER BY sales_rank;


-- Top 10 Customer Report


WITH customer_summary AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
),
customer_ranking AS
(
    SELECT
        Customer_ID,
        total_sales,
        RANK() OVER(ORDER BY total_sales DESC) AS customer_rank
    FROM customer_summary
)
SELECT
    cr.customer_rank,
    c.Customer_Name,
    ROUND(cr.total_sales,2) AS total_sales
FROM customer_ranking AS cr
INNER JOIN customers AS c
ON cr.Customer_ID=c.Customer_ID
WHERE cr.customer_rank<=10
ORDER BY cr.customer_rank;