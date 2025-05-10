/* Segment products into cost ranges (<100, 100-500, 500-1000, >1000) and
   count how many products fall into each segment */

WITH product_segments AS (
	SELECT
		product_id,
		cost,
		CASE
			WHEN cost < 100 THEN 'Bellow 100'
			WHEN cost BETWEEN 100 AND 500 THEN '100-500'
			WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
			ELSE 'Above 1000'
		END AS cost_range
	FROM gold.dim_products
)

SELECT
	cost_range,
	COUNT(product_id) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;