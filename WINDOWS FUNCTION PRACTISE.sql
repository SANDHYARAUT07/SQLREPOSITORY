CREATE DATABASE Windows_function;
USE Windows_function;

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL
);

INSERT INTO employees (name, department_id, salary, hire_date) VALUES
('Alice', 1, 60000, '2020-01-15'),
('Bob', 1, 55000, '2019-03-10'),
('Charlie', 1, 75000, '2021-07-25'),
('David', 2, 50000, '2018-11-05'),
('Eve', 2, 52000, '2017-08-22'),
('Frank', 2, 49000, '2022-06-10'),
('Grace', 3, 67000, '2020-09-30'),
('Hank', 3, 68000, '2021-02-14'),
('Ivy', 3, 70000, '2019-12-18');

SELECT*FROM employees;

CREATE TABLE sales (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    employee_id INT NOT NULL,
    sale_amount DECIMAL(10, 2) NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO sales (product_name, employee_id, sale_amount, sale_date) VALUES
('Laptop', 1, 1200.00, '2023-01-15'),
('Mouse', 1, 25.00, '2023-02-10'),
('Keyboard', 2, 45.00, '2023-01-22'),
('Monitor', 3, 300.00, '2023-03-01'),
('Headphones', 4, 150.00, '2023-04-05'),
('Desk', 5, 200.00, '2023-04-15'),
('Chair', 6, 450.00, '2023-05-18'),
('Printer', 7, 500.00, '2023-05-20'),
('Laptop', 8, 1300.00, '2023-06-25'),
('Tablet', 9, 600.00, '2023-07-01');

SELECT*FROM sales;

-- Aggregate Window Functions
-- Calculate the total salary for each department while retaining each employee's row.
SELECT EMPLOYEE_ID,
DEPARTMENT_ID,
NAME,
SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS TOTAL_SALARY
FROM EMPLOYEES;

-- Compute the cumulative sales amount for each employee by transaction date.
SELECT TRANSACTION_ID,
EMPLOYEE_ID,
SALE_AMOUNT,
SALE_DATE,
SUM(SALE_AMOUNT) OVER(PARTITION BY EMPLOYEE_ID ORDER BY SALE_DATE) AS CUMULATIVE_SALES_AMOUNT
FROM SALES;

-- Ranking Window Functions
-- Rank employees within their department by salary in descending order.
SELECT EMPLOYEE_ID,
NAME,
SALARY,
DEPARTMENT_ID,
HIRE_DATE,
RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS SALARY_RANK
FROM EMPLOYEES;

-- Assign row numbers to all sales transactions, ordered by sale amount.
SELECT TRANSACTION_ID,
EMPLOYEE_ID,
SALE_AMOUNT,
SALE_DATE,
ROW_NUMBER() OVER( ORDER BY SALE_AMOUNT ) AS ROWNUMBER
FROM SALES;









