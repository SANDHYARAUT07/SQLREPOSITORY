CREATE DATABASE window_assignment;
USE window_assignment;

CREATE TABLE dept (
  deptno INTEGER,
  dname  VARCHAR(14),
  loc    VARCHAR(13),
  CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

CREATE TABLE emp (
  empno    INTEGER,
  ename    VARCHAR(10),
  job      VARCHAR(9),
  mgr      INTEGER,
  hiredate DATE,
  sal      DECIMAL(7,2),
  comm     DECIMAL(7,2),
  deptno   INTEGER,
  CONSTRAINT pk_emp PRIMARY KEY (empno),
  CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
);

create table salgrade (
  grade integer,
  losal integer,
  hisal integer,
  constraint pk_salgrade primary key (grade)
);

insert into salgrade (grade, losal, hisal)
       values        (1,      700,  1200),
                     (2,     1201,  1400),
                     (3,     1401,  2000),
                     (4,     2001,  3000),
                     (5,     3001,  9999);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH'  , 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES'     , 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp VALUES (7839, 'KING'  , 'PRESIDENT', NULL, STR_TO_DATE('17-11-1981', '%d-%m-%Y'), 5000, NULL, 10);
INSERT INTO emp VALUES (7698, 'BLAKE' , 'MANAGER'  , 7839, STR_TO_DATE('1-5-1981'  , '%d-%m-%Y'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK' , 'MANAGER'  , 7839, STR_TO_DATE('9-6-1981'  , '%d-%m-%Y'), 2450, NULL, 10);
INSERT INTO emp VALUES (7566, 'JONES' , 'MANAGER'  , 7839, STR_TO_DATE('2-4-1981'  , '%d-%m-%Y'), 2975, NULL, 20);
INSERT INTO emp VALUES (7788, 'SCOTT' , 'ANALYST'  , 7566, STR_TO_DATE('13-6-1987' , '%d-%m-%Y'), 3000, NULL, 20);
INSERT INTO emp VALUES (7902, 'FORD'  , 'ANALYST'  , 7566, STR_TO_DATE('3-12-1981' , '%d-%m-%Y'), 3000, NULL, 20);
INSERT INTO emp VALUES (7369, 'SMITH' , 'CLERK'    , 7902, STR_TO_DATE('17-12-1980', '%d-%m-%Y'),  800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN' , 'SALESMAN' , 7698, STR_TO_DATE('20-2-1981' , '%d-%m-%Y'), 1600,  300, 30);
INSERT INTO emp VALUES (7521, 'WARD'  , 'SALESMAN' , 7698, STR_TO_DATE('22-2-1981' , '%d-%m-%Y'), 1250,  500, 30);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN' , 7698, STR_TO_DATE('28-9-1981' , '%d-%m-%Y'), 1250, 1400, 30);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN' , 7698, STR_TO_DATE('8-9-1981'  , '%d-%m-%Y'), 1500,    0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS' , 'CLERK'    , 7788, STR_TO_DATE('13-6-1987' , '%d-%m-%Y'), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES' , 'CLERK'    , 7698, STR_TO_DATE('3-12-1981' , '%d-%m-%Y'),  950, NULL, 30);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK'    , 7782, STR_TO_DATE('23-1-1982' , '%d-%m-%Y'), 1300, NULL, 10);


show tables;
SELECT*FROM dept;
SELECT*FROM emp;
SELECT*FROM salgrade;

-- Queries using ROW_NUMBER()
-- 1.	Assign a unique rnk to each employee by salary within each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
 ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS ROWNUMBER
FROM EMP;

-- 2.	Find the top 3 highest-paid employees in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM
(SELECT EMPNO,ENAME,DEPTNO,SAL, 
ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY SAL) AS RNK
FROM EMP) RNKD
WHERE RNK <=3;

-- 3.	List employees in order of hire date within each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS ORDER_OF_HIRE
FROM EMP;

-- Queries using RANK()
-- 4.	Rank employees by salary, allowing ties, within each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK
FROM EMP;

-- 5.	Find employees with the second highest salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM(SELECT EMPNO,ENAME,DEPTNO,SAL,
	RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK
    FROM EMP) RNKD
		WHERE RNK>=2;
        
-- Queries using DENSE_RANK()
-- 6.	Dense rnk employees by salary within the entire company.
SELECT EMPNO,ENAME,SAL,
DENSE_RANK() OVER( ORDER BY SAL DESC) AS DENSERANK
FROM EMP;

-- 7.	Find the salary rnk for each employee within their department (allow ties).
SELECT EMPNO,ENAME,DEPTNO,SAL,
DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS DENSERANK
FROM EMP;

-- Queries using AVG()
-- 8.	Calculate the average salary of employees in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
AVG(SAL) OVER(PARTITION BY DEPTNO ) AS AVG_SAL
FROM EMP;

-- 9.	Compare each employee's salary to the average salary in their department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SAL-AVG(SAL) OVER(PARTITION BY DEPTNO ) AS AVG_SAL
FROM EMP;

-- 10.	Find employees earning above the department average salary.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM (SELECT EMPNO,ENAME,DEPTNO,SAL,
		AVG(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL) AS AVG_SAL
        FROM EMP) SUBQUERY
WHERE SAL > AVG_SAL;

-- Queries using SUM()
-- 11.	Calculate the total salary in each department.
SELECT EMPNO,DEPTNO,SAL,
SUM(SAL) OVER(PARTITION BY DEPTNO) AS TOTAL_SALARY
FROM EMP;

-- 12.	Find the cumulative salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
MAX(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL) AS CUMM_SALARY
FROM EMP;

-- 13.	Calculate the company's total salary for comparison.
SELECT EMPNO,ENAME,SAL,
SUM(SAL) OVER() AS COMPANY_TOTAL_SALARY
FROM EMP;

-- Queries using COUNT()
-- 14.	Count the number of employees in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
COUNT(*) OVER(PARTITION BY DEPTNO) AS COUNT_NUMBER_OF_EMPLOYEE
FROM EMP;

-- Find the running total of employees in each department by hire date.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
COUNT(*) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS TOTAL_EMPLOYEES
FROM EMP;

-- Queries using MAX() and MIN()
-- 15.	Find the highest salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
MAX(SAL) OVER(PARTITION BY DEPTNO) AS HIGHEST_SALARY
FROM EMP;

-- 16.	List employees who earn the highest salary in their department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM (SELECT EMPNO,ENAME,DEPTNO,SAL,
		MAX(SAL) OVER(PARTITION BY DEPTNO ) AS HIGHEST_SALARY
        FROM EMP) SUBQUERY
WHERE SAL=HIGHEST_SALARY;

-- 17.	Find the hire date of the earliest employee in each department.
SELECT ENAME,EMPNO,DEPTNO,HIREDATE,
MIN(HIREDATE) OVER(PARTITION BY DEPTNO) AS EARLIEST_HIREDATE
FROM EMP;

-- Queries combining multiple functions
-- 18.	Rank employees by salary and find the cumulative salary in each department.
SELECT EMPNO,ENAME,DEPTNO,SAL,
RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS CUMULATIVE_SALARY
FROM EMP;

-- 19.	Find the percentage of total department salary each employee earns.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SAL/SUM(SAL) OVER(PARTITION BY DEPTNO)*100 AS PERCENTAGE_SALARY
FROM EMP;

-- Queries exploring complex conditions
-- 20.	List employees hired after the department's first hire date.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM (SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
		MIN(SAL) OVER(PARTITION BY DEPTNO) AS FIRST_HIRE_DATE
        FROM EMP) SUBQUERY
        WHERE HIREDATE > FIRST_HIRE_DATE;
        
-- 21.	Rank employees within salary grades.
SELECT E.EMPNO,E.ENAME,SG.GRADE,E.SAL,
RANK() OVER(PARTITION BY SG.GRADE ORDER BY E.SAL DESC) AS RNK_SAL_GRADE
FROM EMP E
JOIN SALGRADE SG ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- Advanced Queries Using ROW_NUMBER()
-- 22.	Find the second newest hire in each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM(SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
		ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS RNK
        FROM EMP) RNKD
        WHERE RNK=2;

-- 23.	Rank employees based on hire date across the entire company.
SELECT EMPNO,ENAME,HIREDATE,
RANK() OVER( ORDER BY HIREDATE) AS RNK
FROM EMP;

-- 24.	List employees in each department with an alternate row color rnk (for reporting purposes).
SELECT EMPNO,ENAME,DEPTNO,SAL,
	CASE
    WHEN ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY SAL ASC)%2=0 THEN "EVEN"
    ELSE "ODD"
    END AS ROW_COLOR
    FROM EMP;
    
