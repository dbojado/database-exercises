#Join Example Database

#1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT*
FROM roles, users;

#2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT roles.id, roles.name
FROM roles
JOIN users ON roles.id = users.role_id;

SELECT roles.id, roles.name
FROM roles
LEFT JOIN users ON roles.id = users.role_id;

SELECT roles.id, roles.name
FROM roles
RIGHT JOIN users ON roles.id = users.role_id;

#3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(roles.name) as Role_Count
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

#Employees Database

#1. Use the employees database.
USE employees;

#2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager
FROM employees AS e
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > curdate()
ORDER BY d.dept_name ASC;

#3. Find the name of all departments currently managed by women.
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Manager_Name
FROM employees AS e
JOIN dept_manager AS dm
ON dm.emp_no = e.emp_no
JOIN departments AS d
ON d.dept_no = dm.dept_no
WHERE dm.to_date > curdate() AND gender = 'F'
ORDER BY d.dept_name ASC;

#4.	Find the current titles of employees currently working in the Customer Service department.
SELECT Title, Count(title) 
FROM titles
JOIN dept_emp ON dept_emp.emp_no = titles.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > curdate()
AND titles.to_date > curdate()
AND departments.dept_name = 'Customer Service'
GROUP BY title;

#5.	Find the current salary of all current managers.
SELECT d.dept_name AS Department_Name, CONCAT(e.first_name, ' ', e.last_name) AS Department_Manager, salary AS Salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > curdate() AND s.to_date > curdate()
ORDER BY d.dept_name ASC;

#6.	Find the number of employees in each department.
SELECT d.dept_no, d.dept_name, count(e.emp_no) AS 'num_employees'
FROM employees AS e
JOIN employees_with_departments AS emp ON emp.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = emp.dept_no
JOIN dept_emp AS dep ON dep.emp_no = e.emp_no
WHERE dep.to_date > curdate()
GROUP BY d.dept_no;

#7. Which department has the highest average salary?
SELECT dept_name, AVG(salary)
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date > curdate() AND salaries.to_date > curdate()
GROUP BY departments.dept_no
ORDER BY AVG(salary) DESC
LIMIT 1;

#8.	Who is the highest paid employee in the Marketing department?
SELECT CONCAT(first_name, ' ', last_name) AS full_name, d.dept_name, max(salary)
FROM salaries AS s
JOIN employees_with_departments AS emp ON emp.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = emp.dept_no
WHERE d.dept_name = "Marketing"
AND s.to_date > curdate()
GROUP BY full_name
ORDER BY max(salary) DESC
limit 1;

#9.	Which current department manager has the highest salary?
SELECT first_name, last_name
FROM employees
JOIN dept_manager on dept_manager.emp_no = employees.emp_no
JOIN salaries on salaries.emp_no = dept_manager.emp_no
JOIN departments on departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date > curdate()
AND salaries.to_date >curdate()
ORDER BY salaries DESC
LIMIT 1; 

