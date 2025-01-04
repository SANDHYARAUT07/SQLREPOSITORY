/*Problem 1: Create the students Table with Constraints
---------
student_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
first_name: A string (VARCHAR) with a length of 100, which cannot be NULL.
last_name: A string (VARCHAR) with a length of 100, which cannot be NULL.
email: A string (VARCHAR) with a length of 255, which must be UNIQUE and NOT NULL.
birthdate: A DATE column with no constraints (can be NULL).*/

CREATE DATABASE question;
USE question;

CREATE TABLE student(
student_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
birthdate DATE);
 
 
 -- Problem 2: Create the courses Table with Constraints
-- ---------
-- course_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
-- course_name: A string (VARCHAR) with a length of 200, which cannot be NULL.
-- credit_hours: An integer that must be between 1 and 5. Use a CHECK constraint.
-- department_id: A foreign key that references the department_id in the departments table. The department_id must be a valid ID from the departments table.

CREATE TABLE department(
department_id INT PRIMARY KEY NOT NULL,
department_name VARCHAR(50) NOT NULL);

CREATE TABLE courses(
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(200) NOT NULL,
credit_hours INT CHECK(credit_hours BETWEEN 1 AND 2),
department_id INT NOT NULL,
FOREIGN KEY(department_id) references department(department_id));



-- Problem 3: Create the departments Table with Constraints
-- ----------
-- department_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
-- department_name: A string (VARCHAR) with a length of 100, which must be NOT NULL and UNIQUE.
-- location: A string (VARCHAR) with a length of 255 that can be NULL.

CREATE TABLE departments(
department_id INT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(100) NOT NULL UNIQUE,
location VARCHAR(255));

-- Problem 2: Create the courses Table with Constraints
-- ---------
-- course_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
-- course_name: A string (VARCHAR) with a length of 200, which cannot be NULL.
-- credit_hours: An integer that must be between 1 and 5. Use a CHECK constraint.
-- department_id: A foreign key that references the department_id in the departments table. The department_id must be a valid ID from the departments table.

CREATE TABLE course(
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(200) NOT NULL,
credit_hours INT CHECK(credit_hours BETWEEN 1 AND 5),
department_id INT NOT NULL,
FOREIGN KEY(department_id) references department(department_id));

-- Problem 3: Create the departments Table with Constraints
-- ----------
-- department_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
-- department_name: A string (VARCHAR) with a length of 100, which must be NOT NULL and UNIQUE.
-- location: A string (VARCHAR) with a length of 255 that can be NULL.

CREATE TABLE department(
department_id INT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(100) NOT NULL UNIQUE,
location VARCHAR(255) NULL);

-- Problem 4: Create the customers Table with Constraints
-- ----------
-- customer_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
-- first_name: A string (VARCHAR) with a length of 100, which cannot be NULL.
-- last_name: A string (VARCHAR) with a length of 100, which cannot be NULL.
-- email: A string (VARCHAR) with a length of 255, which must be UNIQUE and NOT NULL.
-- phone_number: A string (VARCHAR) with a length of 15, which can be NULL.

CREATE TABLE customers(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
phone_number VARCHAR(15));


-- Problem 5: Create the products Table with Constraints
-- ----------
-- product_id: An integer that serves as the PRIMARY KEY and is AUTO_INCREMENT.
-- product_name: A string (VARCHAR) with a length of 100, which must be NOT NULL and UNIQUE.
-- price: A decimal column with precision DECIMAL(10, 2) that must be greater than 0 (use a CHECK constraint).
-- stock_quantity: An integer that must be greater than or equal to 0 (use a CHECK constraint).

CREATE TABLE constraints(
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100) NOT NULL UNIQUE,
price DECIMAL(10,2) CHECK(price>0),
stock_quantity INT CHECK(stock_quantity >=0));

DESC constraints;

SELECT * FROM constraints

SELECT * FROM new_table
DESC new_table;