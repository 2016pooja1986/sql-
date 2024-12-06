use comp;
show tables;
CREATE TABLE student_contacts (  
  studentid int primary key AUTO_INCREMENT,  
  contactname varchar(45) NOT NULL,  
  cellphone varchar(20) DEFAULT NULL,  
  homephone varchar(20) DEFAULT NULL
  );  
  
insert into student_contacts
(contactname,cellphone,homephone)
values 
('pooja',9999644440,235678),  
('Dimple',8799644440,239578);

insert into student_contacts
(contactname,homephone)
values 
('pooja',735678),  
('Dimple',639578);
select * from student_contacts;

-- ifnull
SELECT   
    contactname, IFNULL(cellphone, homephone) phone  
FROM  
    student_contacts; 
    
-- nullif     
select 
contactname, nullif(homephone,735678 ) phone  
FROM  
    student_contacts;
    
    
-- enum in mysql
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


