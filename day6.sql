use comp;
-- to declare variable name @variable_name
SELECT round(avg(age)),min(age) from customers INTO @average, @min_age;
select @average;
select @min_age;

select count(*) into @no_of_rows from customers ;
select @no_of_rows;

-- SELECT col1, col2 INTO @var1, @var2 FROM table_name WHERE condition;

select * from customers
where age =  @min_age;


CREATE DATABASE CompanyDB;
USE CompanyDB;

CREATE TABLE Departments (
    DeptID INT AUTO_INCREMENT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
    EmpID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE,
    Email VARCHAR(100) UNIQUE NOT NULL,
    IsManager BOOLEAN NOT NULL DEFAULT FALSE,
    Salary DECIMAL(10, 2) NOT NULL CHECK (Salary > 0),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Budget DECIMAL(15, 2) CHECK (Budget > 1000),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
show tables;
--  Insert Data into Departments
INSERT INTO Departments (DeptName, Location)
VALUES 
('HR', 'New York'), 
('IT', 'San Francisco'), 
('Finance', 'Chicago'),
('Marketing', 'Los Angeles'), 
('Sales', 'New York'),
('R&D', 'San Francisco');
select * from Departments;
-- Insert Data into Employees
INSERT INTO Employees (FirstName, LastName, DOB, Email, IsManager, Salary, DeptID)
VALUES 
('John', 'Doe', '1988-07-10', 'john.doe@email.com', TRUE, 80000, 2),
('Alice', 'Brown', '1992-03-15', 'alice.brown@email.com', FALSE, 55000, 1),
('Sam', 'Wilson', '1980-12-23', 'sam.wilson@email.com', FALSE, 40000, 3),
('Michael', 'Scott', '1964-03-15', 'michael.scott@email.com', TRUE, 95000, 5),
('Pam', 'Beesly', '1980-03-25', 'pam.beesly@email.com', FALSE, 45000, 1),
('Dwight', 'Schrute', '1976-01-20', 'dwight.schrute@email.com', TRUE, 75000, 5),
('Jim', 'Halpert', '1978-10-01', 'jim.halpert@email.com', FALSE, 65000, 5),
('Stanley', 'Hudson', '1958-04-23', 'stanley.hudson@email.com', FALSE, 60000, 5),
('Phyllis', 'Vance', '1962-07-14', 'phyllis.vance@email.com', FALSE, 58000, 5),
('Kelly', 'Kapoor', '1982-11-13', 'kelly.kapoor@email.com', FALSE, 52000, 4),
('Ryan', 'Howard', '1984-05-05', 'ryan.howard@email.com', FALSE, 50000, 4),
('Oscar', 'Martinez', '1975-11-16', 'oscar.martinez@email.com', FALSE, 70000, 3),
('Angela', 'Martin', '1972-06-11', 'angela.martin@email.com', FALSE, 68000, 1),
('Creed', 'Bratton', '1943-02-08', 'creed.bratton@email.com', FALSE, 40000, 2);

select * from Employees;
-- Insert Data into Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate, Budget, DeptID)
VALUES 
('Project Alpha', '2023-01-10', '2023-06-30', 50000, 2),
('Project Beta', '2023-03-15', NULL, 20000, 1),
('Project Gamma', '2022-01-15', '2022-12-31', 75000, 5),
('Project Delta', '2023-05-01', NULL, 45000, 4),
('Project Epsilon', '2022-09-20', '2023-03-15', 90000, 3),
('Project Zeta', '2023-01-01', '2023-09-30', 30000, 1);

select * from projects;

-- Retrieve the details of all employees whose first name starts with 'J' and who work in the IT department.
SELECT E.FirstName, E.LastName, D.DeptName 
FROM Employees E 
JOIN Departments D ON E.DeptID = D.DeptID
WHERE E.FirstName LIKE 'J%' AND D.DeptName = 'IT';

select * from Employees
where DeptID =2;
select * from Departments;
select * from Employees
where FirstName LIKE 'J%' and  DeptID =2;

-- List all employees along with their department names, sorted by their salary in descending order.
SELECT E.FirstName, E.LastName, D.DeptName, E.Salary
FROM Employees E
JOIN Departments D ON E.DeptID = D.DeptID
ORDER BY E.Salary DESC;

select * from Employees
order by Salary DESC;
select * from projects;
-- Retrieve the total budget allocated for each department but only include departments where the total budget exceeds 20,000.
SELECT D.DeptName, SUM(P.Budget) AS TotalBudget
FROM Projects P
JOIN Departments D using (DeptID)
GROUP BY D.DeptName
HAVING SUM(P.Budget) > 20000
order by TotalBudget DESC;
 
 select DeptID, sum(Budget) as TotalBudget
 from projects
 group by DeptID
 having TotalBudget>20000
 order by TotalBudget DESC;

-- Find the average salary of employees working in the Finance department.
SELECT round(AVG(E.Salary),2) AS AvgSalary
FROM Employees E
JOIN Departments D ON E.DeptID = D.DeptID
WHERE D.DeptName = 'Finance';

