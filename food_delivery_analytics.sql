CREATE DATABASE food_delivery_analytics;
USE food_delivery_analytics;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    registration_date DATE
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1),
    contact_number VARCHAR(15)
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE,


    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_status VARCHAR(30),
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id)
);

CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    vehicle_type VARCHAR(30),
    city VARCHAR(50)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    partner_id INT NOT NULL,
    pickup_time DATETIME,
    delivery_time DATETIME,
    delivery_status VARCHAR(30),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (partner_id)
        REFERENCES delivery_partners(partner_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    payment_date DATETIME,
    amount DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

INSERT INTO customers
(customer_name, email, phone, city, registration_date)
VALUES
('Arun Kumar', 'arun@gmail.com', '9876543210', 'Chennai', '2025-01-10'),
('Priya Sharma', 'priya@gmail.com', '9876543211', 'Chennai', '2025-02-15'),
('Rahul Raj', 'rahul@gmail.com', '9876543212', 'Bangalore', '2025-03-20'),
('Sneha Devi', 'sneha@gmail.com', '9876543213', 'Chennai', '2025-04-05'),
('Vijay Kumar', 'vijay@gmail.com', '9876543214', 'Coimbatore', '2025-05-12'),
('Karthik S', 'karthik@gmail.com', '9876543215', 'Madurai', '2025-06-18'),
('Divya R', 'divya@gmail.com', '9876543216', 'Chennai', '2025-07-22'),
('Ajay Kumar', 'ajay@gmail.com', '9876543217', 'Bangalore', '2025-08-10'),
('Meena K', 'meena@gmail.com', '9876543218', 'Coimbatore', '2025-09-15'),
('Sanjay P', 'sanjay@gmail.com', '9876543219', 'Chennai', '2025-10-01');

INSERT INTO restaurants
(restaurant_name, cuisine_type, city, rating, contact_number)
VALUES
('Anjappar', 'South Indian', 'Chennai', 4.5, '9000000001'),
('Burger Hub', 'Fast Food', 'Chennai', 4.2, '9000000002'),
('Pizza Corner', 'Italian', 'Bangalore', 4.3, '9000000003'),
('Biryani House', 'Biryani', 'Chennai', 4.6, '9000000004'),
('Dosa Point', 'South Indian', 'Coimbatore', 4.1, '9000000005');

INSERT INTO menu_items
(restaurant_id, item_name, category, price, availability)
VALUES
(1, 'Chicken Biryani', 'Main Course', 220.00, TRUE),
(1, 'Parotta', 'Main Course', 60.00, TRUE),
(1, 'Chicken 65', 'Starter', 180.00, TRUE),

(2, 'Chicken Burger', 'Burger', 150.00, TRUE),
(2, 'French Fries', 'Sides', 90.00, TRUE),
(2, 'Veg Burger', 'Burger', 120.00, TRUE),

(3, 'Margherita Pizza', 'Pizza', 250.00, TRUE),
(3, 'Chicken Pizza', 'Pizza', 350.00, TRUE),

(4, 'Mutton Biryani', 'Biryani', 300.00, TRUE),
(4, 'Chicken Biryani', 'Biryani', 240.00, TRUE),

(5, 'Masala Dosa', 'Dosa', 100.00, TRUE),
(5, 'Plain Dosa', 'Dosa', 80.00, TRUE);

INSERT INTO orders
(customer_id, restaurant_id, order_date, order_status, total_amount)
VALUES
(1, 1, '2026-01-05 13:10:00', 'Delivered', 400.00),
(2, 2, '2026-01-07 19:30:00', 'Delivered', 240.00),
(3, 3, '2026-01-10 20:00:00', 'Delivered', 350.00),
(4, 4, '2026-01-12 14:00:00', 'Delivered', 480.00),
(5, 5, '2026-01-15 09:30:00', 'Delivered', 200.00),
(1, 2, '2026-01-18 20:15:00', 'Delivered', 330.00),
(6, 1, '2026-01-20 13:45:00', 'Cancelled', 220.00),
(7, 4, '2026-01-22 21:00:00', 'Delivered', 540.00),
(8, 3, '2026-01-25 19:20:00', 'Delivered', 700.00),
(9, 5, '2026-01-28 10:00:00', 'Delivered', 180.00),
(10, 1, '2026-02-02 13:30:00', 'Delivered', 400.00),
(2, 4, '2026-02-05 20:10:00', 'Delivered', 540.00);

INSERT INTO order_items
(order_id, item_id, quantity, unit_price)
VALUES
(1, 1, 1, 220.00),
(1, 3, 1, 180.00),

(2, 4, 1, 150.00),
(2, 5, 1, 90.00),

(3, 8, 1, 350.00),

(4, 10, 2, 240.00),

(5, 11, 2, 100.00),

(6, 4, 1, 150.00),
(6, 5, 2, 90.00),

(7, 1, 1, 220.00),

(8, 9, 1, 300.00),
(8, 10, 1, 240.00),

(9, 8, 2, 350.00),

(10, 11, 1, 100.00),
(10, 12, 1, 80.00),

(11, 1, 1, 220.00),
(11, 3, 1, 180.00),

(12, 9, 1, 300.00),
(12, 10, 1, 240.00);

INSERT INTO delivery_partners
(partner_name, phone, vehicle_type, city)
VALUES
('Ramesh', '9111111111', 'Bike', 'Chennai'),
('Suresh', '9222222222', 'Bike', 'Chennai'),
('Manoj', '9333333333', 'Scooter', 'Bangalore'),
('Dinesh', '9444444444', 'Bike', 'Coimbatore'),
('Vimal', '9555555555', 'Bike', 'Chennai');

INSERT INTO deliveries
(order_id, partner_id, pickup_time, delivery_time, delivery_status)
VALUES
(1, 1, '2026-01-05 13:25:00', '2026-01-05 13:55:00', 'Delivered'),
(2, 2, '2026-01-07 19:45:00', '2026-01-07 20:20:00', 'Delivered'),
(3, 3, '2026-01-10 20:15:00', '2026-01-10 20:55:00', 'Delivered'),
(4, 1, '2026-01-12 14:15:00', '2026-01-12 14:50:00', 'Delivered'),
(5, 4, '2026-01-15 09:45:00', '2026-01-15 10:15:00', 'Delivered'),
(6, 2, '2026-01-18 20:30:00', '2026-01-18 21:05:00', 'Delivered'),
(8, 5, '2026-01-22 21:15:00', '2026-01-22 21:55:00', 'Delivered'),
(9, 3, '2026-01-25 19:35:00', '2026-01-25 20:20:00', 'Delivered'),
(10, 4, '2026-01-28 10:15:00', '2026-01-28 10:40:00', 'Delivered'),
(11, 1, '2026-02-02 13:45:00', '2026-02-02 14:20:00', 'Delivered'),
(12, 5, '2026-02-05 20:25:00', '2026-02-05 21:05:00', 'Delivered');

SELECT * FROM customers;

SELECT * FROM restaurants;

SELECT * FROM menu_items;

SELECT * FROM orders;

SELECT * FROM order_items;

SELECT * FROM delivery_partners;

SELECT * FROM deliveries;

SELECT * FROM payments;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_restaurants
FROM restaurants;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT 
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';

SELECT 
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE order_status = 'Delivered';

SELECT 
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

SELECT 
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_orders DESC;

SELECT 
    r.restaurant_name,
    SUM(o.total_amount) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC;

SELECT 
    restaurant_name,
    rating
FROM restaurants
ORDER BY rating DESC;

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY total_orders DESC;

SELECT 
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM menu_items m
JOIN order_items oi
    ON m.item_id = oi.item_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY m.item_id, m.item_name
ORDER BY total_quantity DESC;

SELECT 
    m.item_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM menu_items m
JOIN order_items oi
    ON m.item_id = oi.item_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY m.item_id, m.item_name
ORDER BY revenue DESC;

SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM payments
WHERE payment_status = 'Success'
GROUP BY payment_method
ORDER BY total_amount DESC;

SELECT order_id, order_status
FROM orders;

SELECT *
FROM order_items;

INSERT INTO order_items
(order_id, item_id, quantity, unit_price)
VALUES
(1, 1, 1, 220.00),
(1, 3, 1, 180.00),

(2, 4, 1, 150.00),
(2, 5, 1, 90.00),

(3, 8, 1, 350.00),

(4, 10, 2, 240.00),

(5, 11, 2, 100.00),

(6, 4, 1, 150.00),
(6, 5, 2, 90.00),

(7, 1, 1, 220.00),

(8, 9, 1, 300.00),
(8, 10, 1, 240.00),

(9, 8, 2, 350.00),

(10, 11, 1, 100.00),
(10, 12, 1, 80.00),

(11, 1, 1, 220.00),
(11, 3, 1, 180.00),

(12, 9, 1, 300.00),
(12, 10, 1, 240.00);

SELECT *
FROM order_items;    

SELECT 
    m.item_name,
    SUM(oi.quantity) AS total_quantity
FROM menu_items m
JOIN order_items oi
    ON m.item_id = oi.item_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY m.item_id, m.item_name
ORDER BY total_quantity DESC;

SELECT 
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status;

INSERT INTO payments
(order_id, payment_method, payment_status, payment_date, amount)
VALUES
(1, 'UPI', 'Success', '2026-01-05 13:10:00', 400.00),
(2, 'Card', 'Success', '2026-01-07 19:30:00', 240.00),
(3, 'UPI', 'Success', '2026-01-10 20:00:00', 350.00),
(4, 'Cash', 'Success', '2026-01-12 14:00:00', 480.00),
(5, 'UPI', 'Success', '2026-01-15 09:30:00', 200.00),
(6, 'Card', 'Success', '2026-01-18 20:15:00', 330.00),
(7, 'UPI', 'Failed', '2026-01-20 13:45:00', 220.00),
(8, 'UPI', 'Success', '2026-01-22 21:00:00', 540.00),
(9, 'Card', 'Success', '2026-01-25 19:20:00', 700.00),
(10, 'Cash', 'Success', '2026-01-28 10:00:00', 180.00),
(11, 'UPI', 'Success', '2026-02-02 13:30:00', 400.00),
(12, 'Card', 'Success', '2026-02-05 20:10:00', 540.00);

SELECT *
FROM payments;

SELECT 
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status;

SELECT 
    dp.partner_name,
    COUNT(d.delivery_id) AS total_deliveries
FROM delivery_partners dp
JOIN deliveries d
    ON dp.partner_id = d.partner_id
WHERE d.delivery_status = 'Delivered'
GROUP BY dp.partner_id, dp.partner_name
ORDER BY total_deliveries DESC;

SELECT 
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                pickup_time,
                delivery_time
            )
        ), 2
    ) AS avg_delivery_time_minutes
