--view dataset
SELECT * FROM sales_orders limit 100;
--find total revenue
SELECT 
SUM(quantity*unit_price) as total_revenue 
FROM sales_orders;
--find total orders
SELECT
COUNT(DISTINCT order_id) as TOTAL_ORDERS
FROM sales_orders;
--average order value
SELECT 
SUM(quantity*unit_price)/COUNT(DISTINCT order_id) as average_order_value 
FROM sales_orders;
--top 10 performing products
SELECT 
product,SUM(quantity*unit_price) as total_revenue 
FROM sales_orders
GROUP BY product
ORDER BY SUM(quantity*unit_price) DESC
LIMIT 10;
-- monthly yearly revenue
SELECT DISTINCT STRFTIME('%Y-%m',order_date) as order_month, 
SUM(quantity*unit_price) as total_revenue
FROM sales_orders
GROUP BY STRFTIME('%Y-%m',order_date);
-- city wise orders and revenue
SELECT 
city,SUM(quantity*unit_price) as total_revenue,
COUNT(DISTINCT order_id) as total_orders
FROM sales_orders
GROUP BY city;
-- orders and revenue for karachi for each month-year
SELECT city, STRFTIME('%Y-%m',order_date) as order_month,
SUM(quantity*unit_price) as total_revenue,
COUNT(DISTINCT order_id) as total_orders
FROM sales_orders
GROUP BY city, STRFTIME('%Y-%m',order_date)
HAVING city='Karachi';
--top 5 customers by revenue and their total orders and city
SELECT customer_id, city,
SUM(quantity*unit_price) as total_revenue,
COUNT(DISTINCT order_id) as total_orders
FROM sales_orders
GROUP BY customer_id
ORDER BY SUM(quantity*unit_price) DESC
LIMIT 5;
-- customers who placed more than 5 orders
SELECT customer_id,
COUNT(DISTINCT order_id) as total_orders
FROM sales_orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)>5;
-- total customers who placed more than 5 orders
SELECT COUNT(*) as total_customers_with_more_than_5_orders
FROM
(SELECT customer_id,
COUNT(DISTINCT order_id) as total_orders
FROM sales_orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)>5);
--top 5 customers and their city based on average order value
SELECT customer_id,city,
AVG(quantity*unit_price) as average_revenue
FROM sales_orders
GROUP BY customer_id
ORDER BY AVG(quantity*unit_price) DESC
LIMIT 5;