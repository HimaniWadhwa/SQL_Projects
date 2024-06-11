#In the table “Employee”, choose all the Female employees whose employee ID is more than 10200 – list all columns and get only 50 results   
Select * from employees where Gender = 'F' and emp_no > 10200 Limit 50;

#In the table “Employee”, choose all the employees whose name is either Denis/ Giri – list all columns
SELECT * FROM employees WHERE first_name IN ('Denis' , 'Giri') OR Last_name IN ('Denis' , 'Giri');

#In the table “Employee”, choose all the employees whose name is “Shen” & Gender is either Males/ Females – list only first, last names and gender.
Select first_name, last_name, Gender from employees where first_name = 'Shen'and Gender in ('M' , 'F');

#In the table “Employee”, choose all the Female employees whose first name is either Denis/ Elvis – list all columns
Select * from employees where Gender = 'F' and first_name IN ('Denis' , 'Elvis');

#In the table “Employee”, choose all the employees except for those whose first name is either John/ Mark/ Jacob – list all column and get only 200 results observations 
Select * from employees where First_name NOT IN ('John', 'Mark', 'Jacob') LIMIT 200;

#In the “Employees” table, retrieve a list with all employees who were born in 1950s 
Select * from employees where birth_date BETWEEN '1950-01-01' and '1959-12-31';

#In the “Employees” table, choose all individuals whose first name does not start with “M
Select * from employees where first_name NOT LIKE ('M%');

#In the “Titles” table, retrieve the list that has “engineer” in the title
Select * from titles where title LIKE 'Engineer';

#In the “Employees” tables, retrieve a list with all employees whose employee number is written with 5 characters, and start with “100”
Select * from employees where emp_no LIKE '100__';

#In the “Employees” table, retrieve a list with all employees who were born between Jan 1950 to Oct 1956 – select only birth_date, first, last names and gender and get only 500 results
Select birth_date, first_name , last_name, gender from employees where birth_date between '1950-01-01' and '1956-10-31'LIMIT 500;

#In the “salaries” table, retrieve a list with all employees whose salary is not in 60000s
Select * from salaries where salary NOT BETWEEN 60000 and 69999;

#In the “titles” table, retrieve the list of all the titles unduplicated which has “staff” in the title unduplicated
Select distinct * from titles where Title = 'staff';

#In the “titles” table, Count the number of unique titles there are
select COUNT(DISTINCT title) from titles;

#From the “salaries” table, retrieve the average salary of first 200 employees sort this in descending order (there are multiple entries for each employee because of the yearly increments) – also, rename the average salary column to “average_sal”
SELECT emp_no, AVG(Salary) AS average_sal FROM employees.salaries GROUP BY emp_no ORDER BY average_sal DESC LIMIT 200;

#From the “employees” table, retrieve the number of Female hires on each date of the year 1986 and sort them by hire date – rename the count of female hires column to “number_of_female_hires”
SELECT Hire_Date, COUNT(Emp_No) AS number_of_female_hires FROM employees 
WHERE hire_date LIKE '1986%' AND (Gender = 'F')
GROUP BY hire_date
ORDER BY hire_date;
