use companydb;
show tables;
select * from employees;
select * from departments;

select row_number() over(partition by IsManager order by Salary desc) as 'row',
EmpID,concat_ws(FirstName,LastName," ") FullName,DeptName,Email,Salary
from employees e
join departments
using (DeptID)
where salary >50000;

-- -- department wise- employee details having highest salary

select x.DeptID,x.EmpID,concat_ws(x.FirstName,x.LastName,' ') Full_Name,x.Salary Highest_salary from
(select row_number() over(partition by DeptID order by Salary desc) as row_no
,e.*
from employees e) x
where x.row_no=1;




-- department wise- employee details having lowest salary


select row_number() over(partition by DeptID order by Salary desc) as row_no
,e.*
from employees e;






desc employees;
INSERT INTO Employees (FirstName, LastName, DOB, Email, IsManager, Salary, DeptID)
VALUES 
('John', 'wills', '1988-07-10', 'john.wills@email.com', TRUE, 80000, 2),
('Lily', 'Evans', '1990-05-25', 'lily.evans@email.com', FALSE, 82000, 2),
('Mike', 'Wilson', '1985-11-23', 'mike.wilson@email.com', FALSE, 90000, 1),
('Sara', 'Lee', '1992-01-15', 'sara.lee@email.com', FALSE, 85000, 1),
('Tom', 'Brown', '1989-09-03', 'tom.brown@email.com', FALSE, 75000, 3),
('pooja', 'wills', '1988-07-10', 'pooja.wills@email.com', TRUE, 82000, 2),
('vivek', 'Evans', '1990-05-25', 'vivek.evans@email.com', FALSE, 84000, 2);

SELECT EmpID, FirstName, LastName, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS CompanyWideRank,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS CompanyWideDenseRank,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS CompanyWideRowNumber
FROM Employees;


SELECT row_number() over(partition by DeptID order by Salary desc) as row_no,
DeptID, EmpID, FirstName, LastName, Salary
FROM Employees;

SELECT RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SalaryRank,
DeptID, EmpID, FirstName, LastName, Salary
FROM Employees;
       
SELECT dense_rank() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SalaryRank,
DeptID, EmpID, FirstName, LastName, Salary
FROM Employees;

SELECT 
row_number() over(partition by DeptID order by Salary desc) as row_no,
RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SalaryRank,
dense_rank() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SalarydRank,
DeptID, EmpID, FirstName, LastName, Salary
FROM Employees;

-- departmentwise total salary
select DeptID,sum(Salary) from employees
group by DeptID;

select * from departments;
select DeptID,DeptName,FirstName,LastName,Salary,
sum(Salary) over(partition by DeptID) Total_Salary
from employees
join departments
using (DeptID);

select x.DeptID,x.DeptName,x.FirstName,x.LastName,
round((x.Salary/x.Total_salary)*100,2) 'Salary(%)'
from 
(select DeptID,DeptName,FirstName,LastName,Salary,
sum(Salary) over(partition by DeptID) Total_Salary
from employees
join departments
using (DeptID)) x;




select DeptID,DeptName,FirstName,LastName,Salary,
min(Salary) over(partition by DeptID) Min_Salary
from employees
join departments
using (DeptID);

select x.* from
(select DeptID,DeptName,FirstName,LastName,Salary,
min(Salary) over(partition by DeptID) Min_Salary
from employees
join departments
using (DeptID)) x
where salary = min_salary;

select  DeptID,FirstName,LastName,Salary from employees e
where salary =
(select min(Salary) from employees where DeptID = e.DeptID)
order by DeptID;

select DeptID,DeptName,FirstName,LastName,Salary,
max(Salary) over(partition by DeptID) Max_Salary
from employees
join departments
using (DeptID);

select DeptID,DeptName,FirstName,LastName,Salary,
count(Firstname) over(partition by DeptID) No_of_employees
from employees
join departments
using (DeptID);

select DeptID,FirstName,LastName,Salary,
round(avg(Salary) over(partition by DeptID order by FirstName)) Avg_Salary
from employees;






select x.*, round((x.Total_sal/(select sum(e.salary) from employees e))*100) 'Sal(%)'
from
(select deptID,
sum(Salary) Total_sal
from employees
group by DeptID) x;


-- lead(), lag(), first_value and last_value() window functions


show tables;
select * from employees;

select *,
lag(salary,1,0) over(partition by DeptID order by SALARY) prev_emp_sal
from employees;

select *,
salary-lag(salary,1,0) over(partition by DeptID order by SALARY) prev_emp_sal_diff
from employees;


select *,
lead(salary,1,0) over(partition by DeptID order by SALARY) next_emp_sal
from employees;

select *,
lead(FirstName,1,"Unnamed") over(partition by DeptID order by SALARY) next_emp_name
from employees;

select *,
salary- lead(salary) over(partition by DeptID order by SALARY desc) diff_in_next_sal
from employees;

select *,
lead(salary,2,0) over(partition by DeptID order by SALARY) "2nd_next_emp_sal"
from employees;


select e.*,
lead(salary) over(partition by DeptID order by EmpID) as next_emp_sal,
case
when e.salary > lead(salary) over(partition by DeptID order by EmpID) then 'Higher than next employee'
     when e.salary < lead(salary) over(partition by DeptID order by EmpID) then 'Lower than next employee'
	 when e.salary = lead(salary) over(partition by DeptID order by EmpID) then 'Same than next employee' 
     end as sal_range
     from employees e;

desc employees;
select *,
first_value(FirstName) over(partition by DeptID order by salary desc) as highest_paid_employee
from employees;

select *,
first_value(FirstName) over(partition by DeptID order by salary ) as least_paid_employee
from employees;

select *,
last_value(FirstName) 
over(partition by DeptID order by salary range between unbounded preceding and unbounded following) as highest_paid_employee
from employees;

select *,
last_value(FirstName) 
over(partition by DeptID order by salary desc range between unbounded preceding and unbounded following) as least_paid_employee
from employees;
