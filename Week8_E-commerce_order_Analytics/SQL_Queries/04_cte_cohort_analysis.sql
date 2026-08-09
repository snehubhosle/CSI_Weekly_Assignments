/*
Assignment No.: 08
Title          : E-Commerce Order Analytics System
Author         : Snehal A. Bhosale
College        : Sanjivani College of Engineering, Kopargaon
Email          : snehalbhosale1807@gmail.com
Database       : ecommerce_analytics
Tool           : MySQL Workbench

Phase:
SQL Analysis - CTE and Cohort Analysis

Description:
Use Common Table Expressions for multi-step analytics,
customer segmentation, quartile analysis, YoY comparison,
first/last purchase analysis, and customer retention.
*/

USE ecommerce_analytics;


/*
   QUERY 1: MONTHLY CUSTOMER REVENUE CATEGORY
   High    > 10000
   Medium  5000 - 10000
   Low     < 5000
   */

WITH monthly_customer_revenue AS (

    SELECT
        o.customer_id,
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100)
        ) AS revenue

    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        o.customer_id,
        DATE_FORMAT(o.order_date, '%Y-%m')
),

customer_categories AS (

    SELECT
        customer_id,
        month,
        revenue,

        CASE
            WHEN revenue > 10000 THEN 'High'
            WHEN revenue >= 5000 THEN 'Medium'
            ELSE 'Low'
        END AS revenue_category

    FROM monthly_customer_revenue
)

SELECT
    month,
    revenue_category,
    COUNT(*) AS customer_count

FROM customer_categories

GROUP BY
    month,
    revenue_category

ORDER BY
    month,
    revenue_category;


/* 
   QUERY 2: CUSTOMER LIFETIME VALUE QUARTILES
 */

WITH customer_value AS (

    SELECT
        o.customer_id,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100)
        ) AS total_value

    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY o.customer_id
),

quartile_data AS (

    SELECT
        customer_id,
        total_value,

        NTILE(4) OVER (
            ORDER BY total_value DESC
        ) AS quartile

    FROM customer_value
)

SELECT
    customer_id,
    ROUND(total_value, 2) AS total_value,
    quartile,

    CASE
        WHEN quartile = 1 THEN 'Platinum'
        WHEN quartile = 2 THEN 'Gold'
        WHEN quartile = 3 THEN 'Silver'
        WHEN quartile = 4 THEN 'Bronze'
    END AS quartile_label

FROM quartile_data

ORDER BY quartile;


/* 
   QUERY 3: YEAR-OVER-YEAR REVENUE COMPARISON
  */

WITH monthly_revenue AS (

    SELECT
        YEAR(o.order_date) AS year,
        MONTH(o.order_date) AS month,

        SUM(
            oi.quantity *
            oi.unit_price *
            (1 - oi.discount_percent / 100)
        ) AS revenue

    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id

    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date)
),

year_comparison AS (

    SELECT
        year,
        month,
        revenue,

        LAG(revenue, 12) OVER (
            ORDER BY year, month
        ) AS prev_year_revenue

    FROM monthly_revenue
)

SELECT
    year,
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(prev_year_revenue, 2) AS prev_year_revenue,

    CASE
        WHEN prev_year_revenue IS NULL THEN NULL
        WHEN prev_year_revenue = 0 THEN NULL
        ELSE ROUND(
            (
                (revenue - prev_year_revenue)
                / prev_year_revenue
            ) * 100,
            2
        )
    END AS yoy_growth_percent

FROM year_comparison

ORDER BY
    year,
    month;


/* 
   QUERY 4: FIRST PURCHASE CATEGORY VS MOST RECENT CATEGORY
   */

WITH customer_categories AS (

    SELECT
        o.customer_id,
        o.order_date,
        p.category,

        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
        ) AS first_rank,

        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date DESC
        ) AS last_rank

    FROM orders o

    JOIN order_items oi
        ON o.order_id = oi.order_id

    JOIN products p
        ON oi.product_id = p.product_id
),

first_last AS (

    SELECT
        customer_id,

        MAX(
            CASE
                WHEN first_rank = 1
                THEN category
            END
        ) AS first_category,

        MAX(
            CASE
                WHEN last_rank = 1
                THEN category
            END
        ) AS latest_category

    FROM customer_categories

    GROUP BY customer_id
)

SELECT
    customer_id,
    first_category,
    latest_category,

    CASE
        WHEN first_category <> latest_category
        THEN 'Yes'
        ELSE 'No'
    END AS category_shift

FROM first_last;


/*
   QUERY 5: CUSTOMER COHORT ANALYSIS
   Month 0, Month 1, Month 2, Month 3
*/

WITH customer_cohort AS (

    SELECT
        customer_id,
        DATE_FORMAT(
            MIN(registration_date),
            '%Y-%m-01'
        ) AS cohort_month

    FROM customers

    GROUP BY customer_id
),

customer_orders AS (

    SELECT DISTINCT
        o.customer_id,

        DATE_FORMAT(
            o.order_date,
            '%Y-%m-01'
        ) AS order_month

    FROM orders o
),

cohort_activity AS (

    SELECT
        cc.customer_id,
        cc.cohort_month,
        co.order_month,

        TIMESTAMPDIFF(
            MONTH,
            cc.cohort_month,
            co.order_month
        ) AS month_number

    FROM customer_cohort cc

    JOIN customer_orders co
        ON cc.customer_id = co.customer_id

    WHERE TIMESTAMPDIFF(
        MONTH,
        cc.cohort_month,
        co.order_month
    ) BETWEEN 0 AND 3
),

cohort_counts AS (

    SELECT
        cohort_month,
        month_number,
        COUNT(DISTINCT customer_id) AS active_customers

    FROM cohort_activity

    GROUP BY
        cohort_month,
        month_number
)

SELECT
    cohort_month,

    MAX(
        CASE
            WHEN month_number = 0
            THEN active_customers
        END
    ) AS month_0,

    MAX(
        CASE
            WHEN month_number = 1
            THEN active_customers
        END
    ) AS month_1,

    MAX(
        CASE
            WHEN month_number = 2
            THEN active_customers
        END
    ) AS month_2,

    MAX(
        CASE
            WHEN month_number = 3
            THEN active_customers
        END
    ) AS month_3

FROM cohort_counts

GROUP BY cohort_month

ORDER BY cohort_month;