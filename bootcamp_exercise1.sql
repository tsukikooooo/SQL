create database bootcamp_excerise1;
use bootcamp_exercise1;

create table regions(
	region_id int primary key,
    region_name varchar(25)
);
select * from regions;

create table countries(
	country_id char(2) primary key,
    country_name varchar(40),
    region_id int,
    foreign key(region_id) references regions(region_id)
);
select * from countries;

create table locations(
	location_id int primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    foreign key (country_id) references countries(country_id)
);
select* from locations;



create table departments(
	department_id int primary key, 
    department_name varchar(30),
    manager_id int,
    location_id int,
    foreign key (location_id) references locations(location_id)
);
select * from departments;

create table jobs(
	job_id varchar(10) primary key,
    job_title varchar(35),
    min_salary numeric(10,2),
    max_salary numeric(10,2)
);
select * from jobs;

create table job_history(
	employee_id int,
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id int,
    primary key(employee_id, start_date),
    foreign key (department_id) references departments(department_id),
    foreign key (job_id) references jobs(job_id),
    foreign key (employee_id) references employees(employee_id)
);
select * from job_history;



create table employees(
	employee_id int primary key,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(20),
    hire_date date,
    job_id varchar(10),
    salary numeric(10,2),
    commission_pct numeric(10,2),
    manager_id int,
    department_id int,
    foreign key (department_id) references departments(department_id),
    foreign key (job_id) references jobs(job_id)
);
create table job_history(
	employee_id int,
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id int,
    primary key(employee_id, start_date),
    foreign key (department_id) references departments(department_id),
    foreign key (job_id) references jobs(job_id),
    foreign key (employee_id) references employees(employee_id)
);
select * from job_history;



drop table employees;
drop table job_history;
drop table jobs;
drop table departments;
drop table locations;
drop table countries;
drop table regions;


-- REGIONS
INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES
(1, 'North America'),
(2, 'Europe'),
(3, 'Asia');
select * from REGIONS;

-- COUNTRIES
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES
(1, 'United States', 1),
(2, 'United Kingdom', 2),
(3, 'Japan', 3);
select * from COUNTRIES;

