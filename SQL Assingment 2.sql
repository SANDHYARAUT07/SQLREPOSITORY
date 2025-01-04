CREATE DATABASE sample;
USE sample;

CREATE TABLE departments(
department_id INT NOT NULL AUTO_INCREMENT,
department_name VARCHAR(100) NOT NULL,
location VARCHAR(255),
PRIMARY KEY(department_id),
UNIQUE (department_name));

CREATE TABLE emp(
emp_id INT NOT NULL AUTO_INCREMENT,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) NOT NULL,
hire_date DATE DEFAULT (CURRENT_DATE),
Salary DECIMAL (10,2),
department_id INT,
status ENUM('Active','Inactive'),
PRIMARY KEY (emp_id),
UNIQUE(email),
CHECK(salary>0),
FOREIGN KEY(department_id) REFERENCES departments(department_id));
DESC emp;

CREATE DATABASE nareshit;
USE nareshit;

CREATE TABLE student(
student_id INT PRIMARY KEY NOT NULL,
student_name VARCHAR(50) NOT NULL,
Address VARCHAR(100) NOT NULL);

DESC student;

-- ALTER COMMAND
ALTER TABLE student ADD telno VARCHAR(10);
ALTER TABLE student ADD(Age Integer DEFAULT 10);




-- MODIFY COMMAND
ALTER TABLE student MODIFY student_name VARCHAR(40);
ALTER TABLE student MODIFY Address VARCHAR(80);


-- REMOVING COLUMN
ALTER TABLE student DROP telno;
ALTER TABLE emp DROP email,DROP hire_date;
ALTER TABLE emp DROP last_name;

-- CHANGE COLUMN

ALTER TABLE emp CHANGE first_name emp_name VARCHAR(40);

CREATE DATABASE sample1;
USE sample1;

CREATE TABLE student(
std_ID INT NOT NULL PRIMARY KEY,
name VARCHAR(20) NOT NULL,
fname VARCHAR(20) NOT NULL,
DOB DATE NOT NULL,
city VARCHAR(20),
class INT NOT NULL);

DESC student;


-- INSERT COMMAND (DML COMMAND)
-- DML(Data Manupulation Language)


INSERT INTO student VALUES(101,"Sandhya","Pratik","2002-10-18","MUMBAI",12);
SELECT * FROM student;
INSERT INTO student VALUES(102,"Prashant","Vaishnavi","2001-12-19","DELHI",10);


INSERT INTO student (std_ID,name,fname,DOB,city,class)
VALUES
(108,"Rani","Divya","2001-08-09","PUNE",10),
(104,"Priti","Pintu","2000-06-19","BRAMHAPURI",11),
(105,"Dinki","Nandini","2000-07-14","BEED",18),
(106,"Diksha","Manda","2000-05-17","PUNE",15);

SELECT * FROM student;

-- Deleting Record From The Table

CREATE DATABASE temp1;
USE temp1;

CREATE TABLE student(
std_ID INT NOT NULL PRIMARY KEY,
name VARCHAR(20) NOT NULL,
fname VARCHAR(20) NOT NULL,
DOB DATE NOT NULL,
city VARCHAR(20),
class VARCHAR(20) NOT NULL);

DESC student;

INSERT INTO student (std_ID,name,fname,DOB,city,class)
VALUES
(101,"Sandhya","Pratik","2002-10-18","MUMBAI",12),
(102,"Prashant","Vaishnavi","2001-12-19","DELHI",10),
(108,"Rani","Divya","2001-08-09","PUNE","IT"),
(104,"Priti","Pintu","2000-06-19","BRAMHAPURI","CS"),
(105,"Dinki","Nandini","2000-07-14","BEED","DA"),
(106,"Diksha","Manda","2000-05-17","MUMBAI","JAVA");


INSERT INTO student VALUES(107,"Diksha","Manda","2000-05-17",NULL,"JAVA");

SELECT* FROM student;

ROLLBACK;
DELETE FROM student WHERE city="MUMBAI";

DELETE FROM student WHERE class="IT";

SET SQL_SAFE_UPDATES =0;

-- Modifying Records in the Table
-- UPDATE <TABLE NAME> SET <COLUMN>  =<Expression>

UPDATE student SET class="DA" WHERE class="IT";
UPDATE student SET class="IT" WHERE class="10";
UPDATE student SET class="DA" WHERE class="17";
UPDATE student SET city="MUMBAI" WHERE CITY IS NULL;

-- SELECT COMMAND 
-- DQL= DATA QUERRY LANGUAGE

CREATE DATABASE temp2;
USE temp2;

CREATE TABLE student(
st_ID INT NOT NULL PRIMARY KEY,
name VARCHAR(20) NOT NULL,
fname VARCHAR(20) NOT NULL,
DOB DATE NOT NULL,
city VARCHAR(20) NOT NULL,
class INT NOT NULL);


ALTER TABLE student MODIFY st_ID VARCHAR(20);

INSERT INTO student
(st_ID,name,fname,DOB,city,class)
VALUES
("S1","Sam","Pratik","2000-10-29","DELHI",10),
("S2","Nita","Sandhya","2005-11-21","MUMBAI",12),
("S3","Divya","Pankaj","2003-12-24","NAGPUR",14),
("S4","Dimpal","Prakash","2001-09-26","PUNE",15),
("S5","Sandy","Pintu","2002-08-25","SANGLI",16);

SELECT * FROM student;

select st_ID,city FROM student;










