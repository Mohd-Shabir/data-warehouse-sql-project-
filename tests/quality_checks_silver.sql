/*
===============================================================================
MASTER QUALITY CHECKS: SILVER LAYER
===============================================================================
Script Purpose:
    This script performs comprehensive data quality (DQ) tests across all 
    tables in the 'silver' database. It verifies that the transformations 
    (deduplication, standardization, math recalculation, date casting) 
    applied during the Bronze -> Silver ETL pipeline were successful.

Usage Notes:
    - Run these checks after executing your load_silver scripts.
    - Tests labeled "Expectation: No Results" should return exactly 0 rows.
    - Investigate any rows returned by those tests.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- 1. Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    cst_id,
    COUNT(*) AS count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- 2. Check for Unwanted Spaces in Names
-- Expectation: No Results
SELECT 
    cst_firstname, 
    cst_lastname 
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) 
   OR cst_lastname != TRIM(cst_lastname);

-- 3. Data Standardization & Consistency
-- Expectation: Clean categories only (e.g., 'Male', 'Female', 'n/a', 'Single', 'Married')
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info;
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;


-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================
-- 1. Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    prd_id,
    COUNT(*) AS count
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- 2. Check for NULLs or Negative Values in Cost
-- Expectation: No Results
SELECT prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- 3. Data Standardization & Consistency
-- Expectation: Clean categories only ('Mountain', 'Road', 'Other Sales', 'Touring', 'n/a')
SELECT DISTINCT prd_line FROM silver.crm_prd_info;

-- 4. Check for Invalid Date Orders (Time Travel Check)
-- Expectation: No Results (A product cannot end before it starts)
SELECT * FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================
-- 1. Check for Invalid Date Orders (Time Travel Check)
-- Expectation: No Results (Cannot ship before ordering)
SELECT * FROM silver.crm_sales_details
WHERE sls_ship_dt < sls_order_dt 
   OR sls_due_dt < sls_order_dt;

-- 2. Check Data Consistency: Perfect Math Logic
-- Expectation: No Results (Sales MUST equal Quantity * Price, and no zeros/nulls)
SELECT 
    sls_sales,
    sls_quantity,
    sls_price 
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL 
   OR sls_quantity IS NULL 
   OR sls_price IS NULL
   OR sls_sales <= 0 
   OR sls_quantity <= 0 
   OR sls_price <= 0;


-- ====================================================================
-- Checking 'silver.erp_cust_az12'
-- ====================================================================
-- 1. Check for Missing Prefix Clean-up
-- Expectation: No Results (The 'NAS' prefix should be gone)
SELECT cid 
FROM silver.erp_cust_az12
WHERE cid LIKE 'NAS%';

-- 2. Identify Out-of-Range Dates (Time Travelers)
-- Expectation: No Results (Birthdates must be historically logical)
SELECT bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > CURRENT_DATE;

-- 3. Data Standardization & Consistency
-- Expectation: Only 'Male', 'Female', or 'n/a'
SELECT DISTINCT gen 
FROM silver.erp_cust_az12;


-- ====================================================================
-- Checking 'silver.erp_loc_a101'
-- ====================================================================
-- 1. Check for Unwanted Hyphens in ID
-- Expectation: No Results
SELECT cid 
FROM silver.erp_loc_a101
WHERE cid LIKE '%-%';

-- 2. Data Standardization & Consistency
-- Expectation: No variations of 'US', 'USA', or 'DE'. Should be clean words.
SELECT DISTINCT cntry 
FROM silver.erp_loc_a101
ORDER BY cntry;


-- ====================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ====================================================================
-- 1. Check for Unwanted Spaces (The Invisible Space Disease)
-- Expectation: No Results
SELECT * FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) 
   OR subcat != TRIM(subcat) 
   OR maintenance != TRIM(maintenance);