/* What is the total sales for each product category and
   what percentage does each contribute to overall sales?*/

WITH category_sales AS (
	SELECT
		prd.category,
		SUM(sls.sales_amount) AS total_sales
	FROM gold.fact_sales sls
	LEFT JOIN gold.dim_products prd
		ON sls.product_key = prd.product_key
	GROUP BY prd.category
)

SELECT
	category,
	total_sales,
	ROUND((total_sales / SUM(total_sales) OVER()) * 100.0, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
