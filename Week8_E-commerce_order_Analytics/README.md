# E-Commerce Order Analytics System

**Assignment No.: 08**

**Title:** E-Commerce Order Analytics System

**Author:** Snehal A. Bhosale  
**College:** Sanjivani College of Engineering, Kopargaon  
**Email:** snehalbhosale1807@gmail.com  
**Course/Program:** B.Tech in Computer Engineering  
**Database:** MySQL / SQLite  
**Primary Tools:** Python, Pandas, MySQL Workbench, SQLite  
**Project Type:** Data Analytics / SQL / Python

---

## 1. Project Overview

The **E-Commerce Order Analytics System** is an end-to-end data analytics project developed using **Python and SQL**.

The project processes e-commerce data through multiple stages:

- Dataset generation
- Data cleaning and validation using Pandas
- Relational database creation
- SQL-based business analytics
- Window functions and CTEs
- Customer cohort and retention analysis
- Customer segmentation
- Command-line reporting
- Edge-case handling

The system is designed to transform raw e-commerce datasets into meaningful business insights such as revenue trends, customer value, product performance, retention, and purchasing behavior.

---

## 2. Objective

The main objective of this project is to design and develop an end-to-end e-commerce analytics system that combines **Python and SQL** to process, clean, validate, analyze, and report e-commerce order data.

The project focuses on:

- Data quality and validation
- Relational data integrity
- Business-oriented SQL analytics
- Customer behavior analysis
- Revenue analysis
- Cohort and retention analysis
- Command-line reporting

---

## 3. Technologies Used

| Technology | Purpose |
|---|---|
| Python | Data generation, cleaning and CLI reporting |
| Pandas | Data cleaning and validation |
| Faker / Random | Dataset generation |
| MySQL | Relational database and SQL analytics |
| MySQL Workbench | Database management and query execution |
| SQLite | CLI reporting database |
| CSV | Data storage and exchange |
| GitHub | Project version control and submission |

---

## 4. Project Architecture

```text
                    RAW E-COMMERCE DATA
                            |
                            v
                  +-------------------+
                  | Python / Pandas   |
                  | Data Cleaning     |
                  | Data Validation   |
                  +-------------------+
                            |
                            v
                    CLEANED CSV FILES
                            |
             +--------------+--------------+
             |                             |
             v                             v
       MySQL Database                SQLite Database
             |                             |
             v                             v
       SQL Analytics                 Python CLI Tool
             |                             |
             |                             v
             |                      Business Reports
             |                             |
             +--------------+--------------+
                            |
                            v
                     Sample Outputs
```

---

## 5. Dataset

The project uses four related datasets:

```text
customers
products
orders
order_items
```

### Customers

Contains customer information such as:

- Customer ID
- Customer Name
- Email
- Registration Date
- Customer Type

### Products

Contains product information such as:

- Product ID
- Product Name
- Category
- Subcategory
- Cost Price

### Orders

Contains order-level information such as:

- Order ID
- Customer ID
- Order Date
- Order Status
- Region Code

### Order Items

Contains individual items belonging to an order:

- Item ID
- Order ID
- Product ID
- Quantity
- Unit Price
- Discount Percentage

---

## 6. Data Quality and Inconsistencies

The raw datasets contain intentional data-quality issues to simulate realistic e-commerce data.

Examples include:

- Missing values
- Duplicate records
- Invalid data types
- Invalid dates
- Mismatched IDs
- Referential integrity issues

These inconsistencies were handled during the Python/Pandas data-cleaning phase.

---

## 7. Data Cleaning Using Pandas

The raw CSV files were loaded into a Python Jupyter Notebook using Pandas.

The cleaning process included:

1. Loading the datasets.
2. Checking dataset dimensions.
3. Inspecting data types.
4. Detecting missing values.
5. Removing duplicate records.
6. Converting columns to appropriate data types.
7. Validating date fields.
8. Checking primary-key uniqueness.
9. Validating relationships between tables.
10. Removing or correcting invalid records.
11. Exporting cleaned datasets.

