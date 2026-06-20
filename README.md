# E-Commerce 3NF Database Normalization Portfolio
Architect: Deca
Environment: PostgreSQL on Linux

This portfolio asset demonstrates deep-level database engineering by transforming a highly redundant, messy e-commerce dataset into a production-ready relational schema adhering strictly to Third Normal Form (3NF). The project code acts as an architectural blueprint that eliminates structural flaws like insertion, update, and deletion anomalies that plague poorly designed backends. The documentation breaks down the exact step by step mathematical logic used to split composite tables and isolate partial or transitive dependencies. Ultimately, this project signals to senior engineers that you prioritize structural integrity, data security, and absolute database performance over surface-level polish.

## The Normalization Logic

1 First Normal Form (1NF)
Enforced strict scalar values per column. No multi-valued attributes allowed. Every attribute contains only atomic values and every row is uniquely identified by a primary key.

2 Second Normal Form (2NF)
Eliminated partial dependencies. Extracted the core product catalog into its own independent products table so everything depends entirely on the whole primary key. This kills structural update flaws instantly.

3 Third Normal Form (3NF)
Removed transitive dependencies. Isolated customer profiles into a dedicated customers table and decoupled the payment state machine into an independent ledger referencing the parent order via a unique foreign key constraint. This ensures deleting an order doesn't accidentally wipe out a customer profile.

## Project Structure

queries/analytical_audit.sql (Complex cross-table verification JOIN)
schema/3NF_final_schema.sql (DDL architecture specification)
scripts/seed_data.sql (Masked transactional validation data)

## Live Audit Output Proof

The architecture validity is proven by executing a cross-table analytical audit query joining 4 separate tables using single-pass grouping.

```sql
SELECT 
    o.order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(oi.order_item_id) AS unique_items,
    SUM(oi.quantity * oi.unit_price) AS order_total,
    o.order_status,
    pt.payment_method,
    pt.transaction_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN payment_transactions pt ON o.order_id = pt.order_id
GROUP BY o.order_id, c.first_name, c.last_name, o.order_status, pt.payment_method, pt.transaction_status
ORDER BY order_total DESC;
```
 order_id | customer_name | unique_items | order_total | order_status | payment_method | transaction_status 
----------+---------------+--------------+-------------+--------------+----------------+--------------------
        2 | Alice Umutoni |            1 |      399.99 | Processing   | Credit Card    | Authorized
        1 | Jean Bizimana |            2 |      175.00 | Delivered    | Mobile Money   | Completed
        3 | Jean Bizimana |            1 |       45.00 | Pending      | Mobile Money   | Pending
