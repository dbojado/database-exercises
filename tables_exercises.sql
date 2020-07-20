#Specify a Database to use 
USE employees;

#Shows the current database
select database();

#Shows any tables you have permission to see on the current database
show tables;

#Shows all the column names and data-types and contraints for a given table 
DESCRIBE employees;

#Shows the SQL that originally ran to generate that table 
SHOW CREATE TABLE employees;

#What is the relationship between the employees and the departments tables?
#they're both tables under the 'employees' database
DESCRIBE departments;

#Show the SQL that created the dept_manager table
DESCRIBE dept_manager;