FROM deliveries
WHERE delivery_status = 'Delivered';

SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status = 'Delivered'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

SELECT 
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.city
ORDER BY total_revenue DESC; 

WITH delivered_orders AS (
    SELECT *
    FROM orders
    WHERE order_status = 'Delivered'
)
SELECT *
FROM delivered_orders;

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    cs.total_spent
FROM customer_spending cs
JOIN customers c
    ON cs.customer_id = c.customer_id
ORDER BY cs.total_spent DESC;

WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    WHERE order_status = 'Delivered'
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    cs.total_spent
FROM customer_spending cs
JOIN customers c
    ON cs.customer_id = c.customer_id
WHERE cs.total_spent > 500
ORDER BY cs.total_spent DESC;

SELECT AVG(total_amount)
FROM orders
WHERE order_status = 'Delivered';

SELECT
    order_id,
    customer_id,
    total_amount
FROM orders
WHERE order_status = 'Delivered'
AND total_amount > (
    SELECT AVG(total_amount)
    FROM orders
    WHERE order_status = 'Delivered'
);

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_total)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS customer_total
        FROM orders
        WHERE order_status = 'Delivered'
        GROUP BY customer_id
    ) AS customer_summary
);

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS spending_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY spending_rank;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    DENSE_RANK() OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS spending_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY spending_rank;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    ROW_NUMBER() OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS row_num
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY row_num;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY customer_rank;

