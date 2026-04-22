-- Data Cleaning Steps

-- 1. Duplicate Check
SELECT transaction_id, COUNT(*) as count
FROM sales_store
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- 2. Remove Duplicates
CREATE TABLE sales_store_new LIKE sales_store;
INSERT INTO sales_store_new SELECT DISTINCT * FROM sales_store;
DROP TABLE sales_store;
RENAME TABLE sales_store_new TO sales_store;

-- 3. Null Check
SELECT 
    SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS transaction_id_nulls,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_nulls
FROM sales_store;

-- 4. Gender Standardize
SET SQL_SAFE_UPDATES = 0;
UPDATE sales_store SET gender = 'F' WHERE LOWER(TRIM(gender)) LIKE '%female%';
UPDATE sales_store SET gender = 'M' WHERE LOWER(TRIM(gender)) LIKE '%male%';
SET SQL_SAFE_UPDATES = 1;