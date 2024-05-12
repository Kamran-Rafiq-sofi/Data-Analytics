use sfsalaries;

-- show all coumns and rows in a table

select * from test1;
select * from salaries;

-- show columns and datatype
desc salaries;
desc test1;


-- only emplyname and jobtitle
select EmployeeName ,JobTitle from salaries;
select EmployeeName ,JobTitle from test1;

-- show number of employee in table
select Id,EmployeeName,JobTitle,count(*) from salaries 
GROUP BY Id ,EmployeeName,JobTitle
order by Id;

select Id,EmployeeName,JobTitle,count(*) from test1 
GROUP BY Id ,EmployeeName,JobTitle
order by Id;

select count(*) from salaries;

select count(*) from test1;


-- Show unique tobtitles in table

select distinct JobTitle from test1;


-- show the jobtitle and overtiem pay where overtime pay>50000
select * from test1;
select JobTitle,OvertimePay from test1 where OvertimePay>50000;

-- show the average base pay of all employees
select * from test1;
desc test1;
select Avg(BasePay) as avgPay from test1;
select Id,Avg(BasePay) as avgPay from test1 group by Id;




-- show top10 highest paid employee limit 10
select Id,EmployeeName ,TotalPay from test1 order by TotalPay desc limit 10;

-- avg basepay totalpay and otherpay for each employee
select * from test1;
-- row based
select (BasePay+OvertimePay+OtherPay)/3  as avgPaydata from test1;
-- only one
select avg(BasePay+OvertimePay+OtherPay) as avgPaydata from test1;

select Id, (BasePay+OvertimePay+OtherPay)/3  as avgPaydata from test1;
select Id, avg(BasePay+OvertimePay+OtherPay)/3 as avgPaydata from test1 group by Id;

-- show all employee with job title having manager

select * from test1 where JobTitle LIKE "%Manager%";


-- All employee where jobtitle is not manager
select * from test1 where JobTitle<>'Manager';

-- Employee totalPAy between 50,000,750000
select * from test1 where TotalPay Between 50000 And 75000;
select * from test1 where TotalPay>=50000  And TotalPay<=75000;


-- TotalPay benefits between value 125000,15000 job contains director
select * from test1 where TotalPayBenefits Between 125000 And 150000 and JobTitle Like "%director";


-- all employee order by totalPaybenefits
select * from test1 order by TotalPayBenefits;


-- jobtitle avg of base pay at leat 10000 and order by avg(baspay ) in desc;
select JobTitle ,Avg(BasePay) as avgpay from test1 group by JobTitle having AVG(BasePay)>=10000 order by avgpay desc;


-- delete column
select * from test1;
Alter table test1
drop column Notes;


-- update basepay where jobtitle contains manager incfrese it by 10%
set sql_safe_updates=0;
select * from test1;
update test1
set BasePay=Basepay*1.1
where JobTitle Like '%Manager%';
select * from test1;


-- delete employees no overtimepay
select * from test1;
delete from test1 where OvertimePay=0;
select * from test1;

