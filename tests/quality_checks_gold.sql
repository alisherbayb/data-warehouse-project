-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results 
SELECT 
    customer_key,
    COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*)
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales sls
LEFT JOIN gold.dim_customers cst
ON cst.customer_key = sls.customer_key
LEFT JOIN gold.dim_products prd
ON prd.product_key = sls.product_key
WHERE prd.product_key IS NULL OR cst.customer_key IS NULL  