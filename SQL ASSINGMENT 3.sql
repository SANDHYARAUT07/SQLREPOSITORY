CREATE DATABASE practice;
USE practice;

CREATE TABLE department(
department_id INT NOT NULL PRIMARY KEY,
department_name VARCHAR(20) NOT NULL);

DESC department;

INSERT INTO department
(department_id,department_name)
VALUES
(101,"IT"),
(102,"DA"),
(103,"DS"),
(104,"DA");

SELECT* FROM department;

-- ALTER TABLE ADD FUNCTION

ALTER TABLE department
ADD no_emp INT NOT NULL;

-- MODIFY FUNCTION

ALTER TABLE department MODIFY department_name VARCHAR(25);
DESC department;

-- DROP FUNCTION
ALTER TABLE department
DROP no_emp;
DESC department;

-- ADD FOREIGN KEY
CREATE TABLE temp1(
dept_id INT NOT NULL,
dept_name VARCHAR(20) NOT NULL);

ALTER TABLE temp1
ADD CONSTRAINT dept_id PRIMARY KEY(dept_id);
DESC temp1;

-- ADD FOR FOREIGN KEY

CREATE TABLE emp(
emp_id INT NOT NULL PRIMARY KEY,
emp_name VARCHAR(20) NOT NULL,
salary DECIMAL(8,2) NOT NULL,
department_id INT NOT NULL);

DESC emp;

ALTER TABLE emp
ADD CONSTRAINT department_id FOREIGN KEY(department_id) REFERENCES department(department_id);
DESC emp;

-- DROP FUNCTION
ALTER TABLE emp
DROP PRIMARY KEY;
DESC emp;

-- SELECT COMMAND

USE sakila;
SELECT * FROM actor;
SELECT first_name,last_name FROM actor;
SELECT DISTINCT first_name,last_name FROM actor;
SELECT DISTINCT first_name FROM actor;
SELECT DISTINCT last_name FROM actor;

-- AS FUNCTION
SELECT first_name AS fname FROM actor;
SELECT last_name AS surname FROM actor;

-- WHERE CONDITION
SELECT* FROM address
WHERE district="California";

SELECT address, district,postal_code 
FROM address WHERE district="california";

SELECT COUNT(*) FROM address
WHERE district="California";

-- BETWEEN AND

USE practice;
CREATE TABLE emp2(
emp2_id INT NOT NULL PRIMARY KEY,
emp_name VARCHAR(20) NOT NULL,
salary DECIMAL(8,2) NOT NULL,
dept_no INT NOT NULL);

INSERT INTO emp2
(emp2_id,emp_name,salary,dept_no)
VALUES
(101,"John Doe",4500.00,1),
(102,"Jane Smith",6500.00,2),
(103,"Robert Johnson",8500.00,3),
(104,"Emily Davis",5000.00,4);

SELECT* FROM emp2 WHERE salary BETWEEN 2000 AND 4000;

-- LIKE FUNCTION
USE sakila;
SELECT* FROM actor;
SELECT* FROM actor WHERE first_name LIKE "M%";
SELECT*FROM actor WHERE first_name LIKE "j%";
SELECT COUNT(*) FROM actor WHERE last_name LIKE "VI%";
SELECT COUNT(*) FROM actor WHERE first_name LIKE "J%";
SELECT * FROM actor WHERE first_name LIKE "%VI%";

-- DISTINCT WITH LIKE
SELECT DISTINCT first_name FROM actor
WHERE first_name LIKE "%VI%";

-- LIMIT FUNCTION
SELECT* FROM address LIMIT 10;

-- ORDER BY
USE assingment2;
SELECT * FROM emp
ORDER BY sal ASC;

SELECT* FROM emp
ORDER BY emp_id DESC;

SELECT* FROM emp 
WHERE sal>(SELECT AVG(sal) FROM emp);

SELECT* FROM emp
WHERE sal>2000;

 