select round(avg(salary),2) as 'Avg_sal_finance(Rs)' from Employees
where DeptID =3 ;

-- Retrieve the details of the top 2 highest-paid employees.
SELECT FirstName, LastName, Salary
FROM Employees
ORDER BY Salary DESC
LIMIT 2;

-- Retrieve all projects that either have no end date (EndDate is NULL) or have a budget greater than 30,000.
SELECT ProjectName, Budget, EndDate
FROM Projects
WHERE EndDate IS NULL OR Budget > 30000;
select * from employees;
-- Display the first name of each employee and whether they are a manager or not, using an IF statement.
SELECT FirstName, IF(IsManager = TRUE, 'Manager', 'Staff') AS Role
FROM Employees;

/*
Classify employees based on their salary:

High Salary if more than 70,000.
Medium Salary if between 50,000 and 70,000.
Low Salary otherwise. */
show tables;
select * from Employees;
SELECT FirstName, LastName,salary,
CASE 
  WHEN Salary > 70000 THEN 'High Salary'
  WHEN Salary BETWEEN 50000 AND 70000 THEN 'Medium Salary'
  ELSE 'Low Salary'
END AS SalaryCategory
FROM Employees
order by Salary desc;

-- Delete all employees who earn less than 40,000 from the Employees table.
DELETE FROM Employees
WHERE Salary < 40000;
select * from employees;
-- Update John Doe’s department to sales.
UPDATE Employees
SET DeptID = (SELECT DeptID FROM Departments WHERE DeptName = 'sales')
WHERE FirstName = 'John' AND LastName = 'Doe';

-- ASSIGNMENT 2
-- Display the first name, last name, and department name for each employee
-- Retrieve the names of employees and the projects they are associated with, including the department name. Show all employees, even if they are not assigned to any project
-- Retrieve the total salary of all employees for each department. Use GROUP BY to group by department and include departments with no employees
-- Retrieve departments that have more than 3 employees, along with the number of employees in each department.
-- Retrieve the employees whose salary is greater than the average salary of their respective department.
-- Retrieve the total budget allocated to each department by summing the budgets of all projects in that department.
-- Display the first name, last name, and salary of the highest-paid employee in each department.
-- Retrieve the names of employees who are working in departments where there is a project with a budget greater than 50,000.
-- Display each department along with the count of projects associated with it. Use GROUP BY to group by department name.
-- Retrieve the names of departments that do not have any projects assigned. Hint: Use LEFT JOIN to include all departments.
-- Display the names of employees who are managers (IsManager = TRUE) along with their department names.
-- Retrieve the average budget of all projects grouped by department. Only show departments where the average budget exceeds 40,000.
-- Retrieve each department's total salary expense for its employees and the total project budget allocated to that department.
-- Display each project, its department name, and the total number of employees in that department.
-- Display employees who are not part of any department that has an active project. Use a LEFT JOIN and filter for null values in the project table.

-- Assignment3
-- string functions (UPPER, LOWER, CONCAT, SUBSTRING, REPLACE, LENGTH, TRIM, LIKE, etc.) 
-- 1.Display project names after removing the leading 'P' from those that start with the letter 'P' using SUBSTRING() and IF().
-- 2.Retrieve the names of employees whose email address contains a specific domain, e.g., 'email.com', using the LIKE operator.
-- 3.Display the first three characters of each department's name using the SUBSTRING() function.
-- 4.Modify the project names by replacing the word 'Project' with 'Task' using the REPLACE() function.
-- 5.Retrieve the names of employees whose first name has more than 5 characters using the LENGTH() function.
-- 6.Display project names padded with spaces on the right side to ensure a total length of 20 characters using the RPAD() function.
-- 7. Retrieve the names of employees whose last name contains the string 'son' using the LIKE operator.
-- 8.Display the domain part of each employee's email address (the part after '@') using the SUBSTRING() and LOCATE() functions.
-- 9.Replace the letter 'e' with the letter 'a' in each employee's last name using the REPLACE() function.
-- 10.Display department names after removing any leading and trailing spaces using the TRIM() function.
-- 11.Find the number of characters in each employee's first name using the LENGTH() function.
-- 12.Display the full names of all employees by concatenating their first and last names using the CONCAT() function.
-- 13. Show the last names of all employees in lowercase using the LOWER() function.
-- 14.Display the first names of all employees in uppercase using the UPPER() function.
 
# Assignment 5 (On date functions) use CompanyDB
-- Retrieve the current date using the CURDATE() function.
-- Retrieve the first name, last name, and hire date of employees who joined the company in the current year using the YEAR() and CURDATE() functions.
-- Display the first name, last name, and age of each employee based on their date of birth using the TIMESTAMPDIFF() function.
-- Retrieve the first name, last name, and birth date of employees who joined the company after '1980-01-01'.
-- Retrieve the project names and their start dates for projects that started in the last 2 years using the DATE_SUB() and CURDATE() functions.
-- Retrieve the first name, last name, and date of birth of employees who were born in March (month 3) using the MONTH() function.
-- Retrieve the names and start dates of projects that were initiated in the current year using the YEAR() function.

