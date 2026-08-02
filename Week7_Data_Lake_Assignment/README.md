# Assignment No:07
# Delta Lake MERGE Implementation — Incremental Data Processing

**Author:** Snehal A. Bhosale

**College:** Sanjivani College of Engineering, Kopargaon – 423603

**Email:** snehalbhosale1807@gmail.com

## Objective

To understand Delta Lake fundamentals by implementing an incremental data processing pipeline using the MERGE operation. The assignment covers loading data into a Delta table, data cleaning, simulating incremental data, applying UPSERT (Update + Insert) using MERGE, implementing SCD Type 1 and Type 2, validating the final dataset, and demonstrating Delta Lake's reliability features such as time travel and transaction history.

## Dataset

**Sample Superstore Dataset** — a retail sales dataset containing order, customer, product, and sales information.

## Technology Used

- Apache Spark (PySpark) 3.5.1
- Delta Lake 3.2.0
- Python
- Google Colab / Jupyter Notebook
- Spark SQL
- CSV File Format
- Delta Table

## Implementation Steps

1. **Install Required Libraries** — Install PySpark, Delta Lake, and Java dependencies.
2. **Import Libraries** — Import Spark session, functions, and Delta Lake modules.
3. **Initialize SparkSession with Delta Lake** — Configure Spark to support Delta extensions.
4. **Upload and Load Dataset** — Load the Sample Superstore CSV into a Spark DataFrame.
5. **Explore Dataset** — Inspect schema, row count, and column count.
6. **Data Cleaning** — Remove duplicate records and drop rows with null values.
7. **Validate Cleaned Data** — Check for duplicate Order IDs and remaining null values.
8. **Create Master Dataset** — Take a fixed 80% subset (sorted for reproducibility) as the master dataset.
9. **Create Incremental Dataset** — Take the remaining 20% as the incremental dataset.
10. **Create Delta Table** — Write the master dataset to a Delta table.
11. **Simulate Incremental Changes** — Modify existing records and add new records to simulate real-world updates.
12. **Perform MERGE Operation (SCD Type 1)** — Update matched records in place and insert new records.
13. **Read Updated Delta Table** — Confirm the merge was applied correctly.
14. **Validate Results** — Check final row count, duplicates, and null values.
15. **Display Final Dataset Summary** — Show total records, unique orders, and unique customers.
16. **SCD Type 2 Schema Update** — Add `is_current`, `effective_date`, and `end_date` columns to support historical tracking.
17. **SCD Type 2 MERGE** — Expire changed records (`is_current = false`) and insert new versions instead of overwriting.
18. **SCD Type 2 Validation** — Show old and new versions of an updated record side by side.
19. **Delta Time Travel** — Query an earlier version of the Delta table using `versionAsOf`.
20. **Transaction History** — Use `DESCRIBE HISTORY` to view the Delta Lake audit log.
21. **Idempotency Check** — Re-run the merge to confirm no duplicate records are created.

## Key Concepts Demonstrated

| Concept | Description |
|---|---|
| **MERGE (UPSERT)** | Updates matched records and inserts unmatched ones in a single operation. |
| **SCD Type 1** | Overwrites old values with new ones; no history is kept. |
| **SCD Type 2** | Preserves history by expiring old records and inserting new versioned rows. |
| **Time Travel** | Allows querying the Delta table as it existed at a previous version. |
| **Transaction History** | Delta Lake automatically logs every write operation for auditing. |
| **Idempotency** | Re-running the same merge does not create duplicate or inconsistent data. |

## Results

- **Total Records After Merge:** 9,997
- **Unique Orders:** 5,012
- **Unique Customers:** 796
- **Duplicate Row IDs After Merge:** 0
- **Null Values After Merge:** 0

## Folder Structure

```
delta-lake-assignment/
│
├── data/
│   ├── customer_master.csv
│   └── customer_incremental.csv
│
├── notebooks/
│   └── delta_scd_assignment.ipynb
│
├── screenshots/
│   ├── data_loading/
│   ├── data_cleaning/
│   ├── scd1/
│   ├── scd2/
│   ├── validation/
│   └── final_output/
│
├── report/
│   └── assignment_summary.pdf (optional)
│
└── README.md
```

## How to Run

1. Open `notebooks/delta_scd_assignment.ipynb` in Google Colab or Jupyter Notebook.
2. Run all cells in order from top to bottom.
3. When prompted, upload `Sample - Superstore.csv`.
4. All intermediate files (`customer_master.csv`, `customer_incremental.csv`) and the Delta table (`delta/superstore`) will be generated automatically during execution.

## Conclusion

In this assignment, the Sample Superstore dataset was loaded into a Delta table and cleaned by removing duplicate and null records. A fixed master and incremental dataset were created to keep the workflow reproducible. Using Delta Lake's MERGE operation, an SCD Type 1 upsert was first performed to update existing records and insert new ones. This was then extended to SCD Type 2, where changed records were preserved as historical versions instead of being overwritten, giving a full change history. Delta Lake's time travel feature and transaction history (`DESCRIBE HISTORY`) were used to verify past table states, and an idempotency check confirmed that re-running the merge did not create duplicate records. Overall, this implementation demonstrates a complete, reliable, and production-style incremental data pipeline using Delta Lake.
