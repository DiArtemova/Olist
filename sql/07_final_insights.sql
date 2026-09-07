-- Purpose: Identify high-volume states with delivery-risk signals.

USE brazilian;

WITH state_performance AS (
    SELECT
        customer_state,
        COUNT(*) AS delivered_orders,
        ROUND(SUM(gross_merchandise_value), 2) AS gmv_brl,
        ROUND(
            100.0 * AVG(
                delivered_timestamp > estimated_delivery_timestamp
            ),
            2
        ) AS late_delivery_rate_pct,
        ROUND(AVG(average_review_score), 2) AS average_review_score
    FROM vw_order_summary
    WHERE order_status = 'delivered'
      AND delivered_timestamp IS NOT NULL
      AND estimated_delivery_timestamp IS NOT NULL
      AND average_review_score IS NOT NULL
    GROUP BY customer_state
)
SELECT
    customer_state,
    delivered_orders,
    gmv_brl,
    late_delivery_rate_pct,
    average_review_score
FROM state_performance
WHERE delivered_orders >= 100
ORDER BY late_delivery_rate_pct DESC, average_review_score ASC;