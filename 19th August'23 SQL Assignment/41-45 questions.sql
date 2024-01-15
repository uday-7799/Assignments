
CREATE TABLE Warehouse (
    `name` VARCHAR(25),
    product_id INT,
    units INT,
    PRIMARY KEY (`name`, product_id));

CREATE TABLE Productss (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(25),
    Width INT,
    `Length` INT,
    Height INT);

INSERT INTO Warehouse (`name`, product_id, units)
VALUES('LCHouse1', 1, 1),('LCHouse1', 2, 10),('LCHouse1', 3, 5),('LCHouse2', 1, 2),('LCHouse2', 2, 2),('LCHouse3', 4, 1);

INSERT INTO Productss (product_id, product_name, Width, `Length`, Height)
VALUES(1, 'LC-TV', 5, 50, 40),(2, 'LC-KeyChain', 5, 5, 5),(3, 'LC-Phone', 2, 10, 10), (4, 'LC-T-Shirt', 4, 10, 20);

select * from Warehouse;
select * from Productss;


#Q41. Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
#     warehouse.
select w.`name` as warehouse_name,
sum(width*length*height*w.units)
from productss as p join warehouse as w
on p.product_id=w.product_id
group by w.`name`;

#-----------------------------------------------------------------------------------------------------------------

CREATE TABLE Sales (
    sale_date DATE,
    fruit ENUM('apples', 'oranges'),
    sold_num INT,
    PRIMARY KEY (sale_date, fruit));

INSERT INTO Sales (sale_date, fruit, sold_num)
VALUES('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 8),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-03', 'oranges', 0),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 16);
    
#Q42.Write an SQL query to report the difference between the number of apples and oranges sold each day.
#    Return the result table ordered by sale_date.
SELECT sale_date, 
       SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE -sold_num END) AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;

#----------------------------------------------------------------------------------------------------------

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date));

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    
/*Q43.Write an SQL query to report the fraction of players that logged in again on the day after the day they
first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
that logged in for at least two consecutive days starting from their first login date, then divide that
number by the total number of players.*/


WITH CTE AS (
SELECT
player_id, min(event_date) as event_start_date
from
Activity
group by player_id )

SELECT
round((count(distinct c.player_id) / (select count(distinct player_id) from activity)),2)as fraction
FROM
CTE c
JOIN Activity a
on c.player_id = a.player_id
and datediff(c.event_start_date, a.event_date) = -1;

#--------------------------------------------------------------------------------------------------------


CREATE TABLE Employee (
    id INT PRIMARY KEY,
    `name` VARCHAR(25),
    department VARCHAR(25),
    managerId INT);

INSERT INTO Employee (id, `name`, department, managerId)
VALUES(101, 'John', 'A', NULL),
    (102, 'Dan', 'A', 101),
    (103, 'James', 'A', 101),
    (104, 'Amy', 'A', 101),
    (105, 'Anne', 'A', 101),
    (106, 'Ron', 'B', 101);
    
    select * from employee;
    
#Q44.Write an SQL query to report the managers with at least five direct reports.
select name from employee where id in 
(select managerId from employee group by managerId
having (count(id)>=5));

#-----------------------------------------------------------------------------------------------------------

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(25));

INSERT INTO Department (dept_id, dept_name)
VALUES(1, 'Engineering'),
    (2, 'Science'),
    (3, 'Law');

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(25),
    gender VARCHAR(1),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id));

INSERT INTO Student (student_id, student_name, gender, dept_id)
VALUES(1, 'Jack', 'M', 1),
    (2, 'Jane', 'F', 1),
    (3, 'Mark', 'M', 2);
    
/*Q45.Write an SQL query to report the respective department name and number of students majoring in
each department for all departments in the Department table (even ones with no current students).
Return the result table ordered by student_number in descending order. In case of a tie, order them by
dept_name alphabetically.*/

select d.dept_name, count(s.dept_id) as student_number
from Department d left join Student s
on d.dept_id=s.dept_id
group by d.dept_id
order by student_number desc, dept_name;

