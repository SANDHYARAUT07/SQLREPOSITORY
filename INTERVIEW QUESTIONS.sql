-- INTERVIEW QUESTION
USE join_sql;

-- Beginner-Level Questions
-- Basic Queries:

-- 1 Write a query to fetch all records from a table named employees.
SELECT*FROM emp;

-- 2 How would you find the unique values in a column named department from the employees table?
SELECT DISTINCT DEPTNO FROM emp;

-- 3 Write a query to select the first 10 rows from the employees table.
SELECT*FROM emp
LIMIT 10;

-- Filtering and Sorting:
-- 4 Write a query to fetch details of employees who earn a salary greater than 50,000.
SELECT 
ename AS employee,
  sal AS salary
 FROM emp 
WHERE Sal >2500;

-- 5 How do you sort the employees table by hire_date in descending order?
SELECT 
ename AS EMPLOYEE,
HIREDATE
FROM emp
ORDER BY HIREDATE DESC;

-- Aggregations:

-- 6 How would you calculate the total salary paid to employees in the IT department?
SELECT ename,D.DNAME,SUM(E.SAL) AS TOTAL_SALARY
FROM emp e
JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname ="Sales"
GROUP BY e.ename;

-- 7 Write a query to find the average salary of all employees.
SELECT ROUND(AVG(SAL)) FROM EMP;

-- Joins:
-- Explain the difference between INNER JOIN, LEFT JOIN, and RIGHT JOIN.
-- INNER JOIN= INNER JOIN RETURN ALL THE MACH RECORD FROM BOTH THE TABLE .
-- LEFT JOIN=IT RETURNS THE RECORD FROM LEFT TABLE AND MACHED RECORD FROM RIGHT TABLE REMAINING VALUES SHOULD BE NULL.
-- RIGHT JOIN=IT RETURN RECORD FROM RIGHT TABLE AND MACHED RECORD FROM LEFT TABLE REMAINING VALUES SHOULD BE NULL.

-- 8.Write a query to fetch employee names along with their respective department names using tables employees and departments.
SELECT 
e.ename AS employee,
d.dname as department
FROM emp e
JOIN dept d
ON e.deptno=d.deptno;

-- Intermediate-Level Questions
-- Group By and Having Clause:

-- 9.Write a query to count the number of employees in each department.
SELECT d.dname,COUNT(e.empno) AS no_of_employee
FROM dept d
RIGHT JOIN emp e
ON d.deptno=e.deptno
GROUP BY d.dname
HAVING COUNT(e.empno);

-- 10 How would you fetch only those departments with more than 5 employees?
SELECT d.dname,COUNT(e.empno) AS NO_OF_EMPLOYEE
FROM dept d
RIGHT JOIN emp e
ON d.deptno=e.deptno
GROUP BY d.dname
HAVING COUNT(e.empno) >5;

-- Subqueries:
-- 11 Write a query to find employees who earn more than the average salary.
SELECT ename,sal
FROM EMP
WHERE SAL >(SELECT AVG(SAL) FROM EMP);
SELECT AVG(SAL) FROM EMP;

-- 12 How can you fetch the details of employees who joined after the most recently hired employee in the employees table?
SELECT *FROM EMP
WHERE HIREDATE >=(SELECT MAX(HIREDATE) FROM EMP);

-- Window Functions:

-- What is the difference between RANK() and ROW_NUMBER()? Write queries to demonstrate their usage.
-- Write a query to calculate a running total of salaries for all employees.


-- Advanced-Level Questions
-- Data Manipulation:

-- Write a query to update the salary of employees in the HR department by 10%.
SELECT 
ename AS EMPLOYEE,
dname AS DEPARTMENT_NAME,
e.sal AS SALARY
FROM emp e
LEFT JOIN dept d
ON e.deptno=d.deptno
UPDATE E.EMP SET E.SAL=SAL+(SAL*10/100)
WHERE D.DNAME ="Sales"
SELECT*FROM DEPT;

-- How would you delete duplicate records from a table?
-- Complex Joins and Scenarios:

-- You have two tables, orders and customers. Write a query to fetch customer names who have placed no orders.

-- Write a query to find the second highest salary in the employees table.
SELECT ename,sal
FROM EMP 
ORDER BY SAL DESC
LIMIT 2;

-- Optimization and Performance:
-- What are indexes in SQL, and how do they improve query performance?
-- How would you identify slow-performing queries in a database?
