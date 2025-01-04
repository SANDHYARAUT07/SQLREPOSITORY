-- Active: 1735540108712@@127.0.0.1@3306@join_sql
show tables;
SELECT*FROM DEPT;
SELECT*FROM  emp;
SELECT*FROM salgrade;

-- Rank employees based on their job   and hiredate within there department 
SELECT EMPNO,ENAME,DEPTNO,JOB,HIREDATE,
ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE ASC) AS RN 
FROM EMP;

-- Find employees with the THIRD highest salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM(SELECT EMPNO,ENAME,DEPTNO,SAL,
        RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RANK_SALARY
        FROM EMP) SUBQUER
        WHERE RANK_SALARY = 3;

-- Rank employees based on there total earning (salary+commission) within the salary
SELECT EMPNO,ENAME,SAL,COMM,
RANK() OVER(ORDER BY SAL + IFNULL(COMM,0) DESC) AS SALARY_RANK
FROM EMP;

SELECT EMPNO,ENAME,SAL,COMM,
DENSE_RANK() OVER(ORDER BY SAL + IFNULL(COMM,0) DESC) AS SALARY_RANK
FROM EMP;

-- Identify the top 3 earning emloyees (without gap)
SELECT *
FROM(SELECT EMPNO,ENAME,SAL,COMM,
 DENSE_RANK() OVER (ORDER BY SAL+ IFNULL(COMM,0) DESC) AS SALARY_RANK
FROM EMP) SUB 
WHERE SALARY_RANK <= 3;


-- Basic Questions
-- Rank Employees by Salary
-- Write a query to rank employees in the emp table based on their salaries (highest to lowest) using the RANK() function.
SELECT  EMPNO,ENAME,SAL,
RANK() OVER(ORDER BY SAL DESC) AS RANK_EMPLOYEE
FROM EMP;

-- Calculate Running Total of Salaries
-- Display a running total of salaries in the emp table using the SUM() window function.
SELECT EMPNO,ENAME,SAL,DEPTNO,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS TOTAL_SALARY
FROM EMP;

-- Calculate Average Salary per Department
-- Use a window function to calculate the average salary for employees in each department.
SELECT EMPNO,ENAME,SAL,DEPTNO,
AVG(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS AVG_SALARY_DEPARTMENT
FROM EMP;

-- Assign Row Numbers to Employees
-- Assign a row number to each employee, ordered by their hiring date (hire_date).
SELECT EMPNO,ENAME,HIREDATE,
ROW_NUMBER() OVER(ORDER BY HIREDATE ASC) AS  RN 
FROM EMP;

-- Cumulative Salary Percentage
-- Write a query to calculate the cumulative percentage of total salary using the SUM() function and a window clause.
SELECT EMPNO,ENAME,SAL,
SUM(SAL) OVER(ORDER BY SAL ASC) AS CUMMILATIVE_SALARY,
SUM(SAL) OVER() AS TOTAL_SALARY,
ROUND(
      SUM(SAL) OVER(ORDER BY SAL) *100.0/SUM(SAL) OVER(),2)
FROM emp
ORDER BY SAL;

