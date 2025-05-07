
-- 5 products generating the highest revenue

SELECT
	p.product_name,
	SUM(s.sales_amount) AS revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY revenue DESC
FETCH FIRST 5 ROW ONLY;

-- What are the 5 worst performing products in terms of sold_quantity

SELECT
	p.product_name,
	SUM(s.quantity) AS sold_amount
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY sold_amount ASC
FETCH FIRST 5 ROW ONLY;

-- Top 10 customers who have generated the highest revenue

SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY revenue DESC
FETCH FIRST 10 ROW ONLY;

--What are 3 customers with the fewest orders placed

SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS placed_orders
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY placed_orders ASC
FETCH FIRST 3 ROW ONLY;
