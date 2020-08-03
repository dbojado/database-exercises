-- Employees Database
-- 1. How much do the current managers of each department get paid...                                    Tables: salaries, departments, dept_managers, employees
-- 2. relative to the average salary for the department?                                                 Tables: salaries, departments, dept_emp
-- 3. Is there any department where the department manager gets paid less than the average salary?            

USE darden_1037;

create temporary table managers_salary as
select dept_no,emp_no, concat(first_name, ' ', last_name) as manager_name ,dept_name, salary
from employees.employees as e
join employees.salaries as s using(emp_no)
join employees.dept_manager as dm using(emp_no)
join employees.departments as d using(dept_no)
where s.to_date > now()
and dm.to_date > now();

create temporary table department_salary_data as
select dept_name, avg(salary) as department_avg_salary, stddev(salary) as department_standard_deviation
from employees.salaries as s
join employees.dept_emp as de using(emp_no)
join employees.departments as d using(dept_no)
where s.to_date > now()
and de.to_date > now()
group by dept_name;

select dept_name, manager_name, salary, ((salary-department_avg_salary)/department_standard_deviation) as z_score
from managers_salary as ms
join department_salary_data as ds using(dept_name)
where department_avg_salary > salary;