-- Advanced Queries Using RANK()
-- 26.	Rank employees by commission within their department.
SELECT ENAME,EMPNO,DEPTNO,COMM,
RANK() OVER(PARTITION BY DEPTNO ORDER BY COMM DESC) AS RNK
FROM EMP
WHERE COMM IS NOT NULL;

-- 27.	Find employees with the second highest commission in each department.
SELECT EMPNO,ENAME,DEPTNO,COMM
FROM (SELECT EMPNO,ENAME,DEPTNO,COMM,
		RANK() OVER(PARTITION BY DEPTNO ORDER BY COMM DESC) AS RNK
        FROM EMP
        WHERE COMM IS NOT NULL) RNKD
        WHERE RNK >=2;
        
-- Advanced Queries Using DENSE_RANK()
-- 28.	Dense rnk employees by job title and salary within each department
SELECT EMPNO,ENAME,DEPTNO,JOB,SAL,
DENSE_RANK() OVER(PARTITION BY DEPTNO,JOB ORDER BY SAL DESC) AS DESRNK
FROM EMP;

-- 29.	Find the top 2 highest-paid employees for each job role across the company.
SELECT EMPNO,ENAME,JOB,SAL
FROM(SELECT EMPNO,ENAME,JOB,SAL,
		DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS JOB_RANK
        FROM EMP) RNK
        WHERE JOB_RANK <= 2;
        
