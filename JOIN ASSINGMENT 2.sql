CREATE DATABASE join_sql;
USE join_sql;

-- DROP TABLE IF EXISTS emp
-- --Make empno as Primary Key, deptno as Foreign key
CREATE TABLE emp (
  empno decimal(4,0) NOT NULL,
  ename varchar(10) default NULL,
  job varchar(9) default NULL,
  mgr decimal(4,0) default NULL,
  hiredate date default NULL,
  sal decimal(7,2) default NULL,
  comm decimal(7,2) default NULL,
  deptno decimal(2,0) default NULL
);

DROP TABLE IF EXISTS dept;

-- --make deptno as Primary Key
CREATE TABLE dept (
  deptno decimal(2,0) default NULL,
  dname varchar(14) default NULL,
  loc varchar(13) default NULL
);

INSERT INTO emp VALUES ('7369','SMITH','CLERK','7902','1980-12-17','800.00',NULL,'20');
INSERT INTO emp VALUES ('7499','ALLEN','SALESMAN','7698','1981-02-20','1600.00','300.00','30');
INSERT INTO emp VALUES ('7521','WARD','SALESMAN','7698','1981-02-22','1250.00','500.00','30');
INSERT INTO emp VALUES ('7566','JONES','MANAGER','7839','1981-04-02','2975.00',NULL,'20');
INSERT INTO emp VALUES ('7654','MARTIN','SALESMAN','7698','1981-09-28','1250.00','1400.00','30');
INSERT INTO emp VALUES ('7698','BLAKE','MANAGER','7839','1981-05-01','2850.00',NULL,'30');
INSERT INTO emp VALUES ('7782','CLARK','MANAGER','7839','1981-06-09','2450.00',NULL,'10');
INSERT INTO emp VALUES ('7788','SCOTT','ANALYST','7566','1982-12-09','3000.00',NULL,'20');
INSERT INTO emp VALUES ('7839','KING','PRESIDENT',NULL,'1981-11-17','5000.00',NULL,'10');
INSERT INTO emp VALUES ('7844','TURNER','SALESMAN','7698','1981-09-08','1500.00','0.00','30');
INSERT INTO emp VALUES ('7876','ADAMS','CLERK','7788','1983-01-12','1100.00',NULL,'20');
INSERT INTO emp VALUES ('7900','JAMES','CLERK','7698','1981-12-03','950.00',NULL,'30');
INSERT INTO emp VALUES ('7902','FORD','ANALYST','7566','1981-12-03','3000.00',NULL,'20');
INSERT INTO emp VALUES ('7934','MILLER','CLERK','7782','1982-01-23','1300.00',NULL,'10');
SELECT*FROM emp;


INSERT INTO dept VALUES ('10','ACCOUNTING','NEW YORK');
INSERT INTO dept VALUES ('20','RESEARCH','DALLAS');
INSERT INTO dept VALUES ('30','SALES','CHICAGO');
INSERT INTO dept VALUES ('40','OPERATIONS','BOSTON');
SELECT*FROM dept;

CREATE TABLE salgrade (
  grade int NOT NULL,
  losal int DEFAULT NULL,
  hisal int DEFAULT NULL
);

INSERT INTO salgrade
(grade,losal,hisal)
VALUES
(1, 700, 1200),
(2, 1201, 1400),
(3, 1401, 2000),
(4, 2001, 3000),
(5, 3001, 9999);
SELECT*FROM salgrade;


-- Basic Join Queries

-- 1.	Get all employees and their department names
SELECT ename,dname 
from emp as e
JOIN dept as d
on e.deptno=d.deptno;

-- 2.	List all employees and their department names for departments located in New York.
SELECT e.ename,d.dname,d.loc
FROM emp as e
INNER JOIN dept as d
ON e.deptno=d.deptno
WHERE loc="New York";

-- 3.	Get employee names, job titles, and their managers' names.
SELECT 
e.ename AS EMPLOYEE_NAME,
e.job AS JOB_TITLE,
e.ename AS MANAGER_NAME
FROM emp as e
LEFT JOIN emp m
ON e.mgr=m.empno;

-- 4.	Find employees working in the Sales department.
SELECT e.ename,d.dname
FROM emp as e
JOIN dept as d
ON e.deptno=d.deptno
WHERE dname="sales";

-- 5.	List employees and their salaries who earn above 2000.
SELECT ename,sal
FROM emp 
WHERE sal > 2000;

 
-- 6.	Get the department names along with employee names.
SELECT dname AS dept_name,ename AS employee
FROM emp e
join dept d
ON e.deptno=d.deptno;


-- 7.	Find employees who are managers.
SELECT 
e.empno AS employee_no,
ename AS employee_name,
e.job AS job
FROM emp AS e
WHERE e.empno IN (SELECT DISTINCT mgr FROM EMP WHERE mgr IS NOT NULL);

