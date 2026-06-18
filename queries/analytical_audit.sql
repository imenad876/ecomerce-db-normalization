-- Analytical Audit
-- Target: ecommerce_platform (3NF)

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
