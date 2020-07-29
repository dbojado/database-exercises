USE employees; 

#1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
 SELECT emp.emp_no, d.dept_no, emp.start_date, emp.end_date, emp.is_current_emp
 FROM dept_emp d 
 JOIN 
 (SELECT dept_emp.emp_no 
 		, max(employees.hire_date) AS start_date
 		, max(dept_emp.to_date) AS end_date
 		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
 			AS is_current_emp
 FROM dept_emp
 JOIN employees USING(emp_no)
 GROUP BY dept_emp.emp_no 
 ) emp
 ON d.emp_no = emp.emp_no AND d.to_date = emp.end_date
 ;

#2. Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name, last_name, 
	CASE 
		WHEN substr(last_name, 1, 1) IN ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
    	WHEN substr(last_name, 1, 1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
   		WHEN substr(last_name, 1, 1) IN ('r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z') THEN 'R-Z'
		ELSE 'none'
		END AS alpha_group
FROM employees;

#3. How many employees were born in each decade?
SELECT count(birth_date)
 	, CASE WHEN birth_date LIKE '195%' THEN '1950s'
 		WHEN birth_date LIKE '196%' THEN '1960s'
 		END AS birth_decade
FROM employees
GROUP BY birth_decade;


