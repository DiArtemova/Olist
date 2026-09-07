-- Business questions:
-- 1. What are the overall marketplace KPIs?
-- 2. How did delivered orders and GMV change over time?
-- 3. Which states generated the most delivered-order GMV?

USE brazilian;

SELECT
    COUNT(DISTINCT order_id) AS delivered_orders,
    ROUND(SUM(gross_merchandise_value), 2) AS gmv_brl,
    ROUND(AVG(gross_merchandise_value), 2) AS average_order_value_brl,
    ROUND(AVG(average_review_score), 2) AS average_review_score
FROM vw_order_summary
WHERE order_status = 'delivered';

SELECT
    DATE_FORMAT(purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT order_id) AS delivered_orders,
    ROUND(SUM(gross_merchandise_value), 2) AS gmv_brl,
    ROUND(AVG(gross_merchandise_value), 2) AS average_order_value_brl
FROM vw_order_summary
WHERE order_status = 'delivered'
GROUP BY DATE_FORMAT(purchase_timestamp, '%Y-%m')
ORDER BY order_month;