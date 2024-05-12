create schema cars;
use cars;
select * from cars.car_dekho;
select * from car_dekho;

-- question1: all details
select * from car_dekho;

-- question1: total cars
select count(*) as total from car_dekho;

-- question1: total cars in 2023
select count(*)as total from car_dekho where year=2023;
select year,count(*) as total from car_dekho where year=2023 group by year;

-- question1: total cars in 2020 21 22
-- select count(*)as total from car_dekho where year=2020 and year=2021 and year=2022;
select year, count(*) as total from car_dekho where year between 2020 and 2022 group by year;
select year, count(*) as total from car_dekho where year in( 2020 ,2021, 2022) group by year;


-- question1: all cars by year
-- select count(*)as total from car_dekho where year=2020 and year=2021 and year=2022;
select year, count(*) as total from car_dekho  group by year;
select year, count(*) as total from car_dekho group by year;

-- question1: diesel cars in 2020
select * from car_dekho;
select year, count(*) as total from car_dekho where fuel='diesel' and year=2020;

-- question1: petrol cars in 2020
select * from car_dekho;
select year, count(*) as total from car_dekho where fuel='petrol' and year=2020;

-- question1:  cars in 2020 group by fuel
select year,fuel , count(*) as total from car_dekho where  year=2020 group by fuel;

-- question1:  cars group by fuel and year
select year,fuel , count(*) as total from car_dekho   group by fuel,year;


select * from car_dekho;
select year,
sum(case when fuel ='petrol' then 1 else 0 end)as petrol,
sum(case when fuel ='diesel' then 1 else 0 end)as diesel,
sum(case when fuel ='CNG' then 1 else 0 end)as CNG,
sum(case when fuel ='Electric' then 1 else 0 end)as electric
, count(*) as total
from car_dekho group by year;

-- question1:  at least more than 100 cars in a year
select year,count(*)as total from car_dekho group by year  having total>100 ;
select year,fuel , count(*) as total from car_dekho   group by fuel,year  having total>100;

select year,
sum(case when fuel ='petrol' then 1 else 0 end)as petrol,
sum(case when fuel ='diesel' then 1 else 0 end)as diesel,
sum(case when fuel ='CNG' then 1 else 0 end)as CNG,
sum(case when fuel ='Electric' then 1 else 0 end)as electric
, count(*) as total 
from car_dekho group by year having total>100;

-- question1: count from 2015 23
-- select count(*)as total from car_dekho where year=2020 and year=2021 and year=2022;
select year, count(*) as total from car_dekho where year between 2015 and 2023 group by year;
select  count(*) as total from car_dekho where year between 2015 and 2023;


-- question1: all cars 2015 ansd 2023
-- select count(*)as total from car_dekho where year=2020 and year=2021 and year=2022;
select * from car_dekho where year between 2015 and 2023 ;
select  count(*) as total from car_dekho where year between 2015 and 2023;

