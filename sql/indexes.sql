CREATE INDEX idx_customer
ON orders(customer_id);


CREATE INDEX idx_product
ON orders(product_id);


CREATE INDEX idx_order_date
ON orders(order_date);


SET enable_seqscan = OFF;


EXPLAIN ANALYZE

SELECT *
FROM orders
WHERE customer_id = 1;




