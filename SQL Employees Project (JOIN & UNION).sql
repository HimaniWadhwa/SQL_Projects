#How scattered is the man-power for each title?
SELECT 
    t.title, COUNT(e.emp_no) AS Manpower
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
GROUP BY t.title;


#How is the salary distribution between titles?
SELECT 
    t.title, AVG(s.salary) AS Average_Salary
FROM
    salaries s
        JOIN
    titles t ON s.emp_no = t.emp_no
GROUP BY t.title;


#How scattered is the man-power in each department? List the names of the departments, not just the department number.
SELECT 
    de.dept_no, d.dept_name, count(de.emp_no) AS Manpower
FROM
    dept_emp de
        JOIN
    departments d ON de.dept_no = d.dept_no GROUP BY d.dept_name order by de.dept_no;


#Who is the highest and lowest paid employee in the company?
SELECT e.emp_no, e.first_name, e.last_name, s.salary AS Max_Min_Salary FROM employees e JOIN Salaries s on e.emp_no = s.emp_no
where s.salary = (Select max(salary) from salaries)
UNION
 SELECT e.emp_no, e.first_name, e.last_name, s.salary AS Max_Min_Salary FROM employees e JOIN Salaries s on e.emp_no = s.emp_no
where s.salary = (Select min(salary) from salaries);


#Using union only command, list all the employees who were hired in 1985, 1989 and 1994 only and sort them by hire dates
select emp_no, hire_date from employees where hire_date LIKE '1985%'
UNION
select emp_no, hire_date from employees where hire_date LIKE '1989%'
 UNION
select emp_no, hire_date from employees where hire_date LIKE '1994%' ORDER BY hire_date;


#What is the average salary those employees who were hired after 01st Jan 1986?
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    AVG(s.salary) AS Average_salary,
    e.hire_date
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.hire_date > '1986-01-01'
GROUP BY e.emp_no
ORDER BY Average_salary;


#Is there gender disparity in the company?
#Disparity with promotion
with table1 AS (with tbl as (Select e.emp_no as employee_no, e.gender as gendertype, Count(title)-1 as promotions FROM employees e JOIN titles t on e.emp_no = t.emp_no group by employee_no) Select gendertype, sum(promotions) as promotions from tbl group by gendertype),
table2 AS (SELECT  e.gender AS gendertype,  ROUND(AVG(s.salary),1) AS average_salary
FROM  employees e  JOIN  salaries s ON e.emp_no = s.emp_no GROUP BY gendertype)
select table1.gendertype, table1.promotions, table2.average_salary from table1 join table2 on table1.gendertype = table2.gendertype;


#Which department is best paid in the company?
SELECT 
    d.dept_no, d.dept_name, AVG(s.salary) AS Average_salary
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    Salaries s ON s.emp_no = de.emp_no
GROUP BY dept_name
ORDER BY Average_salary DESC;


#Who are the managers for each department? List their names
SELECT 
    dm.emp_no, e.first_name, e.last_name, d.dept_name, d.dept_no
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON e.emp_no = dm.emp_no;
    

#What is the average salary of those employees who were hired after 01st Jan 1986?
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    AVG(s.salary) AS Average_Salary,
    e.hire_date
FROM
    salaries s
        LEFT JOIN
    employees e ON s.emp_no = e.emp_no
WHERE
    e.hire_date > '1986-01-01'
GROUP BY e.emp_no;


#How has the salary changed over the years?
WITH T1 AS (SELECT t.title, YEAR(s.from_date) AS yearofsalary,AVG(s.salary) AS Average_salary,LAG(AVG(s.salary)) OVER (PARTITION BY title ORDER BY YEAR(s.from_date)) AS previous_salary  FROM titles t JOIN salaries s ON t.emp_no = s.emp_no GROUP BY t.title,yearofsalary)
SELECT title,yearofsalary,Average_salary,previous_salary, CONCAT(ROUND(( Average_salary - previous_salary ) * 100 /previous_salary,0),'%') AS yoy FROM T1;
