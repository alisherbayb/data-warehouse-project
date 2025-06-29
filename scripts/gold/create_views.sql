DROP VIEW IF EXISTS gold.dim_customers CASCADE;

CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id							AS customer_id,
	ci.cst_key							AS customer_number,
	ci.cst_firstname					AS first_name,
	ci.cst_lastname						AS last_name,
	la.cntry							AS country,
	ci.cst_marital_status				AS marital_status,
	CASE
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		ELSE COALESCE(ca.gen, 'n/a')
	END									AS gender,
	ca.bdate							AS birth_date,
	ci.cst_create_date					AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON 		  ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		  ci.cst_key = la.cid;

DROP VIEW IF EXISTS gold.dim_products;

CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER (ORDER BY pr.prd_start_dt, pr.prd_key) AS product_key,
	pr.prd_id		AS product_id,
	pr.prd_key		AS product_number,
	pr.prd_nm		AS product_name,
	pr.cat_id		AS category_id,
	ca.cat			AS category,
	ca.subcat		AS subcategory,
	ca.maintenance	AS maintenance,
	pr.prd_cost		AS cost,
	pr.prd_line		AS product_line,
	pr.prd_start_dt AS start_date,
	pr.prd_end_dt   AS end_date
FROM silver.crm_prd_info pr
LEFT JOIN silver.erp_px_cat_g1v2 ca
ON		  pr.cat_id = ca.id;

DROP VIEW IF EXISTS gold.fact_sales;

CREATE VIEW gold.fact_sales AS
SELECT
	sa.sls_ord_num		AS order_number,
	pr.product_key		AS product_key,
	cu.customer_key		AS customer_key,
	sa.sls_order_dt		AS order_date,
	sa.sls_ship_dt		AS shipping_date,
	sa.sls_due_dt		AS due_date,
	sa.sls_sales		AS sales_amount,
	sa.sls_quantity		AS quantity,
	sa.sls_price 		AS price
FROM silver.crm_sales_details sa
LEFT JOIN gold.dim_customers cu
ON		sa.sls_cust_id = cu.customer_id
LEFT JOIN gold.dim_products pr
ON		sa.sls_prd_key = pr.product_number;