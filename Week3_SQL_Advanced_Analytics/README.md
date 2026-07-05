### **SQL Advanced Analytics using Superstore Dataset**



##### **Overview**

This repository contains **Week 3** of my **CSI Data Engineering
Internship** assignment. The objective is to apply advanced SQL
concepts---including **Subqueries, Common Table Expressions (CTEs), and
Window Functions**---to analyze the **Sample Superstore** dataset and
generate meaningful business insights.

The project follows a layered data engineering workflow where raw data
is imported into a staging table, validated, cleaned, transformed into
business tables, and finally analyzed using advanced SQL techniques.



##### **Dataset**

* **Source:** Sample Superstore Dataset (CSV)
* **Records:** 9,994
* **Fields:** Order ID, Order Date, Ship Date, Customer ID, Customer
Name, Segment, Region, Product ID, Category, Sub-Category, Sales,
Quantity, Discount, Profit

##### 

##### **Tech Stack**

Tool              Purpose

\---

MySQL 8.0+        Database Engine
MySQL Workbench   SQL Development
GitHub            Version Control

> \*\*Note:\*\* Window functions (`ROW\_NUMBER()`, `RANK()`, `DENSE\_RANK()`)
> require \*\*MySQL 8.0 or later\*\*.



##### **Repository Structure**


Week-3\_SQL\_Advanced\_Analytics

│

├── Dataset

│      Sample - Superstore.csv

│

├── SQL

│      01\_Database\_Setup.sql

│      02\_Table\_Creation.sql

│      03\_Data\_Validation.sql

│      04\_Subqueries.sql

│      05\_CTEs.sql

│      06\_Window\_Functions.sql

│      07\_Final\_Query.sql

│      08\_Customer\_Sales\_Insights.sql

│      09\_Bonus\_Queries.sql

│

└── Project\_Report.pdf

├── README.md



##### **Execution Order**



Run the SQL files in the following order:

1. 01\_Database\_Setup.sql
2. 02\_Table\_Creation.sql
3. 03\_Data\_Validation.sql
4. 04\_Create\_Business\_Tables.sql
5. 05\_Subqueries.sql
6. 06\_CTEs.sql
7. 07\_Window\_Functions.sql
8. 08\_Final\_Combined\_Query.sql
9. 09\_Customer\_Sales\_Insights.sql



##### **Project Workflow**


CSV Dataset
      │
      ▼
superstore\_raw (Staging Layer)
      │
      ▼
Data Validation
      │
      ▼
superstore\_clean (Clean Layer)
      │
      ▼
Business Tables
(Customers, Orders, Products)
      │
      ▼
Advanced SQL Analysis
(Subqueries, CTEs, Window Functions)
      │
      ▼
Customer Sales Insights




##### **SQL Scripts**



###### **01\_Database\_Setup.sql**

Creates the project database and selects it.



###### **02\_Table\_Creation.sql**

Creates the raw staging table, imports the dataset, validates records,
and creates the cleaned table with proper DATE columns.



###### **03\_Data\_Validation.sql**

Performs row count, NULL check, duplicate analysis, statistics, index
verification, and execution plan analysis.



###### **04\_Create\_Business\_Tables.sql**

Creates normalized `customers`, `orders`, and `products` tables using
`SELECT DISTINCT` and creates indexes.



###### **05\_Subqueries.sql**

Implements scalar, correlated, and nested subqueries for customer and
sales analysis.



###### **06\_CTEs.sql**

Uses Common Table Expressions to simplify customer-level aggregations
and reporting.



###### **07\_Window\_Functions.sql**

Implements `ROW\_NUMBER()`, `RANK()`, `DENSE\_RANK()`, `LAG()`, `NTILE()`,
and running totals.



###### **08\_Final\_Combined\_Query.sql**

Combines JOINs, CTEs, and Window Functions into professional analytical
reports.
---



###### **09\_Customer\_Sales\_Insights.sql**

Answers business questions including: - Top 5 customers - Bottom 5
customers - One-time customers - Above-average customers - Highest order
value - Region-wise and Segment-wise analysis



##### **Key SQL Concepts**

* Data Validation
* Data Cleaning
* Table Normalization
* Aggregate Functions
* JOINs
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* CASE Expressions
* Indexing
* Query Optimization



##### **Troubleshooting**



If window functions return syntax errors:
SELECT VERSION();

Ensure the server version is **MySQL 8.0+**.



##### **Learning Outcomes**

* SQL Data Cleaning
* Data Validation
* Table Normalization
* Advanced SQL Queries
* Customer Sales Analytics
* Business Reporting
* SQL Performance Optimization


# Author

**Snehal Bhosale**

B.Tech Computer Engineering

Sanjivani College of Engineering, Kopargaon

Celebal Technologies Intern

Email: snehalbhosale1807@gmail.com

