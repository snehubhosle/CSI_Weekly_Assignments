/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3

 Objective:
 Validate imported data before performing analysis.
*/

USE superstore_db;

-- Validation 1 : Verify Imported Records

SELECT
    COUNT(*) AS total_records
FROM superstore_raw;

-- Validation 2 : Preview Dataset

SELECT *
FROM superstore_raw
LIMIT 10;

-- Validation 3 : Verify Table Structure

DESCRIBE superstore_raw;


-- Validation 4 : Check NULL Values

SELECT
    SUM(Customer_ID IS NULL) AS null_customer_id,
    SUM(Customer_Name IS NULL) AS null_customer_name,
    SUM(Order_ID IS NULL) AS null_order_id,
    SUM(Product_ID IS NULL) AS null_product_id,
    SUM(Sales IS NULL) AS null_sales,
    SUM(Profit IS NULL) AS null_profit
FROM superstore_raw;

-- Validation 5 : Distinct Records

SELECT
    COUNT(DISTINCT Customer_ID) AS total_customers,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Product_ID) AS total_products
FROM superstore_raw;

-- Validation 6 : Sales Statistics

SELECT
    ROUND(SUM(Sales),2) AS total_sales,
    ROUND(AVG(Sales),2) AS average_sales,
    ROUND(MAX(Sales),2) AS highest_sale,
    ROUND(MIN(Sales),2) AS lowest_sale
FROM superstore_raw;

-- Validation 7 : Duplicate Order Analysis

SELECT
    Order_ID,
    COUNT(*) AS total_records
FROM superstore_raw
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY total_records DESC;

-- Validation 8 : Verify Date Conversion

SELECT
    Order_Date,
    Ship_Date
FROM superstore_clean
LIMIT 10;

-- Validation 9 : Verify Clean Table Structure

DESCRIBE superstore_clean;

-- Validation 10 : Validate Date Range

SELECT
    MIN(Order_Date) AS first_order,
    MAX(Order_Date) AS last_order
FROM superstore_clean;

-- Validation 11 : Invalid Date Check

SELECT *
FROM superstore_clean
WHERE Order_Date IS NULL
OR Ship_Date IS NULL;

-- Validation 12 : Raw vs Clean Record Count

SELECT
    (SELECT COUNT(*) FROM superstore_raw) AS raw_records,
    (SELECT COUNT(*) FROM superstore_clean) AS clean_records;

-- Validation 13 : Verify Table Definition

SHOW CREATE TABLE superstore_clean;

-- Validation 14 : Verify Indexes

SHOW INDEXES
FROM superstore_clean;

-- Validation 15 : Query Execution Plan
EXPLAIN
SELECT *
FROM superstore_clean
WHERE Customer_ID='CG-12520';

-- Validation 16 : Verify Database

SELECT DATABASE() AS current_database;

-- Validation 17 : Verify MySQL Version

SELECT VERSION() AS mysql_version;

-- Validation 18 : Show Available Tables

SHOW TABLES;

-- Validation 19 : Record Count Per Table

SELECT
    'superstore_raw' AS table_name,
    COUNT(*) AS total_rows
FROM superstore_raw
UNION ALL
SELECT
    'superstore_clean',
    COUNT(*)
FROM superstore_clean;

