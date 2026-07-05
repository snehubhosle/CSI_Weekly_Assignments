/*
 Project : SQL Advanced Analytics 
 Dataset: Superstore Dataset
 Author  : Snehal Bhosale
 Week    : 3
 Database: MySQL Workbench

 Objective: Create a dedicated database for performing advanced SQL analysis
 on the Superstore dataset.
*/

DROP DATABASE IF EXISTS superstore_db;

CREATE DATABASE superstore_db;

USE superstore_db;

SHOW DATABASES;

SELECT DATABASE() AS current_database;