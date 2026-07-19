# Assignment No-5: Apache Spark Fundamentals and Data Processing using PySpark

**Author:** Snehal A. Bhosale  
**College:** Sanjivani College of Engineering, Kopargaon  

## Overview

This repository contains my Week-5 Data Engineering internship assignment implemented using **Apache Spark and PySpark DataFrame APIs**.

The project demonstrates an end-to-end data processing workflow on the **Sample Superstore Dataset**, including data loading, exploration, cleaning, transformation, aggregation, business analysis, and ETL pipeline development.

The notebook also covers Spark concepts and provides solutions for **Q1–Q15** related to Spark DataFrames, transformations, aggregations, null handling, shuffle operations, and data processing techniques.

---

## Project Structure

```

Week5_Spark_Data_Processing/

│── Dataset/
│   └── Sample - Superstore.csv
│
│── notebooks/
│   └── Week5_PySpark_Production_Notebook.ipynb
│
│
│── README.md
│
│── requirements.txt

````

---

## Technologies Used

- Python
- Apache Spark (PySpark)
- Jupyter Notebook
- VS Code
- Spark DataFrame API

---

## Key Implementation Steps

The notebook includes:

- Spark environment setup
- Dataset loading and validation
- Data exploration and profiling
- Data quality assessment
- Duplicate and null value handling
- Data cleaning and transformation
- Filtering and aggregation operations
- GroupBy analysis
- Spark shuffle and transformation concepts
- Business insights generation
- Final robust ETL processing pipeline

---

## Assignment Coverage (Q1–Q15)

The notebook covers:

- Limitations of MapReduce and advantages of Spark
- In-memory computing
- DataFrame duplicate removal
- Filtering and grouping operations
- Null value handling using `.na.drop()` and `.na.fill()`
- Aggregation using `agg()`
- DataFrame immutability
- Timestamp conversion
- Shuffle and wide transformations
- Schema inference challenges
- Complete Spark data processing pipeline

---

## Requirements

Prerequisites:

- Java 11+
- Python 3.8+
- Apache Spark
- PySpark

Install dependencies:

```bash
pip install pyspark
pip install pandas
````

---

## How to Run

1. Clone this repository.

2. Place the dataset inside:

```
Dataset/Sample - Superstore.csv
```

3. Open:

```
notebooks/Week5_PySpark_Production_Notebook.ipynb
```

using Jupyter Notebook or VS Code.

4. Run notebook cells sequentially.

5. Generated outputs will be stored in:

```
Output/
```

---

## Final ETL Pipeline

The notebook implements a complete Spark processing pipeline:

```
Load Dataset
      ↓
Schema Validation
      ↓
Data Quality Check
      ↓
Data Cleaning
      ↓
Null Handling
      ↓
Duplicate Removal
      ↓
Data Transformation
      ↓
Aggregation
      ↓
Business Analysis
      ↓
Export Results
```

---

## Learning Outcomes

Through this assignment, I learned:

* Apache Spark architecture and DataFrame operations
* Distributed data processing concepts
* Data cleaning and transformation techniques
* Aggregation and grouping operations
* Shuffle and wide transformation concepts
* ETL pipeline development using PySpark
* Generating business insights from large datasets

---

## Conclusion

This project demonstrates how Apache Spark can be used for scalable data processing and analytics. The implemented workflow follows a structured data engineering approach by combining data cleaning, transformation, analysis, and ETL pipeline development using PySpark.

---

## Author

**Snehal A. Bhosale**
Computer Engineering Student
Sanjivani College of Engineering, Kopargaon

