CREATE DATABASE ecommerce_task3; 
USE ecommerce_task3;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers (customer_id, customer_name, city, country)
VALUES
(1, 'Arun Kumar', 'Chennai', 'India'),
(2, 'Priya Sharma', 'Coimbatore', 'India'),
(3, 'Rahul Das', 'Madurai', 'India'),
(4, 'Divya Raj', 'Bangalore', 'India'),
(5, 'Karthik S', 'Chennai', 'India'),
(6, 'Meena Devi', 'Coimbatore', 'India'),
(7, 'Vijay Kumar', 'Madurai', 'India'),
(8, 'Anitha R', 'Salem', 'India');
INSERT INTO Products (product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Smartphone', 'Electronics', 25000.00),
(103, 'Headphones', 'Electronics', 2500.00),
(104, 'Office Chair', 'Furniture', 8500.00),
(105, 'Table', 'Furniture', 12000.00),
(106, 'Backpack', 'Accessories', 1800.00),
(107, 'Keyboard', 'Electronics', 1500.00),
(108, 'Shoes', 'Fashion', 3000.00);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
(1001, 1, '2026-09-01', 55000.00),
(1002, 2, '2026-09-02', 25000.00),
(1003, 3, '2026-09-03', 8500.00),
(1004, 4, '2026-09-05', 12000.00),
(1005, 5, '2026-09-07', 2500.00),
(1006, 6, '2026-09-10', 3000.00),
(1007, 1, '2026-09-12', 1500.00),
(1008, 7, '2026-09-15', 1800.00),
(1009, 8, '2026-09-18', 25000.00),
(1010, 2, '2026-09-20', 3000.00);
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Items;
SELECT * FROM Orders WHERE total_amount > 10000;
SELECT * FROM Orders ORDER BY total_amount DESC;
SELECT * FROM Orders ORDER BY total_amount ASC;
SELECT SUM(total_amount) AS total_revenue FROM Orders;
SELECT AVG(total_amount) AS average_order_value FROM Orders;
SELECT
    customer_id,
    SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id;
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id;
SELECT
    customer_id,
    AVG(total_amount) AS average_order_value
FROM Orders
GROUP BY customer_id;
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id;
    SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.total_amount
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id;
    SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM Customers c
RIGHT JOIN Orders o
    ON c.customer_id = o.customer_id;
    SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    p.category,
    oi.quantity,
    p.price
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
INNER JOIN Products p
    ON oi.product_id = p.product_id;
SELECT *
FROM Orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM Orders
);  
SELECT customer_name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
);  
SELECT
    product_name,
    category,
    price
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
);
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > 20000;
CREATE VIEW Customer_Order_Summary AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;
SELECT *
FROM Customer_Order_Summary;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';
CREATE INDEX idx_orders_date
ON Orders(order_date);
CREATE INDEX idx_orders_customer
ON Orders(customer_id);
CREATE INDEX idx_products_category
ON Products(category);
SHOW INDEX FROM Orders;
SHOW INDEX FROM Products;
EXPLAIN
SELECT *
FROM Orders
WHERE order_date = '2026-09-05';
EXPLAIN
SELECT *
FROM Orders
WHERE customer_id = 2;