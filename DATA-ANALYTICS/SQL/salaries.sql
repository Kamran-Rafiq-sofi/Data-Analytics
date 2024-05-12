use data_mysql;
-- show all the columns and rows
select * from test1;

-- Only Employee Name and JobTitle
select EmployeeName ,JobTitle from test1;

-- Show number of employees in table
select Count(*) as number_of_employees  from test1;

-- show unique jobtittle in table 
select distinct JobTitle,count(*) as jobs from test1 group by JobTitle;

-- show JobTitle, and overtime pay for all employee with overtime pay greater than 5000;
select * from test1;
select JobTitle ,OvertimePay from test1 where OvertimePay>5000;

-- Average basepay of all employees
select * from test1;
select avg(BasePay) as avg_pay from test1;

-- Top 10 highest paid employee
select * from test1;
desc test1;
select * from test1 order by TotalPayBenefits desc limit 10;

-- avg base pay overtime pay and other pay for employees
select id,EmployeeName, (BasePay+OvertimePay+OtherPay)/3 as average_pay from test1;

-- all employess with jobtitle manager;
select * from test1;
select * from test1 where jobTitle Like '%Manager%';


-- all employess with jobtitle not manager;
select * from test1;
select * from test1 where jobTitle NOT Like '%Manager%';
select * from test1 where jobTitle <> Manager;
-- select * from test1 where jobTitle != '%Manager%';
-- select * from test1 where jobTitle NOT IN( '%Manager%');


-- employee total pay between 5000 and 75000
select * from test1;
select * from test1 where TotalPay between 5000 And 7000 order by TotalPay ;

-- base pay <5000 and total pay >100000
select id,BasePay,TotalPay from test1 where BasePay<50000 or TotalPay>100000;

-- totalpay benefits between value 125000 ,150000 and job containg director
select * from test1;
select id,EmployeeName ,TotalPayBenefits,JobTitle from test1 where TotalPayBenefits between 125000 and 150000 And JobTitle
like '%Director';

-- all employees order by TotalPayBenefits desc
select * from test1 order by TotalPayBenefits;
select * from test1 order by TotalPayBenefits desc;

-- Jobtitle avg base pay where it is atleat 10000 and order by avg base pay
 select Id,EmployeeName ,JobTitle ,avg(BasePay) as avg_pay from test1 group by Id,EmployeeName,JobTitle
 having avg_pay >=10000 order by avg_pay;
-- select Id,EmployeeName ,JobTitle ,avg(BasePay) as avg_pay  from test1 where avg_pay exists(10000),  group by Id,EmployeeName,JobTitle 
--  having avg_pay >=10000 order by avg_pay;

-- delete column notes from trable
select * from test1;
desc test1;
Alter table test1 drop column Notes;
select * from test1;


-- add column notes from trable
select * from test1;
desc test1;
Alter table test1 add column Notes double after TotalPayBenefits;
select * from test1;


-- update base pay where jobTitle containing manager by 10%;
set sql_safe_updates=0;
select * from test1;

update  test1 
   set BasePay=BasePay*1.1
   where JobTitle Like '%Manager';
   
select * from test1;
   
   
-- delete all employess with no overtirm pay
select * from test1;
delete from  test1 
where OvertimePay=0;
select * from test1;