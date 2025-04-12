-- Create the database 
CREATE DATABASE Bookstore_db;

USE Bookstore_db;


-- 1. Create the author table
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. Create the book_language table
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

-- 3. Create the publisher table
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 4. Create the country table
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 5. Create the address_status table
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 6. Create the address table
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(150),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 7. Create the shipping_method table
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL
);

-- 8. Create the order_status table
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 9. Create the book table
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    genre VARCHAR(50),
    price DECIMAL(8, 2),
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 10. Create the book_author table (many-to-many relationship)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 11. Create the customer table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- 12. Create the customer_address table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 13. Create the cust_order table
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 14. Create the order_line table
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. Create the order_history table
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    changed_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);




                                         -- This is Sample data we inserted on the tables we created from the above query.

-- Insert sample data into author
INSERT INTO author (name) VALUES ('Ngugi wa Thiong\'o'), ('Meja Mwangi'), ('Marjorie Oludhe Macgoye');

-- Insert sample data into book_language
INSERT INTO book_language (language_name) VALUES ('English'), ('Swahili'), ('Luo');

-- Insert sample data into publisher
INSERT INTO publisher (name) VALUES ('East African Publishers'), ('Phoenix Publishers'), ('Longhorn Publishers');

-- Insert sample data into country
INSERT INTO country (name) VALUES ('Kenya'), ('Uganda'), ('Tanzania');

-- Insert sample data into address_status
INSERT INTO address_status (status_name) VALUES ('Home'), ('Work'), ('Other');

-- Insert sample data into address
INSERT INTO address (street, city, postal_code, country_id) VALUES 
('Moi Avenue', 'Nairobi', '00100', 1),
('Luthuli Avenue', 'Mombasa', '80100', 1),
('Kenya Road', 'Kisumu', '40100', 1);

-- Insert sample data into shipping_method
INSERT INTO shipping_method (method_name) VALUES ('Standard Shipping'), ('Express Shipping');

-- Insert sample data into order_status
INSERT INTO order_status (status_name) VALUES ('Pending'), ('Shipped'), ('Delivered');

-- Insert sample data into book
INSERT INTO book (title, genre, price, publisher_id, language_id) VALUES 
('The River Between', 'Fiction', 599.99, 1, 1),
('Going Down River Road', 'Fiction', 799.99, 2, 1),
('The Present Moment', 'Fiction', 399.99, 3, 2);

-- Insert sample data into book_author
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3);

-- Insert sample data into customer
INSERT INTO customer (name, email) VALUES 
('James Kariuki', 'james.kariuki@example.com'),
('Mary Wambui', 'mary.wambui@example.com');

-- Insert sample data into customer_address
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(1, 1, 1), 
(2, 2, 2);

-- Insert sample data into cust_order
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id) VALUES 
(1, '2023-10-01', 1, 1), 
(2, '2023-10-02', 2, 2);

-- Insert sample data into order_line
INSERT INTO order_line (order_id, book_id, quantity) VALUES 
(1, 1, 1), 
(1, 3, 2), 
(2, 2, 1);

-- Insert sample data into order_history
INSERT INTO order_history (order_id, status_id, changed_at) VALUES 
(1, 1, '2023-10-01 10:00:00'), 
(1, 2, '2023-10-02 12:00:00'), 
(2, 2, '2023-10-02 14:00:00');



                                              -- Creating users and granting them access to the database


 -- Step 1: Create roles
CREATE ROLE bookstore_reader;
CREATE ROLE bookstore_admin;

-- Step 2: Grant privileges to roles
GRANT SELECT ON bookstore_db.* TO bookstore_reader;
GRANT ALL PRIVILEGES ON bookstore_db.* TO bookstore_admin;

-- Step 3: Create users with password
CREATE USER 'reader_user'@'localhost' IDENTIFIED BY 'Reader@123';
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'Admin@123';

-- Step 4: Grant roles to users
GRANT bookstore_reader TO 'reader_user'@'localhost';
GRANT bookstore_admin TO 'admin_user'@'localhost';



                                     -- Test the database by running queries to retrieve and analyze the data

-- 1. Retrieve all authors and their books
SELECT author.name AS author_name, book.title AS book_title
FROM author
JOIN book_author ON author.author_id = book_author.author_id
JOIN book ON book_author.book_id = book.book_id;

-- 2. Get all books along with their publisher and language
SELECT book.title AS book_title, publisher.name AS publisher_name, book_language.language_name AS language
FROM book
JOIN publisher ON book.publisher_id = publisher.publisher_id
JOIN book_language ON book.language_id = book_language.language_id;

-- 3. Find all customers and their addresses
SELECT customer.name AS customer_name, address.street, address.city, address.postal_code, address_status.status_name AS address_status
FROM customer
JOIN customer_address ON customer.customer_id = customer_address.customer_id
JOIN address ON customer_address.address_id = address.address_id
JOIN address_status ON customer_address.status_id = address_status.status_id;

-- 4. Retrieve all orders and their statuses
SELECT cust_order.order_id, customer.name AS customer_name, cust_order.order_date, order_status.status_name AS order_status
FROM cust_order
JOIN customer ON cust_order.customer_id = customer.customer_id
JOIN order_status ON cust_order.status_id = order_status.status_id;

-- 5. Get details of all books in an order
SELECT order_line.order_id, book.title AS book_title, order_line.quantity, book.price, (order_line.quantity * book.price) AS total_price
FROM order_line
JOIN book ON order_line.book_id = book.book_id;

-- 6. Find the history of order status changes
SELECT order_history.order_id, order_status.status_name AS order_status, order_history.changed_at
FROM order_history
JOIN order_status ON order_history.status_id = order_status.status_id;

-- 7. Retrieve all shipping methods and their orders
SELECT shipping_method.method_name, cust_order.order_id, customer.name AS customer_name
FROM cust_order
JOIN shipping_method ON cust_order.shipping_method_id = shipping_method.shipping_method_id
JOIN customer ON cust_order.customer_id = customer.customer_id;

-- 8. Calculate the total price of all orders
SELECT SUM(order_line.quantity * book.price) AS total_sales
FROM order_line
JOIN book ON order_line.book_id = book.book_id;


