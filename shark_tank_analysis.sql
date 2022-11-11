drop database if exists shark_tank;
create database shark_tank;
use shark_tank;

select * from shark_tank;
desc shark_tank;
alter table shark_tank rename column `ï»¿Ep_No` to Ep_No;

#finding total no. of episodes

select count(distinct Ep_No) as 'Total no. of episodes' from shark_tank;

#finding the total of pitches

select count(distinct brand) as 'Total No. of Pitches' from shark_tank;

#finding the total number of pitches converted

select count(distinct brand) as 'Total No. of Pitches Converted' from shark_tank
where deal not in ('No deal');

#finding total no. of male and female contestants and finding the gender ratio

select sum(male) as 'Total Males',sum(female) as 'Total Females', 
sum(female)/sum(male) as 'Gender Ratio' from shark_tank;

#total investment done
select sum(Amount_Invested_lakhs) as 'Total Amount Invested' from shark_tank;

#total sector wise investment done

select* from shark_tank;
select sector,count(brand) as 'Number of startups',
sum(Amount_Invested_lakhs) as 'Total Amount Invested' from shark_tank
group by sector
order by sum(Amount_Invested_lakhs) desc;

# total startups who pitched (group by place)

select * from shark_tank;
select location,count(brand) as 'Total no. of startups' from shark_tank
group by location
order by count(brand) desc;

#calculate startups based on sector

select sector,count(sector) as 'No. of startups' from shark_tank
group by sector
order by count(sector) desc;

#avg.equity asked and avg.equity taken

select * from shark_tank;
select round(avg(`Equity_Asked_%`),2) as 'Average Equity Asked by startup',
round(avg(`Equity_Taken_%`),2) as 'Average Equity Taken by sharks' from shark_tank;

# which startup had the highest deal taken in terms of amount invested

select * from shark_tank;
select brand, idea, Amount_Invested_lakhs as 'Total Amount Granted(lakhs)'
from shark_tank where Amount_Invested_lakhs 
in (select max(Amount_Invested_lakhs) from shark_tank);

# for which startup highest equity was taken by sharks

select * from shark_tank;
select brand, idea, amount_asked_lakhs, amount_invested_lakhs, `Equity_Asked_%`,`Equity_Taken_%`
from shark_tank where `Equity_Taken_%` in (select max(`Equity_Taken_%`) from shark_tank);

#startups where women participants were present

select * from shark_tank;
select brand,idea, location,male,female from shark_tank 
where female>0;

#count the total no. of startups with women participants

select count(brand) as 'total number of startups' from shark_tank
where female>0;

#pitches converted having atleast 1 woman in team

select * from shark_tank;
select count(deal) as 'No. of startups' from shark_tank
where deal!='No deal' and female>0;

#find average team members (group by sector)

select sector,avg(team_members) from shark_tank
group by sector;

#find average age group of participants

select * from shark_tank;
select avg_age,count(avg_age) as 'no. of startups' from shark_tank
group by avg_age
order by count(avg_age) desc;

#average amount invested per deal(sector wise)
select sector,avg(amount_invested_lakhs) as 'amount invested per deal'from shark_tank
where deal !='no deal'
group by sector
order by avg(amount_invested_lakhs) desc;

#partner deals

select* from shark_tank;
select partners, count(partners) as 'Total deals' from shark_tank
where partners not like 'null'
group by partners
order by count(partners) desc;

select
brand,
sum(partners='Ash') ashneer,
sum(partners='Nam') Namita
from shark_tank
group by brand;

#creating a matrix for deals made by Ashneer

select * from shark_tank;
select 'Ashneer'as keyy,
count(ashneer_amount_invested) as 'No. of startups where invested',
round(sum(ashneer_amount_invested),2) as'total amount invested',round(avg(`Ashneer_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where ashneer_amount_invested!=0
union
select 'Anupam'as keyy,
count(Anupam_amount_invested) as 'No. of startups where invested',
round(sum(Anupam_amount_invested),2) as'total amount invested',round(avg(`Anupam_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where Anupam_amount_invested!=0
union
select 'Aman'as keyy,
count(Aman_amount_invested) as 'No. of startups where invested',
round(sum(Aman_amount_invested),2) as'total amount invested',round(avg(`Aman_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where Aman_amount_invested!=0
union
select 'Peyush'as keyy,
count(Peyush_amount_invested) as 'No. of startups where invested',
round(sum(Peyush_amount_invested),2) as'total amount invested',round(avg(`Peyush_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where Peyush_amount_invested!=0
union
select 'Ghazal'as keyy,
count(Ghazal_amount_invested) as 'No. of startups where invested',
round(sum(Ghazal_amount_invested),2) as'total amount invested',round(avg(`Ghazal_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where Ghazal_amount_invested!=0
union
select 'Vineeta'as keyy,
count(Vineeta_amount_invested) as 'No. of startups where invested',
round(sum(Vineeta_amount_invested),2) as'total amount invested',round(avg(`Vineeta_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where Vineeta_amount_invested!=0
union
select 'Namita'as keyy,
count(Namita_amount_invested) as 'No. of startups where invested',
round(sum(Namita_amount_invested),2) as'total amount invested',round(avg(`Namita_Equity_Taken_%`),2) as 'avg. equity taken'
from shark_tank
where Namita_amount_invested!=0;

#for which startup, highest investment was made in each sector

select* from shark_tank;
select a.* from(select brand, sector,amount_invested_lakhs,rank() over(partition by sector order by amount_invested_lakhs desc) as ranks
from shark_tank)a
where a.ranks in (1)
order by amount_invested_lakhs desc;

