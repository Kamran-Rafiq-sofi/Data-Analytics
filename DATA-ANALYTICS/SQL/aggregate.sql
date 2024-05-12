CREATE DATABASE AGGREGATE_WINDOWS_FUNCTION;
use AGGREGATE_WINDOWS_FUNCTION;
CREATE TABLE Department(
department_id INT primary key,
depertment_name VARCHAR(255)
);
INSERT INTO Department VALUES(1,'sales'),
					         (2,'marketing'),
                             (3,'it');
                       
select * from Department;
CREATE TABLE Employee(
employee_id INT Primary key,
employee_name VARCHAR(250),
department_id INT,
salary  INT
);
alter table Employee ADD foreign key(department_id) REFERENCES Department(department_id);

INSERT INTO Employee VALUES(1,'a',1,50000),
                            (2,'b',1,60000),
                            (3,'c',1,45000),
                            (4,'d',2,70000),
                            (5,'e',2,55000),
                            (6,'f',3,80000),
                            (7,'g',3,90000);
select * from Employee;

select d.department_id, e.employee_id, e.employee_name from Department as d
inner join Employee as e
On
d.department_id=e.department_id;



-- SUM()OVER()
select employee_id ,salary ,SUM(Salary) as Salary from Employee
group by employee_id;

select employee_id, salary, SUM(Salary) over(partition by department_id) as Total_Salary_In_Department from Employee;

-- AVG()OVER()
create table product(
product_id INT primary key,
product_category VARCHAR(250),
price INT

);
INSERT INTO product VALUES(1,'e',500),
                            (2,'e',600),
                            (3,'e',450),
                            (4,'c',700),
                            (5,'c',550),
                            (6,'f',800),
                            (7,'f',900);
	select * from product;
    select product_id ,AVG(price) over(partition by product_category)   as avg_price_per_category  from product order by product_id ;
	select product_id, price, AVG(price) as avg_price  from product  group by product_id;
-- COUNT()OVER()
create table orders(
order_id INT,
customer_id INT
);
alter table orders add primary key(order_id);

INSERT INTO orders VALUES  (1,100),
                            (2,100),
                            (3,200),
                            (4,200),
                            (5,300),
                            (6,300),
                            (7,100);
select * from orders;
select order_id,customer_id ,count(*) as total_count from orders group by order_id;
select order_id,customer_id ,count(*) over(partition by customer_id) as total_count from orders;


-- MIN()OVER()

create table min_products(
product_id INT PRIMARY KEY,
product_name VARCHAR(225),
category VARCHAR(225),
price INT
);
INSERT INTO min_products VALUES(1,'t-shit','cloth',100),
							   (2,'shirt','cloth',50),
                               (3,'mobile','electronics',200),
                               (4,'laptop','electronics',300);
                              
 select * ,MIN(price) as min from min_products group by product_id;                             


-- MAX()OVER() 
create table stocks(
stock_id INT,
symbol VARCHAR(25),
stock_date date,
price INT
);
ALTER TABLE STOCKS ADD PRIMARY KEY(STOCK_ID);
INSERT INTO stocks VALUES   (1,'AAPL','2024-01-20',150),
							(2,'GOOG','2024-01-20',1200),
							(3,'AAPL','2024-01-21',160),
							(4,'MSFT','2024-01-21',200),
							(5,'GOOG','2024-01-22',1150),
   							(6,'AAPL','2024-01-22',145);
SELECT * FROM STOCKS;
select * ,MAX(price) from stocks group by stock_id;

select stock_id,symbol,stock_date,price ,MAX(price)over (partition by symbol)as max_price from stocks;