-- LOCATIONS
INSERT INTO LOCATIONS (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES
(1001, '123 Main St', '12345', 'New York', 'NY', 1),
(1002, '456 Elm St', '67890', 'London', NULL, 2),
(1003, '789 Oak St', '98765', 'Tokyo', NULL, 3);
select * from LOCATIONS;

-- DEPARTMENTS
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Sales', 101, 1001),
(20, 'HR', 102, 1002),
(30, 'IT', 103, 1003);
select * from DEPARTMENTS;

-- JOBS
INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES
('SALESMAN', 'Salesman', 30000, 60000),
('HR_REP', 'HR Representative', 35000, 70000),
('IT_PROG', 'IT Programmer', 40000, 80000);
select * from EMPLOYEE_ID;

-- EMPLOYEES
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(101, 'John', 'Doe', 'john@example.com', '123-456-7890', '2023-01-15', 'SALESMAN', 50000, 0.05, 103, 10),
(102, 'Lex', 'De Haan', 'jane@example.com', '987-654-3210', '2023-02-20', 'HR_REP', 55000, 0.07, 103, 20),
(103, 'Michael', 'Johnson', 'michael@example.com', '555-123-4567', '2023-03-25', 'IT_PROG', 60000, 0.06, 103, 30),
(104, 'Jack', 'Malfod', 'jack@example.com', '321-987-9292', '2022-08-15', 'SALESMAN', 55000, 0.05, 103, 10),
(105, 'Jane', 'Doe', 'jane.doe@example.com', '928-876-0376', '2020-07-20', 'HR_REP', 58000, 0.07, 103, 20),
(106, 'May', 'Parker', 'may@example.com', '234-987-0009', '2021-08-25', 'IT_PROG', 65000, 0.06, 103, 30);
select * from EMPLOYEES;


-- JOB_HISTORY
INSERT INTO JOB_HISTORY (EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID) VALUES
(101,'2023-01-15', '2023-05-15', 'SALESMAN', 10),
(102,'2023-02-20', '2023-06-20', 'HR_REP', 20),
(103,'2023-03-25', NULL, 'IT_PROG', 30),
(104,'2022-08-15','2024-09-01','SALESMAN',10),
(105,'2020-07-20', NULL,'HR_REP',20),
(106,'2021-08-25', NULL,'IT_PROG',30);

select * from Job_history;

-- Question 3
-- FIND THE LOCATION_ID , STREET_ADDRESS, CITY, STATE_PROVINCE, COUNTRY_NAME OF LOCATIONS
SELECT  L.LOCATION_ID, L.STREET_ADDRESS, L.CITY, L.STATE_PROVINCE,C.COUNTRY_NAME
FROM LOCATIONS L
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
order by C.COUNTRY_ID;

-- QUESTION 4
-- FIRST_NAME, LAST_NAME, DEPARTMENT ID OF ALL THE EMPLOYEES
SELECT FIRST_NAME,LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES;

-- QUESTION 5
-- FIND THE FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT ID OF THE EMPLOYEES WHO WORKS IN JAPAN
SELECT E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, E.DEPARTMENT_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE C.COUNTRY_NAME = 'Japan';

-- QUESTION 6
-- FIND THE EMPLOYEE ID , LAST_NAME ALONG WITH THEIR MANAGER_ID AND LAST_NAME
SELECT E1.EMPLOYEE_ID, E1.LAST_NAME, E1.MANAGER_ID, E.LAST_NAME AS MANAGER_LASTNAME
FROM EMPLOYEES E JOIN EMPLOYEES E1 ON E.EMPLOYEE_ID = E1.MANAGER_ID;

-- QUESTION 7 
-- FIND THE FIRST_NAME, LAST_NAME AND HIRE DATE OF THE EMPLOYEES WHO WAS HIRED AFTER EPLOYEE 'LEX DE HAAN'
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE EMPLOYEE_ID >102;

-- QUESTION 8 
-- GET THE DEPARTMENT NAME AND NUMBER OF EMPLOYEES OF EACH THE DEPARTMENT.
SELECT * FROM EMPLOYEES;
SELECT D.DEPARTMENT_NAME, D.DEPARTMENT_ID,COUNT(E.EMPLOYEE_ID) AS EMPLOYEE_COUNT 
FROM DEPARTMENTS D 
INNER JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, D.DEPARTMENT_ID
HAVING COUNT(E.EMPLOYEE_ID)> 0;


-- QUESTION 9
-- FIND THE EMPLOYEE ID, JOB TITLE NUMBER OF DAYS BETWEEN ENDING DATE AND STARTING DATE FOR ALL JOBS IN DEPARTMENT ID 30.
SELECT JH.EMPLOYEE_ID, J.JOB_TITLE, datediff(JH.END_DATE, JH.START_DATE)AS DAYS_BETWEEN
FROM JOB_HISTORY JH
JOIN JOBS J ON JH.JOB_ID = J.JOB_ID
JOIN EMPlOYEES E ON JH.EMPLOYEE_ID = E.EMPLOYEE_ID
WHERE JH.DEPARTMENT_ID = 30;

    
-- QUESTION 10 
-- DISPLAY ALL DEPARTMENT NAME, MANAGER NAME, CITY AND COUNTRY NAME.
SELECT D.DEPARTMENT_NAME,CONCAT(E.FIRST_NAME," ",E.LAST_NAME) AS MANAGER_NAME,L.CITY,C.COUNTRY_NAME
FROM DEPARTMENTS D 
JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID
JOIN LOCATIONS L ON L.LOCATION_ID = D.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID;

-- QUESTION 11
-- DISPLAY THE AVERAGE SALARY OF EACH DEPATERMENT
SELECT D.DEPARTMENT_NAME, AVG(E.SALARY) AS AVERAGE_SALARY
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;
    
-- QUESTION 12 
-- TRY TO PERFORM NORMALIZATION ON TABLE 'JOBS.
-- A: HOW DO YOU RE-RESIGN THE TABLE 'JOBS'? AND ADDING TABLE .JOB_GRADES;
CREATE TABLE JOB_GRADES(
	GRADE_LEVEL VARCHAR (2)PRIMARY KEY,
    LOWEST_SAL NUMERIC (10,2),
    HIGHEST_SAL NUMERIC (10,2)
);

ALTER TABLE JOBS ADD COLUMN GRADE_LEVEL VARCHAR(2);
SELECT* FROM JOBS;
ALTER TABLE JOBS ADD CONSTRAINT FK_GRADE_LEVEL FOREIGN KEY (GRADE_LEVEL) REFERENCES JOB_GRADES(GRADE_LEVEL);

