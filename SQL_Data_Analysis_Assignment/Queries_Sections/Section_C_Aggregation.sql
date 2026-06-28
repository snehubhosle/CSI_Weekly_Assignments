/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section: C - Aggregation (GROUP BY, SUM, COUNT, AVG, MIN, MAX)
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
Description:
This section demonstrates the use of aggregate functions such as
 COUNT(), SUM(), AVG(), MIN(), MAX(), GROUP BY, HAVING, and ORDER BY
 to summarize business data.
 */
 
 -- Q13. Count the total number of orders

SELECT
    COUNT(o.order_id) AS total_orders
FROM orders AS o;

/*
Explanation:
- COUNT() counts the total number of records.
- order_id is used because it is the primary key and never contains NULL.
*/

-- Q14. Total Revenue from Delivered Orders

SELECT
    SUM(o.total_amount) AS total_revenue
FROM orders AS o
WHERE o.status = 'Delivered';

/*
Explanation:
- SUM() calculates the total revenue.
- Filters only delivered orders.
*/

-- Q15. Average Product Price by Category

SELECT
    p.category,
    ROUND(AVG(p.unit_price), 2) AS average_unit_price
FROM products AS p
GROUP BY p.category
ORDER BY average_unit_price DESC;

/*
Description: 
ROUND(): Makes the output cleaner by displaying only two decimal places.
*/

-- Q16. Count of Orders and Total Revenue by Status

SELECT
    o.status,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM orders AS o
GROUP BY o.status
ORDER BY total_revenue DESC;

/*
Explanation
Uses:  GROUP BY, COUNT(), SUM(), ORDER BY all together
*/

-- Q17. Most Expensive and Cheapest Product in Each Category

SELECT
    p.category,
    MAX(p.unit_price) AS highest_price,
    MIN(p.unit_price) AS lowest_price
FROM products AS p
GROUP BY p.category
ORDER BY highest_price DESC;

/*
Explanation:
Shows pricing range within each category.
*/

-- Q18. Categories with Average Price Greater Than ₹2000
SELECT
    p.category,
    ROUND(AVG(p.unit_price), 2) AS average_price
FROM products AS p
GROUP BY p.category
HAVING AVG(p.unit_price) > 2000
ORDER BY average_price DESC;

/* 
Explanation: 
HAVING filters grouped results after aggregation.
*/


/*
 ********Calculate average discount percentage by product category*****
*/

SELECT
    p.category,
    ROUND(AVG(oi.discount_pct), 2) AS average_discount
FROM products AS p
INNER JOIN order_items AS oi
        ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY average_discount DESC;

/*
 *******Display top 3 customers based on total order value******
*/

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
        ON c.customer_id = o.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY total_spent DESC
LIMIT 3;


/*
*********Count products available in each category*********
*/

SELECT
    p.category,
    COUNT(p.product_id) AS total_products
FROM products AS p
GROUP BY p.category
ORDER BY total_products DESC;
