-- Active: 1735540108712@@127.0.0.1@3306@join_sql
SELECT*from emp;
SELECT*FROM dept;
SELECT*FROM salgrade;


-- Queries using ROW_NUMBER()
-- 1.	Assign a unique rnk to each employee by salary within each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RN 
FROM EMP;

-- 2.	Find the top 3 highest-paid employees in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM(
    SELECT EMPNO,ENAME,DEPTNO,SAL,
    ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY SAL) AS RNK
    FROM EMP) SUB
WHERE RNK =3;

-- 3.	List employees in order of hire date within each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE ) AS RNK 
FROM EMP;


-- Queries using RANK()
-- 4.	Rank employees by salary, allowing ties, within each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK 
FROM EMP;

-- 5.	Find employees with the second highest salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM(
    SELECT EMPNO,ENAME,DEPTNO,SAL,
    RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK 
    FROM EMP) SUB
WHERE RNK= 2;

-- Queries using DENSE_RANK()
-- 6.	Dense rnk employees by salary within the entire company.
SELECT EMPNO,ENAME,SAL,
DENSE_RANK() OVER(ORDER BY SAL DESC) AS DENSERANK 
FROM EMP;

-- 7.	Find the salary rnk for each employee within their department (allow ties).
SELECT EMPNO,ENAME,DEPTNO,SAL,
DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS DESRNK 
FROM EMP;

-- Queries using AVG()
-- 8.	Calculate the average salary of employees in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
ROUND(
AVG(SAL) OVER(PARTITION BY DEPTNO )) AS AVG_SAL_EMPLOYEE 
FROM EMP;

-- 9.	Compare each employee's salary to the average salary in their department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SAL-AVG(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL) AS SALARY_DIFFERANCE
FROM EMP;

-- 10.	Find employees earning above the department average salary.
SELECT EMPNO,ENAME,SAL,DEPTNO
FROM(
    SELECT EMPNO,ENAME,SAL,DEPTNO,
    AVG(SAL) OVER(PARTITION BY DEPTNO ) AVG_SAL 
    FROM EMP) SUB 
    WHERE SAL > AVG_SAL;

-- Queries using SUM()
-- 11.	Calculate the total salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SUM(SAL) OVER(PARTITION BY DEPTNO ) AS TOTAL_SALARY
FROM EMP;

-- 12.	Find the cumulative salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS CUMULATIVE_SALARY 
FROM EMP;

-- 13.	Calculate the company's total salary for comparison.
SELECT EMPNO,ENAME,SAL,
SUM(SAL) OVER() AS TOTAL_SALARY 
FROM EMP;

-- Queries using COUNT()
-- 14.	Count the number of employees in each department.
SELECT EMPNO,ENAME,DEPTNO,
COUNT(*) OVER(PARTITION  BY DEPTNO) AS DEPT_EMPLOYEE_COUNT 
FROM EMP;

-- Find the running total of employees in each department by hire date.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
COUNT(*) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS TOTAL_EMPLOYEE 
FROM EMP;

-- Queries using MAX() and MIN()
-- 15.	Find the highest salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
MAX(SAL) OVER(PARTITION BY DEPTNO) AS MAX_SAL 
FROM EMP;

-- 16.	List employees who earn the highest salary in their department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM(
    SELECT EMPNO,ENAME,DEPTNO,SAL,
    MAX(SAL) OVER(PARTITION BY DEPTNO) AS MAX_SALARY
    FROM EMP) SUB
    WHERE SAL=MAX_SALARY;


-- 17.	Find the hire date of the earliest employee in each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
MAX(HIREDATE) OVER(PARTITION BY DEPTNO ) AS EARLIEST_EMPLOYEE 
FROM EMP;

-- Queries combining multiple functions
-- 18.	Rank employees by salary and find the cumulative salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS TOTAL_SALARY
FROM EMP;

-- 19.	Find the percentage of total department salary each employee earns.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SAL/SUM(SAL) OVER(PARTITION BY DEPTNO )*100 AS TOTAL_SALARY 
FROM EMP;

-- Queries exploring complex conditions
-- 20.	List employees hired after the department's first hire date.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM(
    SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
    MIN(HIREDATE) OVER(PARTITION BY DEPTNO) AS FIRST_HIREDATE 
    FROM EMP) SUB
    WHERE HIREDATE > FIRST_HIREDATE;

-- 21.	Rank employees within salary grades.
SELECT E.EMPNO,E.ENAME,E.SAL,SG.GRADE,
RANK() OVER(PARTITION BY SG.GRADE ORDER BY E.SAL DESC) AS ENK_WITHIN_GRADE
FROM EMP E
JOIN SALGRADE SG 
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- Advanced Queries Using ROW_NUMBER()
-- 22.	Find the second newest hire in each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM(
    SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
    ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE DESC) AS LATEST_HIREDATE
    FROM EMP) SUB 
    WHERE LATEST_HIREDATE=2;

-- 23.	Rank employees based on hire date across the entire company.
SELECT EMPNO,ENAME,HIREDATE,JOB,DEPTNO,
RANK() OVER(ORDER BY HIREDATE ASC) AS HIRE_RANK
FROM EMP;

