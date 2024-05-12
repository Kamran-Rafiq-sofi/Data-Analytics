create database titanic;
use  titanic;
-- select * from titanic;
-- drop table titanic;
select * from titanic;


-- Question1 ...first 10 rows of a dataset;
select * from titanic;
select * from titanic limit 10;

-- number of passengers who survived
select * from titanic;
select count(*) from titanic where Survived=1;

select PassengerId,Survived,count(*)as count from titanic where Survived=1 group by PassengerId;


-- Average age of all passenger
select * from titanic;
select Avg(Age) as AvgAge from titanic;
select PassengerId, Avg(Age) as AvgAge from titanic group by PassengerId;
select Pclass, Avg(Age) as AvgAge from titanic group by Pclass;


-- First 10 rows sorted by Pclass in desc;
select * from titanic;
select * from titanic order by Pclass desc limit 10;
select * from titanic order by Pclass limit 10;



-- number of passengers in each class
select * from titanic;
select Pclass ,Count(*) as Count from titanic group by Pclass order by Pclass;

-- average fair paid by each class
select * from titanic;
select Pclass,Avg(Fare) from titanic group by Pclass;

-- name of passenger with hihest fare;
select * from titanic;
select max(Fare) from titanic;

select * from titanic where fare=(select max(Fare) from titanic);
select Name ,Fare from titanic where fare=(select max(Fare) from titanic);


-- Number and name of passenger with higest age

select * from titanic;
select max(Age) from titanic;
select * from titanic where age=(select max(Age) from titanic);
select Name,Age from titanic where age=(select max(Age) from titanic);

-- Number and name of passenger with higest age and survived

select * from titanic;
select max(Age) from titanic;
select * from titanic where age=(select max(Age) from titanic where survived =1);
select Name,Age from titanic where age=(select max(Age) from titanic where survived =1);


-- numvber of passengers who paid more than avg fare;
select * from titanic;
select Avg(Fare) from titanic; 

select Avg(Fare) from titanic where survived=1; 
select * from titanic where Fare>(select Avg(Fare) from titanic);
select * from titanic where Fare>(select Avg(Fare) from titanic where survived=1) ;
select * from titanic where Fare>(select Avg(Fare) from titanic where survived=1) and survived=1;


-- Name of passenger no child or parent on board
select * from titanic;
select * from titanic where Parch =0;

-- Name of passenger most child or parent on board
select * from titanic;
select * from titanic where Parch =(select Max(Parch) from titanic);

-- number of male and female passengers who survived order by sex;
select * from titanic ;
select Sex,count(*) as count from titanic where survived=1 group by Sex order by Sex;
-- select count(*) as count from titanic where Sex In(Select Sex From titanic where survived=1) group by Sex;

-- Name age ,fare of max age who survived
select * from titanic;
select * from titanic where Age=(Select Max(age) from titanic where Survived=1);
select Name,Age,Fare from titanic where Age=(Select Max(age) from titanic where Survived=1);

-- Name age,fare youngest female who survived in 3rd class
select * from titanic;
select Min(age) from titanic;
select Min(age) from titanic where Sex='female' and Survived=1 and Pclass=3;

select Name,Age,Fare from titanic where age=(select Min(Age) from titanic where Sex='female' and Survived=1 and Pclass=3) and Sex='female' and Survived=1 and Pclass=3;


-- find number of male and female passenger
Select Sex,count(*) from titanic group by Sex;
select 
count(case when Sex='male' then 1 else 0 End)as male,
count(case when Sex='female' then 1 else 0 End)as female
from titanic;

select 
sum(case when Sex='male' then 1 else 0 End)as male,
sum(case when Sex='female' then 1 else 0 End)as female
from titanic;


-- select 
-- sum(case when Sex='male' then Sex else 0 End)as male,
-- sum(case when Sex='female' then Sex else 0 End)as female
-- from titanic;


-- all passengers who travelled in a cabin not shared by any other
select * from titanic;
select cabin from titanic  group by cabin having count(*)>1;
select * from titanic where cabin Not in(select cabin from titanic  group by cabin having count(*)>1);
select * from titanic where cabin in(select cabin from titanic  group by cabin having count(*)=1);
-- select *,count(cabin) from titanic where count(cabin)=1 group by cabin;
-- select * ,count(cabin) as c from titanic where Parch=0 and SibSp=0 and c=1  ;