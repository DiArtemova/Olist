-- Purpose: Create an order-level analytical view.
-- Note: Item and payment amounts are aggregated separately before joining to avoid double counting.

USE brazilian;

CREATE OR REPLACE VIEW vw_order_summary AS
WITH item_totals AS (
    SELECT
        order_id,
        SUM(price) AS item_revenue,
        SUM(freight_value) AS freight_revenue,
        SUM(price + freight_value) AS gross_merchandise_value,
        COUNT(*) AS item_count,
        COUNT(DISTINCT product_id) AS distinct_product_count,
        COUNT(DISTINCT seller_id) AS seller_count
    FROM order_items
    GROUP BY order_id
),
payment_totals AS (
    SELECT
        order_id,
        SUM(payment_value) AS payment_value,
        COUNT(*) AS payment_records,
        MAX(payment_installments) AS max_installments
    FROM order_payments
    GROUP BY order_id
),
review_totals AS (
    SELECT
        order_id,
        AVG(review_score) AS average_review_score,
        COUNT(*) AS review_rows
    FROM reviews
    GROUP BY order_id
)
SELECT
    o.order_id,
    o.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_status,
    CAST(o.order_purchase_timestamp AS DATETIME) AS purchase_timestamp,
    CAST(o.order_delivered_customer_date AS DATETIME) AS delivered_timestamp,
    CAST(o.order_estimated_delivery_date AS DATETIME) AS estimated_delivery_timestamp,
    it.item_revenue,
    it.freight_revenue,
    it.gross_merchandise_value,
    it.item_count,
    it.distinct_product_count,
    it.seller_count,
    pt.payment_value,
    pt.payment_records,
    pt.max_installments,
    rt.average_review_score,
    rt.review_rows
FROM orders AS o
LEFT JOIN customers_0 AS c
    ON o.customer_id = c.customer_id
LEFT JOIN item_totals AS it
    ON o.order_id = it.order_id
LEFT JOIN payment_totals AS pt
    ON o.order_id = pt.order_id
LEFT JOIN review_totals AS rt
    ON o.order_id = rt.order_id;