-- 24.	List employees in each department with an alternate row color rnk (for reporting purposes).
SELECT empno,ename,sal,job,
CASE 
    WHEN ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC)%2 THEN "EVEN"
    ELSE "ODD"
    END AS ROW_COLOR
    FROM EMP;

--     Advanced Queries Using RANK()
-- 26.	Rank employees by commission within their department.
SELECT empno,ename,deptno,comm,
RANK() OVER(PARTITION BY deptno ORDER BY COMM DESC ) AS EMPLOYEE_RANK
FROM EMP
WHERE COMM IS NOT NULL;

-- 27.	Find employees with the second highest commission in each department.
SELECT empno,ename,deptno,comm
FROM(
    SELECT empno,ename,deptno,comm,
    RANK() OVER(PARTITION BY deptno ORDER BY comm DESC ) AS COMM_RNK 
    FROM EMP
    WHERE COMM IS NOT NULL) AS SUB
WHERE COMM_RNK >2;

-- Advanced Queries Using DENSE_RANK()
-- 28.	Dense rnk employees by job title and salary within each department.
SELECT empno,ename,job,sal,deptno,
DENSE_RANK() OVER(PARTITION BY deptno,job ORDER BY sal DESC) AS employee_dense_rank
FROM emp;

-- 29.	Find the top 2 highest-paid employees for each job role across the company.
SELECT empno,ename,job,deptno,sal
FROM(
    SELECT empno,ename,job,deptno,sal,
    DENSE_RANK() OVER(PARTITION BY job ORDER BY sal DESC ) as JOB_RANK
    FROM emp) SUB 
    WHERE JOB_RANK <=2;

-- Advanced Queries Using AVG()
-- 30.	Calculate the average salary by job role across all departments.
SELECT empno,ename,sal,job,
AVG(sal) OVER( PARTITION BY job) AS AVG_SALARY_FOR_JOB
FROM emp;


-- 31.	Identify employees whose salary is below the company average.
SELECT empno,ename,sal
FROM(
    SELECT empno,ename,sal,
    AVG(sal) OVER(ORDER BY sal DESC) AS  COMPANY_AVERAGE
    FROM emp) SUB
    WHERE sal < COMPANY_AVERAGE;

SELECT empno,ename,sal,
AVG(sal) OVER() AS COMPANY_AVERAGE_SALARY
FROM emp
WHERE sal<(SELECT AVG(sal) OVER());

-- 32.	Compare each employee's commission with the average commission in their department.
SELECT empno,ename,comm,deptno,
AVG(comm) OVER(PARTITION BY deptno) AS avg_commission
FROM emp
WHERE COMM IS NOT NULL;



-- Advanced Queries Using SUM()
-- 33.	Calculate the cumulative commission for each department.
SELECT empno,ename,deptno,comm,
SUM(COMM) OVER(PARTITION BY deptno ORDER BY comm) AS CUMULATIVE_COMMISSION
FROM emp
WHERE comm IS NOT NULL;

-- 34.	Find employees contributing more than 20% to their department's total salary.
SELECT empno,ename,deptno,sal,
sal/SUM(sal) OVER(PARTITION BY deptno)*100 AS contributing_percentage
FROM emp
WHERE sal/SUM(sal) OVER(PARTITION BY deptno)*100 >20;

-- 35.	Calculate the total salary of employees under each manager.
SELECT empno,sal,mgr,
SUM(sal) OVER(PARTITION BY mgr) as SALARY_EACH_MANAGER
FROM emp;


-- Advanced Queries Using COUNT()
-- 36.	Find the number of employees reporting to each manager.
SELECT empno,ename,mgr,
COUNT(*) OVER(PARTITION BY mgr) AS REPORTING_EACH_MANAGER
FROM emp;


-- 37.	List employees who are the only ones in their department with their job title.
SELECT empno,ename,job,deptno
FROM (
    SELECT empno,ename,job,deptno,
    COUNT(*) OVER(PARTITION BY deptno,job) AS COUNT_EMPLOYEE
    FROM EMP) SUB
    WHERE COUNT_EMPLOYEE =1;


-- 38.	Count employees hired before each employee in their department.
SELECT empno,ename,hiredate,deptno,
COUNT(*) OVER(PARTITION BY deptno ORDER BY hiredate ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS COUNT_EMPLOYEE
FROM emp;

-- Advanced Queries Using MAX() and MIN()
-- 39.	Find the latest hire date in each department.
SELECT empno,ename,hiredate,deptno,
MAX(hiredate) OVER(PARTITION BY deptno) AS LATEST_HIREDATE
FROM emp;


-- 40.	List employees who were hired on the latest hire date in their department.
SELECT empno,ename,hiredate,deptno
FROM(
    SELECT empno,ename,hiredate,deptno,
    MAX(hiredate) OVER(PARTITION BY deptno) AS latest_hiredate
    FROM emp) SUB
    WHERE HIREDATE=latest_hiredate;


    --  41.	Find employees whose salary matches the lowest salary in their department.   
    SELECT empno,ename,sal,deptno
    FROM(
        SELECT empno,ename,sal,deptno,
        MIN(sal) OVER(PARTITION BY deptno) AS LOWEST_SALARY
        FROM emp) SUB
        WHERE sal=LOWEST_SALARY;

-- Advanced Multi-Function Queries
-- 42.	Rank employees by salary, and calculate the cumulative salary and percentage of total salary.
SELECT empno,ename,sal,deptno,
RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) AS RNK_OF_EMPLOYEE,
SUM(sal) OVER(PARTITION BY deptno ORDER BY sal DESC) AS CUMULATIVE_SALARY,
sal/SUM(sal) OVER(PARTITION BY deptno ORDER BY sal DESC)*100 AS SALARY_PERCENTAGE
FROM emp;

