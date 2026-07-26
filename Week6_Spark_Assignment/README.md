# Apache Spark Data Engineering Assignment No. 6
## Apache Spark Architecture, Data Processing & Performance Optimization using PySpark

### Author
**Snehal A. Bhosale**

### College
**Sanjivani College of Engineering, Kopargaon – 423603**

### E-mail
**snehalbhosale1807@gmail.com**

---

# Overview

This repository contains my **Week-6 Data Engineering Internship Assignment** completed using **Apache Spark (PySpark)**. The main objective of this assignment is to understand how Apache Spark processes large datasets efficiently using distributed computing.

The assignment covers Spark Architecture, DataFrame operations, transformations, actions, lazy evaluation, schema handling, optimized storage formats, and Spark performance concepts. It also demonstrates how to build a simple data processing pipeline using PySpark.

---

# Objectives

The main objectives of this assignment are:

- Understand Apache Spark Architecture
- Learn the roles of Driver, Cluster Manager, and Executors
- Understand Lazy Evaluation and DAG (Lineage Graph)
- Read CSV and Parquet files using Spark
- Perform DataFrame transformations and filtering
- Select required columns
- Rename columns and cast data types
- Add new calculated columns
- Handle missing (null) values
- Understand Predicate Pushdown and Shuffle operations
- Compare CSV and Parquet file formats
- Build a simple Spark data pipeline
- Save processed data in CSV and Parquet formats
- Follow Spark best practices for handling large datasets

---

# Technologies Used

- Apache Spark (PySpark)
- Python
- Google Colab
- Jupyter Notebook
- Spark SQL

---

# Dataset

**Dataset Name:** Sample Superstore Dataset

The Sample Superstore dataset is commonly used for data analytics and business intelligence practice. It contains sales transactions from a retail store and includes customer, product, shipping, and profit information.

### Main Columns

- Order ID
- Order Date
- Ship Date
- Customer Name
- Segment
- Region
- State
- Category
- Sub-Category
- Product Name
- Sales
- Quantity
- Discount
- Profit

---

# Project Structure

```
Week6_Spark_Assignment/

│
├── data/
│     Sample - Superstore.csv
│
├── output/
│   Week6_Spark_Assignment_Implementation_output     
│
│
├── Week6_Spark_Assignment.ipynb
│
├── README.md
```

---

# Tasks Performed

During this assignment, the following tasks were completed:

- Created a Spark Session
- Loaded the CSV dataset
- Displayed the dataset and schema
- Selected required columns
- Filtered records using conditions
- Renamed columns
- Added a new calculated column
- Handled null values
- Applied Spark transformations and actions
- Saved processed data as CSV
- Saved processed data as Parquet
- Read data back from Parquet
- Compared CSV and Parquet performance
- Studied Spark Architecture and execution process
- Learned Spark optimization techniques

---

# Spark Concepts Covered

## Spark Architecture

- Driver
- Cluster Manager
- Executors
- Tasks
- Jobs

## Data Processing

- Reading CSV files
- Reading Parquet files
- DataFrame Operations
- Filtering
- Selecting Columns
- Renaming Columns
- Creating New Columns
- Handling Null Values

## Spark Optimization

- Lazy Evaluation
- DAG (Lineage Graph)
- Predicate Pushdown
- Shuffle Operations
- Narrow Transformations
- Wide Transformations

---

# Sample Operations

Some operations performed during this assignment include:

- Reading CSV files
- Reading Parquet files
- Filtering records
- Selecting columns
- Renaming columns
- Creating calculated columns
- Removing null values
- Saving output files
- Viewing execution plans
- Comparing storage formats

---

# CSV vs Parquet Comparison

| Feature | CSV | Parquet |
|----------|------|----------|
| Storage Format | Row-based | Column-based |
| File Size | Larger | Smaller |
| Compression | No | Yes |
| Query Performance | Slower | Faster |
| Schema Support | Limited | Built-in |
| Best Use Case | Data Exchange | Analytics & Big Data |

---

# Key Learning

Through this assignment, I learned how Spark distributes work across multiple machines to process large datasets efficiently. I also understood the importance of lazy evaluation, how Spark builds a DAG before execution, and why Parquet is preferred over CSV for analytical workloads.

Working with DataFrames helped me understand how transformations and actions work together. I also learned how filtering data early, using efficient storage formats, and avoiding unnecessary operations can improve Spark application performance.

---

# Best Practices Followed

- Used DataFrames instead of RDDs
- Enabled automatic schema detection
- Filtered data before processing
- Used Parquet for optimized storage
- Used `.show()` instead of `.collect()` for data exploration
- Saved processed data using overwrite mode
- Kept code clean and modular

---

# Results

The assignment was completed successfully by implementing all the required Spark concepts and DataFrame operations.

Successfully performed:

- CSV data loading
- Schema handling
- Filtering and selection
- DataFrame transformations
- Column modifications
- Null value handling
- CSV output generation
- Parquet output generation
- Performance comparison
- Spark Architecture study

---

# Learning Outcomes

After completing this assignment, I am able to:

- Understand Apache Spark Architecture
- Explain Driver, Cluster Manager, and Executors
- Work with Spark DataFrames
- Apply transformations and actions
- Build simple Spark data pipelines
- Handle missing values
- Compare CSV and Parquet formats
- Understand Spark performance optimization concepts
- Use Spark efficiently for large-scale data processing

---

# Conclusion

This assignment provided practical experience with Apache Spark and PySpark for distributed data processing. It helped me understand how Spark executes jobs efficiently using lazy evaluation and DAG-based execution. I also learned the importance of choosing the right file format, applying efficient transformations, and following best practices while processing large datasets.

Overall, this assignment strengthened my understanding of Spark fundamentals and improved my practical skills in building scalable data processing pipelines using PySpark.

---

## Thank You
**Snehal A. Bhosale**
**B.Tech Computer Engineering**
**Sanjivani College of Engineering, Kopargaon**
**Celebal Technologies – Data Engineering Internship**
````
