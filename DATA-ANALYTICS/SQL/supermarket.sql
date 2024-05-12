create database eda_supermarket;
use eda_supermarket;
select * from supermarket;
-- question1: display first 5 rows from dataset;
select * from supermarket limit 5;


-- question2: display last 5 rows from dataset;
select * from supermarket;
select * from supermarket order by `Invoice ID` desc limit 5;
select * from (select * from supermarket order by `Invoice ID` desc ) as supertable order by `Invoice ID` asc limit 5;


-- question3: display random 5 rows;
select * from supermarket;
select * from supermarket order by rand() limit 5;
select * from supermarket order by rand() limit 0, 5;



-- question 4 : select count avg min max  and std deviation on a column 
--   UNIVARATE ANALYSIS:   when analysis is done on single column only no
--   other taken in consisedration when numerical no group by when categorical
--   use group by
desc supermarket;
select * from supermarket;
select count(*) as count , min(`gross income` ) as min ,max(`gross income`) as max, avg(`gross income`) as avg_start ,std(`gross income`) as std from supermarket;
select count(`gross income`) as count , min(`gross income` ) as min ,max(`gross income`) as max, avg(`gross income`) as avg_start ,std(`gross income`) as std from supermarket;

-- question5  : number of missing values
select * from supermarket;
select count(*) as missing from supermarket where Branch is null;

-- question6  : number of occurenecs of each city
select * from supermarket;
select count(City) as occurenec from supermarket group by City ;
select City, count(City) as occurenece from supermarket group by City ;


-- question7: most frequently used payment menthod
select * from supermarket;
select Payment, count(*) as payment_method_count from supermarket group by Payment order by payment_method_count desc;
select Payment, count(*) as payment_method_count from supermarket group by Payment order by payment_method_count desc limit 1;


-- question 8: does cost of goods sold affect rating that customer provide;
-- it is a bivarate analysis two columns in consideraion; both numerical
select * from supermarket;
select Rating,cogs from supermarket;
desc supermarket;


-- question 9: most profitable branch as per gross income;
-- it is a bivarate analysis two columns in consideraion; both numerical
select * from supermarket;
select Branch,sum(`gross income`)as gross from supermarket group by branch order by gross desc;
select Branch,round(sum(`gross income`),0)as gross from supermarket group by branch order by gross desc;

desc supermarket;

-- question10: most used payment methiod city wise
select * from supermarket;
select City,Payment, count(*) as used from supermarket group by City,Payment order by used desc;
-- select City,Payment, count(`Credit card`) as c_used ,count(Ewallet) as e_used ,count(Cash)as cash_used from supermarket 
-- group by City,Payment ;

-- select City,
-- sum(case when Payment="Cash" then 1 else 0 end)as cash,
-- sum(case when Payment="Credit card" then 1 else 0 end)as credit_card,
-- sum(case when Payment="Ewallet" then 1 else 0 end)as e_wallet
-- from supermarket
-- group by City


select City,
sum(case when Payment="Cash" then 1 else 0 end)as cash,
sum(case when Payment="Credit card" then 1 else 0 end)as credit_card,
sum(case when Payment="Ewallet" then 1 else 0 end)as e_wallet
from supermarket
group by City ;

-- question 11: find the product line purchased in highest quantity

select * from supermarket;
select `Product line` ,sum(Quantity) as highest from supermarket group by `Product line` order by highest;
select `Product line` ,sum(Quantity) as highest from supermarket group by `Product line` order by highest desc;

-- question12 display daily sales by the day of week
select * from supermarket;
-- select dayname(date) as dayname,dayofweek(date) as dayofweek,sum(Total)as total from supermarket group by dayname,dayofweek;
set sql_safe_updates=0;
update supermarket set date=str_to_date(Date,"%m/%d/%Y");
select dayname(date) as dayname,dayofweek(date) as dayofweek,sum(Total)as total from supermarket group by dayname,dayofweek;
select dayname(date) as dayname,dayofweek(date) as dayofweek,sum(Total)as total from supermarket group by dayname,dayofweek order by 
total desc ;


-- question 14: Month with highest Sales
select * from supermarket;
select monthname(date)as month_name ,month(date)as month, sum(Total)as total from supermarket group by month_name ,month 
order by total desc;



-- question 13: time at which highest Sales
select * from supermarket;
select hour(time)as hour ,sum(Total)as total from supermarket group by hour 
order by total desc;
-- select time, hour(time)as hour ,sum(Total)as total from supermarket group by time, hour 
-- order by total desc;


-- question 14: which geneder spends more on average
select * from supermarket;
desc supermarket;
select Gender, avg(`gross income`)as gross from supermarket group by Gender;
select Gender, avg(`gross income`)as gross from supermarket group by Gender order by gross desc;




