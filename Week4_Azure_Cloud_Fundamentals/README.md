# Azure Cloud Fundamentals and Data Pipeline Implementation using Azure Data Factory

## Submitted By

| Details | Information |
|---------|-------------|
| **Assignment No.** | 03 |
| **Assignment Title** | Azure Cloud Fundamentals and Data Pipeline Implementation using ADF |
| **Dataset** | Sample Superstore Dataset |
| **Author** | Snehal A. Bhosale |
| **College** | Sanjivani College of Engineering, Kopargaon - 423603 |
| **E-mail** | snehalbhosale1807@gmail.com |
| **Technology** | Microsoft Azure, Azure Blob Storage, Azure Data Factory (ADF) |

---

# Project Overview

This project demonstrates the implementation of an end-to-end data pipeline using Microsoft Azure services. The pipeline reads a CSV file from Azure Blob Storage, validates the file using the **Get Metadata** activity, and copies it to another Blob container using the **Copy Data** activity in Azure Data Factory.

The project provides hands-on experience with cloud storage, data integration, pipeline development, monitoring, and secure resource management.

---

# Objective

The main objective of this assignment is to understand Azure cloud services and build a complete data pipeline using Azure Storage Account and Azure Data Factory.

---

# Azure Services Used

- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory (ADF)
- Azure IAM (Role-Based Access Control)

---

# Project Architecture

```text
                   Azure Resource Group
                           │
            ┌──────────────┴──────────────┐
            │                             │
     Storage Account              Azure Data Factory
            │                             │
     ┌──────┴──────┐                      │
     │             │                      │
 Source        Destination                │
 Container      Container                 │
     │             ▲                      │
     │             │                      │
     └──────► Copy Data ◄─────────────────┘
                   ▲
                   │
            Get Metadata
```

---

# Implementation Steps

### Step 1
Created a Resource Group to organize all Azure resources.

### Step 2
Created a Storage Account and two Blob containers:
- **source**
- **destination**

### Step 3
Uploaded the **Sample Superstore.csv** dataset to the source container.

### Step 4
Created an Azure Data Factory instance and launched ADF Studio.

### Step 5
Configured a Linked Service to connect Azure Data Factory with Azure Blob Storage.

### Step 6
Created Source and Destination Datasets.

### Step 7
Developed a pipeline using:
- Get Metadata Activity
- Copy Data Activity

### Step 8
Validated, published, and executed the pipeline.

### Step 9
Monitored the pipeline execution and verified the copied file in the destination container.

---

# Pipeline Workflow

```text
Sample Superstore.csv
          │
          ▼
 Azure Blob Storage (Source)
          │
          ▼
    Get Metadata
(Check Exists, Size, Last Modified)
          │
          ▼
      Copy Data
          │
          ▼
 Azure Blob Storage (Destination)
          │
          ▼
 Superstore_Output.csv
```

---

# Expected Output

- Source CSV file validated successfully.
- Pipeline executed without errors.
- Data copied to the destination Blob container.
- Output file generated successfully.
- Pipeline execution monitored in Azure Data Factory.

---

# Learning Outcomes

Through this assignment, I learned how to:

- Understand Azure cloud fundamentals.
- Create and manage Azure Resource Groups.
- Configure Azure Storage Accounts and Blob Containers.
- Upload and manage datasets in Azure Blob Storage.
- Create Linked Services and Datasets in Azure Data Factory.
- Build and execute end-to-end data pipelines.
- Validate source files using the Get Metadata activity.
- Copy data between Blob containers using the Copy Data activity.
- Monitor pipeline execution and troubleshoot errors.
- Understand the importance of IAM roles for secure resource access.

---

# Conclusion

This project successfully demonstrates the implementation of an end-to-end data pipeline using Microsoft Azure and Azure Data Factory. The pipeline validates the source dataset, copies the CSV file to the destination container, and monitors the execution successfully. This assignment strengthened my understanding of Azure cloud services, data integration, and pipeline orchestration while providing practical experience with real-world cloud data engineering concepts.

---

# Repository Structure

```text
Azure-ADF-Data-Pipeline/
│
├── README.md
├── Sample-Superstore.csv
├── Screenshots/
│   ├── Resource_Group.png
│   ├── Storage_Account.png
│   ├── Blob_Container.png
│   ├── Linked_Service.png
│   ├── Source_Dataset.png
│   ├── Destination_Dataset.png
│   ├── Pipeline_Design.png
│   ├── Pipeline_Success.png
│   └── IAM_Role_Assignment.png
│
└── Report/
    └── Azure_ADF_Assignment_Report.pdf
```

---

## Thank You
**Snehal A. Bhosale**  
*Data Engineering Intern*