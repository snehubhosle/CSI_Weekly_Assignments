/*
Assignment No.: 08
Title          : E-Commerce Order Analytics System
Author         : Snehal A. Bhosale
College        : Sanjivani College of Engineering, Kopargaon
Email          : snehalbhosale1807@gmail.com
Database       : ecommerce_analytics
Tool           : MySQL Workbench

Objective:
Design and develop an end-to-end e-commerce order analytics
system using Python and SQL.

Phase:
SQL Database Schema Creation

Description:
Create relational tables for customers, products, orders,
and order_items with appropriate Primary Keys and
Foreign Key relationships.
*/

DROP DATABASE IF EXISTS ecommerce_analytics;

CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;

CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    registration_date DATE,
    customer_type VARCHAR(20)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    subcategory VARCHAR(100),
    cost_price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_date DATETIME,
    status VARCHAR(20),
    region_code VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

USE ecommerce_analytics;

SHOW TABLES;

DESCRIBE customers;