/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench

 Objective:
 Perform customer-level sales analysis using Common Table Expressions (CTEs)
 to simplify complex queries and improve readability.
*/

USE superstore_db;

/*
 Query 1
 Calculate total sales for each customer.
 Concept Used: Common Table Expression (CTE)
*/

WITH customer_sales_summary AS
(
    SELECT
        o.Customer_ID,
        SUM(o.Sales) AS total_sales
    FROM orders AS o
    GROUP BY o.Customer_ID
)

SELECT
    cs.Customer_ID,
    c.Customer_Name,
    ROUND(cs.total_sales,2) AS total_sales
FROM customer_sales_summary AS cs
INNER JOIN customers AS c
ON cs.Customer_ID = c.Customer_ID
ORDER BY total_sales DESC;

/*
 Query 2
 Find customers whose total sales are above average.
 Concepts Used: CTE + Subquery
*/

WITH customer_sales_summary AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    css.Customer_ID,
    c.Customer_Name,
    ROUND(css.total_sales,2) AS total_sales
FROM customer_sales_summary AS css
INNER JOIN customers AS c
ON css.Customer_ID = c.Customer_ID

WHERE css.total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales_summary
)

ORDER BY total_sales DESC;

/*
 Query 3
 Display customer sales summary including:
 - Total Orders
 - Total Sales
 - Average Order Value
 Concept Used: CTE
*/

WITH customer_summary AS
(
    SELECT
        Customer_ID,
        COUNT(Order_ID) AS total_orders,
        SUM(Sales) AS total_sales,
        AVG(Sales) AS average_order_value
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    cs.Customer_ID,
    c.Customer_Name,
    cs.total_orders,
    ROUND(cs.total_sales,2) AS total_sales,
    ROUND(cs.average_order_value,2) AS average_order_value
FROM customer_summary AS cs
INNER JOIN customers AS c
ON cs.Customer_ID = c.Customer_ID
ORDER BY total_sales DESC;

/*
 Query 4
 Calculate customer-wise profit.
 Concept Used: CTE
*/

WITH customer_profit_summary AS
(
    SELECT
        Customer_ID,
        SUM(Profit) AS total_profit
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    cps.Customer_ID,
    c.Customer_Name,
    ROUND(cps.total_profit,2) AS total_profit
FROM customer_profit_summary AS cps
INNER JOIN customers AS c
ON cps.Customer_ID = c.Customer_ID

ORDER BY total_profit DESC;

/*
 Query 5
 Customers whose sales exceed ₹10,000.
 Concept Used: CTE
*/

WITH customer_sales_summary AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)

SELECT
    css.Customer_ID,
    c.Customer_Name,
    ROUND(css.total_sales,2) AS total_sales
FROM customer_sales_summary AS css
INNER JOIN customers AS c
ON css.Customer_ID = c.Customer_ID
WHERE css.total_sales > 10000
ORDER BY total_sales DESC;

/*
 Query 6
 Categorize customers based on total sales.
 Concept Used: CTE + CASE
*/

WITH customer_sales_summary AS
(
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM orders
    GROUP BY Customer_ID
)
SELECT
    css.Customer_ID,
    c.Customer_Name,
    ROUND(css.total_sales,2) AS total_sales,
    CASE
        WHEN css.total_sales >= 15000 THEN 'Platinum Customer'
        WHEN css.total_sales >= 10000 THEN 'Gold Customer'
        WHEN css.total_sales >= 5000 THEN 'Silver Customer'
        ELSE 'Regular Customer'
    END AS customer_category
FROM customer_sales_summary AS css
INNER JOIN customers AS c
ON css.Customer_ID = c.Customer_ID
ORDER BY total_sales DESC;

/*
 Query 7
 Region-wise customer sales analysis.
 Concept Used: CTE
 */

WITH regional_sales AS
(
    SELECT
        c.Region,
        o.Customer_ID,
        SUM(o.Sales) AS total_sales
    FROM orders AS o
    INNER JOIN customers AS c
    ON o.Customer_ID = c.Customer_ID
    GROUP BY
        c.Region,
        o.Customer_ID
)

SELECT
    Region,
    Customer_ID,
    ROUND(total_sales,2) AS total_sales
FROM regional_sales
ORDER BY
    Region,
    total_sales DESC;