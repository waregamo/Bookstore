B# Bookstore_db

## Overview

**Bookstore_db** is a collaborative SQL project designed to manage and streamline bookstore operations through a structured relational database. Built using MySQL, this system organizes key data including books, authors, customers, orders, addresses, and shipping logistics. It enables efficient data management and insightful querying for real-world bookstore operations.

## Team Members

- **Warega Moses** – Database Design  
- **Esther Irungu** – Data Insertion  
- **Brendah Warigia** – Query Development

## Database Structure

The database consists of 15 interconnected tables:

1. **author** – Stores information about authors.  
2. **book** – Contains details about books such as title, price, and publication year.  
3. **book_language** – Lists possible languages books can be written in.  
4. **publisher** – Stores information about publishers.  
5. **country** – Contains country names for address mapping.  
6. **address** – Stores physical addresses.  
7. **address_status** – Specifies whether an address is current, old, work, etc.  
8. **shipping_method** – Contains shipping methods like standard, express, etc.  
9. **order_status** – Lists possible statuses of orders (e.g., pending, shipped).  
10. **customer** – Stores customer information.  
11. **customer_address** – Maps customers to their addresses.  
12. **cust_order** – Tracks orders made by customers.  
13. **book_author** – Resolves the many-to-many relationship between books and authors.  
14. **order_line** – Stores the books included in each order.  
15. **order_history** – Tracks status changes in customer orders.

## Getting Started

### Prerequisites

- MySQL Server installed and running
- MySQL client (e.g., MySQL Workbench, phpMyAdmin, or command line)

### Installation

1. **Clone the repository** or **download the SQL script**.
2. Open your MySQL client and connect to your server.
3. Run the following command to create the database:

   ```sql
   CREATE DATABASE bookstore_db;
   USE bookstore_db;
