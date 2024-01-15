
create table employee(
employee_id int,
team_id int,
primary key(employee_id)
);

insert into employee values(1,8),(2,8),(3,8),(4,7),(5,9),(6,9);
select * from employee;

# Qn 21. Write an SQL query to find the team size of each of the employees.
#Return result table in any order.

select e.employee_id,
(select count(team_id) from Employee where e.team_id = team_id) 
as team_size
from Employee e;


#-------------------------------------------------------------------------------------------------



create table Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(25));

insert into Countries values(2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');


CREATE TABLE Weather (
    country_id INT,
    weather_state INT,
    day DATE,
    PRIMARY KEY (country_id, day));

INSERT INTO Weather VALUES(2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');
    
select * from Countries;
select * from Weather;

# Qn 22 Write an SQL query to find the type of weather in each country for November 2019.
#The type of weather is:
#● Cold if the average weather_state is less than or equal 15,
#● Hot if the average weather_state is greater than or equal to 25, and
#● Warm otherwise.
#Return result table in any order.

select country_name,
(case when avg (weather_state<=15) then "Cold"
      when avg(weather_state>=25) then "Hot"
      else "Warm"
      end) as weather_type
from Countries as c left join Weather as w
on c.country_id=w.country_id
where day between '2019-11-01' and '2019-11-30'
group by country_name;
      
      
#-------------------------------------------------------------------------------------------------




CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date)
);

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);

CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT);

INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);
    
    select * from Prices;
    select * from UnitsSold;
    
#Q23.Write an SQL query to find the average selling price for each product. average_price should be
#    rounded to 2 decimal places.

select p.product_id,
round(sum(p.price*us.units)/sum(us.units),2) as average_price
from Prices as p join UnitsSold as us
on p.product_id=us.product_id 
and us.purchase_date between p.start_date and p.end_date
group by us.product_id;

#--------------------------------------------------------------------------------------------------



CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    
select * from Activity;
#Q24.Write an SQL query to report the first login date for each player.
select player_id,
min(event_date) as first_login
from Activity
group by player_id;


#--------------------------------------------------------------------------------------------------------------

#Q25.Write an SQL query to report the device that is first logged in for each player.
select player_id,
min(device_id) as first_logged
from Activity
group by player_id;