USE employees;
SHOW tables;
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE salaries;
SHOW CREATE TABLE salaries;

#What is the relationship between the employees and the departments tables?
#they're both tables under the 'employees' database, other than that no direct relationship 
#however dept_emp and dept_manager table do show a relationship

#Show the SQL that created the dept_manager table
SHOW CREATE TABLE dept_manager;
