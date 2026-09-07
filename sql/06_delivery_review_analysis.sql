-- Business questions:
-- 1. What was the late-delivery rate?
-- 2. Which customer states experienced the most late delivery?
-- 3. Are late deliveries associated with lower review scores?

USE brazilian;

SELECT
    COUNT(*) AS delivered_orders,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                DAY,
                purchase_timestamp,
                delivered_timestamp
            )
        ),
        2
    ) AS average_delivery_days,
    SUM(delivered_timestamp > estimated_delivery_timestamp) AS late_orders,
    ROUND(
        100.0 * AVG(delivered_timestamp > estimated_delivery_timestamp),
        2
    ) AS late_delivery_rate_pct
FROM vw_order_summary
WHERE order_status = 'delivered'
  AND delivered_timestamp IS NOT NULL
  AND estimated_delivery_timestamp IS NOT NULL;

SELECT
    CASE
        WHEN delivered_timestamp > estimated_delivery_timestamp
            THEN 'Late'
        ELSE 'On time or early'
    END AS delivery_group,
    COUNT(*) AS reviewed_delivered_orders,
    ROUND(AVG(average_review_score), 2) AS average_review_score
FROM vw_order_summary
WHERE order_status = 'delivered'
  AND delivered_timestamp IS NOT NULL
  AND estimated_delivery_timestamp IS NOT NULL
  AND average_review_score IS NOT NULL
GROUP BY
    CASE
        WHEN delivered_timestamp > estimated_delivery_timestamp
            THEN 'Late'
        ELSE 'On time or early'
    END;