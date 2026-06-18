-- Seed Data
-- Target: ecommerce_platform (3NF)

INSERT INTO customers (first_name, last_name, email, phone_number) VALUES
('Jean', 'Bizimana', 'jean.bizimana@mail.com', '+25078*******'),
('Alice', 'Umutoni', 'alice.u@mail.com', '+25078*******'),
('David', 'Nshuti', 'david.n@mail.com', NULL);

INSERT INTO products (product_name, sku, price, stock_quantity) VALUES
('Mechanical Keyboard TKL', 'KBD-TKL-01', 85.00, 45),
('Ergonomic Wireless Mouse', 'MSE-WRL-02', 45.00, 120),
('UltraWide 34-Inch Monitor', 'MON-UW-34', 399.99, 15),
('USB-C Hub Multi-port', 'HUB-USBC-09', 29.99, 0);

INSERT INTO orders (customer_id, order_status, shipping_street, shipping_city) VALUES
(1, 'Delivered', 'KN 78 St', 'Kigali'),
(2, 'Processing', 'KG 11 Ave', 'Kigali'),
(1, 'Pending', 'RN 3 Rd', 'Rubavu');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 85.00),
(1, 2, 2, 45.00),
(2, 3, 1, 399.99),
(3, 2, 1, 45.00);

INSERT INTO payment_transactions (order_id, payment_method, transaction_status, gateway_reference) VALUES
(1, 'Mobile Money', 'Completed', 'TXN-MOMO-99281'),
(2, 'Credit Card', 'Authorized', 'TXN-STRIPE-00219'),
(3, 'Mobile Money', 'Pending', 'TXN-MOMO-00482');
