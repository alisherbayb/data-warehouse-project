
-- Find the Total Sales

SELECT
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Find how many items are sold

SELECT
	SUM(quantity) AS total_amount
FROM gold.fact_sales;

-- Find the average selling price

SELECT
	ROUND(AVG(price), 2) AS avg_price
FROM gold.fact_sales;

-- Find the Total number of Orders

SELECT
	COUNT(order_number) AS total_orders
FROM gold.fact_sales;

SELECT
	COUNT(DISTINCT order_number) AS total_distinct_orders
FROM gold.fact_sales;

-- Find the total number of products

SELECT
	COUNT(DISTINCT product_id) AS total_products
	--COUNT(product_number),
	--COUNT(product_name)
FROM gold.dim_products;

-- Find the total number of customers

SELECT
	COUNT(DISTINCT customer_id) AS total_customers
	--COUNT(customer_number)
FROM gold.dim_customers;

-- Find the total number of customers that have placed an order

SELECT
	COUNT(DISTINCT customer_key) AS total_active_customers
FROM gold.dim_customers
WHERE customer_key in ( SELECT customer_key
                        FROM gold.fact_sales);

-- Generate a Report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_id) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;