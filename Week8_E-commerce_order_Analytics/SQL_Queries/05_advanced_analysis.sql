/*
Assignment No.: 08
Title          : E-Commerce Order Analytics System
Author         : Snehal A. Bhosale
College        : Sanjivani College of Engineering, Kopargaon
Email          : snehalbhosale1807@gmail.com
Database       : ecommerce_analytics
Tool           : MySQL Workbench

Phase:
SQL Analysis - Advanced Business Analytics

Description:
Perform cumulative revenue analysis and product affinity
analysis using window functions and self joins.
*/

USE ecommerce_analytics;


/*
   QUERY 1: CUSTOMER CUMULATIVE REVENUE
*/

WITH customer_revenue AS (

    SELECT
        o.customer_id,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100)
        ) AS revenue

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY o.customer_id
),

cumulative_revenue AS (

    SELECT
        customer_id,
        revenue,

        SUM(revenue) OVER (
            ORDER BY revenue DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ) AS cumulative_revenue,

        SUM(revenue) OVER () AS total_revenue

    FROM customer_revenue
)

SELECT
    customer_id,
    ROUND(revenue, 2) AS revenue,
    ROUND(cumulative_revenue, 2) AS cumulative_revenue,

    ROUND(
        cumulative_revenue / NULLIF(total_revenue, 0) * 100,
        2
    ) AS cumulative_percent

FROM cumulative_revenue

ORDER BY revenue DESC;


/*
   QUERY 2: FREQUENTLY BOUGHT TOGETHER PRODUCTS
   A-B and B-A are treated as the same pair.
 */

SELECT
    oi1.product_id AS product_a,
    oi2.product_id AS product_b,

    COUNT(DISTINCT oi1.order_id) AS times_bought_together

FROM order_items oi1

JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id

GROUP BY
    oi1.product_id,
    oi2.product_id

ORDER BY
    times_bought_together DESC;


/*
   QUERY 3: PRODUCT NAMES FOR FREQUENTLY BOUGHT TOGETHER
 */

SELECT
    p1.product_name AS product_a,
    p2.product_name AS product_b,

    COUNT(DISTINCT oi1.order_id) AS times_bought_together

FROM order_items oi1

JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id

JOIN products p1
    ON oi1.product_id = p1.product_id

JOIN products p2
    ON oi2.product_id = p2.product_id

GROUP BY
    p1.product_id,
    p1.product_name,
    p2.product_id,
    p2.product_name

ORDER BY
    times_bought_together DESC;