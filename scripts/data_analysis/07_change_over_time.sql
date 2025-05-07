
-- Analyse sales performance over time

SELECT
	EXTRACT(year from order_date) AS year,
	EXTRACT(month from order_date) AS month,
	SUM(sales_amount) AS total_sales,
	ROUND(AVG(sales_amount), 2) AS avg_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY year, month
ORDER BY year, month;