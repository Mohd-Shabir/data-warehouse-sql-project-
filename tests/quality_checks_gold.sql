/*
===============================================================================
MASTER QUALITY CHECKS: GOLD LAYER (MySQL)
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer Star Schema. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
===============================================================================
*/

-- ====================================================================
-- TEST 1: Checking 'gold.dim_customers'
-- ====================================================================
-- Check for Uniqueness of Surrogate Key
-- Expectation: 0 rows (Every customer record must have a unique key)

SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- TEST 2: Checking 'gold.dim_products'
-- ====================================================================
-- Check for Uniqueness of Surrogate Key
-- Expectation: 0 rows (Every product record must have a unique key)

SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- TEST 3: Checking 'gold.fact_sales' (The Big One!)
-- ====================================================================
-- Check the data model connectivity between the Fact and Dimensions
-- Expectation: 0 rows (Every single sale MUST map to a valid customer and product)

SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
   OR c.customer_key IS NULL;