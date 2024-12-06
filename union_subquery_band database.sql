CREATE DATABASE IF NOT exists band ;
use band;
-- Create the Orchestras table
CREATE TABLE Orchestras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    rating DECIMAL(2, 1), -- Assuming rating is out of 10.0
    city_origin VARCHAR(255),
    country_origin VARCHAR(255),
    year INT
);

-- Create the Concerts table
CREATE TABLE Concerts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    rating DECIMAL(2, 1), -- Assuming rating is out of 10.0
    year INT,
    orchestras_id INT,
    FOREIGN KEY (orchestras_id) REFERENCES Orchestras(id) ON DELETE CASCADE
);

-- Create the Members table
CREATE TABLE Members (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255),
    experience INT, -- Assuming experience is in years
    orchestras_id INT,
    wage DECIMAL(10, 2), -- Assuming wage is a monetary value
    FOREIGN KEY (orchestras_id) REFERENCES Orchestras(id) ON DELETE CASCADE
);


-- Insert data into the Orchestras table
INSERT INTO Orchestras (name, rating, city_origin, country_origin, year) VALUES
('Symphony of Dreams', 8.5, 'New York', 'USA', 1995),
('Harmonic Fusion', 9.0, 'Berlin', 'Germany', 2001),
('Melody Makers', 7.5, 'London', 'UK', 1987),
('Rhythm Masters', 8.0, 'Paris', 'France', 1990),
('Orchestral Bliss', 9.2, 'Vienna', 'Austria', 2000),
('Soundscape Artists', 8.8, 'Madrid', 'Spain', 2005),
('Echo Ensemble', 7.8, 'Rome', 'Italy', 1998),
('Crescendo Creators', 8.4, 'Chicago', 'USA', 1992),
('Harmony Horizons', 8.9, 'Tokyo', 'Japan', 1997),
('Symphonic Souls', 9.1, 'Sydney', 'Australia', 1985);
select * from Orchestras;
-- Insert data into the Concerts table
INSERT INTO Concerts (city, country, rating, year, orchestras_id) VALUES
('New York', 'USA', 8.7, 2013, 1),
('Berlin', 'Germany', 8.9, 2013, 2),
('London', 'UK', 8.3, 2015, 3),
('Paris', 'France', 8.4, 2013, 4),
('Vienna', 'Austria', 9.0, 2012, 5),
('Madrid', 'Spain', 8.2, 2013, 6),
('Rome', 'Italy', 7.9, 2014, 7),
('Chicago', 'USA', 8.6, 2013, 8),
('Tokyo', 'Japan', 9.1, 2013, 9),
('Sydney', 'Australia', 9.3, 2016, 10);

-- Insert data into the Members table
INSERT INTO Members (name, position, experience, orchestras_id, wage) VALUES
('Alice Johnson', 'Violinist', 10, 1, 55000.00),
('Bob Smith', 'Cellist', 7, 2, 48000.00),
('Carlos Mendez', 'Conductor', 15, 3, 75000.00),
('Diana Lee', 'Violinist', 12, 4, 56000.00),
('Elena Rossi', 'Pianist', 8, 5, 50000.00),
('Fabio Sanchez', 'Percussionist', 9, 6, 52000.00),
('Grace Kim', 'Violist', 5, 7, 45000.00),
('Hiro Tanaka', 'Double Bassist', 6, 8, 47000.00),
('Ivy Williams', 'Trumpeter', 11, 9, 53000.00),
('Jack Brown', 'Saxophonist', 8, 10, 49000.00);

-- 1. Find all concerts held in the same country as the orchestra's origin.

SELECT o.name AS orchestra_name, c.city AS concert_city, c.country AS concert_country, c.year AS concert_year
FROM Orchestras o
JOIN Concerts c ON o.id = c.orchestras_id
WHERE o.country_origin = c.country;

-- 2. Find orchestras and their concerts where both the orchestra rating and concert rating are above 8.0.
SELECT o.name AS orchestra_name, o.rating AS orchestra_rating, c.city AS concert_city, c.rating AS concert_rating
FROM Orchestras o
JOIN Concerts c ON o.id = c.orchestras_id
WHERE o.rating > 8.0 AND c.rating > 8.0;

-- 3. List all members with their respective orchestra's name and city of origin. 
  -- Show member name,position, orchestra name, and city of origin.
SELECT m.name AS member_name, m.position, o.name AS orchestra_name, o.city_origin
FROM Members m
JOIN Orchestras o ON m.orchestras_id = o.id;

-- 4. List all orchestras and any concerts they have, even if they have none.
  -- Show the orchestra name, concert city, and concert year. If no concert exists, show NULL for concert details.
  
SELECT o.name AS orchestra_name, c.city AS concert_city, c.year AS concert_year
FROM Orchestras o
LEFT JOIN Concerts c ON o.id = c.orchestras_id;

-- 5. Find all concerts held in 2013 along with the orchestra's rating.
  -- Show the concert city, concert country, concert year, and the orchestra's rating.
  
