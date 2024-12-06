-- DDL: Create,drop,alter and truncate

drop database tgc_db;
show databases;
create database tgc_db;
show databases;
select database();
use tgc_db;

create table trainer(
t_id int primary key,
t_name varchar(20) not null,
course varchar(30) default 'python',
phn_no int check(length(phn_no)=10),
address varchar(50) 
);



show tables;
desc trainer;
drop table trainer;

-- renaming of column
alter table trainer rename column t_id to id;

describe trainer;
-- renaming of table
alter table trainer rename to teacher;
desc teacher;

alter table teacher modify column course varchar(30) default 'sql';

-- add column 
alter table teacher add column salary int;
desc teacher;

-- drop column
alter table teacher drop column address;
desc teacher;


alter table teacher modify column salary int not null;


-- DML : insert, update, delete

insert into teacher
values
(1,'pooja','python',1234561234,35000),
(2,'twinkle','admin',1234567890,45000);

insert into teacher
(id,t_name,phn_no,salary)
values
(3,'tanzeel',1234561234,35000);

insert into teacher
(id,phn_no,salary)
values
(4,1234561234,35000);







-- DQL: select

select * from teacher;

truncate table teacher;
update teacher set course = 'python' where id =2;

delete from teacher where id=3;

desc teacher;

create table student(
s_id int primary key,
sname varchar(20) not null,
tid int,
foreign key(tid) references teacher(id)
);

select * from teacher;

insert into student values
(101,'Tanisha',1);

select * from student;


create table course(
cid int primary key auto_increment,
c_name varchar(20) unique,
sub_name varchar(30) not null,
fees int 
)auto_increment=1001;

desc course;

insert into course 
(c_name,sub_name,fees) values
('DS','python,sql,ml',42000),
('DA','python,sql,powerbi',46000);

select * from course;

update course set fees = 30000;

select * from teacher;

select t_name, course from teacher;

select * from teacher where id = 1;
insert into teacher
values
(3,'sanjay','ML',1234561234,35000),
(4,'mohit','html',1234567890,45000),
(5,'rohit','React',1234561234,35000),
(6,'bhupinder','video editing',1234567890,45000);

select * from teacher;

select * from teacher where course='python' and salary>35000;



select * from teacher where salary=35000;


select * from teacher where course='python' or course='html';

select * from teacher where course in ('python','html');

