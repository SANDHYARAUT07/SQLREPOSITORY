create database college;
USE college;

create table students(
stcode char(3) NOT NULL PRIMARY KEY,
stname char(20) NOT NULL,
stAdd VARCHAR(40),
AdmNO char(5) UNIQUE,
stSex char(1) DEFAULT 'M',
stAge integer CHECK(stAge>=5));



create table emp(
code char(3) NOT NULL,
Name char(20) NOT NULL,
City Varchar(40),
Pay Decimal(10,2),
PRIMARY KEY(code));

desc emp;


create database mydb;
 
 USE mydb;

CREATE TABLE voter(
voterid INT NOT NULL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
age INT(2) NOT NULL CHECK(age>=18),
gender CHAR(1) NOT NULL,
address_line1 VARCHAR(50),
address_line2 VARCHAR(50),
city VARCHAR(20) NOT NULL,
State VARCHAR(20) NOT NULL);



desc voter;