-- Advanced Queries Using AVG()
-- 30.	Calculate the average salary by job role across all departments.
SELECT EMPNO,ENAME,JOB,SAL,
AVG(SAL) OVER(PARTITION BY JOB) AS AVG_SAL_FOR_JOB
FROM EMP;

-- 31.	Identify employees whose salary is below the company average.
SELECT EMPNO,ENAME,SAL,
AVG(SAL) OVER() AS COMPANY_AVERAGE_SAL
FROM EMP
WHERE SAL < (SELECT AVG(SAL) OVER());

-- 32.	Compare each employee's commission with the average commission in their department.
SELECT EMPNO,ENAME,DEPTNO,COMM,
AVG(COMM) OVER (PARTITION BY DEPTNO ORDER BY COMM DESC) AS AVERAGE_COMMISION_DEPARTMENT
FROM EMP
WHERE COMM IS NOT NULL;

-- Advanced Queries Using SUM()
-- 33.	Calculate the cumulative commission for each department.
SELECT EMPNO,ENAME,DEPTNO,COMM,
SUM(COMM) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS CUMULATIVE_COMMISSION
FROM EMP
WHERE COMM IS NOT NULL;

-- 34.	Find employees contributing more than 20% to their department's total salary.
SELECT EMPNO,ENAME,DEPTNO,SAL,
SAL/SUM(SAL) OVER(PARTITION BY DEPTNO)*100 AS CONTRIBUTING_PERCENNTAGE
FROM EMP
WHERE SAL/SUM(SAL) OVER(PARTITION BY DEPTNO)*100 > 20; 

-- 35.	Calculate the total salary of employees under each manager.
SELECT MGR,
SUM(SAL) OVER(PARTITION BY MGR) AS TOTAL_SALARY_UNDER_MANAGER
FROM EMP;

-- Advanced Queries Using COUNT()
-- 36.	Find the number of employees reporting to each manager.
SELECT MGR,
COUNT(*) OVER(PARTITION BY MGR) AS EMPLOYEE_COUNT
FROM EMP;

-- 37.	List employees who are the only ones in their department with their job title.
SELECT EMPNO,ENAME,DEPTNO,JOB
FROM(SELECT EMPNO,ENAME,DEPTNO,JOB,
		COUNT(*) OVER(PARTITION BY DEPTNO,JOB) AS JOB_COUNT
        FROM EMP) SUBQUERY
        WHERE JOB_COUNT =1;
        
-- 38.	Count employees hired before each employee in their department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
COUNT(*) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS COUNT_BEFORE
FROM EMP;

-- Advanced Queries Using MAX() and MIN()
-- 39.	Find the latest hire date in each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
MAX(HIREDATE) OVER(PARTITION BY DEPTNO ) AS MAX_HIREDATE
FROM EMP;

-- 40.	List employees who were hired on the latest hire date in their department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM(SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
	MAX(HIREDATE) OVER(PARTITION BY DEPTNO) AS LATEST_HIREDATE
    FROM EMP) SUBQUERY
    WHERE HIREDATE =LATEST_HIREDATE;


