-- Data engineering first assignment
-- Student: Teja
-- Run in the database containing the retail schema after loading all five tables.
-- These queries are read-only. Run each numbered statement separately in pgAdmin.

-- 1. How many customers are there?
SELECT COUNT(*) AS customer_count
FROM retail.customers;

-- 2. How many products are there?
SELECT COUNT(*) AS product_count
FROM retail.products;

-- 3. How many sellers are there?
SELECT COUNT(*) AS seller_count
FROM retail.sellers;

-- 4. How many orders are there?
SELECT COUNT(*) AS order_count
FROM retail.orders;

-- 5. What are the different order statuses?
SELECT DISTINCT order_status
FROM retail.orders
ORDER BY order_status;

-- 6. How many orders exist for each order status?
SELECT order_status, COUNT(*) AS order_count
FROM retail.orders
GROUP BY order_status
ORDER BY order_count DESC, order_status;

-- 7. What are the top 10 product categories by number of products?
-- Exclude missing category names.
SELECT product_category_name, COUNT(*) AS product_count
FROM retail.products
WHERE product_category_name IS NOT NULL
GROUP BY product_category_name
ORDER BY product_count DESC, product_category_name
LIMIT 10;

-- 8. Who are the top 10 sellers by number of order items?
-- One row in order_items represents one item.
SELECT s.seller_id, s.seller_city, s.seller_state,
       COUNT(*) AS order_item_count
FROM retail.sellers AS s
JOIN retail.order_items AS oi ON oi.seller_id = s.seller_id
GROUP BY s.seller_id, s.seller_city, s.seller_state
ORDER BY order_item_count DESC, s.seller_id
LIMIT 10;

-- 9. What is the total sales value based on order_items.price?
-- Includes all imported items, regardless of order status; excludes freight.
SELECT SUM(price) AS total_sales_value
FROM retail.order_items;

-- 10. What are the top 10 orders by total item value?
-- AVG also shows the average item price within each order.
SELECT order_id,
       COUNT(*) AS item_count,
       SUM(price) AS total_item_value,
       ROUND(AVG(price), 2) AS average_item_price
FROM retail.order_items
GROUP BY order_id
ORDER BY total_item_value DESC NULLS LAST, order_id
LIMIT 10;

-- 11. Which customer states have the most customers?
SELECT customer_state, COUNT(*) AS customer_count
FROM retail.customers
GROUP BY customer_state
ORDER BY customer_count DESC, customer_state;

-- 12. How many orders does each customer have?
-- LEFT JOIN includes customers with zero orders.
-- COUNT(o.order_id) counts matched orders, not the unmatched customer row.
-- Group by customer_id as defined by the relationship in this assignment.
SELECT c.customer_id, COUNT(o.order_id) AS order_count
FROM retail.customers AS c
LEFT JOIN retail.orders AS o ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC, c.customer_id;
