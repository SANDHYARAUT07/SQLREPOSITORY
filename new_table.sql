USE sample_db;

desc new_table;

INSERT INTO new_table
VALUES
(101,"Sandhya",22,50000,"2024-12-13","DA");

SELECT * FROM new_table;
USE new_table;
desc new_table;

CREATE DATABASE S;
USE s;

CREATE TABLE dept(
dept_no INT PRIMARY KEY NOT NULL,
dept_name VARCHAR(100) NOT NULL);
DESC dept;

INSERT INTO dept
(dept_no,dept_name)
VALUES
(1,"Sales"),
(2,"Engineering"),
(3,"HR"),
(4,"Finance");

SELECT*FROM dept;

CREATE TABLE emp(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
sal DECIMAL(8,2),
dept_no INT,
foreign key (dept_no) references dept(dept_no));

INSERT INTO emp
(emp_id,emp_name,sal,dept_no)
VALUES
(101,'John Doe',4500.00,1),
(102,'Jane Smith',6500.00,2),
(103,'Emily Davis',5000.00,4),
(104,'Robert Johnson',8500.00,3);
SELECT*FROM emp;


CREATE TABLE salary(
grade INT PRIMARY KEY,
low_salary DECIMAL(8,2) NOT NULL,
high_salary DECIMAL(8,2) NOT NULL);

INSERT INTO salary
(grade,low_salary,high_salary)
VALUES
(1,2000.00,4000.00),
(2,4000.01,6000.00),
(3,6000.01,8000.00),
(4,8000.01,10000.00);
SELECT*FROM salary;

-- SELECT ALL DEPARTMENTS WHERE DEPARTMENT NO IS GRATER THAN TWO --
SELECT*FROM dept
WHERE dept_no > 2;

-- SELECT TOTAL NO OF EMPLOYEE
SELECT COUNT(*) FROM emp;

-- select all the employee whose dept number is 1
SELECT*FROM emp;
SELECT*FROM emp
WHERE dept_no=1;

-- INCREASE THE SALARY OF ALL EMPLOYEE 15%
SELECT*FROM emp
UPDATE emp SET sal=sal+sal(sal*15/100);