SELECT
    r.restaurant_name,
    m.item_name,
    SUM(oi.quantity) AS total_quantity,

    RANK() OVER (
        PARTITION BY r.restaurant_id
        ORDER BY SUM(oi.quantity) DESC
    ) AS item_rank

FROM restaurants r
JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
JOIN order_items oi
    ON m.item_id = oi.item_id
JOIN orders o
    ON oi.order_id = o.order_id

WHERE o.order_status = 'Delivered'

GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    m.item_id,
    m.item_name

ORDER BY
    r.restaurant_name,
    item_rank;
    
    SELECT
    c.city,
    c.customer_name,
    SUM(o.total_amount) AS total_spent,

    RANK() OVER (
        PARTITION BY c.city
        ORDER BY SUM(o.total_amount) DESC
    ) AS customer_rank

FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id

WHERE o.order_status = 'Delivered'

GROUP BY
    c.city,
    c.customer_id,
    c.customer_name

ORDER BY
    c.city,
    customer_rank;
    
    SELECT
    order_id,
    total_amount,
    CASE
        WHEN total_amount >= 500 THEN 'High Value'
        WHEN total_amount >= 300 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category
FROM orders
WHERE order_status = 'Delivered';
    
    SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    CASE
        WHEN SUM(o.total_amount) >= 1000 THEN 'Premium Customer'
        WHEN SUM(o.total_amount) >= 500 THEN 'Regular Customer'
        ELSE 'Low Spending Customer'
    END AS customer_category
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

