/*
NTH_VALUE, NTILE, and CUME_DIST in SQL:
NTH_VALUE: Retrieves the N-th value from a window of ordered rows within a partition.
NTILE: Divides rows in a result set into a specified number of approximately equal-sized groups.
CUME_DIST: Calculates the cumulative distribution (rank as a fraction of the total) of a row in a partition.
*/


use companyDB;
show tables;
desc employees;

select *,
NTH_VALUE(FirstName, 4) OVER (PARTITION BY DeptID ORDER BY Salary) '3rd_employee'
from employees;

-- Get the 2nd highest salary in each department.
select x.* from
(
SELECT DeptID, EmpID, FirstName, LastName, Salary,
       NTH_VALUE(Salary, 2) OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SecondHighestSalary
FROM Employees) x
where salary = SecondHighestSalary;
-- Identify the 5th highest salary in the entire company.

select x.* from
(
SELECT DeptID, EmpID, FirstName, LastName, Salary,
       NTH_VALUE(Salary, 5) OVER (ORDER BY Salary DESC) AS SecondHighestSalary
FROM Employees) x
where salary = SecondHighestSalary;

SELECT DeptID, EmpID, FirstName, LastName, Salary,
       NTH_VALUE(Salary, 5) OVER (ORDER BY Salary DESC) AS SecondHighestSalary
FROM Employees;


-- NTILE(number_of_buckets) OVER (PARTITION BY column_name ORDER BY column_name)
SELECT DeptID, EmpID, FirstName, LastName, Salary,
       NTILE(3) OVER (ORDER BY Salary DESC) AS SecondHighestSalary
FROM Employees;

select count(*) from employees;
-- Divide employees into 4 salary quartiles within each department.

select DeptID, EmpID, FirstName, LastName, Salary,
ntile(4) over (partition by DeptID order by Salary desc) 'group'
from employees;


-- Split employees into 3 groups by salary within their respective departments and create column to display category of salary distribution high,low and medium.


SELECT DeptID, EmpID, FirstName, LastName, Salary,
       CUME_DIST() OVER (PARTITION BY DeptID ORDER BY Salary DESC)*100 AS 'CumulativeDistribution (%)',
       Sum(Salary) OVER (PARTITION BY DeptID ) as total_sal
FROM Employees;

