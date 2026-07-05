/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench

 Objective:
 Analyze customer sales using SQL Window Functions including
 ROW_NUMBER(), RANK(), DENSE_RANK() and other analytical functions.
*/

USE superstore_db;

/*
Query 1 : Rank Customers Based on Total Sales
Concept : RANK()
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
    RANK() OVER(ORDER BY css.total_sales DESC) AS customer_rank
FROM customer_sales_summary AS css
INNER JOIN customers AS c
ON css.Customer_ID=c.Customer_ID
ORDER BY customer_rank;

/*
Query 2 : Dense Rank Customers
Concept : DENSE_RANK()
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
    DENSE_RANK() OVER(ORDER BY css.total_sales DESC) AS dense_rank
FROM customer_sales_summary AS css
INNER JOIN customers AS c
ON css.Customer_ID=c.Customer_ID
ORDER BY dense_rank;

/*
Query 3 : Assign Row Number to Each Order
Concept : ROW_NUMBER() + PARTITION BY
*/

SELECT
    Order_ID,
    Customer_ID,
    Sales,
    ROW_NUMBER() OVER(
        PARTITION BY Customer_ID
        ORDER BY Sales DESC
    ) AS order_number
FROM orders
ORDER BY Customer_ID,order_number;

/*
Query 4 : Display Top 3 Customers
Concept : Window Function
*/

WITH customer_sales_summary AS
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
    FROM customer_sales_summary
)
SELECT
    cr.Customer_ID,
    c.Customer_Name,
    ROUND(cr.total_sales,2) AS total_sales,
    cr.customer_rank
FROM customer_ranking AS cr
INNER JOIN customers AS c
ON cr.Customer_ID=c.Customer_ID
WHERE cr.customer_rank<=3
ORDER BY cr.customer_rank;

/*
Query 5 : Highest Sale in Each Customer
Concept : ROW_NUMBER()
*/

WITH ranked_orders AS
(
    SELECT
        Order_ID,
        Customer_ID,
        Sales,
        Profit,
        ROW_NUMBER() OVER(
            PARTITION BY Customer_ID
            ORDER BY Sales DESC
        ) AS row_num
    FROM orders
)
SELECT
    ro.Order_ID,
    ro.Customer_ID,
    c.Customer_Name,
    ro.Sales,
    ro.Profit
FROM ranked_orders AS ro
INNER JOIN customers AS c
ON ro.Customer_ID=c.Customer_ID
WHERE ro.row_num=1
ORDER BY ro.Sales DESC;

/*
Query 6 : Previous Order Sales
 Concept : LAG()
*/

SELECT
    Customer_ID,
    Order_ID,
    Sales,
    LAG(Sales) OVER(
        PARTITION BY Customer_ID
        ORDER BY Order_Date
    ) AS previous_order_sales
FROM orders;

/*
-- Query 7 : Compare Current & Previous Sales
-- Concept : LAG() + COALESCE()
*/

SELECT
    Customer_ID,
    Order_ID,
    Sales,
    COALESCE(
        LAG(Sales) OVER(
            PARTITION BY Customer_ID
            ORDER BY Order_Date
        ),
        0
    ) AS previous_sales
FROM orders;

/*
Query 8 : Divide Customers Into 4 Groups
Concept : NTILE()
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
    Customer_ID,
    ROUND(total_sales,2) AS total_sales,
    NTILE(4) OVER(ORDER BY total_sales DESC) AS sales_quartile
FROM customer_sales_summary;

/*
Query 9 : Running Total of Sales
Concept : SUM() OVER()
*/

SELECT
    Order_Date,
    Order_ID,
    Sales,
    SUM(Sales) OVER(
        ORDER BY Order_Date
    ) AS running_total_sales
FROM orders;

/*
Query 10 : Customer Sales Percentage
 Concept : Window Aggregate
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
    Customer_ID,
    ROUND(total_sales,2) AS total_sales,
    ROUND(
        total_sales/
        SUM(total_sales) OVER()*100,
        2
    ) AS sales_percentage
FROM customer_sales_summary
ORDER BY total_sales DESC;