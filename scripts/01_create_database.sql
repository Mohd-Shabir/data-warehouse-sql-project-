
/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script sets up the database structure for the Data Warehouse project. 
    It first checks if the databases already exist and drops them if they do 
    to ensure we start fresh.
    
    While some traditional architectures use a single 'DataWarehouse' database 
    with internal schemas, I am building this in MySQL. Because MySQL treats 
    schemas and databases as the exact same thing, I am creating three separate 
    databases ('bronze', 'silver', and 'gold') instead. This cleanly organizes 
    the raw ERP and CRM data while maintaining strict industry naming conventions.
*/


-- Drop the database if it already exists
DROP DATABASE IF EXISTS bronze;

DROP DATABASE IF EXISTS silver;

DROP DATABASE IF EXISTS gold;

/* CREATE DATABASES ─────────────────────────────────────────
Creating 3 separate databases instead of 1 DataWarehouse.
Why? Because MySQL doesn't have SQL Server-style schemas (folders).
By making them separate databases, I can still use the exact same naming 
convention (like bronze.crm_cust_info) without breaking the rules! */
CREATE DATABASE bronze;

CREATE DATABASE silver;

CREATE DATABASE gold;

 




