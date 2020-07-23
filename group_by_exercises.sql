USE employees;

#In your script, use DISTINCT to find the unique titles in the titles table. 
SELECT DISTINCT title
FROM titles;

#Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. 
SELECT DISTINCT last_name AS unique_names
FROM employees 
WHERE last_name LIKE 'E%' 
AND last_name LIKE '%E'
GROUP BY unique_names ASC;

#Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.
SELECT CONCAT(first_name, ' ', last_name) AS unique_full_names
FROM employees 
WHERE last_name LIKE 'E%E' 
GROUP BY unique_full_names ASC;

#Find the unique last names with a 'q' but not 'qu'. 
SELECT DISTINCT last_name AS last_names_with_q
FROM employees 
WHERE last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';

#Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT last_name, COUNT(last_name)
FROM employees 
WHERE last_name LIKE '%q%'AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(last_name);

#Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. 
SELECT COUNT(*), gender 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

#Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames?
#Yes, there are many duplicate usernames
SELECT DISTINCT LOWER(CONCAT(SUBSTR(first_name,1,1), 
						SUBSTR(last_name,1,4),
						'_',
						SUBSTR(birth_date,6,2),
						SUBSTR(birth_date,3,2)
						)) AS user_name				
FROM employees;
		
SELECT user_name, COUNT(*) AS records					
FROM (SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), 
						SUBSTR(last_name,1,4),
						'_',
						SUBSTR(birth_date,6,2),
						SUBSTR(birth_date,3,2)
						)) AS user_name,		
					first_name, last_name		
		FROM employees
	) AS temp
	GROUP BY user_name
	ORDER BY records DESC;

#Bonus: how many duplicate usernames are there?
SELECT sum(temp.username_count) AS total_users_with_duplicated_usernames,
		COUNT(temp.username_count) AS duplicated_distinct_usernames,
		sum(temp.username_count) - COUNT(temp.username_count) AS number_of_users_needing_new_usernames
FROM (SELECT CONCAT(LOWER(SUBSTR(first_name,1,1)), 
						LOWER(SUBSTR(last_name,1,4)), "_",
						SUBSTR(birth_date,6,2),
						SUBSTR(birth_date,3,2)) AS username,
						COUNT(*) AS username_count			
			FROM employees
			GROUP BY username
			ORDER BY username_count DESC
) AS temp
WHERE username_count > 1;
	