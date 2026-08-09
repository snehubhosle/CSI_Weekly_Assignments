/*
Assignment No.: 08
Title          : E-Commerce Order Analytics System
Author         : Snehal A. Bhosale
College        : Sanjivani College of Engineering, Kopargaon
Email          : snehalbhosale1807@gmail.com
Database       : ecommerce_analytics
Tool           : MySQL Workbench

Phase:
SQL Analysis - Window Functions

Description:
Use RANK, DENSE_RANK, SUM OVER, AVG OVER, LAG and
window functions for business analytics.
*/

USE ecommerce_analytics;


/* 
   QUERY 1: RUNNING TOTAL OF REVENUE PER REGION
 */

WITH daily_revenue AS (
    SELECT
        o.region_code,
        DATE(o.order_date) AS order_date,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100)
        ) AS daily_revenue

    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        o.region_code,
        DATE(o.order_date)
)

SELECT
    region_code,
    order_date,
    ROUND(daily_revenue, 2) AS daily_revenue,

    ROUND(
        SUM(daily_revenue) OVER (
            PARTITION BY region_code
            ORDER BY order_date
        ), 2
    ) AS running_total

FROM daily_revenue

ORDER BY
    region_code,
    order_date;


/*
   QUERY 2: RANK PRODUCTS BY REVENUE WITHIN CATEGORY
   Same revenue gets same rank.
 */

WITH product_revenue AS (
    SELECT
        p.category,
        p.product_id,
        p.product_name,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100)
        ) AS total_revenue

    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id

    GROUP BY
        p.category,
        p.product_id,
        p.product_name
)

SELECT
    category,
    product_name,
    ROUND(total_revenue, 2) AS total_revenue,

    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS rank_in_category

FROM product_revenue

ORDER BY
    category,
    rank_in_category;


/*
   QUERY 3: DAYS BETWEEN CONSECUTIVE ORDERS
 */

WITH customer_orders AS (
    SELECT
        customer_id,
        order_date,

        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date

    FROM orders
)

SELECT
    customer_id,
    order_date,
    previous_order_date,

    DATEDIFF(
        order_date,
        previous_order_date
    ) AS days_gap

FROM customer_orders

ORDER BY
    customer_id,
    order_date;


/*
   QUERY 4: CUSTOMERS WITH AVERAGE GAP > 30 DAYS
            ARE FLAGGED AS AT RISK
 */

WITH customer_orders AS (
    SELECT
        customer_id,
        order_date,

        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date

    FROM orders
),

customer_gaps AS (
    SELECT
        customer_id,

        DATEDIFF(
            order_date,
            previous_order_date
        ) AS days_gap

    FROM customer_orders

    WHERE previous_order_date IS NOT NULL
)

SELECT
    customer_id,
    ROUND(AVG(days_gap), 2) AS average_gap_days,

    CASE
        WHEN AVG(days_gap) > 30
        THEN 'At Risk'
        ELSE 'Active'
    END AS customer_status

FROM customer_gaps

GROUP BY customer_id;