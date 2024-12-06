use tgc_db;

show tables;
select * from teacher;

truncate table teacher;

desc teacher;
select * from teacher;


alter table teacher drop column course;
alter table teacher add column course_id int not null;
desc course;
alter table teacher add constraint foreign key(course_id) references course(cid);

select * from course;

insert into teacher values
(1,'pooja',1234567890,35000,1001),
(2,'twinkle',1234567890,35000,1002),
(3,'Mohit',1234567890,30000,1001),
(4,'Rohit',1234567890,35000,1002),
(5,'sujit',1234567890,35000,1002),
(6,'kabir',1234567890,35000,1001);

desc student;
insert into student 
values
(101,'tanisha',1),
(102,'Dimple',3),
(103,'Ravi',4),
(104,'Munna',5);


select * from teacher;

update teacher set salary = 40000 where id in (2,4);

-- course id,trainer name salary between 30000 to 37000
-- between includes both values

select course_id,t_name  Trainer_Name ,salary
from teacher
where salary between 30000 and 35000;

select course_id,t_name  Trainer_Name ,salary
from teacher
where salary>= 30000 and salary <=35000;

use comp;
show tables;
select * from customers;
-- retrive the firstname and lastname as full name from customers table

select concat(first_name," ",last_name) Full_Name,country
from customers;
-- retrive the product name whose total sale is greater and equal to 500 from orders table
select product, total
from orders
where total >=500;

select distinct product 
from orders 
order by product desc;

-- retrive all entries except product is paper
select * from orders
where product <> 'Paper';

select * from orders
where not product = 'Paper';

-- retrive all distinct country name from customers table
-- sorting the table in ascending order on total column
select * from orders
order by total , product desc;
-- retrieve the distinct firstname from the customer table
-- retrieve all the customers name whose age is between 23 to 35 
-- retrieve top 3 high saleing product
select * from orders
order by total desc
limit 3;

-- 3rd highest saling product details
select * from orders
order by total desc
limit 1 offset 2;

select * from orders
order by total desc
limit 3,3;

-- Retrieve all entries from student1
-- Retrieve name and class from student1
-- Retrieve name and class from student1
-- Retrieve distinct name  from student1
-- Retrieve only 5 rows entry.
-- Retrieve rows from 4 to 8
-- Sort the table by class in desc order.
-- Sort the table by age(ascending) and class(descending)
-- Retrieve the data for class 12
-- Retrieve the data for id more than 5 and less than 9


