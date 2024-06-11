#Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995
SELECT 
    emp_no, first_name, last_name, hire_date
FROM
    employees
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            dept_manager) AND HIRE_date between '1990-01-01' AND '1995-01-01';


#Extract information of all the “Female Managers”
SELECT  e.emp_no, e.first_name, e.last_name, e.birth_date, e.gender, e.hire_date, dm.dept_no, dm.from_date, dm.to_date
FROM employees e JOIN dept_manager dm on e.emp_no = dm.emp_no 
WHERE e.emp_no IN (SELECT emp_no FROM dept_manager) AND GENDER = 'F';

#Select the entire information for all employees whose job title is “Assistant Engineer”.
SELECT e.emp_no,  e.first_name,  e.last_name,  e.gender,  t.title,  s.salary FROM
    employees e  JOIN Titles t ON e.emp_no = t.emp_no JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no IN (SELECT emp_no  FROM titles) AND t.title = 'Assistant Engineer';

#Please get the minimum, maximum and average salary of all the employees.
#Then, Add another column (“Salary Bracket) to the “Salaries” table with following conditions:
# a. Anyone with the salary less than or equal to 65000 should return “Low salaried” in the new column
# b. Anyone with salary between 65000 and 100,000 should return Medium
# c. Otherwise “High Salaried” in the new column
SELECT emp_no, ROUND(AVG(salary),0) AS AVG_salary, MIN(Salary), MAX(Salary),
    CASE
    When AVG(Salary) <= 65000 Then 'Low salaried'
    When AVG(Salary) > 65000 and AVG(Salary) < 100000 Then 'Medium' 
    ELSE 'High Salaried'
    END AS Salary_Bracket from salaries GROUP BY emp_no;


#Add another column (name the column to your liking) to the “Titles” table with following conditions. Anyone with the title “Engineer” or “Technical” in it should return “Engineer” in the new column, otherwise “Admin” in the new column
Select *,
    CASE WHEN title = 'Engineer' then 'Engineer' 
    WHEN title = 'Technical' then 'Engineer' 
	ELSE 'Admin'
    END AS new_title from titles;


#Add another column to the “employees” table (called it hire_quarter), that returns the Quarter number for the respective hire month. For eg, if someone joined in either Jan, Feb or March, this column should return the value “Q1”
Select *,
    CASE WHEN MONTH(HIRE_DATE) between 1 and 3 then 'Q1' 
    WHEN MONTH(HIRE_DATE) between 4 and 6 then 'Q2' 
    WHEN MONTH(HIRE_DATE) between 7 and 9 then 'Q3' 
    WHEN MONTH(HIRE_DATE) between 10 and 12 then 'Q4' 
    END AS hire_quarter from employees;
    

#Using “Case When”, in the “dept_emp” table, please add the respective department name
select *,
CASE when dept_no = 'd001' then 'Marketing'
when dept_no = 'd002' then 'Finance'
when dept_no = 'd003' then 'Human Resources'
when dept_no = 'd004' then 'Production'
when dept_no = 'd005' then 'Development'
when dept_no = 'd006' then 'Quality Management'
when dept_no = 'd007' then 'Sales'
when dept_no = 'd008' then 'Research'
when dept_no = 'd009' then 'Customer Service'
ELSE 'Unknown Department'
END AS Department_Name
From dept_emp;
