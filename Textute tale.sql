Create database textile;
use textile;

select*from product_details;
SELECT * FROM textile.sales;
SELECT * FROM textile.product_hierarchy;
SELECT * FROM product_prices;
select count(distinct(prod_id)) as " pm" from sales;


#----------------------------*-----------------------------#

SELECT 
	details.product_name,
	SUM(sales.qty) AS sale_counts
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY details.product_name
ORDER BY sale_counts DESC;

#------------------------------*-------------------------------#

SELECT * FROM textile.sales;

select sum(qty*price) as "Total_revenue" from sales ;


SELECT 
	SUM(price * qty * discount)/100 AS total_discount
FROM sales;

SELECT 
	COUNT(DISTINCT txn_id) AS unique_txn
FROM sales;


WITH cte_transaction_products AS (
	SELECT
		txn_id,
		COUNT(DISTINCT prod_id) AS product_count
	FROM sales
	GROUP BY txn_id
)
SELECT
	ROUND(AVG(product_count)) AS avg_unique_products
FROM cte_transaction_products;


WITH cte_transaction_discounts AS (
	SELECT
		txn_id,
		SUM(price * qty * discount)/100 AS total_discount
	FROM sales
	GROUP BY txn_id
)
SELECT
	ROUND(AVG(total_discount)) AS avg_unique_products
FROM cte_transaction_discounts;



WITH cte_member_revenue AS (
  SELECT
    member,
    txn_id,
    SUM(price * qty) AS revenue
  FROM sales
  GROUP BY 
	member, 
	txn_id
)
SELECT
  member,
  ROUND(AVG(revenue), 2) AS avg_revenue
FROM cte_member_revenue
GROUP BY member;

SELECT 
	details.product_name,
	SUM(sales.qty * sales.price) AS nodis_revenue
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY details.product_name
ORDER BY nodis_revenue DESC
LIMIT 3;

SELECT 
	details.segment_id,
	details.segment_name,
	SUM(sales.qty) AS total_quantity,
	SUM(sales.qty * sales.price) AS total_revenue,
	SUM(sales.qty * sales.price * sales.discount)/100 AS total_discount
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY 
	details.segment_id,
	details.segment_name
ORDER BY total_revenue DESC;


##Q10


SELECT 
	details.segment_id,
	details.segment_name,
	details.product_id,
	details.product_name,
	SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY
	details.segment_id,
	details.segment_name,
	details.product_id,
	details.product_name
ORDER BY product_quantity DESC
LIMIT 5;


##Q11

SELECT 
	details.category_id,
	details.category_name,
	SUM(sales.qty) AS total_quantity,
	SUM(sales.qty * sales.price) AS total_revenue,
	SUM(sales.qty * sales.price * sales.discount)/100 AS total_discount
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY 
	details.category_id,
	details.category_name
ORDER BY total_revenue DESC;


##Q12

SELECT 
  details.category_id,
  details.category_name,
  details.product_id,
  details.product_name,
  SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
  ON sales.prod_id = details.product_id
GROUP BY
  details.category_id,
  details.category_name,
  details.product_id,
  details.product_name
ORDER BY product_quantity DESC
LIMIT 5;




