
-- Retrieve a list of existing catalogs and schemas in RDBMS

SELECT DISTINCT
	table_catalog,
	table_schema
FROM information_schema.tables;

-- Retrieve a list of tables and corresponding types of selected schemas
SELECT
	table_schema,
	table_name,
	table_type
FROM information_schema.tables
WHERE table_schema in ('bronze', 'silver','gold');

-- Retrive a list of columns and corresponding information of selected table

SELECT
	column_name,
	data_type,
	is_nullable,
	character_maximum_length
FROM information_schema.columns
WHERE table_name = 'dim_customers';