### Cleaned datasets

```text
data/cleaned/
├── customers_clean.csv
├── products_clean.csv
├── orders_clean.csv
└── order_items_clean.csv
```

---

## 8. Database Schema

The cleaned datasets were loaded into the `ecommerce_analytics` database.

```text
customers
    |
    | 1
    |
    | M
orders
    |
    | 1
    |
    | M
order_items
    |
    | M
    |
    | 1
products
```

### Primary Keys

```text
customers.customer_id
products.product_id
orders.order_id
order_items.item_id
```

### Foreign Keys

```text
orders.customer_id
        → customers.customer_id

order_items.order_id
        → orders.order_id

order_items.product_id
        → products.product_id
```

This structure maintains referential integrity between the four tables.

---

## 9. SQL Analytics

The project implements SQL queries covering basic, intermediate, and advanced analytics.

### Basic and Intermediate Analysis

The following analyses were implemented:

- Total revenue per category
- Top 10 customers by order value
- Monthly order count
- Customers without delivered orders
- Products with more returns than purchases
- Return rate by category

---

## 10. Window Functions

Window functions were used for advanced customer and product analysis.

Implemented operations include:

- Running revenue totals
- `DENSE_RANK()`
- `LAG()`
- Customer order-gap analysis
- At-risk customer identification

Example:

```sql
DENSE_RANK() OVER (
    PARTITION BY category
    ORDER BY total_revenue DESC
)
```

This ranks products based on revenue within each category.

---

## 11. Common Table Expressions

CTEs were used to simplify multi-step analytical queries.

The project uses CTEs for:

- Monthly customer revenue
- Customer value calculation
- Customer quartile analysis
- Year-over-year revenue comparison
- First and latest purchase category
- Cohort analysis

---

## 12. Customer Segmentation

Customers were analyzed using purchase and revenue-based metrics.

The project includes:

### Revenue Segmentation

```text
High
Medium
Low
```

### Customer Value Quartiles

```text
Platinum
Gold
Silver
Bronze
```

These segments help identify high-value and low-value customer groups.

---

## 13. Cohort and Retention Analysis

Customer cohorts are created based on the customer's first/registration purchase period.

The analysis measures customer activity across:

```text
Month 0
Month 1
Month 2
Month 3
```

This helps identify:

- New customers
- Returning customers
- Retained customers
- Customer drop-off
- Retention trends

---

## 14. Year-over-Year Revenue Analysis

Monthly revenue is compared with the corresponding previous-year period.

The analysis calculates:

```text
Current Revenue
Previous-Year Revenue
YoY Growth Percentage
```

This helps identify revenue growth or decline over time.

---

## 15. Product Purchase Analysis

The project also identifies frequently purchased product combinations.

The analysis determines which products are commonly purchased together in the same order.

This can help with:

- Product bundling
- Cross-selling
- Recommendation systems
- Marketing campaigns

---

## 16. Command-Line Reporting Tool

A Python command-line reporting tool was developed using `sqlite3`.

The CLI provides dynamic business reports directly from the terminal.

### Supported Reports

```text
revenue
top_customers
monthly_summary
retention
```

### Revenue Report

```bash
python scripts/report_cli.py --report revenue --start-date 2026-01-01 --end-date 2026-12-31
```

### Top Customers Report

```bash
python scripts/report_cli.py --report top_customers --start-date 2026-01-01 --end-date 2026-12-31
```

### Monthly Summary

```bash
python scripts/report_cli.py --report monthly_summary --start-date 2026-01-01 --end-date 2026-12-31
```

### Retention Report

```bash
python scripts/report_cli.py --report retention --start-date 2026-01-01 --end-date 2026-12-31
```

### Help

```bash
python scripts/report_cli.py --help
```

---

## 17. CLI Features

The reporting tool supports:

- Command-line arguments
- Report selection
- Start-date filtering
- End-date filtering
- SQLite database connection
- Automatic database initialization
- Clean tabular output
- Revenue calculations
- Customer analysis
- Retention analysis
- Empty-result handling
- Invalid-input validation
- Database error handling

