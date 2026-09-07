-- Purpose: Assess row counts, duplicates, missing values, and referential-integrity exceptions.

USE brazilian;

SELECT 'customers_0' AS table_name, COUNT(*) AS row_count FROM customers_0
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'translation', COUNT(*) FROM translation
ORDER BY table_name;

SELECT
    review_id,
    COUNT(*) AS review_id_occurrences
FROM reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY review_id_occurrences DESC;

SELECT
    COUNT(*) AS unmatched_order_item_rows,
    COUNT(DISTINCT oi.product_id) AS unmatched_product_ids
FROM order_items AS oi
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
WHERE oi.product_id IS NOT NULL
  AND p.product_id IS NULL;