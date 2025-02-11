USE join_sql;
SELECT*FROM DEPT;
SELECT*FROM EMP;
SELECT*FROM SALGRADE;

-- Basic Join Queries
-- 1.	Get all employees and their department names.
SELECT E.EMPNO AS EMPLOYEE_NO,ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT_NAME
FROM EMP E
JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 2.	List all employees and their department names for departments located in New York.
SELECT E.EMPNO AS EMPLOYEE_NUMBER,E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,D.LOC AS LOCATION
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC="NEW YORK";

-- 3.	Get employee names, job titles, and their managers' names.
SELECT E.ENAME AS EMPLOYEE_NAME,E.JOB AS JOBS,M.ENAME AS MANAGER
FROM EMP E
JOIN EMP M
ON E.MGR=M.EMPNO;

-- 4.	Find employees working in the Sales department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME="SALES";

-- 5.	List employees and their salaries who earn above 2000.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY
FROM EMP E
WHERE E.SAL >2000;

-- 6.	Get the department names along with employee names.
SELECT D.DNAME AS DEPARTMENT,E.ENAME AS EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO;

-- 7.	Find employees who are managers.
SELECT ENAME AS EMPLOYEE,JOB AS JOBS
FROM EMP 
WHERE JOB="MANAGER";

-- 8.	List employees and their salaries where their salary is between 1000 and 3000.
SELECT ENAME AS EMPLOYEE,SAL AS SALARY
FROM EMP 
WHERE SAL BETWEEN 1000 AND 3000;

-- 9.	Find employees who do not have a manager.
SELECT ENAME AS EMPLOYEE,MGR AS MANAGER
FROM EMP
WHERE MGR IS NULL;

-- 10.	Get the number of employees in each department.
SELECT D.DNAME AS DEPARTMENT,COUNT(E.EMPNO) AS NO_OF_EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
ORDER BY COUNT(E.EMPNO) DESC;

-- Using Multiple Joins
-- 11.	Get employee names along with their salary and department name.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 12.	Find all employees with their department name and location.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,D.LOC AS LOCATION
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 13.	Get employee names, their jobs, and the salary grade based on their salary.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,E.SAL AS SALARY,SG.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- 14.	Get all employees and the grade of their salary.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,SG.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE AS SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- 15.	Find employees with their salary and the department they belong to.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 16.	List employees, their job, and their manager's job.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,M.ENAME AS MANAGER,M.JOB AS MANAGER_JOB
FROM EMP E
JOIN EMP M
ON E.MGR=M.EMPNO;

