/*
===============================================================================
Script: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    Loads data from CSV files into the bronze database.
    Truncates each table before loading fresh data.

Note:
    MySQL adaptation — LOAD DATA LOCAL INFILE replaces BULK INSERT.
    LINES TERMINATED BY '\r\n' used for Mac/Windows CSV compatibility.

Usage:
    Run this entire script to reload all bronze tables.
===============================================================================
*/

-- Enable local file loading (MySQL blocks this by default)
SET GLOBAL local_infile = 1;

-- ==========================================
-- CRM Tables
-- ==========================================


-- 1. Status print to track progress in the console
SELECT '>> Loading Table: bronze.crm_cust_info' AS 'Status';

-- Wipe table first to avoid duplicate data if script is re-run
TRUNCATE TABLE bronze.crm_cust_info;

-- Load data from CSV
LOAD DATA LOCAL INFILE '/Users/mohammedshabir/Downloads/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'       -- Fix for Mac/Windows compatibility (\r\n handles hidden carriage returns)
IGNORE 1 ROWS;                   -- Skip the header line



-- 2. Status print to track progress in the console
SELECT '>> Loading Table: bronze.crm_prd_info' AS 'Status';

-- Wipe table first to avoid duplicate data if script is re-run
TRUNCATE TABLE bronze.crm_prd_info;

-- Load data from CSV
LOAD DATA LOCAL INFILE '/Users/mohammedshabir/Downloads/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 3. Status print to track progress in the console
SELECT '>> Loading Table: bronze.crm_sales_details' AS 'Status';

-- Wipe table first to avoid duplicate data if script is re-run
TRUNCATE TABLE bronze.crm_sales_details;

-- Load data from CSV
LOAD DATA LOCAL INFILE '/Users/mohammedshabir/Downloads/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- ==========================================
-- ERP Tables
-- ==========================================


-- 1. Status print to track progress in the console
SELECT '>> Loading Table: bronze.erp_loc_a101' AS 'Status';

-- Wipe table first to avoid duplicate data if script is re-run
TRUNCATE TABLE bronze.erp_loc_a101;

-- Load data from CSV
LOAD DATA LOCAL INFILE '/Users/mohammedshabir/Downloads/sql-data-warehouse-project/datasets/source_erp/loc_a101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- 2. Status print to track progress in the console
SELECT '>> Loading Table: bronze.erp_cust_az12' AS 'Status';

-- Wipe table first to avoid duplicate data if script is re-run
TRUNCATE TABLE bronze.erp_cust_az12;

-- Load data from CSV
LOAD DATA LOCAL INFILE '/Users/mohammedshabir/Downloads/sql-data-warehouse-project/datasets/source_erp/cust_az12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- 3. Status print to track progress in the console
SELECT '>> Loading Table: bronze.erp_px_cat_g1v2' AS 'Status';

-- Wipe table first to avoid duplicate data if script is re-run
TRUNCATE TABLE bronze.erp_px_cat_g1v2;

-- Load data from CSV
LOAD DATA LOCAL INFILE '/Users/mohammedshabir/Downloads/sql-data-warehouse-project/datasets/source_erp/px_cat_g1v2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- ==========================================
-- Completion Status
-- ==========================================

SELECT '===========================================' AS 'Status';
SELECT '>> Bronze Layer Load Complete!'             AS 'Status';
SELECT '===========================================' AS 'Status';






