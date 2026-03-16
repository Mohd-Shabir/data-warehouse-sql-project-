# data-warehouse-sql-project-


> End-to-end data warehouse built with MySQL using Medallion Architecture
> (Bronze → Silver → Gold), covering ETL pipelines, data modeling, and 
> analytical reporting.

---

## 🏗️ Architecture



The project follows **Medallion Architecture** with three distinct layers:

- **Bronze Layer** — Raw data ingested as-is from source systems (ERP & CRM)
- **Silver Layer** — Cleansed, standardized, and normalized data
- **Gold Layer** — Business-ready star schema optimized for analytics

---

## 📖 Project Overview

This project simulates a real-world data warehouse workflow, covering:

1. **Data Architecture** — Designing a modern warehouse using Medallion Architecture
2. **ETL Pipelines** — Extracting, transforming, and loading data across layers
3. **Data Modeling** — Building fact and dimension tables in a star schema
4. **Analytics & Reporting** — SQL-based insights on customer, product, and sales data

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| MySQL | Database engine |
| DBeaver | SQL client & database management |
| Git / GitHub | Version control |
| Draw.io | Architecture diagrams |

> **Note:** This project uses MySQL instead of SQL Server.
> Since MySQL does not support schemas the same way SQL Server does,
> three separate databases are used (bronze, silver, gold) to achieve
> the same logical layer separation.

---
