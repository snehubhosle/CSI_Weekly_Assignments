# Smart Fraud Detection Pipeline

### PySpark | Spark SQL | Azure Databricks | Delta Lake | Medallion Architecture

**Author:** Snehal A. Bhosale
**College:** Sanjivani College of Engineering, Kopargaon
**Internship:** Celebal Technologies – Data Engineering Internship
**Project Type:** Final Internship Project

---

## 1. Project Objective

To design and implement an end-to-end fraud detection data pipeline that processes account, transaction, and fraud-watchlist data using **PySpark and Spark SQL**.

The project follows the **Medallion Architecture (Bronze → Silver → Gold)** and demonstrates data ingestion, data cleaning, validation, enrichment, fraud detection, analytical processing, and visualization.

The second phase extends the pipeline to **Azure Databricks and Delta Lake** for scalable cloud-based processing and reliable data storage.

---

## 2. Problem Statement

Financial transaction systems generate large volumes of transaction data that may contain missing values, duplicates, invalid dates, incorrect amounts, inconsistent text, and suspicious accounts.

The objective of this project is to build a structured data pipeline that:

* Ingests raw financial data
* Identifies and handles data-quality issues
* Cleans and validates transaction data
* Enriches transactions with account information
* Matches transactions against a fraud watchlist
* Classifies transactions as **Fraud** or **Normal**
* Generates account-level and business-level fraud insights
* Stores processed data using Delta Lake
* Supports analytical queries using Spark SQL

---

# 3. Architecture

```text
                         RAW CSV DATA
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
          Accounts       Transactions    Fraud Watchlist
              │               │               │
              └───────────────┼───────────────┘
                              ▼
                    ┌───────────────────┐
                    │   BRONZE LAYER    │
                    │                   │
                    │ Raw Data Ingestion│
                    │ Audit / Lineage   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │   SILVER LAYER    │
                    │                   │
                    │ Cleaning          │
                    │ Validation        │
                    │ Deduplication     │
                    │ Type Casting      │
                    │ Date Validation   │
                    │ Data Enrichment   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │    GOLD LAYER     │
                    │                   │
                    │ Fraud Detection   │
                    │ Fraud / Normal    │
                    │ Risk Analysis     │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │  SPARK SQL / DQ   │
                    │                   │
                    │ Aggregations       │
                    │ Fraud Metrics      │
                    │ Account Analysis   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ VISUALIZATIONS    │
                    │                   │
                    │ Fraud vs Normal   │
                    │ Fraud Types       │
                    │ Top Accounts      │
                    │ Risk Analysis     │
                    └───────────────────┘
```

---

# 4. Technology Stack

| Technology         | Purpose                                 |
| ------------------ | --------------------------------------- |
| Python             | Programming and data processing         |
| PySpark            | Distributed data processing             |
| Spark SQL          | Analytical queries                      |
| Jupyter Notebook   | Initial development and analysis        |
| Azure Databricks   | Cloud-based Spark execution             |
| Delta Lake         | Reliable storage for Bronze/Silver/Gold |
| Pandas             | Result analysis                         |
| Matplotlib         | Data visualization                      |
| Azure Data Factory | Data engineering workflow experience    |
| MySQL Workbench    | SQL analysis and validation             |

---

# 5. Dataset

The project uses three realistic financial datasets.

## Accounts

| Column          | Description               |
| --------------- | ------------------------- |
| `account_id`    | Unique account identifier |
| `customer_name` | Customer name             |
| `account_type`  | Savings, Current, Salary  |
| `credit_limit`  | Account credit limit      |
| `branch`        | Bank branch               |

## Transactions

| Column       | Description                      |
| ------------ | -------------------------------- |
| `txn_id`     | Unique transaction identifier    |
| `account_id` | Associated account               |
| `txn_date`   | Transaction date                 |
| `amount`     | Transaction amount               |
| `merchant`   | Merchant or transaction location |

## Fraud Watchlist

| Column         | Description                  |
| -------------- | ---------------------------- |
| `account_id`   | Watchlisted account          |
| `fraud_type`   | Type of suspected fraud      |
| `flagged_date` | Date the account was flagged |

---

# 6. Dataset Quality Issues

The datasets intentionally contain realistic inconsistencies to demonstrate data-quality processing.

### Accounts

* Duplicate account IDs
* Missing account ID
* Extra whitespace
* Missing customer name
* Missing branch
* Negative credit limit

### Transactions

* Missing account ID
* Missing transaction date
* Invalid date formats
* Missing amount
* Negative amount
* Non-numeric amount
* Duplicate transaction
* Extra whitespace
* Orphan account IDs

### Fraud Watchlist

* Duplicate account
* Missing fraud type
* Invalid date format
* Extra whitespace
* Orphan account ID

These issues are handled during the **Silver layer**.

---

# 7. Medallion Architecture

## Bronze Layer

The Bronze layer stores the raw ingested datasets with minimal transformation.

