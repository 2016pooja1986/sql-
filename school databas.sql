-- Create Database
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- Create Table: Students
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender ENUM('M', 'F'),
    BirthDate DATE,
    AdmissionDate DATE,
    Grade INT
);

-- Create Table: Teachers
CREATE TABLE Teachers (
    TeacherID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Subject VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(8, 2)
);

-- Create Table: Classes
CREATE TABLE Classes (
    ClassID INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(50),
    TeacherID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

-- Create Table: Enrollments
CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    ClassID INT,
    EnrollDate DATE,
    Grade CHAR(1),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (ClassID) REFERENCES Classes(ClassID)
);

-- Insert Data into Students Table

INSERT INTO Students (FirstName, LastName, Gender, BirthDate, AdmissionDate, Grade) VALUES
('John', 'Doe', 'M', '2008-05-15', '2020-08-12', 10),
('Jane', 'Smith', 'F', '2007-09-10', '2019-08-10', 11),
('Alice', 'Johnson', 'F', '2009-12-20', '2021-08-15', 9),
('Mike', 'Brown', 'M', '2010-02-25', '2022-08-16', 8),
('Emma', 'Davis', 'F', '2006-07-05', '2018-08-12', 12),
('Lucas', 'Miller', 'M', '2008-03-30', '2020-08-14', 10),
('Lily', 'Wilson', 'F', '2007-01-20', '2019-08-13', 11),
('Oliver', 'Taylor', 'M', '2009-04-18', '2021-08-17', 9),
('Sophia', 'Anderson', 'F', '2010-08-08', '2022-08-15', 8),
('James', 'Thomas', 'M', '2006-09-12', '2018-08-11', 12);


-- Insert Data into Teachers Table

INSERT INTO Teachers (FirstName, LastName, Subject, HireDate, Salary) VALUES
('David', 'Wilson', 'Mathematics', '2015-08-20', 55000),
('Mary', 'Brown', 'English', '2018-05-10', 53000),
('Robert', 'Taylor', 'Science', '2016-03-15', 57000),
('Linda', 'Davis', 'History', '2017-09-25', 52000),
('Michael', 'Thomas', 'Mathematics', '2014-07-14', 58000),
('Sarah', 'Johnson', 'English', '2019-11-05', 51000),
('James', 'White', 'Science', '2016-01-19', 54000),
('Patricia', 'Garcia', 'History', '2018-03-20', 55000),
('Thomas', 'Martinez', 'Mathematics', '2020-10-22', 52000),
('Elizabeth', 'Lopez', 'English', '2017-06-11', 53000);


-- Insert Data into Classes Table

INSERT INTO Classes (ClassName, TeacherID, StartDate, EndDate) VALUES
('Algebra', 1, '2023-09-01', '2024-05-15'),
('Biology', 3, '2023-09-01', '2024-05-15'),
('English Literature', 2, '2023-09-01', '2024-05-15'),
('World History', 4, '2023-09-01', '2024-05-15'),
('Calculus', 5, '2023-09-01', '2024-05-15'),
('Creative Writing', 6, '2023-09-01', '2024-05-15'),
('Physics', 7, '2023-09-01', '2024-05-15'),
('Modern History', 8, '2023-09-01', '2024-05-15'),
('Geometry', 9, '2023-09-01', '2024-05-15'),
('Advanced English', 10, '2023-09-01', '2024-05-15');


-- Insert Data into Enrollments Table
INSERT INTO Enrollments (StudentID, ClassID, EnrollDate, Grade) VALUES
(1, 1, '2023-09-01', 'A'),
(2, 1, '2023-09-01', 'B'),
(3, 2, '2023-09-01', 'A'),
(4, 3, '2023-09-01', 'C'),
(5, 4, '2023-09-01', 'B'),
(6, 5, '2023-09-01', 'A'),
(7, 6, '2023-09-01', 'A'),
(8, 7, '2023-09-01', 'B'),
(9, 8, '2023-09-01', 'C'),
(10, 9, '2023-09-01', 'B');

/*
Assignments on window functions
1. Find the average grade in each class by gender
2. List the top 3 students in each class based on their grade
3. Calculate the cumulative average salary of teachers based on hire date
4. Show each student’s grade and the difference between their grade and the highest grade in the same class
5. Find the highest salary per department, with each teacher's salary and hire date
6. Identify the enrollment date and class rank for each student by enrollment date
7. Calculate the total  overall enrollments
8. Get each teacher’s salary and the cumulative percentage of salary relative to others
9. Show students’ grade and class position based on grade with ties handled
10. Find students who received the highest grade in each class
11. Find students who received the lowest grade in each class
12. Compare each student's current grade with their previous grade in the same class
Use LAG to see how a student’s grade in each class has changed over time (assuming there are multiple enrollments per student in the same class).
13. Show the grade progression of each student by class using LEAD to show the next grade

Use LEAD to display the grade a student received in their next enrollment within the same class.
14. Identify the first grade each student received when they enrolled in a class

Use FIRST_VALUE to find the earliest grade for each student in each class.
15. Find the last grade each student received in each class

Use LAST_VALUE to retrieve the latest grade for each student within each class.
16. Display each student’s grade alongside the highest grade in the class up to that point

Use FIRST_VALUE to show the top grade received in the class at any point.
17. Identify students whose grades have dropped compared to the previous enrollment in the same class

Compare each grade with the previous grade using LAG.
18. Show each student's grade trend within each class by comparing the first and last grades

Use FIRST_VALUE and LAST_VALUE to track grade progression from the first to the last enrollment in each class.
19. Calculate each student’s grade ranking within their class at each enrollment

Use RANK along with LAG to observe changes in ranking.
20. For each student, find the highest grade they received in all classes by enrollment date

Use LAST_VALUE to determine the highest grade.
*/

SELECT e.ClassID, s.Gender, AVG(e.Grade) AS AvgGrade
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
GROUP BY e.ClassID, s.Gender;