-- 8.	List employees and their salaries where their salary is between 1000 and 3000.
SELECT 
ename AS employee_name,
empno AS employee_no,
sal AS employee_salary
FROM emp
WHERE sal BETWEEN 1000 AND 3000;

-- 9.	Find employees who do not have a manager.
SELECT 
empno AS employee_no,
ename AS employee_name,
job 
from emp
WHERE mgr IS NULL;

-- 10.	Get the number of employees in each department.
SELECT d.dname,count(e.empno) AS no_of_employee
FROM emp e
join dept d 
ON e.deptno=d.deptno
GROUP BY d.dname;

-- Using Multiple joins
-- --------------------
-- 11.	Get employee names along with their salary and department name.
SELECT e.ename,e.sal,d.dname
FROM emp e
INNER JOIN dept d
ON e.deptno=d.deptno;

-- 12.	Find all employees with their department name and location.
SELECT e.ename,d.dname,d.loc
FROM emp e
LEFT JOIN dept d
on e.deptno=d.deptno;

-- 13.	Get employee names, their jobs, and the salary grade based on their salary.
SELECT 
e.ename AS EMPLOYEE,
e.job AS JOB_TITLE,
s.grade AS SAL_GRADE
FROM emp e
LEFT JOIN salgrade s
ON e.sal BETWEEN LOSAL AND HISAL;

-- 14.	Get all employees and the grade of their salary.
SELECT e.ename,e.sal,s.grade
FROM emp e
LEFT JOIN salgrade s
ON e.sal BETWEEN LOSAL AND HISAL;

-- 15.	Find employees with their salary and the department they belong to.
SELECT e.ename,e.sal,d.dname
FROM emp e
LEFT JOIN dept d
ON e.deptno=d.deptno;

-- 16.	List employees, their job, and their manager's job.
SELECT 
e.ename AS EMPLOYEE,
e.job AS JOB,
m.ename AS MANAGER_NAME,
m.job AS manager_job
FROM emp e
LEFT JOIN emp m
ON e.mgr=m.empno;

-- 17.	Find employees who earn above the average salary in their department.
SELECT ename,sal FROM emp 
WHERE sal > (SELECT AVG(sal) from emp WHERE deptno=deptno);

-- 18.	Get the employee names along with the salary range they fall under.
SELECT 
e.ename AS EMPLOYEE,
e.sal AS SALARY,
sg.grade AS SALARY_GRADE,
concat(sg.losal,"-",sg.hisal) AS SALARY_RANGE
FROM emp e
JOIN salgrade sg
ON e.sal BETWEEN losal AND hisal;

-- 19.	List employees with their manager's name and job title.
SELECT 
e.ename AS employee,
m.ename AS manager,
m.job AS job
FROM emp e
LEFT JOIN emp m
ON e.mgr=m.empno;

-- 20.	Find employees who belong to the Research department and earn more than 2000.
SELECT ename,dname,e.sal
FROM emp e
LEFT JOIN dept d
ON e.deptno=d.deptno
WHERE e.sal>2000;

-- Left Join queries
-- -----------------
-- 21.	List all employees and their departments, including employees without a department.
SELECT e.ename,d.dname,e.job,d.loc
FROM emp e
LEFT JOIN dept d
ON e.deptno=d.deptno;

-- 22.	Get all departments with the names of employees who work in them.
SELECT 
d.dname AS department_name,
e.ename AS employee
FROM dept d
LEFT JOIN emp e
ON d.deptno=e.deptno;

-- 23.	Find all employees who do not belong to a department.
SELECT 
e.ename AS employee,
d.dname AS department_name
FROM emp e
LEFT JOIN dept d
ON e.deptno=d.deptno
WHERE d.dname IS NULL;


-- 24.	List employees who have no manager.
SELECT
e.ename AS employee,
m.ename AS manager
FROM emp e
LEFT JOIN emp m
ON e.mgr=m.deptno
WHERE e.mgr IS NULL;

-- 25.	Get employees who have a manager and their manager's name.
SELECT 
e.ename AS employeename,
m.ename AS Manager_name
FROM emp e
LEFT JOIN emp m
ON e.mgr=m.empno;

 -- Right Jion queries
 
-- 26.	List all departments and employees who work in them, including departments with no employees.
SELECT
d.dname AS dept_name,
e.ename AS emp_name 
FROM dept d
RIGHT JOIN emp e
ON d.deptno=e.deptno;

-- 27.	Get all employees and their departments, including employees who do not belong to any department.
SELECT 
e.ename AS employee_name,
d.dname AS department_name
FROM dept d
RIGHT JOIN emp e
ON d.deptno=e.deptno;
