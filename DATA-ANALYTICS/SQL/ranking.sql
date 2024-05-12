create database ranking_windows_function;
use ranking_windows_function;


-- RANK()
create table employee(
employee_id INT primary KEY,
employee_name VARCHAR(25),
salary INT
);
-- drop table employee;
-- alter table employee add primary key(
INSERT INTO employee VALUES(1,'a',60),
                           (2,'b',50),
                           (3,'c',40),
                           (4,'d',70),
                           (5,'e',55);
                           
select employee_id ,employee_name,salary from employee;                                                      
select employee_id ,employee_name,salary, RANK()OVER(order by salary desc) as salary_rank from employee; 

create table employee_dept(
employee_id INT primary KEY,
department_name VARCHAR(25),
salary INT
);
-- drop table employee;
-- alter table employee add primary key(
INSERT INTO employee_dept VALUES(1,'M',50),
                           (2,'M',45),
                           (3,'IT',60),
                           (4,'IT',55),
                           (5,'S',70),
						   (6,'S',65),
                           (7,'HR',50),
                           (8,'HR',40);
                           
select employee_id ,department_name,salary from employee_dept;                                                      
select employee_id ,department_name,salary, RANK()OVER(partition by department_name order by salary desc) as salary_rank from employee_dept;
-- select employee_id ,department_name,salary, RANK()OVER(partition by department_name ) as salary_rank from employee_dept ; 
-- select employee_id ,department_name,salary, RANK()OVER(partition by department_name order by salary desc) as salary_rank from employee_dept;
select employee_id ,department_name,salary, RANK()OVER(partition by department_name order by salary desc) as salary_rank from employee_dept
order by salary  desc;



-- DENSE_RANK()
 create table product_dept(
product_id INT primary KEY,
product_name VARCHAR(25),
price INT
);

INSERT INTO product_dept VALUES (1,'T-shirt',500),
                           (2,'Laptop',4500),
                           (3,'Headphones',300),
                           (4,'Phone',550),
                           (5,'Shoe',700);
select * from product_dept;

select product_id ,product_name,price from product_dept;                                                      
select product_id ,product_name,price, DENSE_RANK()OVER( order by price desc) as price_rank from product_dept;

 create table products_dept(
product_id INT primary KEY,
product_name VARCHAR(25),
category VARCHAR(255),
price INT
);
-- drop table products_dept;
INSERT INTO products_dept VALUES (1,'T-shirt','wear',500),
                                 (2,'Laptop','ele',4500),
                                 (3,'Headphones','ele',300),
								 (4,'Phone','ele',550),
                                 (5,'Shoe','wear',700);
select * from products_dept;                                 
select product_id,category ,product_name,price, DENSE_RANK()OVER(partition by category order by price ) as price_rank from products_dept
order by category,price;

select product_id,category ,product_name,price, DENSE_RANK()OVER(partition by category order by price desc) as price_rank from products_dept
order by category, price desc;


-- ROW_NUMBER()
create table customer(
customer_id INT ,
order_date DATE

);

insert into  customer values (1,'2023-11-20'),
                             (1,'2023-11-15'),
                             (2,'2024-01-10'),
                             (2,'2024-01-15'),
                             (2,'2023-12-20'),
                             (3,'2024-01-20');
 select * from customer;                            
select customer_id,order_date,ROW_NUMBER()over(partition by customer_id order by order_date desc)as order_number from customer
order by customer_id,order_date desc;


-- NTILE(N)
create table student(
student_id INT PRIMARY KEY,
score INT

);

insert into student values(1,80),
							(2,95),
                            (3,70),
                            (4,65),
                            (5,90),
                            (6,85),
                            (7,55),
                            (8,100),
                            (9,75),
                            (10,60);
select * from student;    
select student_id,score ,NTILE(4)over(order by score) as score_quartile from student;  
select student_id,score ,NTILE(4)over(order by score desc) as score_quartile from student;   
-- select student_id,score ,NTILE(4)over(order by score desc) as score_quartile from student order by student_id; 


create table students(
student_id INT PRIMARY KEY,
score INT,
course VARCHAR(256)

);

insert into students values (1,80,'m'),
							(2,95,'m'),
                            (3,70,'h'),
                            (4,65,'h'),
                            (5,90,'s'),
                            (6,85,'s'),
                            (7,55,'l'),
                            (8,100,'l');
select * from students;    
select student_id,score,course ,NTILE(4)over(order by score) as score_quartile from students;  
select student_id,score,course ,NTILE(4)over(order by score desc) as score_quartile from students;   
select student_id,score,course ,NTILE(4)over(partition by course order by score desc) as score_quartile from students;   


-- select student_id,score ,NTILE(4)over(order by score desc) as score_quartile from student order by student_id;                                                                                         
                                                                                        