-- 17.	Find employees who earn above the average salary in their department.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
JOIN DEPT D
ON E.DEPTNO=E.DEPTNO
WHERE E.SAL IN (SELECT AVG(E.SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- 18.	Get the employee names along with the salary range they fall under.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY_RANGE,SG.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- 19.	List employees with their manager's name and job title.
SELECT E.ENAME AS EMPLOYEE,M.ENAME AS MANAGER_NAME,E.JOB AS JOB_TITLE
FROM EMP E
JOIN EMP M
ON E.MGR=M.EMPNO;

-- 20.	Find employees who belong to the Research department and earn more than 2000.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,E.SAL AS SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME="Research" AND E.SAL >2000;

-- Using LEFT JOIN
-- 21.	List all employees and their departments, including employees without a department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 22.	Get all departments with the names of employees who work in them.
SELECT D.DNAME AS DEPARTMENT,E.ENAME AS EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO;

-- 23.	Find all employees who do not belong to a department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME IS NULL;

-- 24.	List employees who have no manager.
SELECT E.ENAME AS EMPLOYEE,M.ENAME AS MANAGER
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.EMPNO
WHERE M.EMPNO IS NULL;

-- 25.	Get employees who have a manager and their manager's name.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,M.ENAME AS MANAGER_NAME
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.EMPNO
WHERE M.ENAME IS NOT NULL;

-- Using RIGHT JOIN
-- 26.	List all departments and employees who work in them, including departments with no employees.
SELECT D.DNAME AS DEPARTMENT,E.ENAME AS EMPLOYEE
FROM EMP E
RIGHT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME IS  NOT NULL;

-- 27.	Get all employees and their departments, including employees who do not belong to any department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
RIGHT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- Using FULL OUTER JOIN (if supported)
-- 28.	Find all employees and all departments, even those without a match.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
UNION
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPERTMENT
FROM EMP E
RIGHT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- Advanced Join Queries
-- 29.	Get all employees who are managers of other employees.
SELECT DISTINCT E.ENAME
FROM EMP E
WHERE E.EMPNO IN (SELECT MGR FROM EMP WHERE MGR IS NOT NULL);

-- 30.	Get the department with the highest average salary.
SELECT D.DNAME AS DEPARTMENT,MAX(E.SAL) AS HIGHEST_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

-- 31.	List the department with the highest number of employees.
SELECT D.DNAME AS DEPARTMENT,COUNT(E.EMPNO) AS NO_OF_EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
ORDER BY NO_OF_EMPLOYEE DESC
LIMIT 1;

-- 32.	Find employees who are analysts and work in the Research department.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB="Analyst" AND D.DNAME="Research";

-- 33.	List employees with their managers and the number of employees managed by each manager.
SELECT E.ENAME AS EMPLOYEE,M.ENAME AS MANAGER,COUNT(E2.EMPNO) AS NO_OF_EMPLOYEE_MANAGE
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.EMPNO
LEFT JOIN EMP E2
ON E2.EMPNO=M.MGR
GROUP BY E.ENAME,M.ENAME;

-- 34.	Get the list of employees along with their salary grade.
SELECT E.ENAME AS EMPLOYEE,E.SAL,SG.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- 35.	Find employees whose salary is higher than the maximum salary in their department.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- More Join Variants
-- 36.	Get employees who have a commission.
SELECT E.ENAME AS EMPLOYEE,E.COMM AS COMMISSION
FROM EMP E
WHERE E.COMM IS NOT NULL;

-- 37.	List employees with their department names and location.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,D.LOC AS LOCATION
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 38.	Find the department with the highest total salary.
SELECT D.DNAME AS DEPARTMENT,SUM(E.SAL) AS TOTAL_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
ORDER BY TOTAL_SALARY DESC
LIMIT 1;

-- Working with Aggregates and Grouping
-- 39.	List each department and the average salary of employees in each department.
SELECT D.DNAME AS DEPARTMENT,E.ENAME AS EMPLOYEE,AVG(E.SAL) AS AVG_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME,E.ENAME;

-- 40.	Find the department with the highest average salary.
SELECT D.DNAME AS DEPARTMENT,ROUND(AVG(E.SAL)) AS AVG_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
ORDER BY AVG_SALARY DESC
LIMIT 1;

-- 41.	Get the number of employees in each department.
SELECT D.DNAME AS DEPARTMENT,COUNT(E.EMPNO) AS NO_OF_EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

-- 42.	Find departments that have more than 3 employees.
SELECT D.DNAME AS DEPARTMENT,COUNT(E.EMPNO) AS EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
HAVING COUNT(E.EMPNO) >3;

-- 43.	Get the total salary of employees in each department.
SELECT D.DNAME AS DEPARTMENT,SUM(E.SAL) AS TOTAL_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

-- 44.	Find the average salary of employees who have a manager.
SELECT E.ENAME AS EMPLOYEE,AVG(E.SAL) AS AVG_SALARY
FROM EMP E
WHERE E.MGR IS NOT NULL
GROUP BY E.ENAME;

-- 45.	Get employees with their salary grade, grouped by salary grade.
SELECT E.ENAME AS EMPLOYEE,SG.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
GROUP BY E.ENAME, SG.GRADE;

-- 46.	List departments along with the highest salary in each department.
SELECT D.DNAME AS DEPARTMET,MAX(E.SAL) AS HIGHEST_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

-- 47.	Find employees who earn more than the average salary of their department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,AVG(E.SAL) AS AVG_SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
GROUP BY E.ENAME,D.DNAME;

-- 48.	Find departments that have no employees.
SELECT D.DNAME AS DEPARTMENT,E.EMPNO AS EMPLOYEE_NO
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
WHERE E.EMPNO IS NULL;

-- 49.	Get the employees with the highest salary in each department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,MAX(E.SAL) AS HIGHEST_SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
GROUP BY E.ENAME,D.DNAME
ORDER BY HIGHEST_SALARY DESC;

SELECT E.ENAME,E.SAL,D.DNAME
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL =(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- 50.	Find the total commission for each department.
SELECT D.DNAME AS DEPARTMENT,SUM(E.COMM) AS TOTAL_COMMISSION
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

-- Using Nested Joins and Subqueries
-- 51.	List employees who earn more than the average salary of their department.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL > (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- 52.	Find the employees whose salary is the same as the highest salary in their department.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL = (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- 53.	Get all employees who earn more than any employee in department 20.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY
FROM EMP E
WHERE E.SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

-- 54.	Find employees who are paid less than their manager.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,M.ENAME AS MANAGER
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.EMPNO
WHERE E.SAL < M.SAL;

-- 55.	Get departments that have employees earning more than 5000.
SELECT D.DNAME AS DEPARTMENT,E.ENAME AS EMPLOYEE,E.SAL AS SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
WHERE E.SAL > 5000
GROUP BY D.DNAME,E.ENAME,E.SAL;

-- 56.	List employees who have the same job as their manager.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,M.ENAME AS MANAGER
FROM EMP E
LEFT JOIN EMP M
ON E.MGR=M.EMPNO
WHERE E.JOB=M.JOB;

-- 57.	Find employees who are not assigned to any department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME IS NULL;

-- 58.	List employees who do not have a commission.
SELECT E.ENAME AS EMPLOYEE,E.COMM AS EOMMISSION
FROM EMP E
WHERE E.COMM IS NULL;

-- 59.	Get employees who were hired after 1995.
SELECT E.ENAME AS EMPLOYEE,E.HIREDATE AS HIRE_DATE
FROM EMP E
WHERE E.HIREDATE > "1995-01-01";

-- 60.	Find the names of employees working in the 'Sales' department but not as 'SALESMAN'.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME="Sales" AND E.JOB <> "Salesman";

-- Using Full Outer Join (if supported)
-- 61.	Get a list of all employees and departments, including employees without departments and departments without employees.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
UNION
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
RIGHT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 62.	Find all employees and departments where an employee is assigned to a department, or the department has no employees.
 

-- Working with Self-Join
-- 63.	Get the list of employees who are managers (have subordinates).
SELECT E.ENAME AS EMPLOYEE,M.ENAME AS MANAGER
FROM EMP E
JOIN EMP M
ON E.MGR=M.EMPNO
WHERE E.MGR IS NOT NULL;

-- 64.	List employees and their direct reports (subordinates).
SELECT E.ENAME AS MANAGER,M.ENAME AS EMPLOYEE
FROM EMP E
JOIN EMP M
ON E.EMPNO=M.MGR;

-- 65.	Find employees who are not managers.
SELECT E.ENAME AS EMPLOYEE
FROM EMP E
WHERE E.EMPNO NOT IN(SELECT MGR FROM EMP WHERE MGR IS NOT NULL);

-- 66.	Find employees who manage employees but do not have a manager themselves
SELECT E.ENAME AS MANAGER
FROM EMP E
WHERE E.EMPNO IN (SELECT DISTINCT MGR FROM EMP) AND E.MGR IS NULL;

-- More Advanced Join Queries
-- 67.	List all employees with their job, department name, and salary.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,D.DNAME AS DEPARTMENT,E.SAL AS SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 68.	Find employees whose salary is within the range of any salary grade.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,SG.GRADE AS SALGRADE
FROM EMP E
LEFT JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL;

-- 69.	Get the name of the department with the most number of employees.
SELECT D.DNAME AS DEPARTMENT,COUNT(E.EMPNO) AS NO_OF_EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
ORDER BY NO_OF_EMPLOYEE DESC
LIMIT 1;

-- 70.	Find departments where the average salary is above 2500.
SELECT D.DNAME DEPARTMENT,ROUND(AVG(E.SAL)) AS AVG_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
HAVING AVG_SALARY > 2500;

-- 71.	Get the employee name and the highest salary among their peers in the same department.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY, (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO) AS HIGHEST_SALARY
FROM EMP E; 

-- 72.	List employees along with their department location.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,D.LOC AS LOCATION
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 73.	Get employees who are not in the 'Sales' department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.DNAME <>"Sales";

-- 74.	List employees with their salaries, including departments that have no employees.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO;

-- 75.	Find employees who are analysts and belong to the 'Research' department.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB="Analyst" AND D.DNAME="Research";

-- 76.	Get employees who have a salary higher than any analyst in the same department.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,D.DNAME AS DEPARTMENT,MAX(E.SAL) AS HIGHER_SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB ="Analyst" 
GROUP BY E.ENAME,E.JOB,D.DNAME;

SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL > (SELECT MAX(SAL) FROM EMP WHERE E.JOB="Analyst" AND DEPTNO=E.DEPTNO );

-- 77.	Get the department with the highest number of employees earning above 2000.
SELECT D.DNAME AS DEPARTMENT,COUNT(E.EMPNO) AS NO_OF_EMPLOYEE
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
WHERE E.SAL > 2000
GROUP BY D.DNAME 
ORDER BY NO_OF_EMPLOYEE DESC
LIMIT 1;

-- Final Set of Queries
-- 78.	Find employees and their salaries who belong to departments located in 'New York'.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,D.LOC AS LOCATION
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC="NEW YORK"
ORDER BY E.ENAME,D.DNAME,D.LOC;

-- 79.	Get employees whose salaries are in the highest grade.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY,MAX(SG.GRADE) AS HIGHEST_GRADE
FROM EMP E
LEFT JOIN SALGRADE SG
ON E.SAL BETWEEN SG.LOSAL AND SG.HISAL
GROUP BY E.ENAME,E.SAL,SG.GRADE
ORDER BY HIGHEST_GRADE DESC
LIMIT 1;

-- 80.	List employees who are clerks and work in the Sales department.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.JOB="CLERK" AND D.DNAME="SALES";

-- 81.	Find the highest salary in the department where employee 'ALLEN' works.
SELECT D.DNAME AS DEPARTMENT,E.ENAME AS EMPLOYEE_NAME,E.JOB AS JOBS,MAX(E.SAL) AS HIGHEST_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
WHERE E.ENAME="ALLEN"
GROUP BY D.DNAME,E.ENAME,E.JOB;

-- 82.	List departments where all employees earn more than 1500
SELECT D.DNAME AS DEPARTMENT
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME
HAVING MIN(E.SAL)>1500;

-- 83.	Get the employees who report directly to the president.
SELECT E.ENAME AS EMPLOYEE
FROM EMP E
WHERE E.MGR=(SELECT EMPNO FROM EMP WHERE ENAME="KING");

-- 84.	Get employees who have a job title of either 'SALESMAN' or 'MANAGER'.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS
FROM EMP E
WHERE E.JOB IN("SALESMAN" , "MANAGER");

-- 85.	Find employees who earn less than the average salary of their department.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,E.SAL AS SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.SAL < (SELECT AVG(SAL) FROM EMP WHERE DEPTNO=E.DEPTNO);

-- 86.	List employees with their department and job title.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,E.JOB AS JOBS
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- 87.	Find employees who were hired after '1995-01-01' in the Sales department.
SELECT E.ENAME AS EMPLOYEE,E.HIREDATE AS HIREDATE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.HIREDATE > "1995-01-01" AND D.DNAME="SALES";

-- 88.	Get employees and their department names where the department is located in 'Boston'.
SELECT E.ENAME AS EMPLOYEE,D.DNAME AS DEPARTMENT,D.LOC AS LOCATON
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC="BOSTON";

-- 89.	List employees who were hired after '1990-01-01' in the 'Research' department.
SELECT E.ENAME AS EMPLOYEE,E.HIREDATE AS HIREDATE,D.DNAME AS DEPARTMENT
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.HIREDATE > "1990-01-01" AND D.DNAME="RESEARCH";

-- 90.	Find the department with the minimum salary.
SELECT D.DNAME AS DEPARTMENT,MIN(E.SAL) AS MINIMUM_SALARY
FROM DEPT D
LEFT JOIN EMP E
ON D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME;

-- 91.	List employees whose salary is higher than 'FORD'.
SELECT E.ENAME AS EMPLOYEE
FROM EMP E
WHERE E.SAL > (SELECT SAL FROM EMP WHERE ENAME="FORD");

-- 92.	Get employees who have the same job as 'KING'.
SELECT E.ENAME AS EMPLOYEE
FROM EMP E
WHERE E.JOB =(SELECT JOB FROM EMP WHERE ENAME="KING");

-- 93.	List employees who are 'SALESMAN' but earn less than 2000.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY
FROM EMP E
WHERE E.JOB="SALESMAN" AND E.SAL < 2000;

-- 94.	Find all employees whose manager has the job 'MANAGER'.
SELECT E.ENAME AS EMPLOYEE,M.ENAME AS MANAGER
FROM EMP E
JOIN EMP M
ON E.MGR=M.EMPNO
WHERE E.JOB="MANAGER";

-- 95.	Get employees who earn between 1500 and 3000.
SELECT E.ENAME AS EMPLOYEE,E.SAL AS SALARY
FROM EMP E
WHERE E.SAL BETWEEN 1500 AND 3000;

-- 96.	Find the average salary of employees who work in 'New York'.
SELECT E.ENAME AS EMPLOYEE,D.LOC AS LOCATION,AVG(E.SAL) AS AVG_SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE D.LOC="NEW YORK"
GROUP BY E.ENAME,D.LOC;

-- 97.	List the highest salary employee in each department.
SELECT E.ENAME AS EMPLOYEE, D.DNAME AS DEPARTMENT,MAX(E.SAL) AS HIGHEST_SALARY
FROM EMP E
LEFT JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
GROUP BY E.ENAME,D.DNAME;

-- 98.	Find employees who report to 'SCOTT'.
SELECT E.ENAME
FROM EMP E
WHERE E.MGR= (SELECT EMPNO FROM EMP WHERE ENAME="SCOTT");

-- 99.	List employees who were hired before '1990-01-01' and earn more than 2000.
SELECT E.ENAME AS EMPLOYEE,E.HIREDATE AS HIREDATE,E.SAL AS SALARY
FROM EMP E
WHERE E.HIREDATE < "1990-01-01" AND E.SAL >2000;

-- 100.	Find employees who have a job title of 'CLERK' and earn more than 1000.
SELECT E.ENAME AS EMPLOYEE,E.JOB AS JOBS,E.SAL AS SALARY
FROM EMP E
WHERE E.JOB="CLERK" AND E.SAL >1000;


















 