---

## 18. Edge-Case Handling

The system was designed to handle important edge cases.

Test cases include:

```text
✓ Invalid report name
✓ Invalid date format
✓ Start date greater than end date
✓ Empty result set
✓ Missing CSV file
✓ Database connection error
✓ Zero orders
✓ Single customer
```

The CLI displays appropriate error or warning messages instead of terminating unexpectedly.

---

## 19. Project Structure

```text
ecommerce-analytics-system/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── customers_clean.csv
│       ├── products_clean.csv
│       ├── orders_clean.csv
│       └── order_items_clean.csv
│
├── notebooks/
│   └── data_cleaning.ipynb
│
├── scripts/
│   └── report_cli.py
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_basic_intermediate.sql
│   ├── 03_window_functions.sql
│   ├── 04_cte_cohort_analysis.sql
│   └── 05_advanced_analysis.sql
│
├── output/
│   └── sample_reports/
│       ├── revenue_report.txt
│       ├── top_customers_report.txt
│       ├── monthly_summary_report.txt
│       └── retention_report.txt
│
└── README.md
```

---

## 20. How to Run the Project

### Step 1: Clone the Repository

```bash
git clone <your-github-repository-url>
```

### Step 2: Open the Project

Open the project in VS Code.

### Step 3: Install Required Python Libraries

```bash
pip install pandas faker
```

The CLI itself primarily uses Python standard-library modules such as `sqlite3`, `argparse`, and `csv`.

### Step 4: Run the CLI

Example:

```bash
python scripts/report_cli.py --report revenue --start-date 2026-01-01 --end-date 2026-12-31
```

### Step 5: Execute SQL Queries

Open the SQL files in MySQL Workbench and execute them in the following order:

```text
01_schema.sql
02_basic_intermediate.sql
03_window_functions.sql
04_cte_cohort_analysis.sql
05_advanced_analysis.sql
```

---

## 21. Sample Reports

Generated CLI reports are stored in:

```text
output/sample_reports/
```

Available sample outputs include:

```text
revenue_report.txt
top_customers_report.txt
monthly_summary_report.txt
retention_report.txt
```

These outputs demonstrate the execution of the Python command-line reporting system.

---

## 22. Key Business Insights

The system can be used to identify:

- Highest-revenue product categories
- Top customers by lifetime/order value
- Monthly revenue trends
- Customer retention patterns
- High-value customer segments
- At-risk customers
- Products with high return rates
- Frequently purchased product combinations
- Year-over-year revenue changes

---

## 23. Learning Outcomes

This project demonstrates practical knowledge of:

- Python programming
- Pandas data cleaning
- CSV processing
- Data validation
- Relational database design
- Primary and foreign keys
- SQL joins
- Aggregations
- CTEs
- Window functions
- Ranking functions
- Cohort analysis
- Customer segmentation
- Retention analysis
- SQLite
- Command-line application development
- Error and edge-case handling

---

## 24. Conclusion

The **E-Commerce Order Analytics System** provides an end-to-end solution for processing and analyzing e-commerce order data.

Python and Pandas were used for data preparation and validation, while MySQL was used for relational database management and advanced SQL analytics. A SQLite-based Python CLI was implemented to provide dynamic business reports from the command line.

The project demonstrates how raw e-commerce data can be transformed into structured information and meaningful business insights using Python and SQL.

---

## 25. Author

**Snehal A. Bhosale**

B.Tech Computer Engineering  
Sanjivani College of Engineering, Kopargaon

**Email:** snehalbhosale1807@gmail.com

---

## 26. Assignment Information

```text
Assignment No. : 08
Title          : E-Commerce Order Analytics System
Author         : Snehal A. Bhosale
College        : Sanjivani College of Engineering, Kopargaon
Database       : ecommerce_analytics
SQL Tool       : MySQL Workbench
Programming    : Python
Analytics      : Pandas + SQL
CLI Database   : SQLite
```