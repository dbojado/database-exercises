#Subqueries
USE employees;

#1.Find all the employees with the same hire date as employee 101010 using a sub-query. 69 Rows
SELECT CONCAT(first_name, ' ', last_name) as full_name, hire_date
FROM employees
WHERE hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
	);

#2.Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles
SELECT CONCAT(first_name, ' ', last_name) AS full_name, titles.title
FROM titles
JOIN employees ON employees.emp_no = titles.emp_no
WHERE titles.emp_no IN (
	SELECT emp_no 
	FROM employees 
	WHERE employees.first_name = 'Aamod')
ORDER BY title;

#3.How many people in the employees table are no longer working for the company?
SELECT *
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate()
);

#4.Find all the current department managers that are female.
SELECT first_name, last_name
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE employees.gender = 'F'
	)
AND dept_manager.to_date > curdate();
	
#5.Find all the employees that currently have a higher than average salary. 154543 rows in total.
SELECT first_name, last_name, salary
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE salary  > (
	SELECT AVG(salary)
	FROM salaries
)
AND to_date > curdate()
LIMIT 5; 

#6.How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this? 78 salaries
SELECT *
FROM salaries
WHERE salary > 
(
	(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
)
AND to_date > curdate();



SELECT count(*) AS "num_salaries_1_stddev_below_max", (count(*)/(SELECT count(*) FROM salaries))*100 AS "percentage_of_current_salaries"
FROM salaries
WHERE salary >=
(
	(SELECT max(salary) FROM salaries) - (SELECT STDDEV(salary) FROM salaries)
)
AND to_date > curdate()
;