SELECT c.city AS concert_city, c.country AS concert_country, c.year AS concert_year, o.rating AS orchestra_rating
FROM Concerts c
JOIN Orchestras o ON c.orchestras_id = o.id
WHERE c.year = 2013;

-- 6. Find pairs of orchestras from the same country with different ratings.
  -- Show the names and ratings of both orchestras in each pair.
  
SELECT o1.name AS orchestra_name_1, o1.rating AS rating_1, o2.name AS orchestra_name_2, o2.rating AS rating_2
FROM Orchestras o1
JOIN Orchestras o2 ON o1.country_origin = o2.country_origin AND o1.id > o2.id
WHERE o1.rating != o2.rating;

-- 7. Count the number of concerts held by each orchestra.
  -- Show the orchestra name and the count of concerts.
select o.name, count(*) NO_of_Concerts
from orchestras o
join concerts c
on o.id=c.orchestras_id
GROUP BY o.id, o.name;  

SELECT o.name AS orchestra_name, COUNT(c.id) AS concert_count
FROM Orchestras o
JOIN Concerts c ON o.id = c.orchestras_id
GROUP BY o.name;

-- 8. Find the total experience of members in each orchestra.
  -- Show the orchestra name and the sum of experience (in years) of its members.

SELECT o.name AS orchestra_name, SUM(m.experience) AS total_experience
FROM Orchestras o
JOIN Members m ON o.id = m.orchestras_id
GROUP BY o.name;

-- 9. List each country along with the total number of orchestras originating from it and the total number of concerts held in that country. 
  -- Show the country, count of orchestras, and count of concerts.
  
SELECT 
    o.country_origin AS country,
    COUNT(DISTINCT o.id) AS total_orchestras,
    COUNT(c.id) AS total_concerts
FROM 
    Orchestras o
LEFT JOIN 
    Concerts c ON o.country_origin = c.country
GROUP BY 
    o.country_origin;

-- 10.  Concatenate the orchestra name with its city of origin, separated by a comma. 
  -- Show the concatenated result.
  
SELECT 
    CONCAT(name, ', ', city_origin) AS orchestra_city
FROM 
    Orchestras;

-- 11. Replace any occurrence of "Symphony" with "Orchestra" in orchestra names. Show the modified orchestra name.

SELECT *,
    REPLACE(name, 'Symphony', 'Orchestra') AS modified_orchestra_name
FROM 
    Orchestras;

-- 12. Calculate the average wage of members and round it to two decimal places. Show the result as the average wage.
SELECT 
    ROUND(AVG(wage), 2) AS average_wage
FROM 
    Members;

-- 13.  Find the absolute difference between the orchestra rating and concert rating for concerts held in 2013. 
  -- Show the orchestra name, concert city, and the absolute difference in rating.
SELECT 
    o.name AS orchestra_name,
    c.city AS concert_city,
    ABS(o.rating - c.rating) AS rating_difference
FROM 
    Orchestras o
JOIN 
    Concerts c ON o.id = c.orchestras_id
WHERE 
    c.year = 2013;

-- 14.  Get the highest, lowest, and average experience of members in each orchestra. Show the orchestra name and these statistics.
SELECT 
    o.name AS orchestra_name,
    MAX(m.experience) AS max_experience,
    MIN(m.experience) AS min_experience,
    AVG(m.experience) AS avg_experience
FROM 
    Orchestras o
JOIN 
    Members m ON o.id = m.orchestras_id
GROUP BY 
    o.name;

-- 15. Find concerts held in 2013 and display their month and year. (Not applicable for this database)
  -- Show the concert city and month and year of the concert.
  SELECT 
    city AS concert_city,
    MONTH(DATE(CONCAT(year, '-01-01'))) AS concert_month,
    year AS concert_year
FROM 
    Concerts
WHERE 
    year = 2013;

-- 16. Add 5 years to each orchestra’s establishment year and show the new year. Show the orchestra name, original year, and new year.
SELECT 
    name AS orchestra_name,
    year AS original_year,
    year + 5 AS new_year
FROM 
    Orchestras;

-- 17. Find all orchestras established before the year 2000 and show how many years ago they were founded. 
  -- Show the orchestra name, establishment year, and years since founded.
SELECT 
    name AS orchestra_name,
    year AS establishment_year,
    YEAR(CURDATE()) - year AS years_since_founded
FROM 
    Orchestras
WHERE 
    year < 2000;

-- 18. Classify orchestras based on their rating.
  -- If the rating is above 8, classify as 'High', otherwise 'Standard'. Show the orchestra name and its classification.
  
SELECT 
    name AS orchestra_name,
    IF(rating > 8, 'High', 'Standard') AS rating_classification
FROM 
    Orchestras;

-- 19. Label concerts as 'Domestic' or 'International' based on the orchestra's country of origin.
  -- Show the concert city, country, and label.
  
INSERT INTO Concerts (city, country, rating, year, orchestras_id) VALUES
('New York', 'Germany', 8.7, 2013, 1),
('Berlin', 'UK', 8.9, 2013, 2),
('London', 'Germany', 8.3, 2015, 3);

