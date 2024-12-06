/*
A stored procedure in MySQL is a precompiled collection of SQL statements that can be executed as a single unit.
 It allows you to encapsulate business logic and improve code reusability. 
Stored procedures are particularly useful for repetitive tasks, complex operations, and centralizing logic.
*/

use google;

show tables;

DELIMITER //
CREATE PROCEDURE get_employee()
begin
	select * from employee;
end //


show procedure status;
call get_employee();

drop procedure get_employee;
desc employee;

DELIMITER $$
create procedure dept_get_emp(IN d_name varchar(50))
begin
	select * from employee
    where DEPT_NAME = d_name;
end $$



call dept_get_emp('IT');






use google;

DELIMITER $$

CREATE PROCEDURE dept_get_emp_more_sal(IN d_name VARCHAR(50), IN min_salary INT)
BEGIN
    SELECT *
    FROM employee
    WHERE DEPT_NAME = d_name AND SALARY > min_salary;
END $$



drop procedure google.dept_get_emp_more_salary;


call dept_get_emp_more_sal('HR',6000);

SHOW PROCEDURE STATUS WHERE Db = 'google';


DELIMITER $$

CREATE PROCEDURE InsertEmployees()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 3 DO
        INSERT INTO employee (emp_ID, emp_NAME, DEPT_NAME, SALARY)
        VALUES (1000 + i, CONCAT('Employee_', i), 'Admin', 4000);
        SET i = i + 1;
    END WHILE;
END $$


-- Call the procedure
CALL InsertEmployees();

-- Verify
SELECT * FROM employee;

DELIMITER $$

CREATE PROCEDURE CheckEmployeeExists(IN e_id INT)
BEGIN
    IF EXISTS (SELECT 1 FROM employee WHERE emp_ID = e_id) THEN
        SELECT CONCAT('Employee with ID ', e_id, ' exists.') AS Message;
    ELSE
        SELECT CONCAT('Employee with ID ', e_id, ' does not exist.') AS Message;
    END IF;
END $$


drop procedure google.CheckEmployeeExists;

-- Call the procedure
CALL CheckEmployeeExists(102);

SELECT * FROM employee ;