### Responsibilities

* Raw data ingestion
* Preserve original information
* Track source data
* Create initial Delta tables in Databricks

### Bronze tables

```text
bronze_accounts
bronze_transactions
bronze_fraud_watchlist
```

---

# 8. Silver Layer

The Silver layer performs data cleaning, validation, and enrichment.

### Processing performed

* Remove duplicates
* Handle null values
* Trim whitespace
* Cast numeric columns
* Convert date columns
* Remove invalid transaction records
* Validate account IDs
* Handle orphan records
* Join transactions with account information

### Silver tables

```text
silver_accounts
silver_transactions
silver_fraud_watchlist
silver_enriched_transactions
```

The enriched transaction dataset combines transaction information with relevant account details.

---

# 9. Gold Layer

The Gold layer contains business-ready fraud detection results.

Transactions are matched with the fraud watchlist using:

```text
account_id
```

A transaction is classified as:

```text
Fraud
```

when its account exists in the fraud watchlist.

Otherwise:

```text
Normal
```

### Gold tables

```text
gold_fraud_transactions
gold_fraud_per_account
```

> A left join on `account_id` is used instead of a true Cartesian cross join. This avoids unnecessary row multiplication and is more appropriate for scalable fraud detection.

---

# 10. Fraud Detection Logic

The primary fraud detection rule is:

```text
IF transaction.account_id exists in fraud_watchlist
        ↓
      FRAUD
ELSE
      NORMAL
```

The Gold dataset contains additional information such as:

* Fraud type
* Flagged date
* Customer information
* Transaction amount
* Merchant
* Fraud flag

---

# 11. Data Quality Validation

The pipeline performs data-quality checks including:

* Null-value detection
* Duplicate detection
* Invalid date detection
* Invalid numeric-value detection
* Orphan-account detection
* Row-count validation
* Gold-layer validation

Example validation:

```python
assert gold_transactions.filter(
    col("account_id").isNull()
).count() == 0
```

The objective is to prevent invalid records from silently entering the final analytical layer.

---

# 12. Spark SQL Analytics

Spark SQL is used to generate business insights such as:

### Fraud vs Normal Transactions

```sql
SELECT
    fraud_flag,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM gold_fraud_transactions
GROUP BY fraud_flag;
```

### Fraud by Account

```sql
SELECT
    account_id,
    fraud_type,
    COUNT(*) AS fraud_transactions,
    SUM(amount) AS fraud_amount
FROM gold_fraud_transactions
WHERE fraud_flag = 'fraud'
GROUP BY account_id, fraud_type
ORDER BY fraud_amount DESC;
```

---

# 13. Azure Databricks and Delta Lake

The second phase of the project extends the Jupyter-based implementation to **Azure Databricks**.

The existing CSV datasets and processed Silver/Gold datasets are uploaded to Databricks and stored as Delta tables.

### Databricks Delta Architecture

```text
CSV
 │
 ▼
Azure Databricks
 │
 ├── Bronze Delta Tables
 │
 ├── Silver Delta Tables
 │
 └── Gold Delta Tables
```

### Delta tables

```text
bronze_accounts
bronze_transactions
bronze_fraud_watchlist

silver_accounts
silver_transactions
silver_fraud_watchlist
silver_enriched_transactions

gold_fraud_transactions
```

Delta Lake provides reliable table storage and supports features such as transaction history and incremental updates.

---

# 14. Delta Lake Features

The Databricks implementation demonstrates:

### Delta Table Storage

```python
df.write \
  .format("delta") \
  .mode("overwrite") \
  .saveAsTable("bronze_accounts")
```

### Table Metadata

```sql
DESCRIBE DETAIL gold_fraud_transactions;
```

### Transaction History

```sql
DESCRIBE HISTORY gold_fraud_transactions;
```

### Incremental MERGE

```sql
MERGE INTO gold_fraud_transactions AS target
USING new_fraud_transactions AS source
ON target.txn_id = source.txn_id

WHEN MATCHED THEN
    UPDATE SET *

WHEN NOT MATCHED THEN
    INSERT *;
```

This allows the pipeline to support incremental updates without blindly duplicating existing transactions.

---

# 15. Project Notebooks

```text
notebooks/
│
├── 01_Data_Analysis.ipynb
├── 02_Bronze_Layer_Ingestion.ipynb
├── 03_Silver_Layer_Cleaning.ipynb
├── 04_Gold_Fraud_Detection.ipynb
├── 05_Fraud_Analytics_and_Visualization.ipynb
└── 06_Databricks_Delta_Implementation.ipynb
```

### Notebook 1 — Data Analysis

* Load datasets
* Explore schema
* Analyze data quality
* Identify inconsistencies
* Understand dataset structure

### Notebook 2 — Bronze Layer

* Read raw CSV files
* Create raw Bronze datasets
* Preserve source data
* Prepare data for transformation