CREATE VIEW customer_spending_view AS
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.customer_name;

SELECT *
FROM customer_spending_view;

SELECT *
FROM customer_spending_view
WHERE total_spent > 500
ORDER BY total_spent DESC;

CREATE VIEW restaurant_revenue_view AS
SELECT
    r.restaurant_id,
    r.restaurant_name,
    SUM(o.total_amount) AS total_revenue
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name;

SELECT *
FROM restaurant_revenue_view
ORDER BY total_revenue DESC;

DELIMITER //

CREATE PROCEDURE get_customer_orders(IN cust_id INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        o.order_status,
        o.total_amount
    FROM orders o
    WHERE o.customer_id = cust_id
    ORDER BY o.order_date DESC;
END //

DELIMITER ;

CALL get_customer_orders(1);

DELIMITER //

CREATE PROCEDURE get_customer_spending(IN cust_id INT)
BEGIN
    SELECT
        c.customer_name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE c.customer_id = cust_id
      AND o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name;
END //

DELIMITER ;

CALL get_customer_spending(1);

CREATE TABLE order_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    action_type VARCHAR(30),
    action_time DATETIME
);

DELIMITER //

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (
        order_id,
        action_type,
        action_time
    )
    VALUES (
        NEW.order_id,
        'ORDER CREATED',
        NOW()
    );
END //

DELIMITER ;

INSERT INTO orders (
    customer_id,
    restaurant_id,
    order_date,
    order_status,
    total_amount
)
VALUES (
    1,
    2,
    NOW(),
    'Delivered',
    350
);

SELECT *
FROM order_audit;

WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name
),
ranked_customers AS (
    SELECT
        customer_name,
        total_spent,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS customer_rank
    FROM customer_spending
)
SELECT
    customer_name,
    total_spent,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3
ORDER BY customer_rank;

SELECT
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    AVG(o.total_amount) AS average_order_value
FROM restaurants r
JOIN orders o
    ON r.restaurant_id = o.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC;

SELECT
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN order_status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    ROUND(
        SUM(
            CASE
                WHEN order_status = 'Cancelled' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM orders;

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
WHERE order_status = 'Delivered'
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;
    
    SELECT
    r.restaurant_name,
    r.cuisine_type,
    r.rating,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_revenue
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
    AND o.order_status = 'Delivered'
GROUP BY
    r.restaurant_id,
    r.restaurant_name,
    r.cuisine_type,
    r.rating
ORDER BY total_revenue DESC;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,

    CASE
        WHEN COUNT(o.order_id) >= 3 THEN 'Highly Active'
        WHEN COUNT(o.order_id) = 2 THEN 'Repeat Customer'
        ELSE 'One Time Customer'
    END AS customer_type

FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id

WHERE o.order_status = 'Delivered'

GROUP BY
    c.customer_id,
    c.customer_name

ORDER BY total_spent DESC;

SELECT
    m.item_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM menu_items m
JOIN order_items oi
    ON m.item_id = oi.item_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY
    m.item_id,
    m.item_name
ORDER BY total_quantity_sold DESC;

SELECT
    dp.partner_name,
    COUNT(d.delivery_id) AS total_deliveries,

    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                d.pickup_time,
                d.delivery_time
            )
        ),
        2
    ) AS avg_delivery_time_minutes

FROM delivery_partners dp
JOIN deliveries d
    ON dp.partner_id = d.partner_id

WHERE d.delivery_status = 'Delivered'

GROUP BY
    dp.partner_id,
    dp.partner_name

ORDER BY avg_delivery_time_minutes;
