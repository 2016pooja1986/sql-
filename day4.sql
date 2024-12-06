select database();
use comp;
show tables;
select * from customers;
select * from orders;
select * from student1;

-- Aggregate function

-- max
select max(total) 'max sale' from orders;

-- min
select min(total) min_sale from orders;

-- avg
select round(avg(total),2) avg_sale from orders;

-- sum
select sum(total) total_sale from orders;

-- count
select count(*) No_of_entries from orders;

select count(*) No_of_entries,sum(total) total_sale ,
round(avg(total),2) avg_sale,max(total) 'max sale',
min(total) min_sale from orders;

-- enlist all the products name with min sale
select * from orders;
select distinct product,total as sale 
from orders
where total = (select min(total) from orders)
order by product;

-- enlist all the products name with max sale
-- enlist all the product details whose sale is more than avg  sale

select * from orders
where total>(select avg(total) from orders)
order by total desc, product;

select sum(total) Sale_by_books from orders
where product in ( 'Markers', 'Pens');

-- group by

-- product wise sale

select product,sum(total) as sale 
from orders
group by product
order by sum(total) desc;

select product,min(total) as min_sale 
from orders
group by product
order by min(total) desc;


select product,sum(total) as sale 
from orders
group by product
having sum(total) > avg(total)
order by sum(total) desc;

select product,sum(total) as sale 
from orders
group by 1
having sum(total) > avg(total)
order by sum(total) desc;

select * from student1;
update student1 set class = 5 where id=2;

select age,class,count(*) as No_of_students
from student1
group by 1,2
order by No_of_students desc;


-- QUESTIONS
-- classwise no of student
-- agewise no of student
-- find the min age  of student in each class
-- find tne max age of student in each class
-- find avg age of student in each class
-- customer wise total purchase and display only those customer's detail whose purchase > 1000
-- country wise No of customers


