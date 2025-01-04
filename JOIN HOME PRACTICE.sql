USE join_sql;
SELECT*FROM DEPT;
SELECT*FROM EMP;
SELECT*FROM SALGRADE;

-- 1.	Get all employees and their department names
SELECT E.ENAME,D.DNAME
FROM EMP E
INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 2.	List all employees and their department names for departments located in New York.
SELECT E.ENAME,D.DNAME,D.LOC
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC="NEW YORK";

-- 3.	Get employee names, job titles, and their managers' names.
SELECT E.ENAME AS EMPLOYEE,
E.JOB AS JOB_TITLE,
E.ENAME AS MANAGER
FROM EMP E
JOIN EMP M
ON E.MGR=M.EMPNO;

-- 4.	Find employees working in the Sales department.
SELECT 
E.ENAME AS EMPLOYEE,
D.DNAME AS DEPARTMENT_NAME
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME="SALES";

-- 5.	List employees and their salaries who earn above 2000.
SELECT
ENAME,SAL
FROM EMP
WHERE SAL>2000;

-- 6.	Get the department names along with employee names.
SELECT 
D.DNAME AS DEPARTMENT,
E.ENAME AS EMPLOYEE
FROM EMP E
INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

 -- 7.	Find employees who are managers.
 SELECT
 E.ENAME AS EMPLOYEE,
 E.JOB AS JOB,
 E.ENAME AS MANAGER
 FROM EMP E
 WHERE E.EMPNO IN(SELECT DISTINCT MGR FROM EMP WHERE MGR IS NOT NULL);
 
 -- 8.	List employees and their salaries where their salary is between 1000 and 3000.
SELECT
E.ENAME AS EMPLOYEE,
E.EMPNO AS EMPLOYEE_NUMBER,
E.SAL AS SALARY
FROM EMP E
WHERE SAL BETWEEN 1000 AND 3000;

-- 9.	Find employees who do not have a manager.
SELECT
E.ENAME AS EMPLOYEE,
E.JOB AS JOB,
E.EMPNO AS EMPLOYEE_NUMBER
FROM EMP E
WHERE MGR IS NULL;

-- 10.	Get the number of employees in each department.
SELECT D.DNAME,COUNT(EMPNO) AS NO_OF_EMPLOYEE
FROM EMP E
INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
GROUP BY D.DNAME;

-- 11.	Get employee names along with their salary and department name.
SELECT
E.ENAME AS EMPLOYEE,
E.SAL AS SALARY,
D.DNAME AS DEPARTMENT_NAME
FROM EMP E
LEFT JOIN DEPT D
 ON E.DEPTNO=D.DEPTNO;
 
 -- 12.	Find all employees with their department name and location.
 SELECT
 E.ENAME AS EMPLOYEE,
 D.DNAME AS DEPARTMENT,
 D.LOC AS LOCATION
 FROM EMP E
 LEFT JOIN DEPT D
 ON E.DEPTNO=D.DEPTNO;
 
 -- 13.	Get employee names, their jobs, and the salary grade based on their salary.
SELECT
E.ENAME AS EMPLOYEE,
E.JOB AS JOB,
S.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE AS S
ON E.SAL BETWEEN LOSAL AND HISAL;

-- 14.	Get all employees and the grade of their salary.
SELECT
E.ENAME AS EMPLOYEE,
S.GRADE AS SALGRADE,
E.SAL AS SALARY
FROM EMP E
LEFT JOIN SALGRADE S
ON E.SAL BETWEEN LOSAL AND HISAL;

-- 15.	Find employees with their salary and the department they belong to
SELECT
E.ENAME AS EMPLOYEE,
E.SAL AS SALARY,
D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 16.	List employees, their job, and their manager's job.
SELECT
E.ENAME AS EMPLOYEE,
E.JOB AS JOB,
E.ENAME AS MANAGER
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=E.DEPTNO;

-- 17.	Find employees who earn above the average salary in their department.
SELECT
ENAME,SAL
FROM EMP 
WHERE SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=DEPTNO);

-- 18.	Get the employee names along with the salary range they fall under.
SELECT
E.ENAME AS EMPLOYEE,
E.SAL AS SALARY,
SG.GRADE AS SALARY_GRADE,
CONCAT(SG.LOSAL,"-",SG.HISAL)
FROM EMP E
JOIN SALGRADE SG
ON E.SAL BETWEEN LOSAL AND HISAL;

-- 19.	List employees with their manager's name and job title.
SELECT
E.ENAME AS EMPLOYEE,
E.ENAME AS MANAGER,
E.JOB AS JOB
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.DEPTNO;

-- 20.	Find employees who belong to the Research department and earn more than 2000.
SELECT
E.ENAME AS EMPLOYEE,
E.SAL AS SALARY,
D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=E.DEPTNO
WHERE E.SAL >2000;

-- Left Join queries
-- -----------------
-- 21.	List all employees and their departments, including employees without a department.
SELECT
E.ENAME AS EMPLOYEE,
D.DNAME AS DEPARTMENT,
D.LOC AS LOCATION,
E.JOB AS JOB
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 22.	Get all departments with the names of employees who work in them.
SELECT
D.DNAME AS DEPARTMENT,
E.ENAME AS EMPLOYEE
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 23.	Find all employees who do not belong to a department.
SELECT
E.ENAME AS EMPLOYEE,
D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO 
WHERE D.DNAME  IS NULL;

-- 24.	List employees who have no manager.
SELECT
E.ENAME AS EMPLOYEE,
E.JOB AS JOB_TITLE,
E.ENAME AS MANAGER
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.DEPTNO
WHERE E.MGR IS NULL;

-- 25.	Get employees who have a manager and their manager's name.
SELECT
E.ENAME AS EMPLOYEE,
E.ENAME AS MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.EMPNO;

 -- Right Jion queries
 
-- 26.	List all departments and employees who work in them, including departments with no employees.
SELECT
D.DNAME AS DEPARTMENT,
E.ENAME AS EMPLOYEE
FROM EMP E
RIGHT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 27.	Get all employees and their departments, including employees who do not belong to any department.
SELECT 
E.ENAME AS EMPLOYEE,
D.DNAME AS DEPARTMENT
FROM EMP E
RIGHT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- HAVING CLAUSE
USE join_sql;

SELECT*FROM EMP;
SELECT*FROM DEPT;

-- Count the number of employee in each department where the count is grater than 5
SELECT DEPTNO,COUNT(EMPNO) AS NO_OF_EMPLOYEE
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(EMPNO) >5;

-- Find departments with a total salary sum grater than 100000
SELECT D.DNAME, SUM(E.SAL) AS TOTAL_SALARY
FROM EMP E
JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
GROUP BY D.DNAME
HAVING SUM(E.SAL) >1000;



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
SELECT Product_ID,SUM(Units_sold) AS SUM_QUANTITY
FROM Productsales
GROUP BY Product_ID
HAVING SUM(Units_Sold) >100;

-- Q2.Find the products that sold more than 100 units by filtering sales after 01-12-2024.
SELECT Product_ID,SUM(Units_Sold) AS SUM_QUANTITY
FROM Productsales
WHERE Sale_Date ="2024-12-01"
GROUP BY Product_ID
HAVING SUM(Units_Sold) >100;