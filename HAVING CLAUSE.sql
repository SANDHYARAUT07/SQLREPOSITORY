-- HAVING CLAUSE
-- IN MYSQL THE HAVING CLUASE IS USED TO FILTER THE RESULTS OF A GROUP BY QUERY IT ALLOW US TO APPLY CONDITION GROUP OF ROWS RATHER THAN INDIVIDUAL ROWS

-- NOTE KEY POINT
-- 1.THE HAVING CLAUSE IS USED TO GROUP BY CLAUSE TO FILTER GROUPPED DATA
-- 2.IT CAN BE USED WITH AGGRIGATE FUNCTION LIKE COUNT(),SUM(),MAX(),MIN(),AVG() ETC.

-- SYNTAX
-- SELECT COLUMN1,COLUMN2,AGGREGATE_FUNCTION (COLUMN3)
-- FROM TABLE_NAME
-- WHERE CONDITION
-- GROUP BY COLUMN1,COLUMN2
-- HAVING AGRIGATE_CONDITION;

USE join_sql;

-- Count the number of employee in each department where the count is grater than 5.
SELECT deptno,COUNT(empno) AS employee_count
FROM emp
GROUP BY deptno
HAVING COUNT(empno) >5;

-- Find departments with a total salary sum grater than 100000
SELECT d.dname,SUM(e.sal) AS total_salary
FROM emp e
JOIN dept d
ON e.deptno=d.deptno
GROUP BY d.dname
HAVING SUM(e.sal) > 10000;


CREATE TABLE ProductSales (
    Product_ID INT,
    Sale_Date DATE,
    Quantity INT
);



INSERT INTO ProductSales (Product_ID, Sale_Date, Quantity) VALUES
(1, '2024-12-01', 50),
(1, '2024-12-02', 60),
(2, '2024-12-01', 120),
(2, '2024-12-03', 80),
(3, '2024-11-30', 30),
(3, '2024-12-02', 40),
(4, '2024-12-04', 200),
(5, '2024-12-05', 90),
(5, '2024-12-06', 20);
SELECT*FROM  productsales;


-- 	Q1.Query : Find the products that sold more than 100 units in total
SELECT product_id,SUM(quantity) AS total_sales
FROM productsales
GROUP BY product_id
HAVING SUM(quantity) >100;

-- Q2.Find the products that sold more than 100 units by filtering sales after 01-12-2024.
SELECT product_id,SUM(quantity) AS total_sales 
FROM productsales
WHERE sale_date > 01-12-2024
GROUP BY product_id
HAVING SUM(quantity) >100
ORDER BY product_id
LIMIT 4;

-- Differeance between WHERE AND HAVING
-- 1.WHERE is used to filter individual row before the data is grouped
-- 2.HAVING is used to filter after the data has been grouped