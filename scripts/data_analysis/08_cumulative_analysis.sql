
-- Calcualte total sales per month, running total sales and
-- moving average over time

SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	ROUND(avg_sales, 2) AS avg_sales,
	ROUND(AVG(avg_sales) OVER (ORDER BY order_date), 2) AS moving_average_sales
FROM (
	SELECT
		EXTRACT(YEAR FROM order_date) as order_date,
		SUM(sales_amount) AS total_sales,
		AVG(sales_amount) AS avg_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY EXTRACT(YEAR FROM order_date)
) t

-- Checking the completeness of data to address
-- the question of low total sales in year 2014

SELECT
	EXTRACT(MONTH FROM order_date) as month,
	SUM(sales_amount) as total_sales
FROM gold.fact_sales
WHERE EXTRACT(YEAR FROM order_date) = 2014
GROUP BY month
ORDER BY month
