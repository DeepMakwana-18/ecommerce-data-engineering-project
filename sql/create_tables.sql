

SELECT current_database();

CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

CREATE TABLE orders(

    order_id SERIAL PRIMARY KEY,

    customer_id INT NOT NULL,

    product_id INT NOT NULL,

    order_date DATE NOT NULL,

    quantity INT NOT NULL CHECK(quantity > 0),

    sales NUMERIC(10,2) NOT NULL CHECK(sales >= 0),

    CONSTRAINT fk_customer
        FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_product
        FOREIGN KEY(product_id)
        REFERENCES products(product_id)
);


CREATE TABLE payments(

    payment_id INT PRIMARY KEY,

    order_id INT NOT NULL,

    payment_method VARCHAR(50) NOT NULL,

    payment_date DATE NOT NULL,

    amount NUMERIC(10,2) NOT NULL,

    CONSTRAINT fk_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);