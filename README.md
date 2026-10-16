# SQL-Olist
Analysis of Olist e-commerce orders to evaluate business


## Repository structure

- `sql/01_schema_review.sql` — Database structure and foreign-key review
- `sql/02_data_quality_checks.sql` — Row counts, duplicate checks, null checks, and unmatched products
- `sql/03_create_analysis_views.sql` — Reusable order-level analytical view
- `sql/04_marketplace_overview.sql` — KPIs, monthly trends, and geographic performance
- `sql/05_product_seller_analysis.sql` — Product categories, sellers, prices, and freight
- `sql/06_delivery_review_analysis.sql` — Delivery reliability and review-score analysis
- `sql/07_final_insights.sql` — Final business-prioritization queries
- `images/` — EER diagram and Power BI dashboard screenshot


## Workflow

1. Reviewed the relational schema and checked data quality in MySQL.
2. Created an order-level analytical view.
3. Used SQL to investigate marketplace performance, categories,
   sellers, delivery reliability, and customer reviews.
4. Built the Power BI data model and DAX measures.
5. Validated selected dashboard KPIs against SQL query results.
