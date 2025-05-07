
-- Determine the fisrt and last order date and the total duration in months

SELECT
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 +
	EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date)))
										AS order_range_months
FROM gold.fact_sales;


-- Find the youngest and oldest customer based on birthdate

WITH age_data AS (
	SELECT
		customer_id,
		first_name,
		last_name,
		birth_date,
		EXTRACT(YEAR FROM AGE(birth_date)) AS age
	FROM gold.dim_customers
)

SELECT *
FROM age_data
WHERE birth_date = (SELECT MIN(birth_date) FROM age_data)
   OR birth_date = (SELECT MAX(birth_date) FROM age_data);

