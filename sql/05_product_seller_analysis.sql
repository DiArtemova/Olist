-- Business questions:
-- 1. Which product categories generated the highest GMV?
-- 2. Which sellers generated the most item revenue?
-- 3. Which categories had the highest freight cost?

USE brazilian;

SELECT
    COALESCE(
        t.product_category_name_english,
        'Unknown / unmatched'
    ) AS product_category,
    COUNT(DISTINCT oi.order_id) AS delivered_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue_brl,
    ROUND(SUM(oi.freight_value), 2) AS freight_revenue_brl,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS gmv_brl
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN translation AS t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(
    t.product_category_name_english,
    'Unknown / unmatched'
)
ORDER BY gmv_brl DESC
LIMIT 15;