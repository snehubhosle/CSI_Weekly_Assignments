/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section:  E - Advanced Concepts (CASE, ACID, Transactions)
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
Description:
This section demonstrates advanced SQL concepts including CASE
 statements, ACID properties, and Transaction Management.
*/


/*
Q24. Write a query using CASE to classify products into price tiers: 
  • 'Budget'    → unit_price < 1000 
  • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
  • 'Premium'   → unit_price > 3000 
Display: product_name, unit_price, price_tier. 
*/

SELECT
    p.product_name,
    p.unit_price,

    CASE
        WHEN p.unit_price < 1000 THEN 'Budget'
        WHEN p.unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS price_tier

FROM products AS p
ORDER BY
    p.unit_price ASC;

/*
Explanation:
The `CASE` statement works like an **IF...ELSE** condition.

Classification:
Price       Tier      
< 1000      Budget   
1000–3000   Mid-Range 
>3000       Premium   
*/

/*
Q25. Using a CASE statement inside an aggregate function, count how many 
orders are 'Delivered' vs 'Not Delivered' (all other statuses). 
Display the result in a single row. 
*/

SELECT

    SUM(
        CASE
            WHEN o.status = 'Delivered'
            THEN 1
            ELSE 0
        END
    ) AS delivered_orders,

    SUM(
        CASE
            WHEN o.status <> 'Delivered'
            THEN 1
            ELSE 0
        END
    ) AS not_delivered_orders

FROM orders AS o;

/*
Explanation:
This query uses:
- CASE
- SUM()
to count records without using multiple queries.
*/


-- Q26. ACID Properties

/*
1. A — Atomicity:
A transaction is treated as a single unit of work.
Either:
- All operations succeed
- OR
- All operations fail
There is **no partial execution**.

Example:
Bank Transfer:
Rahul transfers ₹5000 to Snehal.
If money is deducted from Rahul's account but not deposited into Snehal's account,
the transaction is rolled back.
No money is lost

2. C — Consistency:
A transaction always moves the database from one valid state to another.
Database rules remain valid.

Example:
Stock quantity cannot become negative.
If only 5 items exist,
selling 8 items is rejected.

3. I — Isolation:
Multiple transactions can execute simultaneously without interfering with each other.

Example:
Two customers attempt to buy the last laptop.
Only one purchase succeeds.
The second transaction waits or fails.

4. D — Durability:
Once a transaction is committed,
its changes are permanently saved.
Even if:
- Power fails
- Server crashes
the data remains stored.

Example:
Online payment succeeds.
Even if electricity goes off immediately afterward,
the payment record remains in the database.
*/



/*
 Q27. Write a SQL transaction that does the following atomically: 
  1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
  2. Insert two order items for that order 
  3. Update the stock_qty of the purchased products 
  4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
Write the complete BEGIN...COMMIT/ROLLBACK block. 
*/

START TRANSACTION;

-- Step 1 : Insert a new order
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
    1011,
    102,
    CURDATE(),
    'Pending',
    1598.00
);

-- Step 2 : Insert first order item
INSERT INTO order_items
(
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_pct
)
VALUES
(
    16,
    1011,
    201,
    1,
    999.00,
    0
);

-- Step 3 : Insert second order item
INSERT INTO order_items
(
    item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount_pct
)
VALUES
(
    17,
    1011,
    202,
    1,
    599.00,
    0
);

-- Step 4 : Update stock for Product 201
UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 201;

-- Step 5 : Update stock for Product 202
UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 202;

COMMIT;

-- Rollback Demonstration:

-- If an error occurs before `COMMIT`, execute:
ROLLBACK;

/*
This will undo:
- Order insertion
- Order item insertion
- Stock updates
The database returns to its previous state.
*/


/*
 ********Count products in each price tier*******
*/

SELECT

    CASE
        WHEN p.unit_price < 1000 THEN 'Budget'
        WHEN p.unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
        ELSE 'Premium'
    END AS price_tier,

    COUNT(*) AS total_products

FROM products AS p

GROUP BY price_tier

ORDER BY total_products DESC;