SELECT ProjectName, StartDate
FROM Projects
WHERE StartDate >= DATE_SUB(CURDATE(), INTERVAL 2 year);
select * from projects;
SELECT FirstName, LastName, DOB
FROM Employees
WHERE DOB > '1980-01-01';


show tables;

desc departments;
desc employees;
desc projects;

-- Retrieve each department's total salary expense for its employees and the total project budget allocated to that department.

select Deptname,sum(Salary) as total_sal_exp, sum(Budget)
from departments d
join employees e using (DeptID)
join projects p
using (DeptID)
group by 1;

SELECT d.DeptName, SUM(e.Salary) AS Total_Salary_Expense, SUM(p.Budget) AS Total_Project_Budget
FROM Departments d
JOIN Employees e ON d.DeptID = e.DeptID
JOIN Projects p ON d.DeptID = p.DeptID
GROUP BY d.DeptName;

use CompanyDB;
CREATE TABLE Employees1 LIKE Employees; # same structure
/*CREATE TABLE Employees_Copy AS
SELECT * FROM Employees;*/
show tables;
desc employees1;
select * from employees;
alter table Employees1 add column managerid int;

INSERT INTO Employees1 (FirstName, LastName, DOB, Email, IsManager, Salary, DeptID,managerid)
VALUES 
('John', 'Doe', '1988-07-10', 'john.doe@email.com', TRUE, 80000, 2,4),
('Alice', 'Brown', '1992-03-15', 'alice.brown@email.com', FALSE, 55000, 1,7),
('Sam', 'Wilson', '1980-12-23', 'sam.wilson@email.com', FALSE, 40000, 3,4),
('Michael', 'Scott', '1964-03-15', 'michael.scott@email.com', TRUE, 95000, 5,6),
('Pam', 'Beesly', '1980-03-25', 'pam.beesly@email.com', FALSE, 45000, 1,4),
('Dwight', 'Schrute', '1976-01-20', 'dwight.schrute@email.com', TRUE, 75000, 5,6),
('Jim', 'Halpert', '1978-10-01', 'jim.halpert@email.com', FALSE, 65000, 5,7),
('Stanley', 'Hudson', '1958-04-23', 'stanley.hudson@email.com', FALSE, 60000, 5,1),
('Phyllis', 'Vance', '1962-07-14', 'phyllis.vance@email.com', FALSE, 58000, 5,3),
('Kelly', 'Kapoor', '1982-11-13', 'kelly.kapoor@email.com', FALSE, 52000, 4,1),
('Ryan', 'Howard', '1984-05-05', 'ryan.howard@email.com', FALSE, 50000, 4,7),
('Oscar', 'Martinez', '1975-11-16', 'oscar.martinez@email.com', FALSE, 70000, 3,6),
('Angela', 'Martin', '1972-06-11', 'angela.martin@email.com', FALSE, 68000, 1,1),
('Creed', 'Bratton', '1943-02-08', 'creed.bratton@email.com', FALSE, 40000, 2,null);


select * from employees1;
-- display EmpID ,Full name, manager name,deptID

select e.EmpID,e.FirstName,
e.DeptID,m.FirstName Manager_name
from employees1 e
join employees1 m
on e.managerid = m.EmpID;

-- Find employees who report to the same manager
SELECT E1.FirstName AS Employee, E2.FirstName AS Colleague, E3.FirstName As ManagerName
FROM Employees1 E1
JOIN Employees1 E2 
join Employees1 E3
ON E1.managerid = E2.managerid
and E1.managerid = E3.EmpID
WHERE E1.EmpID != E2.EmpID;

-- List employees and their managers
SELECT E1.FirstName AS EmployeeFirstName, E1.LastName AS EmployeeLastName, 
       E2.FirstName AS ManagerFirstName, E2.LastName AS ManagerLastName
FROM Employees1 E1
left JOIN Employees1 E2 ON E1.managerid = E2.EmpID;

desc employees1;
-- Assignment4
-- 1. Retrieve the names of employees who earn a higher salary than their respective manager using a self-join.
-- 2.Retrieve the names of employees who were born on the same date using a self-join.
-- 3.Retrieve the first name, last name, and salary of employees who share the same salary using a self-join.
SELECT E1.FirstName AS Employee, E1.LastName AS EmployeeLastName, E1.Salary AS EmployeeSalary,
       E2.FirstName AS Manager, E2.LastName AS ManagerLastName, E2.Salary AS ManagerSalary
FROM Employees1 E1
JOIN Employees1 E2 ON E1.managerid = E2.EmpID
WHERE E1.Salary > E2.Salary;

SELECT E1.FirstName AS Employee1, E1.LastName AS Employee1LastName,
       E2.FirstName AS Employee2, E2.LastName AS Employee2LastName, E1.HireDate
FROM Employees1 E1
JOIN Employees1 E2 ON E1.DOB = E2.DOB
WHERE E1.EmpID != E2.EmpID;





