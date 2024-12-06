use comp;
select *, char_length(first_name) as len from customers;
select *, character_length(first_name) as len from customers;
select *, length(first_name) as len from customers;

select concat_ws("-",first_name,last_name) Full_name 
from customers;

select find_in_set('Pooja',first_name) from customers;

select locate('h','john');
select position('h' in 'john');
select format(23.6778899,2) as output;
select round(23.6778899,2) as output;

SELECT INSERT("W3Schools.com", 1, 7, "Example");

update customers set age=45.65678798
where age >30;

select * from customers;
select *,insert(country,1,2,"china") from customers
where country='UK';

select ucase(first_name),lcase(first_name) from customers;
select upper(first_name),lower(first_name) from customers;

select left(first_name,2) from customers;
select right(first_name,2) from customers;

select lpad(first_name,10," ") from customers;
select rpad(first_name,10,"madam") from customers;
desc customers;
update customers set first_name = "  john  "
where first_name = 'john';

select * from customers
where trim(first_name)='john';
select * from customers
where rtrim(first_name)='john';

SELECT REPEAT("Nancy", 3);



SELECT MID("SQL Tutorial", 5,5) AS ExtractString;
select substr("SQL Tutorial", 5,5) AS ExtractString;
select substring("SQL Tutorial", 5,5) AS ExtractString;

select replace(first_name,'o',"O") from customers;
update customers set first_name = replace(first_name,'o',"O");
update customers set first_name = trim(first_name);
select * from customers;
SELECT REVERSE("SQL Tutorial");
SELECT if(STRCMP("SQL Tutorial", "SQL Tutorial"),'not matched','mathched');

SELECT SUBSTRING_INDEX("www.w3schools.com", ".", 2);

