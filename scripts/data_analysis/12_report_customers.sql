/*----------------------------------------------------------------------------
	This VIEW retrieves data from CTEs and categorizes customers
	based on their age and sales behaviour:

	Personal Details:
		- Customer Key
		- Customer Number
		- Name
		- Age
		- The date of the last order

	Metrics:
		- Total orders, sales, quantity, and total products purchased
		- Lifespan: time as a customer in months
		- Recency: time since the last order in months
		- Average Order Value: total sales / total orders
		- Average Monthly Spend: total sales / lifespan
		
	Segmentation:
	
		- Age group:
			- Under 20
			- 20 - 29
			- 30 - 39
			- 40 - 49
			- 50 and above
			
		- Customer type:
			- VIP: lifespan >= 12 months and total sales > 5000
			- Regular: lifespan >= 12 months and total sales <= 5000
			- New lifespan < 12 months
----------------------------------------------------------------------------*/

DROP VIEW IF EXISTS gold.report_customers;

CREATE VIEW gold.report_customers AS

WITH base_query AS(
/*--------------------------------------------------------
	Base Query: Retrieve core columns from tables
--------------------------------------------------------*/
SELECT
	sls.order_number,
	sls.product_key,
	sls.order_date,
	sls.sales_amount,
	sls.quantity,
	cst.customer_key,
	cst.customer_number,
	CONCAT(cst.first_name , ' ', cst.last_name) AS customer_name,
	EXTRACT(YEAR FROM AGE(NOW(), cst.birth_date)) AS age
FROM gold.fact_sales sls
LEFT JOIN gold.dim_customers cst
ON cst.customer_key = sls.customer_key
WHERE order_date IS NOT NULL),

customer_aggregation AS(
/*----------------------------------------------------------
	Customer Aggregation: Key metrics at the customer level
----------------------------------------------------------*/
SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS lifespan,
	EXTRACT(MONTH FROM AGE(NOW(), MAX(order_date))) AS recency
FROM base_query
GROUP BY
	customer_key,
	customer_number,
	customer_name,
	age
)

SELECT
--	Personal details
	customer_key,
	customer_number,
	customer_name,
	age,
	last_order_date,
-- Metrics
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	lifespan,
	recency,
	ROUND((total_sales / total_orders), 2) AS avg_order_value,
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE ROUND((total_sales / lifespan), 2)
	END AS avg_monthly_spend,
-- Segmentation
	CASE
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 and above'
	END AS age_group,
	CASE
		WHEN lifespan >= 12 AND total_sales >= 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_sales < 5000 THEN 'Regular'
		ELSE 'NEW'
	END AS customer_segment
FROM customer_aggregation;

SELECT *
FROM gold.report_customers
FETCH FIRST 10 ROWS ONLY;