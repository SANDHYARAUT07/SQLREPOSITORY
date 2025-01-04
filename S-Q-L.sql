CREATE DATABASE college;
USE college;

CREATE TABLE student(
rollno INT PRIMARY KEY,
name VARCHAR(50)
);

SELECT * FROM student;

INSERT INTO student
(rollno,name)
value
(101,"Sandhya"),
(102,"Pratik"),
(103,"Sanket");

INSERT INTO student
(rollno,name)
VALUES
(104,"Vaishnavi");


CREATE DATABASE company_xyz;
USE company_xyz;

CREATE TABLE emp(
id INT PRIMARY KEY NOT NULL,
name VARCHAR(20) NOT NULL,
salary DECIMAL(8,2));

INSERT INTO emp
(id,name,salary)
VALUES
(101,"Sandhya",5000.00),
(102,"Pratik",4500.00);

SELECT * FROM emp;

CREATE DATABASE studio;
 USE studio;
 
 CREATE TABLE temp2(
 id INT NOT NULL,
 name VARCHAR(40) NOT NULL,
 age INT NOT NULL,
 PRIMARY KEY(id,name));
 
 CREATE TABLE emp1(
 id INT NOT NULL,
 salary INT DEFAULT 25000);
 
 INSERT INTO emp1(id) VALUES(101);
 
 SELECT * FROM emp1;
 
 CREATE DATABASE local;
 
 USE local;
 
USE local;
CREATE TABLE newTab(
age INT check(age>=20));
DROP DATABASE local; 

CREATE DATABASE local;
USE local;
CREATE TABLE newTab(
age INT CHECK(age>=18));

INSERT INTO newTab VALUES(20);
INSERT INTO newTab VALUES(10);
INSERT INTO newTab VALUES(25);
SELECT * FROM newTab;



  CREATE DATABASE college;
  USE college;
  CREATE TABLE student(
  roll_no INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  marks INT NOT NULL CHECK(marks>=60),
  grade VARCHAR(5) NOT NULL,
  city VARCHAR(30) NOT NULL);
  
  INSERT INTO student 
(roll_no,name,marks,grade,city)
  VALUES
  (20,"Sandhya",50,"A","Pune"),
  (23,"Pratik",60,"A","Hydrabad"),
  (39,"Vaishnavi",80,"B","Mumbai"),
  (32,"Sanjiwani",70,"A","Divya");
  
  SELECT name,marks FROM student;
  DESC student;
  
  CREATE DATABASE temp3;
  USE temp3;
  
  CREATE TABLE student(
  roll_no INT PRIMARY KEY,
  name VARCHAR(20),
  marks INT NOT NULL,
  grade VARCHAR(1),
  city VARCHAR(50));
  
  DESC student;
  
  INSERT INTO student 
(roll_no,name,marks,grade,city)
  VALUES
  (20,"Sandhya",50,"A","Pune"),
  (23,"Pratik",60,"A","Hydrabad"),
  (39,"Vaishnavi",80,"B","Mumbai"),
  (32,"Sanjiwani",70,"A","Divya");
  
  
  SET SQL_SAFE_UPDATES=0;
  UPDATE student SET city="Delhi" WHERE city= "Divya";
  
  SELECT * FROM student;
  SELECT name,marks FROM student;
  SELECT city from student;
  SELECT DISTINCT grade FROM student;
  
  SELECT * FROM student WHERE marks> 50; 
  
  SELECT *
  FROM student
  WHERE marks >60;
  
  SELECT*
  FROM student
  WHERE city= "Mumbai";
  
  SELECT * 
  FROM student
  WHERE Marks>70 AND city="Mumbai";
  
  
SELECT *
FROM student
WHERE marks+10 > 70;  

SELECT *
FROM student
WHERE marks=70;

SELECT *
FROM student
WHERE marks>79;

SELECT*
FROM student
WHERE marks>70 AND city="Mumbai";

SELECT*
FROM student
WHERE marks>60 OR city="Mumbai";

SELECT*
FROM student
WHERE marks BETWEEN 50 AND 80;

SELECT*
FROM student
WHERE city IN("Pune","Mumbai");

SELECT*
FROM student
WHERE city IN("Dubai","Agra");

SELECT*
FROM student
WHERE city NOT IN("Pune","Mumbai");



  
  
  
  
  
  






