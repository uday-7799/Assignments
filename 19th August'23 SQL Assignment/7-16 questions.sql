

create table station(
id int,
city varchar(21),
state varchar(2),
Lat_N int,
Long_W int);

select * from station;
select count(id) from station;


#Q7. Query a list of CITY and STATE from the STATION table.
select city, state from station;


#Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results
#in any order, but exclude duplicates from the answer.
select distinct city from station where id%2=0;


#Q9. Find the difference between the total number of CITY entries in the table and the number of
#    distinct CITY entries in the table.
select count(city) - count(distinct city) as difference from station;


#Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
#     respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
#     largest city, choose the one that comes first when ordered alphabetically.
(select city,length(city) as city_length from station
order by length(city), city
limit 1)
union
(select city,length(city) as city_length from station
order by length(city) desc, city
limit 1);


#Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
#     cannot contain duplicates.
select distinct city from station 
where substr(city,1,1) in ('a','e','i','o','u');


#Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
#     contain duplicates.
select distinct city from station
where substr(reverse(city),1,1) in ('a','e','i','o','u');


# Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
#      contain duplicates.
select distinct city from station
where substr(city,1,1) not in ('a','e','i','o','u');


#Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
#     contain duplicates.
select city from station 
where substr(reverse(city),1,1) not in ('a','e','i','o','u');


#Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
#     with vowels. Your result cannot contain duplicates.
select city from station 
where substr(city,1,1) not in ('a','e','i','o','u')
or substr(reverse(city),1,1) not in ('a','e','i','o','u');


#Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with
#     vowels. Your result cannot contain duplicates.
select distinct city from station 
where substr(city,1,1) not in ('a','e','i','o','u')
and substr(reverse(city),1,1) not in ('a','e','i','o','u');




