use companydb;

show tables;

select * from employees;

create view Managerdetails as 
select * from employees
where IsManager is True;

-- Syntax to display all created views in particular database
SELECT TABLE_NAME
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'companydb';

SELECT *
FROM information_schema.VIEWS;

select * from managerdetails;

desc departments;
create view Lead_Lag_sal as 
select EmpID, concat_ws(' ',FirstName,LastName) FullName,DeptName,Salary,
lag(salary,1,0) over(order by Salary) 'Prev_emp_sal',
lead(Salary,1,0) over(order by Salary) 'next_emp_sal'
from employees 
join departments 
using (DeptID);

drop view Lead_lag_sal;
show tables;

desc lead_lag_sal;

select * from lead_lag_sal;
-- update and delete query is not valid on view
