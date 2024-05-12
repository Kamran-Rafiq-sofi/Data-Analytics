-- CREATE DATABASE INSURANCE;
-- drop database Insurance;

CREATE DATABASE INSURANCE_DB;
USE INSURANCE_DB;
-- question1 : Retrieve all patients details
select * from insurance;

-- question2: Average claim amount for patients in each region;
select * from insurance;
select avg(charges) from insurance;
select region, avg(charges) from insurance group by region;


-- question3: select max ,min ,avg bmi values ;
select * from insurance;
select avg(bmi) from insurance;
select max(bmi) as max_bmi,min(bmi)as min_bmi,avg(bmi)as avg_bmi  from insurance;
select region,max(bmi) as max_bmi,min(bmi)as min_bmi,avg(bmi)as avg_bmi  from insurance group by region;

-- question 4: select patientId,age and bmi  with bmi between 40 and 50
select * from insurance;
select age ,sex,bmi from insurance where bmi between 40 and 50 order by age;
desc insurance ;




-- question 5: Number of Smokers in Each Region
select * from insurance;
select count(*) as count_smokers from insurance where smoker='yes' ;
select region, count(*) as count_smokers from insurance where smoker='yes'group by region ;
desc insurance ;



-- question 5: Average claim of patients who are smokers
select * from insurance;
select avg(charges) as avg_amount from insurance where smoker='yes' ;
select region, avg(charges) as avg_amount from insurance where smoker='yes'group by region ;
select region, round(avg(charges),2) as avg_amount from insurance where smoker='yes'group by region ;
desc insurance ;

-- question 6: Average claim of patients who are smokers
select * from insurance;
select avg(charges) as avg_amount from insurance where smoker='yes' ;
select region, avg(charges) as avg_amount from insurance where smoker='yes'group by region ;
select region, round(avg(charges),2) as avg_amount from insurance where smoker='yes'group by region ;
desc insurance ;


-- question 7 : retieve all patienst who have a bmi greater than avg bmi of all who are smokers
select * from insurance;
select * from insurance where bmi>(select avg(bmi) from insurance where smoker='yes')and smoker='yes' ;


-- question 8: average claim in each age group
select * from insurance;
select
   case when age<18 then "under 18" 
   when age between 18 and 30 then "18-30" 
   when age between 31 and 50 then "31-50"
   else "over 50" end as age_group, avg(charges) as avg_charges from insurance group by age_group;
-- select * from insurance where bmi>(select avg(bmi) from insurance where smoker='yes')and smoker='yes' ;

-- question 9: Retrieve total claim of each patients along with avg claim across all patients
select * from insurance;
select age, sum(charges)over(partition by age) as total ,avg(charges) over()as avg_charges from insurance ;

-- question10 : Retireve top 3 patients with higest claim along with their claim and total claim for all patients

select * from insurance;
select * ,charges, sum(charges)over() as sum from insurance order by charges limit 3;
select * ,charges, sum(charges)over() as sum from insurance order by charges desc limit 3;
select * , sum(charges)over() as sum from insurance order by charges desc limit 3;
select charges, sum(charges)over() as sum from insurance order by charges desc limit 3;

select charges, sum(charges)over() as sum from insurance group by charges order by charges desc limit 3;


select *  from insurance order by charges limit 3;
select *  from insurance order by charges desc limit 3;

-- question 11: deatls of patients who have a claim > avg claim amount for their region 
select * from insurance where charges>(select  avg(charges)as avg_charges from insurance) order by region;
select * from insurance t1 where charges>(select  avg(charges)as avg_charges from insurance as t2 where t2.region=t1.region) order by region;
-- select * from insurance where charges>(select region,avg(charges) from insurance group by region) ;

select * from (select * ,avg(charges) over(partition by region)as avg_charges from insurance) as subquery where charges>avg_charges;

-- question12: deatls of all patienst and on rank based on charges
select * ,Rank()over (order by charges) from insurance; 
select * ,Rank()over (order by charges desc) from insurance; 


-- question13: deatls of all patienst along with their claim amount and  rank based on charges within their region
select * ,Rank()over (partition by region order by charges) from insurance; 
select * ,Rank()over ( partition by region order by charges desc) from insurance; 

-- question13: deatls of all patienst along with their claim amount and  rank based on charges within their region
select * ,Rank()over (partition by region order by charges) from insurance; 
select * ,dense_Rank()over ( partition by region order by charges desc) from insurance; 