-- 43.	List employees with their hire order and cumulative salary within their department.

SELECT empno,ename,sal,deptno,hiredate,
ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY hiredate) AS HIREDATE,
SUM(sal) OVER(PARTITION BY deptno ORDER BY hiredate) AS CUMULATIVE_SALARY
FROM emp;

-- 44.	Calculate the average and median salary within each department.
SELECT empno,ename,sal,deptno,
AVG(sal) OVER(PARTITION BY deptno) AS AVG_SALARY,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY sal)
OVER(PARTATION BY deptno) AS MEDIAN_SALARY
FROM emp;



-- Advanced Queries Using ROW_NUMBER()
-- 45.	Find the employee hired most recently in each department.
SELECT empno,ename,hiredate,deptno
FROM(
    SELECT empno,ename,hiredate,deptno,
    ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY hiredate DESC) AS RNK
    FROM emp) SUB
    WHERE RNK=1;


-- 46.	Assign unique IDs to employees within salary brackets.
SELECT empno,ename,sal,
ROW_NUMBER() OVER(PARTITION BY CASE
                WHEN sal BETWEEN 700 AND 1200 THEN "Low"
                WHEN sal BETWEEN 1201 AND 2000 THEN"Medium"
                ELSE "High"
                END ORDER BY sal ) AS Bracket_id
FROM emp;

-- 47.	Identify employees in descending hire date order across departments
SELECT empno,ename,hiredate,deptno,
ROW_NUMBER() OVER( ORDER BY deptno,hiredate DESC) AS hiredate
FROM emp;


-- Advanced Queries Using RANK()
-- 48.	Rank employees by job title within each department.
SELECT empno,ename,job,sal,deptno,
RANK() OVER(PARTITION BY deptno,job ORDER BY sal DESC) AS RAK 
FROM emp;


-- 49.	Find the top-rnked employees by salary for each job type.
SELECT empno,ename,job,sal
FROM(
    SELECT empno,ename,job,sal,
    RANK() OVER(PARTITION BY job ORDER BY sal) AS RNK 
    FROM emp) SUB 
    WHERE RNK=1;

-- Advanced Queries Using DENSE_RANK()
-- 50.	Dense rnk employees based on hire date within the company.
SELECT empno,ename,hiredate,
DENSE_RANK() OVER(ORDER BY hiredate) AS hire_rnk
FROM emp;

-- 51.	Find employees sharing the same hire rnk as their department’s earliest hires.
SELECT empno,ename,deptno,hiredate
FROM(
    SELECT empno,ename,deptno,hiredate,
    DENSE_RANK() OVER(PARTITION BY deptno ORDER BY hiredate) AS RNK
    FROM emp) SUB
    WHERE RNK=1;

-- Advanced Queries Using AVG()
-- 52.	Find departments where employees' salaries exceed the average department salary.
SELECT empno,ename,deptno,sal,
AVG(sal) OVER(PARTITON BY deptno) AS average_department_salary
FROM emp
WHERE sal >(SELECT AVG(sal) OVER(PARTITION BY deptno));

-- 53.	Calculate moving average salary in each department by hire date.
SELECT empno,ename,sal,deptno,hiredate,
AVG(sal) OVER(PARTITION BY deptno ORDER BY hiredate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_salary
FROM emp;

-- Advanced Queries Using SUM()
-- 54.	Calculate the cumulative sum of salaries company-wide.
SELECT empno,ename,sal,
SUM(sal) OVER(ORDER BY sal DESC) AS CUMULATIVE_SALARY
FROM emp;

-- 55.	Find departments where the cumulative salary exceeds 5000.
SELECT empno,ename,deptno,sal,
SUM(sal) OVER(PARTITION BY deptno ORDER BY sal DESC) AS CUMULATIVE_SALARY
FROM emp
WHERE SUM(sal) OVER(PARTITION BY deptno ORDER BY sal DESC)> 5000;


-- Advanced Queries Using COUNT()
-- 56.	Count employees grouped by job titles company-wide.
SELECT empno,ename,job,
COUNT(*) OVER(PARTITION BY JOB) AS JOB_TITLES
FROM emp;

-- 57.	Find the running total of employees in each department by hire date.
SELECT empno,deptno,hiredate,
SUM(hiredate) OVER(PARTITION BY deptno ORDER BY hiredate) AS running_total
FROM emp;
