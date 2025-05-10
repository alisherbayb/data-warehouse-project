/*----------------------------------------------------------------------------
	This VIEW retrieves product performance and segmentation data from CTEs.
	It provides a comprehensive view of each product's sales, customer reach,
	and revenue trends for analysis and reporting:

	Product details:
		- Product Key
		- Product Name
		- Category
		- Subcategory
		- Cost
		- The date of the last sale

	Metrics:
		- Total orders, sales, quantity, customers
		- Lifespan: time being in sale in months
		- Average Order Revenue: total sales / total orders
		- Average Monthly Revenue: total sales / lifespan

	Segmentation:

		Sales performance segment:
			- High-Performer: total sales >=50000
			- Mid-Range: total sales >= 10000
			- Low-Performer: total sales < 10000
----------------------------------------------------------------------------*/

DROP VIEW IF EXISTS gold.report_products;

CREATE VIEW gold.report_products AS

WITH base_query AS (
/*--------------------------------------------------------
	Base Query: Retrieve core columns from tables
--------------------------------------------------------*/
SELECT
	sls.order_number,
	sls.product_key,
	sls.customer_key,
	sls.order_date,
	sls.sales_amount,
	sls.quantity,
	sls.price,
	prd.product_name,
	prd.category,
	prd.subcategory,
	prd.cost
FROM gold.fact_sales sls
LEFT JOIN gold.dim_products prd
ON prd.product_key = sls.product_key
WHERE sls.order_date IS NOT NULL),

product_aggregation AS (
/*----------------------------------------------------------
	Product Aggregation: Key metrics at the customer level
----------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	price,
	cost,
	EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS lifespan,
	MAX(order_date) AS last_sale_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(sales_amount - quantity * cost) AS total_profit,
	SUM(quantity) AS total_quantity
FROM base_query
GROUP BY product_key,
         product_name,
	     category,
	     subcategory,
		 price,
	     cost
)

SELECT
--	Product details
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sale_date,
--	Metrics
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	lifespan,
	CASE
		WHEN total_orders = 0 THEN total_sales
		ELSE total_sales / total_orders
	END AS avg_order_revenue,
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE ROUND((total_sales / lifespan), 2)
	END AS avg_monthly_revenue,
-- Segmentation
	CASE
		WHEN total_sales >= 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment
FROM product_aggregation;















