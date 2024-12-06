show databases;
use mysql;
show tables;
select * from user;

-- grant and revoke

create user 'poorvi' identified by 'poorvi123';
select * from user;
grant select,update,insert on book_store.* to 'poorvi';
-- To grant privileges across all databases on the MySQL server, use the following syntax:
-- GRANT SELECT, INSERT, UPDATE ON *.* TO 'username'@'localhost';
flush privileges;
show grants for 'poorvi';

revoke update,insert on book_store.* from 'poorvi';

drop user 'poorvi';
flush privileges;
select * from user;