create database book_store;
use book_store;

create table category(
id int primary key,
C_name varchar(20));

alter table category modify column C_name varchar(20) Not null;
desc category;

create table Authors(
id int primary key,
A_name varchar(20));

alter table Authors modify column A_name varchar(20) not null;

create table Books(
id int auto_increment primary key,
b_name varchar(20) not null,
price int ,
Cat_id int,
Aut_id int,
foreign key(Cat_id) references category(id),
foreign key(Aut_id) references Authors(id)
) auto_increment=100;

ALTER TABLE table_name 
MODIFY column_name INT AUTO_INCREMENT, 
AUTO_INCREMENT = 100;


INSERT INTO category 
VALUES (1, 'Cat-A'),
(2, 'Cat-B'),
(3, 'Cat-C'),
(7, 'Cat-D'),
(8, 'Cat-E'),
(4, 'Cat-F'),
(10,'Cat-G'),
(12,'Cat-H'),
(6, 'Cat-I');

INSERT INTO Authors
VALUES (1, 'Author-A'),
(2, 'Author-B'),
(3, 'Author-C'),
(10, 'Author-D'),
(12, 'Author-E');
desc Books;
INSERT INTO Books 
(b_name,price,Cat_id,Aut_id)
VALUES ( 'Book-A', 100, 1, 2),
( 'Book-B', 200, 2, 2),
( 'Book-C', 150, 3, 2),
( 'Book-D', 100, 3,1),
( 'Book-E', 200, 3,1),
( 'Book-F', 150, 4,1),
( 'Book-G', 100, 7,10),
( 'Book-H', 200, 8,12),
('Book-I', 150, 7,3);

show tables;
select * from books;
desc authors;
desc books;
desc category;

-- id, book name, author name, price 

select b.id,b_name,A_name, price
from books b
join authors a
on b.Aut_id = a.id;

select b.id,b.b_name,a.A_name, b.price
from books b, authors a
where b.Aut_id = a.id;

-- id, book name, author name,cat_name price 

select b.id,b_name,A_name,C_name, price
from books b
join authors a
join category c
on b.Aut_id = a.id
and b.Cat_id = c.Cat_id;

select b.id,b_name,A_name,C_name, price
from books b,authors a,category c
where b.Aut_id = a.id
and b.Cat_id = c.Cat_id;

select * from category;
select * from books;

select b.id,b_name,C_name, price
from books b
right join category c
on b.Cat_id = c.Cat_id;

select b.id,b_name,C_name, price
from category c
left join books b
on b.Cat_id = c.Cat_id;

select b.id,b_name,C_name, price
from category c
join books b
using (Cat_id);


-- Author wise Author_id,author_name,no of books where no of book>1

select b.Aut_id,a.A_name,count(*) No_of_books 
from books b
join authors a
on b.Aut_id = a.id
group by 1
having No_of_books>1;

select b.Aut_id,a.A_name,count(*) No_of_books 
from books b, authors a
where b.Aut_id = a.id
group by 1
having No_of_books>1;

-- Author wise no of books(Author_id,author_name,no of books)
-- Retrieve Category id wise no of books  
-- Category id wise total earning from the books..
-- what is author_id wise ,the min and max priceof the book
-- display book name, category name and price for book id =103;
-- retrive all the rows where book name ends with "Vowels"
-- display author wise : author_name, no of books, min price of book whose min price of book >150

