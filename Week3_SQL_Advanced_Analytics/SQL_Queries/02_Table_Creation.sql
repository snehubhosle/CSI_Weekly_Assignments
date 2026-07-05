/*
 Project  : SQL Advanced Analytics
 Dataset  : Sample Superstore
 Author   : Snehal Bhosale
 Week     : 3
 Database : MySQL Workbench

 Objective:
 Create the staging table, import the raw dataset,
 convert date columns, and prepare the cleaned table.
*/

USE superstore_db;

-- Step 1 : Drop Existing Raw Table

DROP TABLE IF EXISTS superstore_raw;

-- Step 2 : Create Raw (Bronze) Table

CREATE TABLE superstore_raw
(
    Row_ID INT,
    Order_ID VARCHAR(30),
    Order_Date VARCHAR(20),
    Ship_Date VARCHAR(20),
    Ship_Mode VARCHAR(50),

    Customer_ID VARCHAR(30),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(30),

    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),

    Postal_Code VARCHAR(20),

    Region VARCHAR(30),

    Product_ID VARCHAR(30),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),

    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

-- Step 3 : Import Sample-Superstore.csv

/*
Import using:
Schemas
- superstore_db
- Tables
- Right Click superstore_raw
- Table Data Import Wizard
*/

-- Step 4 : Create Cleaned Table

DROP TABLE IF EXISTS superstore_clean;

CREATE TABLE superstore_clean AS

SELECT
    Row_ID,
    Order_ID,
    STR_TO_DATE(Order_Date,'%m/%d/%Y') AS Order_Date,
    STR_TO_DATE(Ship_Date,'%m/%d/%Y') AS Ship_Date,
    Ship_Mode,
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region,
    Product_ID,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_raw;

-- Step 5 : Create Performance Indexes

CREATE INDEX idx_customer_id
ON superstore_clean(Customer_ID);

CREATE INDEX idx_order_id
ON superstore_clean(Order_ID);

CREATE INDEX idx_product_id
ON superstore_clean(Product_ID);


-- Change Postal Code INT to VARCHAR

ALTER TABLE superstore_raw
MODIFY COLUMN Postal_Code VARCHAR(20);

ALTER TABLE superstore_clean
MODIFY COLUMN Postal_Code VARCHAR(20);