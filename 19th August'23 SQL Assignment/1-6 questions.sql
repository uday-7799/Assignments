

create table city(
id int,
name varchar(17),
countrycode varchar(3),
district varchar(20),
population int);

select * from city;
desc city;




#Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
select * from city where countrycode="USA" and population>100000;

#Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
select name from city where countrycode="USA" and population>120000;

#Q3. Query all columns (attributes) for every row in the CITY table.
select * from city;

#Q4. Query all columns for a city in CITY with the ID 1661.
select * from city where id=1661;

#Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from city where countrycode="JPN";

#Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select name from city where countrycode="JPN";
