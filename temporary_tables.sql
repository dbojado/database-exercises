USE darden_1037;

#1. Using the example from the lesson, re-create the employees_with_departments table.
#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
#Update the table so that full name column contains the correct data
#Remove the first_name and last_name columns from the table.
#What is another way you could have ended up with this same table?
#Create a temporary table based on the payment table from the sakila database.

SELECT e.emp_no, 
concat(e.first_name, ' ', e.last_name) as full_name,
e.birth_date,
e.hire_date,
e.gender,
d.dept_name,
d.dept_no,
de.from_date,
de.to_date
from employees.employees as e
join employees.dept_emp as de using(emp_no)
join employees.departments as d using(dept_no);


#2. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

CREATE TEMPORARY TABLE payments AS 
select *
from sakila.payment;

ALTER TABLE payments modify amount INT UNSIGNED;

UPDATE payments
set amount = amount * 100;

CREATE TEMPORARY TABLE payments AS 
select *, amount * 100 as pennies
from sakila.payment;

ALTER TABLE payments modify pennies INT UNSIGNED;


#3. Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

CREATE TABLE emps AS
SELECT
	e.*,
	s.salary,
	d.dept_name AS department,
	d.dept_no
FROM employees.employees as e
JOIN employees.salaries s USING (emp_no)
JOIN employees.dept_emp de USING (emp_no)
JOIN employees.departments d USING (dept_no);

SELECT * FROM emps LIMIT 50;

ALTER TABLE emps ADD mean_salary FLOAT;
ALTER TABLE emps ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;


CREATE TEMPORARY TABLE salary_aggregates AS
SELECT
	AVG(salary) AS mean,
	STDDEV(salary) AS sd
FROM emps;

SELECT * FROM salary_aggregates;

UPDATE emps SET mean_salary = (SELECT mean FROM salary_aggregates);
UPDATE emps SET sd_salary = (SELECT sd FROM salary_aggregates);	
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;

SELECT
	department,
	AVG(z_salary) AS z_salary
FROM emps
GROUP BY department
ORDER BY z_salary; 
