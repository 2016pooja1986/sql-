use google;

show tables;
desc product;
desc employee;
-- Display the details about employee having highest salary  Within Each Department

with dept_highest_paid_emp as (select * ,
rank() over(partition by DEPT_NAME order by salary desc) as ranking
from employee)

select DEPT_NAME,emp_NAME, SALARY from dept_highest_paid_emp
where ranking=1;



select * from employee;
select * from product;
select * from sales;


create database Creed;
use creed;
drop table employee;
create table employee (
emp_ID int primary key
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee 
values
(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh',  'Finance', 5000),
(107, 'Preet', 'HR', 7000),
(108, 'Maryam', 'Admin', 4000),
(109, 'Sanjay', 'IT', 6500),
(110, 'Vasudha', 'IT', 7000),
(111, 'Melinda', 'IT', 8000),
(112, 'Komal', 'IT', 10000),
(113, 'Gautham', 'Admin', 2000),
(114, 'Manisha', 'HR', 3000),
(115, 'Chandni', 'IT', 4500),
(116, 'Satya', 'Finance', 6500),
(117, 'Adarsh', 'HR', 3500),
(118, 'Tejaswi', 'Finance', 5500),
(119, 'Cory', 'HR', 8000),
(120, 'Monica', 'Admin', 5000),
(121, 'Rosalin', 'IT', 6000),
(122, 'Ibrahim', 'IT', 8000),
(123, 'Vikram', 'IT', 8000),
(124, 'Dheeraj', 'IT', 11000);

 CREATE TABLE sales(
    emp_ID INT NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    FOREIGN KEY(emp_ID) REFERENCES employee(emp_ID)
);

 show tables;
 
 INSERT INTO sales
VALUES(103,2016,100),
      (104,2017,150),
      (110,2018,200),
      (113,2016,150),
      (103,2017,100),
      (104,2018,200),
       (110,2016,200),
      (104,2017,150),
      (105,2018,250);  


-- Create a CTE to display total sales and average salary for each employee.
desc employee;
desc sales;


with total_sales as (
select distinct emp_ID,emp_NAME,DEPT_NAME,SALARY,
sum(sale) over(partition by emp_ID) Total_Sale from sales
join employee 
using (emp_ID)
),

Avg_salary as (
select distinct emp_ID,emp_NAME,DEPT_NAME,SALARY,
avg(salary) over(partition by DEPT_NAME) Avg_sal from employee
)

select a.*,Total_sale
from total_sales t
join 
Avg_salary a
using (emp_ID) 
order by emp_name;

select * from Avg_salary;
