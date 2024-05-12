create database if not exists covid ;
use covid;


-- all details from data
select * from covid;

-- show likelihood of a of death in infected where location is canada
select * from covid;
select location,sum(dead) as dead,sum(infected) as infected, ((Sum(dead)/sum(infected))*100) as death_ratio from covid
where location like "%canada%"  group by location order by death_ratio desc ;

select location,sum(dead) as dead,sum(infected) as infected, ((Sum(dead)/sum(infected))*100) as death_ratio from covid
 group by location order by death_ratio desc ;
 
 
 
 -- show likelihood of a of death in vaccinated where location is canada
select * from covid;
select location,sum(dead) as dead,sum(vaccinated) as vaccinated, ((Sum(dead)/sum(vaccinated))*100) as death_ratio from covid
where location like "%canada%"  group by location order by death_ratio desc ;

select location,sum(dead) as dead,sum(vaccinated) as vaccinated, ((Sum(dead)/sum(vaccinated))*100) as death_ratio from covid
 group by location order by death_ratio desc ;
 
 
  -- show likelihood of a of infected in vaccinated where location is canada
select * from covid;
select location,sum(infected) as infected ,sum(vaccinated) as vaccinated, ((Sum(infected)/sum(vaccinated))*100) as death_ratio from covid
where location like "%canada%"  group by location order by death_ratio desc ;

select location,sum(infected) as infected,sum(vaccinated) as vaccinated, ((Sum(infected)/sum(vaccinated))*100) as death_ratio from covid
 group by location order by death_ratio desc;
 
 
   -- show country with highest death per population 
select * from covid;
-- select location,sum(infected) as infected ,sum(vaccinated) as vaccinated, ((Sum(infected)/sum(vaccinated))*100) as death_ratio from covid
-- where location like "%canada%"  group by location order by death_ratio desc ;

select location,population,sum(dead) as dead, ((Sum(dead)/population)*100) as death_ratio_country from covid
 group by location,population order by death_ratio_country desc;

-- select location,sum(infected) as infected,sum(vaccinated) as vaccinated, ((Sum(infected)/sum(vaccinated))*100) as death_ratio from covid
--  group by location order by death_ratio desc;