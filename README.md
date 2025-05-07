# Data Warehouse Project with PostgreSQL, PL/pgSQL & Medallion Architecture

A Data Warehouse project using PostgreSQL RDBMS, featuring a complete ETL process based on the Medallion Architecture design pattern.

---

## 📚 Overview

This project showcases a Data Warehouse implementation using PostgreSQL and PL/pgSQL stored procedures, with a complete ETL process following the Medallion Architecture (Bronze, Silver, Gold layers). All transformations are handled within stored procedures, and final business-ready views are created in the Gold layer using a star schema design.

---

## 🧰 Tech Stack

| Tool/Technology | Purpose                                 |
|-----------------|-----------------------------------------|
| PostgreSQL      | RDBMS for storing and processing data   |
| PL/pgSQL        | Stored procedures for transformation    |
| pgAdmin 4       | Database management and development UI  |

---

## 🧱 Architecture Overview

![docs/data_management.png](https://github.com/alisherbayb/data-warehouse-project/blob/93548913a0d0558c51ca2e5915d38748c92cf97d/docs/data_management.png)



| Layer  | Description                                                                 |
|--------|-----------------------------------------------------------------------------|
| Bronze | Raw data loaded from source CSVs (CRM & ERP). No transformations applied.   |
| Silver | Cleaned, deduplicated, and structured data. Stored procedures applied here. |
| Gold   | Business-ready Star Schema (fact & dimension views). Used for reporting.    |

---

## 🔄 Data Flow

![docs/data_flow.png](https://github.com/alisherbayb/data-warehouse-project/blob/93548913a0d0558c51ca2e5915d38748c92cf97d/docs/data_flow.png)

---

## 📂 Project Structure

```
data-warehouse-project/
│
├── data/                               # Raw csv datasets from CRM and ERP
│   ├──source_crm/
│   ├──source_erp/
│
├── docs/                               # Project architecture details
│   ├── data_management.png             # Draw.io file shows the project's architecture
│   ├── data_flow.png                   # Draw.io file for the data flow diagram
│   ├── logical_model.png               # Draw.io file for data models (star schema)
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│   ├── data_analysis                   # SQL scripts from database exploration to
│                                         customer and products reports
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
└── LICENSE                             # License information for the repository
```
---

## 🙏 Acknowledgements

- [Baraa Khatib Salkini’s Data Warehouse Tutorial](https://github.com/DataWithBaraa/sql-data-warehouse-project/)  
  This project was inspired by and follows the structure of the original work. Licensed under MIT.
