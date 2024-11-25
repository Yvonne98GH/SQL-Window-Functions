--PRACTICE QUESTIONS ON WINDOW FUNCTIONS USING THE TABLE EMPLOYEES2

-- 1. Assign a unique number to each employee ordered by salary within each department.
CREATE TABLE Employees2 AS
SELECT * FROM Employees;

SELECT Employee_ID, first_name || ' ' || last_name AS Name, department_id,
    ROW_NUMBER () OVER (PARTITION BY department_id ORDER BY salary DESC) AS Numbered_Rows
FROM Employees2;

-- 2. Rank employees by salary within each department.
SELECT first_name, department_id, salary,
   RANK () OVER (PARTITION BY Department_ID ORDER BY Salary DESC) AS Emp_Rank
FROM Employees2;

--3. Calculate the cumulative salary for employees ordered by salary.
SELECT employee_id, first_name, salary,
    ROUND(CUME_DIST() OVER (ORDER BY salary DESC),3) AS Cumulative_Sal
FROM Employees2;

--4. Find the next salary for each employee in the list.
SELECT first_name, salary,
    LEAD(salary) OVER(ORDER BY salary DESC) AS next_salary
FROM employees2;

--5. Find the previous salary for each employee.
SELECT first_name || ' ' || last_name AS Name, salary,
    LAG(salary) OVER(ORDER BY salary DESC) AS previous_salary
FROM employees2;

--6. Calculate the percentile rank of employees based on salary.
SELECT first_name || ' ' || last_name AS Name, salary,
    ROUND(PERCENT_RANK() OVER(ORDER BY salary DESC),3) AS P_Rank
FROM employees2;

--7. Calculate the running total of salary using SUM() as a window function, partitioned by department.
SELECT first_name || ' ' || last_name AS Name, department_ID, salary,
    SUM(salary) OVER(PARTITION BY Department_ID) AS Sal_Run
FROM employees2;

--8. Divide employees into 4 quartiles based on salary.
SELECT first_name || ' ' || last_name AS Name, salary,
    NTILE(4) OVER(ORDER BY salary DESC) AS Sal_Quartile
FROM employees2;

--9. /*Calculate the average salary for each department using the AVG() window function.
       Return the department_ID, department-name, and average salary per department in descending order. */
       
SELECT DISTINCT E. department_ID, D.Department_Name,
    ROUND(AVG(salary) OVER (PARTITION BY E. department_id),2) AS Dept_Avg_Sal
FROM employees2 E
INNER JOIN Departments D ON
E.Department_ID = D.Department_ID
ORDER BY Dept_Avg_Sal DESC;

-- 10. Find the minimum salary within each department using MIN() as a window function.
SELECT DISTINCT department_ID,
    MIN(salary) OVER(PARTITION BY DEPARTMENT_ID) AS Min_Sal_Dept
FROM Employees2;

--11. Eeturn the highest salary for each department.
SELECT DISTINCT department_ID,
    MAX(salary) OVER(PARTITION BY DEPARTMENT_ID) AS Max_Sal_Dept
FROM Employees2;

--12. Partition employees by job and calculate the salary average within each job group.
SELECT DISTINCT job_id,
    AVG(salary) OVER(PARTITION BY job_id) AS Jobgrp_Avg
FROM employees2;

--13. Rank employees by salary but allow for ties.
SELECT first_name || ' ' || last_name AS Name, salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS Sal_Rank
FROM employees2;

--14. Assign row numbers for employees in each department ordered by hire date.
SELECT first_name || ' ' || last_name AS Name, department_ID, hire_date,
    ROW_NUMBER() OVER(PARTITION BY Department_ID ORDER BY hire_date) AS Row_No
FROM employees2;

--15. Get the next hire date for each employee in the table.
SELECT first_name || ' ' || last_name AS Name, hire_date,
    LEAD(hire_date) OVER(ORDER BY hire_date ASC) AS Next_Hire
FROM employees2;
--16. Get the previous job title for each employee.
SELECT E.first_name || ' ' || E.last_name AS Name, J.Job_Title,
    LAG(J.Job_ID) OVER(ORDER BY hire_date ASC) AS Prev_Job_Title
FROM employees2 E
INNER JOIN jobs J
ON E.Job_ID = J.JOB_ID;

--17. Calculate the difference in salaries between consecutive employees
SELECT first_name || ' ' || last_name AS Name, salary,
    LAG(salary) OVER(ORDER BY salary DESC) - salary AS Sal_Diff
FROM employees2;

--18. Use SUM() as a window function to calculate the total commission for each employee within their department.
SELECT first_name || ' ' || last_name AS Name, department_id, commission_pct,
    SUM(commission_pct) OVER(PARTITION BY department_id) AS Comm_Total
FROM employees2;

--19. Calculate the moving average salary for employees within each department using a window frame.
SELECT  DISTINCT department_id,
    ROUND(AVG(salary) OVER(PARTITION BY department_id),2) AS AVG_Sal
FROM employees2;

--20. Calculate the total salary for each department, ordering by hire date.
SELECT department_ID,
    SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date) AS Dept_sal
FROM Employees2;