### Notebook 3 — Silver Layer

* Clean data
* Handle nulls
* Remove duplicates
* Validate dates and amounts
* Join account and transaction data

### Notebook 4 — Gold Fraud Detection

* Match transactions with fraud watchlist
* Classify Fraud/Normal
* Generate account-level fraud results

### Notebook 5 — Fraud Analytics

* Calculate fraud metrics
* Perform Spark SQL analysis
* Generate visualizations
* Extract business insights

### Notebook 6 — Databricks + Delta Lake

* Upload data to Azure Databricks
* Create Bronze Delta tables
* Create Silver Delta tables
* Create Gold Delta tables
* Execute Spark SQL
* Demonstrate Delta table metadata
* Demonstrate Delta history
* Demonstrate MERGE-based incremental processing

---

# 16. Project Folder Structure

```text
Smart-Fraud-Detection-Pipeline/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── data/
│   ├── accounts.csv
│   ├── transactions.csv
│   └── fraud_watchlist.csv
│
├── notebooks/
│   ├── 01_Data_Analysis.ipynb
│   ├── 02_Bronze_Layer_Ingestion.ipynb
│   ├── 03_Silver_Layer_Cleaning.ipynb
│   ├── 04_Gold_Fraud_Detection.ipynb
│   ├── 05_Fraud_Analytics_and_Visualization.ipynb
│   └── 06_Databricks_Delta_Implementation.ipynb
│
├── outputs/
│   ├── fraud_summary.csv
│   ├── fraud_by_type.csv
│   ├── top_fraud_accounts.csv
│   ├── fraud_by_merchant.csv
│   └── risk_summary.csv
│
├── visualizations/
│   ├── fraud_vs_normal.png
│   ├── fraud_by_type.png
│   ├── top_fraud_accounts.png
│   └── risk_distribution.png
│
└── docs/
    └── architecture_diagram.png
```

---

# 17. End-to-End Workflow

```text
1. Raw CSV Files
       ↓
2. Data Exploration
       ↓
3. Bronze Ingestion
       ↓
4. Data Cleaning
       ↓
5. Silver Transformation
       ↓
6. Account + Transaction Enrichment
       ↓
7. Fraud Watchlist Matching
       ↓
8. Gold Fraud Classification
       ↓
9. Spark SQL Analytics
       ↓
10. Visualizations
       ↓
11. Azure Databricks
       ↓
12. Delta Lake Tables
       ↓
13. Delta MERGE / History
```

---

# 18. Key Business Insights

The final pipeline provides insights such as:

* Total number of transactions
* Number of fraudulent transactions
* Number of normal transactions
* Fraud rate
* Total fraudulent transaction amount
* Fraud by account
* Fraud by fraud type
* Fraud by merchant
* High-risk accounts
* Transaction risk distribution

Actual values should be updated in this section using the final output generated by Notebook 5 and Databricks.

---

# 19. Visualizations

The project generates visualizations including:

1. Fraud vs Normal Transactions
2. Fraud by Type
3. Top Fraudulent Accounts
4. Risk Distribution
5. Fraud by Merchant

These visualizations help convert processed transaction data into actionable business insights.

---

# 20. Data Engineering Concepts Demonstrated

This project demonstrates practical knowledge of:

* ETL / ELT pipelines
* Medallion Architecture
* PySpark
* Spark SQL
* Data cleaning
* Data validation
* Schema handling
* Data enrichment
* Joins
* Aggregations
* Delta Lake
* Azure Databricks
* Incremental processing
* MERGE operations
* Data quality checks
* Business analytics
* Data visualization

---

# 21. Future Scope

The project can be further enhanced by:

* Implementing machine-learning-based fraud prediction
* Adding real-time fraud detection using Spark Structured Streaming
* Connecting Gold tables to Power BI
* Automating the pipeline using Azure Data Factory or Databricks Workflows
* Adding automated data-quality monitoring
* Implementing advanced risk scoring
* Integrating external fraud intelligence sources

---

# 22. Conclusion

The **Smart Fraud Detection Pipeline** demonstrates an end-to-end data engineering solution for processing and analyzing financial transaction data.

The project uses the **Medallion Architecture** to separate raw, cleaned, and business-ready data into Bronze, Silver, and Gold layers. PySpark is used for scalable data processing, while Spark SQL is used for analytical queries and business insights.

The Azure Databricks implementation extends the pipeline into a cloud-based environment, while Delta Lake provides reliable storage, transaction history, and incremental data-processing capabilities.

Overall, the project demonstrates how raw financial data can be transformed into a reliable fraud detection and analytics solution using modern data engineering technologies.

---

## Author

**Snehal A. Bhosale**
Sanjivani College of Engineering, Kopargaon
Celebal Technologies – Data Engineering Internship

---

## Project Title

**Smart Fraud Detection Pipeline using PySpark, Spark SQL, Azure Databricks and Delta Lake**
