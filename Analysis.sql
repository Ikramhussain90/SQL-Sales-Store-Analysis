-- Sales Store Analysis Queries

-- 1. Total Revenue
SELECT SUM(price * quantity) AS total_revenue FROM sales_store;

-- 2. Top 5 Products
SELECT product_name, COUNT(*) AS total_orders,
       SUM(price * quantity) AS total_revenue
FROM sales_store
GROUP BY product_name
ORDER BY total_revenue DESC LIMIT 5;

-- 3. Monthly Revenue
SELECT MONTH(STR_TO_DATE(purchase_date, '%d/%m/%Y')) AS month_no,
       MONTHNAME(STR_TO_DATE(purchase_date, '%d/%m/%Y')) AS month_name,
       SUM(price * quantity) AS monthly_revenue
FROM sales_store
GROUP BY month_no, month_name
ORDER BY month_no;

-- 4. Payment Mode Analysis
SELECT payment_mode, COUNT(*) AS total_transactions,
       SUM(price * quantity) AS total_revenue
FROM sales_store
GROUP BY payment_mode
ORDER BY total_transactions DESC;

-- 5. Category Wise Sales
SELECT product_category, COUNT(*) AS total_orders,
       SUM(price * quantity) AS total_revenue
FROM sales_store
GROUP BY product_category
ORDER BY total_revenue DESC;

-- 6. Gender Wise Analysis
SELECT gender, COUNT(*) AS total_orders,
       ROUND(AVG(price), 2) AS avg_order_value,
       SUM(price * quantity) AS total_revenue
FROM sales_store GROUP BY gender;

-- 7. Order Status Analysis
SELECT status, COUNT(*) AS total_orders,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM sales_store), 2) AS percentage
FROM sales_store
GROUP BY status
ORDER BY total_orders DESC;

-- 8. Top 5 Customers
SELECT customer_name, customer_id,
       COUNT(*) AS total_orders,
       SUM(price * quantity) AS total_spent
FROM sales_store
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC LIMIT 5;

-- 9. Age Group Analysis
SELECT 
    CASE 
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN customer_age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_orders,
    SUM(price * quantity) AS total_revenue
FROM sales_store
GROUP BY age_group
ORDER BY total_revenue DESC;

-- 10. Most Returned Products
SELECT product_name, COUNT(*) AS return_count
FROM sales_store
WHERE status = 'returned'
GROUP BY product_name
ORDER BY return_count DESC LIMIT 5;

-- 11. Peak Hours
SELECT HOUR(time_of_purchase) AS hour,
       COUNT(*) AS total_orders
FROM sales_store
GROUP BY HOUR(time_of_purchase)
ORDER BY total_orders DESC LIMIT 5;