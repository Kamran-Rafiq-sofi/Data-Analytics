-- DDL
-- create

create database employee_db;
use employee_db;
create table employee_details(
eid INT,
e_name VARCHAR(250),
e_add VARCHAR(250),
e_phone VARCHAR(250),
e_salary decimal(6,2),
e_email VARCHAR(200)
);
desc employee_detaols;
desc employee_db;


-- drop table and db
drop table employee_detaols;
desc employee_detaols;
-- drop database employee_db;

-- drop table employee_detaols;

-- alter add
alter table employee_detaols add e_dept varchar(250);
desc employee_detaols;

alter table employee_detaols add e_dept_id  varchar(250) after e_salary;
desc employee_detaols;

alter table employee_detaols add e_dept_idgen  varchar(250) first ;
desc employee_detaols;


-- alter modify
alter table employee_detaols modify e_dept_id  INT;
desc employee_detaols;

alter table employee_detaols modify e_dept_idgen  bigint ;
desc employee_detaols;


-- alter change
alter table employee_detaols change column e_dept_idgen e_dept_gen VARCHAR(250);
desc employee_detaols;



-- alter drop
alter table employee_detaols drop column e_dept_gen ;
desc employee_detaols;

alter table employee_detaols drop  e_dept_id ;
desc employee_detaols;



-- alter rename
alter table employee_detaols rename column eid to e_id;
desc employee_detaols;

alter table employee_detaols rename to employee_details;
desc employee_details;
truncate table employee_details;
desc employee_details;