SELECT 
    c.city AS concert_city,
    c.country AS concert_country,
    IF(o.country_origin = c.country, 'Domestic', 'International') AS concert_label
FROM 
    Concerts c
JOIN 
    Orchestras o ON c.orchestras_id = o.id;

-- 20. Classify members based on years of experience.
  -- If experience is 10 or more years, show 'Veteran'; between 5 and 9 years, show 'Experienced'; below 5 years, show 'Novice'. 
  -- Show member name and classification.

SELECT 
    name AS member_name,
    CASE 
        WHEN experience >= 10 THEN 'Veteran'
        WHEN experience BETWEEN 5 AND 9 THEN 'Experienced'
        ELSE 'Novice'
    END AS experience_classification
FROM 
    Members;


/*
In MySQL, the UNION operator is used to combine the result sets of two or more SELECT statements into a single result set. 
The UNION operator automatically removes duplicate rows from the final result. 
If you want to include duplicates, you can use UNION ALL.

Syntax
The basic syntax for using UNION is as follows:
SELECT column1, column2, ...
FROM table1
WHERE condition
UNION
SELECT column1, column2, ...
FROM table2
WHERE condition;

*/
show tables;
select * from orchestras;
select * from concerts;
select * from members;
-- Write a query to list all unique cities where concerts are held and the cities of origin for orchestras. Show only unique city names.

select city from concerts
union 
select city_origin from orchestras;

select city from concerts
union all 
select city_origin from orchestras;


-- SUBQUERIES

-- Select the names of all orchestras that have the same city of origin as any city in which any orchestra performed in 2013.

select * from orchestras 
where city_origin in  (select city from concerts where year=2016);

select o.* from orchestras o
join concerts c
on o.city_origin = c.city
and c.year=2016;

select o.*,c.* from orchestras o,concerts c
where o.city_origin = c.city
and c.year=2016; 

select * from orchestras;
-- Select the names and positions (i.e. instrument played) of all orchestra members that have above 10 years of experience 
-- and do not belong to orchestras with a rating below 8.0.

select m.name, m.position, m.experience
from members m
where m.experience > 10 and m.orchestras_id in (select id from orchestras where rating >=8.0);

select m.name, m.position, m.experience,o.rating
from members m 
join orchestras o
on  m.experience > 10 and m.orchestras_id = o.id and o.rating >=8.0;

select m.name, m.position, m.experience,o.rating
from members m , orchestras o
where  m.experience > 10 and m.orchestras_id = o.id and o.rating >=8.0;

select * from members;
-- Show the name and position of orchestra members who earn more than the average wage of all violinists.
select name,position, wage from members
where wage >=(select avg(wage) from members where position = 'Violinist');

set @avg_wage = round((select avg(wage) from members where position = 'Violinist'));

select @avg_wage ;
select name,position, wage from members
where wage >=@avg_wage;

select round(avg(wage)) from members where position = 'Violinist' into @avg;
select @avg;

use band;

-- Show the names of orchestras that were created after the 'Orchestral Bliss' and have a rating greater than 7.5.
show tables;
select * from orchestras;

select name,rating,year
from orchestras
where year > (select year from orchestras where name ='Orchestral Bliss') 
and rating >7.5;

-- SUBQUERY

-- Find the highest-paid employee in each department.
SELECT EmpID, FirstName, LastName, DeptID, Salary
FROM Employees
WHERE Salary = (SELECT MAX(Salary)
                FROM Employees AS E
                WHERE E.DeptID = Employees.DeptID);
-- List the names of departments that have more than 3 employees.
SELECT DeptName
FROM Departments
WHERE DeptID IN (
    SELECT DeptID
    FROM Employees
    GROUP BY DeptID
    HAVING COUNT(EmpID) > 3
);

-- Retrieve employee details for employees who earn more than the average salary in their department.

SELECT EmpID, FirstName, LastName, DeptID, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary)
                FROM Employees AS E
                WHERE E.DeptID = Employees.DeptID);
-- Find departments where the total salary expenditure is more than 150,000.
SELECT DeptName
FROM Departments
WHERE DeptID IN (
    SELECT DeptID
    FROM Employees
    GROUP BY DeptID
    HAVING SUM(Salary) > 150000
);



select * from employees;

-- Find the names of employees who have a salary greater than the highest-paid employee in the HR department.

SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT MAX(Salary)
                FROM Employees
                WHERE DeptID = (SELECT DeptID FROM Departments WHERE DeptName = 'HR'));
                
-- Find employees who work in the same department as "Alice Brown" (by name).
SELECT FirstName, LastName
FROM Employees
WHERE DeptID = (SELECT DeptID
                FROM Employees
                WHERE FirstName = 'Alice' AND LastName = 'Johnson');
-- List departments that do not have any employees.
SELECT DeptName
FROM Departments
WHERE DeptID NOT IN (
    SELECT DISTINCT DeptID
    FROM Employees
);

-- Find employees who earn more than the average salary of the entire company.
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);







