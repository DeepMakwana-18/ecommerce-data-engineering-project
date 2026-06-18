INSERT INTO customers
(customer_id, customer_name, country, city)

VALUES
(1, 'Rahul Sharma', 'India', 'Mumbai'),
(2, 'Priya Patel', 'India', 'Ahmedabad'),
(3, 'John Smith', 'USA', 'New York'),
(4, 'Emma Wilson', 'UK', 'London'),
(5, 'Aarav Mehta', 'India', 'Bangalore');


INSERT INTO products
(product_id, product_name, category, price)

VALUES
(101, 'MacBook Air M3', 'Laptop', 1299.99),
(102, 'iPhone 15', 'Mobile', 899.99),
(103, 'Sony WH-1000XM5', 'Headphones', 349.99),
(104, 'iPad Air', 'Tablet', 699.99),
(105, 'Logitech MX Master 3S', 'Accessories', 99.99);

INSERT INTO orders
(order_id, customer_id, product_id, order_date, quantity, sales)

VALUES
(1001, 1, 101, '2025-06-01', 1, 1299.99),

(1002, 2, 102, '2025-06-02', 1, 899.99),

(1003, 3, 103, '2025-06-03', 2, 699.98),

(1004, 4, 104, '2025-06-04', 1, 699.99),

(1005, 5, 105, '2025-06-05', 3, 299.97),

(1006, 1, 102, '2025-06-06', 1, 899.99),

(1007, 2, 105, '2025-06-07', 2, 199.98),

(1008, 3, 101, '2025-06-08', 1, 1299.99),

(1009, 4, 103, '2025-06-09', 1, 349.99),

(1010, 5, 104, '2025-06-10', 2, 1399.98);

INSERT INTO payments
(payment_id, order_id, payment_method, payment_date, amount)

VALUES
(5001, 1001, 'Credit Card', '2025-06-01', 1299.99),

(5002, 1002, 'UPI', '2025-06-02', 899.99),

(5003, 1003, 'PayPal', '2025-06-03', 699.98),

(5004, 1004, 'Credit Card', '2025-06-04', 699.99),

(5005, 1005, 'UPI', '2025-06-05', 299.97),

(5006, 1006, 'Debit Card', '2025-06-06', 899.99),

(5007, 1007, 'UPI', '2025-06-07', 199.98),

(5008, 1008, 'Credit Card', '2025-06-08', 1299.99),

(5009, 1009, 'PayPal', '2025-06-09', 349.99),

(5010, 1010, 'Debit Card', '2025-06-10', 1399.98);