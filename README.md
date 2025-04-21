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

![data_management](https://github.com/user-attachments/assets/26eb5e21-91e5-453c-9f5a-e2fb08d78ef8)



| Layer  | Description                                                                 |
|--------|-----------------------------------------------------------------------------|
| Bronze | Raw data loaded from source CSVs (CRM & ERP). No transformations applied.   |
| Silver | Cleaned, deduplicated, and structured data. Stored procedures applied here. |
| Gold   | Business-ready Star Schema (fact & dimension views). Used for reporting.    |

---

## 📂 Project Structure

```
data-warehouse-project/
│
├── data/                           # Raw csv datasets from CRM and ERP
│   ├──source_crm/
│   ├──source_erp/
│
├── docs/                               # Project documentation and architecture details
│   ├── etl.drawio                      # Draw.io file shows all different techniquies and methods of ETL
│   ├── data_architecture.drawio        # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io file for the data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
```
---

## 🙏 Acknowledgements

- [Baraa Khatib Salkini’s Data Warehouse Tutorial](https://github.com/DataWithBaraa/sql-data-warehouse-project/)  
  This project was inspired by and follows the structure of the original work. Licensed under MIT.

## 🛡️ License

This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.




