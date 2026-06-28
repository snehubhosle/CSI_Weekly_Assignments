/*
Assignment No: Week 2 SQL Assignment
Database : Ecommerce_sales
Section: A-SQL Basics
Author: Snehal Bhosale
College: Sanjivani College OF Engineering, Kopargaon
E-mail: snehalbhosale1807@gmail.com
*/

-- Index for filtering by city/state 
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state);

-- Index for filtering by category 
CREATE INDEX idx_products_category ON products(category); 

-- Index for date-based filtering and sorting 
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 