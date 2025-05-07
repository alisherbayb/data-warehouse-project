-- PROCEDURE: bronze.load_tables()

-- DROP PROCEDURE IF EXISTS bronze.load_tables();

CREATE OR REPLACE PROCEDURE bronze.load_tables(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	start_time TIMESTAMP;
	end_time TIMESTAMP;
BEGIN
	RAISE NOTICE 'Loading Bronze Layer';

	RAISE NOTICE 'Loading CRM Tables';

	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE BRONZE.CRM_CUST_INFO;
		
		RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
		COPY BRONZE.CRM_CUST_INFO
		FROM '/Users/alisherbaibussinov/dev/DataWarehouseProject/datasets/source_crm/cust_info.csv'
		DELIMITER ','
		CSV HEADER;
	
		end_time := clock_timestamp();
		RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(epoch from (end_time - start_time));
		
		EXCEPTION
			WHEN OTHERS THEN
			RAISE WARNING 'Failed to load bronze.crm_cust_info: %', SQLERRM;
	END;

	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE BRONZE.CRM_PRD_INFO;
	
		RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
		COPY BRONZE.CRM_PRD_INFO
		FROM '/Users/alisherbaibussinov/dev/DataWarehouseProject/datasets/source_crm/prd_info.csv'
		DELIMITER ','
		CSV HEADER;
	
		end_time := clock_timestamp();
		RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(epoch from (end_time - start_time));

		EXCEPTION
			WHEN OTHERS THEN
			RAISE WARNING 'Failed to load bronze.crm_prd_info: %', SQLERRM;
	END;

	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>> Truncating Table: bronze.crm_sales_info';
		TRUNCATE TABLE BRONZE.CRM_SALES_DETAILS;
	
		RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_info';
		COPY BRONZE.CRM_SALES_DETAILS
		FROM '/Users/alisherbaibussinov/dev/DataWarehouseProject/datasets/source_crm/sales_details.csv'
		DELIMITER ','
		CSV HEADER;
	
		end_time := clock_timestamp();
		RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(epoch from (end_time - start_time));
		EXCEPTION
			WHEN OTHERS THEN
			RAISE WARNING 'Failed to load bronze.crm_sales_info: %', SQLERRM;
	END;

	RAISE NOTICE 'Loading ERP Tables';

	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE BRONZE.ERP_CUST_AZ12;
	
		RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
		COPY BRONZE.ERP_CUST_AZ12
		FROM '/Users/alisherbaibussinov/dev/DataWarehouseProject/datasets/source_erp/cust_az12.csv'
		DELIMITER ','
		CSV HEADER;
	
		end_time := clock_timestamp();
		RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(epoch from (end_time - start_time));
		EXCEPTION
				WHEN OTHERS THEN
				RAISE WARNING 'Failed to load bronze.erp_cust_az12: %', SQLERRM;
	END;

	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE BRONZE.ERP_LOC_A101;
	
		RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
		COPY BRONZE.ERP_LOC_A101
		FROM '/Users/alisherbaibussinov/dev/DataWarehouseProject/datasets/source_erp/loc_a101.csv'
		DELIMITER ','
		CSV HEADER;
	
		end_time := clock_timestamp();
		RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(epoch from (end_time - start_time));
		EXCEPTION
				WHEN OTHERS THEN
				RAISE WARNING 'Failed to load bronze.erp_loc_a101: %', SQLERRM;
	END;

	BEGIN
		start_time := clock_timestamp();
		RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE BRONZE.ERP_PX_CAT_G1V2;
	
		RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		COPY BRONZE.ERP_PX_CAT_G1V2
		FROM '/Users/alisherbaibussinov/dev/DataWarehouseProject/datasets/source_erp/px_cat_g1v2.csv'
		DELIMITER ','
		CSV HEADER;
	
		end_time := clock_timestamp();
		RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(epoch from (end_time - start_time));
		EXCEPTION
				WHEN OTHERS THEN
				RAISE WARNING 'Failed to load bronze.erp_px_cat_g1v2: %', SQLERRM;
	END;
END;
$BODY$;
ALTER PROCEDURE bronze.load_tables()
    OWNER TO postgres;
