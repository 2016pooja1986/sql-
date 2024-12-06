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
(4,'tanzeel',1234561234,35000);

insert into teacher
(id,phn_no,salary)
values
(5,1234561234,35000);




-- DQL: select

select * from teacher;

