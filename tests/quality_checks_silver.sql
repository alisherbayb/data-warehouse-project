-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results

-- silver.crm_cust_info
SELECT *
FROM silver.crm_cust_info;

SELECT
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 or cst_id IS NULL;

-- silver.crm_prd_info
SELECT *
FROM silver.crm_prd_info;

SELECT
	prd_id,
	COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 or prd_id IS NULL;

-- silver.crm_sales_details
-- uniqueness of the primary key here is not expected
SELECT *
FROM silver.crm_sales_details;

SELECT
	sls_ord_num,
	COUNT(*)
FROM silver.crm_sales_details
GROUP BY sls_ord_num
HAVING COUNT(*) > 1 or sls_ord_num IS NULL;

-- silver.erp_cust_az12
SELECT *
FROM silver.erp_cust_az12;

SELECT
	cid,
	COUNT(*)
FROM silver.erp_cust_az12
GROUP BY cid
HAVING COUNT(*) > 1 or cid IS NULL;

-- silver.erp_loc_a101
SELECT *
FROM silver.erp_loc_a101;

SELECT
	cid,
	COUNT(*)
FROM silver.erp_loc_a101
GROUP BY cid
HAVING COUNT(*) > 1 or cid IS NULL;


-- silver.erp_px_cat_g1v2
SELECT *
FROM silver.erp_px_cat_g1v2;

SELECT
	id,
	COUNT(*)
FROM silver.erp_px_cat_g1v2
GROUP BY id
HAVING COUNT(*) > 1 or id IS NULL;