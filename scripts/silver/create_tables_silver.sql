-- PROCEDURE: silver.create_tables()

-- DROP PROCEDURE IF EXISTS silver.create_tables();

CREATE OR REPLACE PROCEDURE silver.create_tables(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	EXECUTE 'DROP TABLE IF EXISTS silver.crm_cust_info';
	EXECUTE '
		CREATE TABLE silver.crm_cust_info (
			cst_id INT,
			cst_key VARCHAR(50),
			cst_firstname VARCHAR(50),
			cst_lastname VARCHAR(50),
			cst_marital_status VARCHAR(50),
			cst_gndr VARCHAR(50),
			cst_create_date DATE
		)
	';

	EXECUTE 'DROP TABLE IF EXISTS silver.crm_prd_info';
	EXECUTE '
		CREATE TABLE silver.crm_prd_info (
			prd_id INT,
			cat_id VARCHAR(50),
			prd_key VARCHAR(50),
			prd_nm VARCHAR(50),
			prd_cost INT,
			prd_line VARCHAR(50),
			prd_start_dt TIMESTAMP,
			prd_end_dt TIMESTAMP
		)
	';

	EXECUTE 'DROP TABLE IF EXISTS silver.crm_sales_details';
	EXECUTE '
		CREATE TABLE silver.crm_sales_details (
			sls_ord_num VARCHAR(50),
			sls_prd_key VARCHAR(50),
			sls_cust_id INT,
			sls_order_dt DATE,
			sls_ship_dt DATE,
			sls_due_dt DATE,
			sls_sales INT,
			sls_quantity INT,
			sls_price INT
		)
	';

	EXECUTE 'DROP TABLE IF EXISTS silver.erp_loc_a101';
	EXECUTE '
		CREATE TABLE silver.erp_loc_a101 (
			cid VARCHAR(50),
			cntry VARCHAR(50)
		)
	';

	EXECUTE 'DROP TABLE IF EXISTS silver.erp_cust_az12';
	EXECUTE '
		CREATE TABLE silver.erp_cust_az12 (
			cid VARCHAR(50),
			bdate DATE,
			gen VARCHAR(50)
		)
	';

	EXECUTE 'DROP TABLE IF EXISTS silver.erp_px_cat_g1v2';
	EXECUTE '
		CREATE TABLE silver.erp_px_cat_g1v2 (
			id VARCHAR(50),
			cat VARCHAR(50),
			subcat VARCHAR(50),
			maintenance VARCHAR(50)
		)
	';
END;
$BODY$;
ALTER PROCEDURE silver.create_tables()
    OWNER TO postgres;