-- 41.	Find employees whose salary matches the lowest salary in their department.
SELECT EMPNO,ENAME,DEPTNO,SAL
FROM (
		SELECT EMPNO,ENAME,DEPTNO,SAL,
        MIN(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS LOWEST_SALARY
        FROM EMP) SUB
        WHERE SAL=LOWEST_SALARY;
        
-- Advanced Multi-Function Queries
-- 42.	Rank employees by salary, and calculate the cumulative salary and percentage of total salary.
SELECT EMPNO,ENAME,SAL,DEPTNO,
RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS RNK,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) AS TOTAL_SALARY,
SAL/SUM(SAL) OVER(PARTITION BY DEPTNO)*100 AS PERCENTAGE_SALARY
FROM EMP;

-- 43.	List employees with their hire order and cumulative salary within their department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS HIREDATE,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS CUMMULATIVE_SALARY
FROM EMP;

-- 44.	Calculate the average and median salary within each department-- 
SELECT EMPNO,ENAME,DEPTNO,SAL,
AVG(SAL) OVER(PARTITION BY DEPTNO) AS AVG_SALARY,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY SAL)
OVER(PARTITION BY DEPTNO) AS MEDIAN_SALARY
FROM EMP;

-- Advanced Queries Using ROW_NUMBER()
-- 45.	Find the employee hired most recently in each department.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM(
		SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
        ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE DESC) AS RNK
        FROM EMP) SUB
        WHERE RNK=1;
        
-- 46.	Assign unique IDs to employees within salary brackets.
SELECT EMPNO,ENAME,DEPTNO,SAL,
ROW_NUMBER() OVER(PARTITION BY CASE
					WHEN SAL BETWEEN 700 AND 1200 THEN "LOW"
                    WHEN SAL BETWEEN 1201 AND 2000 THEN "MEDIUM"
                    ELSE "HIGH"
                    END ORDER BY SAL) AS BRACKET_ID
FROM EMP;

-- 47.	Identify employees in descending hire date order across departments.
     SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
     ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE DESC) AS RNK
     FROM EMP;
     
-- Advanced Queries Using RANK()
-- 48.	Rank employees by job title within each department.
SELECT EMPNO,ENAME,JOB,DEPTNO,
RANK() OVER(PARTITION BY DEPTNO,JOB ORDER BY SAL DESC) AS RNK
FROM EMP;

-- Advanced Queries Using RANK()
-- 48.	Rank employees by job title within each department.
SELECT EMPNO,ENAME,DEPTNO,JOB,SAL
FROM(
		SELECT EMPNO,ENAME,DEPTNO,JOB,SAL,
        RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) AS RNK
        FROM EMP) SUB
WHERE RNK=1;

-- Advanced Queries Using DENSE_RANK()
-- 50.	Dense rnk employees based on hire date within the company.
SELECT EMPNO,ENAME,JOB,HIREDATE,
DENSE_RANK() OVER(ORDER BY HIREDATE) AS RNK
FROM EMP;

-- 51.	Find employees sharing the same hire rnk as their department’s earliest hires.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE
FROM(
		SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
        ROW_NUMBER() OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS RNK
        FROM EMP) SUB
WHERE RNK=1;

-- Advanced Queries Using AVG()
-- 52.	Find departments where employees' salaries exceed the average department salary.
SELECT EMPNO,ENAME,DEPTNO,SAL,
AVG(SAL) OVER(PARTITION BY DEPTNO) AS AVG_SALARY
FROM EMP
WHERE SAL >(SELECT AVG(SAL) OVER(PARTITION BY DEPTNO));

-- 53.	Calculate moving average salary in each department by hire date.
SELECT EMPNO,ENAME,SAL,DEPTNO,HIREDATE,
AVG(SAL) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MOVINGAVG_SALARY
FROM EMP;

-- Advanced Queries Using SUM()
-- 54.	Calculate the cumulative sum of salaries company-wide.
SELECT EMPNO,ENAME,SAL,
SUM(SAL) OVER(ORDER BY SAL) AS CUMULATIVE_SALARY
FROM EMP;

-- 55.	Find departments where the cumulative salary exceeds 5000.
SELECT EMPNO,ENAME,SAL,DEPTNO,
SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL) AS CUMULATIVE_SALARY
FROM EMP
WHERE SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY SAL)>5000;

--  Advanced Queries Using COUNT()
-- 56.	Count employees grouped by job titles company-wide.
SELECT EMPNO,ENAME,JOB,DEPTNO,
COUNT(*) OVER(PARTITION BY JOB) AS COUNT_EMPLOYEE
FROM EMP;

-- 57.	Find the running total of employees in each department by hire date.
SELECT EMPNO,ENAME,DEPTNO,HIREDATE,
COUNT(*) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) AS TOTAL_EMPLOYEE
FROM EMP;






     



    
    





