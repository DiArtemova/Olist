-- 01_schema_review.sql
-- Purpose: Review database tables, keys, and foreign-key relationships.

USE brazilian;

SHOW TABLES;

SHOW CREATE TABLE orders;
SHOW CREATE TABLE order_items;
SHOW CREATE TABLE order_payments;
SHOW CREATE TABLE reviews;
SHOW CREATE TABLE products;
SHOW CREATE TABLE sellers;
SHOW CREATE TABLE customers_0;
SHOW CREATE TABLE translation;

SELECT
    TABLE_NAME AS child_table,
    COLUMN_NAME AS child_column,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME AS parent_table,
    REFERENCED_COLUMN_NAME AS parent_column
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'brazilian'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY child_table, constraint_name;