use comp;
show tables;
-- % (zero or more occurance of character) and _ (single character)

-- retrieve all the name of customers having 'o' in their names
select concat(first_name," ",last_name) Full_Name ,country
from customers
where concat(first_name," ",last_name) like '%o%';

-- retrieve all the name of customers end with 'n'
select concat(first_name," ",last_name) Full_Name ,country
from customers
where concat(first_name," ",last_name) like '%n';

-- retrieve all country name start with 'U' 
select * from customers;
update customers set country = 'UAE'
where id=9;

select * from customers
where country not like 'U%';

-- retrieve all country name start with 'U' and end with 'K'
select * from customers
where country like 'U%K';
-- retrieve all country name start with 'U' and end with 'K' or 'A'
select * from customers
where country like 'U%' and (country like '%K' or country like '%A');


-- create table sid -primary key, autoincrement, name,age,pass(boolean)

create table student
(
s_id int primary key auto_increment,
s_name varchar(30) not null,
age int,
pass boolean
)auto_increment=101;

desc student;

insert into student 
(s_name,age,pass)
values
('pooja',20,true),
('munna',19,false),
('dimple',20,true),
('manav',18,false),
('Mr x',17,false);

insert into student 
(s_name,pass)
values
('poorvi',true),
('ravi',false),
('nancy',true);

select * from student
where pass = TRUE;

select * from student
where pass is TRUE;

select * from student
where pass = 1;

select * from student
where pass = FALSE;

select * from student
where pass is FALSE;

select s_id,s_name,age,
if(pass = 1,'pass','fail') result
from student;

select * from student
where age is null;


update student set age= 19
where age is null;


select * from student
where age is not null;

select s_id,s_name,age,
if(pass = 1,'pass','fail') result
from student;

select s_id, s_name, age,
case
when pass=1 then 'pass'
else 'fail'
end result
from student;

set @varname =1000;

CREATE TABLE student_contacts (  
  studentid int primary key AUTO_INCREMENT,  
  contactname varchar(45) NOT NULL,  
  cellphone varchar(20) DEFAULT NULL,  
  homephone varchar(20) DEFAULT NULL
  );  
-- Insert the rows in the table
-- apply nullif and ifnull

  SELECT   
    contactname, IFNULL(cellphone, homephone) phone  
FROM  
    student_contact;  
   
# type casting 
select cast('2007-10-12' as date);
select convert('2007-10-12' , date);

show tables;
desc customers;

CREATE TABLE shirts (  
    id INT PRIMARY KEY AUTO_INCREMENT,   
    name VARCHAR(35),   
    size ENUM('small', 'medium', 'large', 'x-large')  
);  

INSERT INTO shirts(id, name, size)   
VALUES (1,'t-shirt', 'medium'),   
(2, 'casual-shirt', 3),   
(3, 'formal-shirt', 4),   
(4, 'polo-shirt', 'small');  


INSERT INTO shirts(id, name, size)   
VALUES (5,'t-shirt', 'small'),   
(6, 'casual-shirt', 1);
select * from shirts;


