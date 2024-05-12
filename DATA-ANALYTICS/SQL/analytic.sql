create database analytics_windows_function;
use analytics_windows_function;
-- LEAD()
create table orders(
order_id INT primary key,
customer_id INT,
order_date DATE,
price INT

);
insert into orders values(1,1,'2023-11-15',100),
                         (2,1,'2023-11-20',150),
                         (3,2,'2023-12-20',200),
                         (4,2,'2024-01-10',120),
                         (5,2,'2024-01-15',80);
select * from orders;

select order_id,customer_id,order_date,price ,lead(price,1)over(partition by customer_id order by order_date) as next_price from orders 
order by order_date;

select order_id,customer_id,order_date,price ,lead(price,1)over(partition by customer_id order by order_id) as next_price from orders 
order by order_date;


-- LAG()

create table weather(
temp_date DATE,
temp INT

);

insert into weather values('2023-12-21',10),
                         ('2023-12-22',15),
                         ('2023-12-23',8),
                         ('2023-12-24',12),
                         ('2023-12-25',5);
select *from weather;

select temp_date,temp,lag(temp,2)over(order by temp_date) as temp_2_days_ago from weather;
select temp_date,temp,lag(temp,1)over(order by temp_date) as temp_2_days_ago from weather;
-- first_value(),last_value()
create table firstorders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE

);

insert into firstorders values( 1,1,'2024-01-15'),
                                ( 2,1,'2023-11-20'),
                                ( 3,2,'2024-01-10'),
                                ( 4,2,'2023-12-20'),
                                ( 5,3,'2024-01-20');
select * from firstorders;
select order_id,customer_id,order_date,first_value(order_date)over(partition by customer_id)as first_order_date from firstorders;
select customer_id,first_value(order_date)over(partition by customer_id)as first_order_date from firstorders;
select customer_id,last_value(order_date)over(partition by customer_id)as first_order_date from firstorders;


-- NTH_Value()
create table  employees(
employee_id INT PRIMARY KEY,
salary INT
);
 drop table employees;

insert into employees values(1,900),
                            (2,850),
                            (3,800),
                            (4,700),
                            (5,600);
                            
select * from employees;   
select employee_id,NTH_VALUE(salary ,2)over(order by salary desc)as second_largest_salary from employees;                         


create table productstable(
order_id INT PRIMARY KEY,
category VARCHAR(25),
pname VARCHAR(25),
price INT

);


insert into productstable values(1,'c','j',10),
                                 (2,'c','s',9),
                                 (3,'c','ts',8),
                                 (4,'e','l',13),
                                 (5,'e','m',12),
                                 (6,'e','w',11);
                                 
select * from productstable;                                 
select order_id,category,pname,NTH_VALUE(price,2)over(partition by category order by price desc)as second_highest from productstable;
