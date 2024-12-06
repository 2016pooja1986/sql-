USE CompanyDB;

select DOB,adddate(DOB,interval 2 Month) from employees;
select DOB,adddate(DOB,interval 3 year) from employees;
select DOB,date_add(DOB,interval 3 month) from employees;
-- https://www.w3schools.com/MySQL/func_mysql_adddate.asp

select curdate();
select current_date();
select current_time();
select current_timestamp();
select curtime();

select date('2018-10-24');
SELECT DOB,DATE_FORMAT(DOB, concat_ws(" ","%d","th", "%M", "%Y", "%b")) from employees;

-- Return the number of days between two date values:
select round(datediff(curdate(),DOB)/365) from employees;

select year(curdate())-year(DOB) as age
from employees;

SELECT DATE_SUB("2017-06-15", INTERVAL 10 DAY);
SELECT DATE_add("2017-06-15", INTERVAL -10 DAY);

select DOB,day(DOB),dayofmonth(DOB),dayname(DOB),
dayofweek(DOB),dayofyear(DOB) 
from employees;
select DOB, month(DOB),monthname(DOB) 
from employees;

select DOB, extract(month from DOB),monthname(DOB) 
from employees;

select DOB,year(DOB),yearweek(DOB)
from employees;

select DOB, quarter(DOB)
from employees;

SELECT DOB,EXTRACT(quarter FROM DOB) as quarters from employees;

select now();

-- Returns the difference in a specified unit between two dates or times.
SELECT TIMESTAMPDIFF(MINUTE, '2024-10-17 12:00:00', NOW()) AS minutes_difference;
SELECT TIMESTAMPDIFF(hour, '2024-10-17 10:00:00', NOW()) AS hours_difference;
SELECT TIMESTAMPDIFF(day, '2024-01-07 12:00:00', NOW()) AS days_difference;
/*
%m - month no
%M - month name
%b - abbr month name
%d - day
%y - abbr of year(24)
%Y - full year(2024)
%W - full name of week day
%a - abbr of week day 
*/
SELECT STR_TO_DATE("October 17 2024 Thursday", "%M %d %Y");

select DOB,week(DOB),weekday(DOB),weekofyear(DOB) from employees;


