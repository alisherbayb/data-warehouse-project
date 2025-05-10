/* How has each product's yearly sales performance changed over time compared to its
   historical average and the previous year's sales? Order by product_name and
   order_year*/
   
/* Output columns: order_year, product name, current sales, avg_sales, diff_avg, avg_change,
                   prev_year_sales, diff_prev_year, prev_year_change*/

WITH yearly_product_sales AS (
	SELECT
		EXTRACT(YEAR FROM sls.order_date) AS order_year,
		prd.product_name AS product_name,
		SUM(sls.sales_amount) AS current_sales
	FROM gold.fact_sales sls
	LEFT JOIN gold.dim_products prd
	ON sls.product_key = prd.product_key
	WHERE sls.order_date IS NOT NULL
	GROUP BY order_year,
	         product_name
)

SELECT
	order_year,
	product_name,
	current_sales,
	ROUND(AVG(current_sales) OVER (PARTITION BY product_name), 2) AS avg_sales,
	ROUND(current_sales - AVG(current_sales) OVER (PARTITION BY product_name), 2) AS diff_avg,
	CASE
		WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0
			THEN 'Above Avg'
		WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0
			THEN 'Below Avg'
		ELSE
			     'Avg'
	END AS avg_change,
	LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_year_sales,
	current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_prev_year,
	CASE
		WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0
			THEN 'Increase'
		WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0
			THEN 'Descrease'
		ELSE
			     'No Change'
	END AS prev_year_change
FROM yearly_product_sales
ORDER BY product_name,
         order_year

   