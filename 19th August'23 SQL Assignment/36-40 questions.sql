
CREATE TABLE Users (
    id INT PRIMARY KEY,
    `name` VARCHAR(25));

INSERT INTO Users (id, `name`)
VALUES(1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');

CREATE TABLE Rides (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT);

INSERT INTO Rides (id, user_id, distance)
VALUES(1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);

select * from users;
select * from rides;

#    Q36.Write an SQL query to report the distance travelled by each user.
#    Return the result table ordered by travelled_distance in descending order, if two or more users
#    travelled the same distance, order them by their name in ascending order.

select u.`name`, ifnull(sum(r.distance), 0) as travelled_distance
from users as u left join rides as r
on u.id=r.user_id
group by u.`name`
order by travelled_distance desc, name asc;

#-------------------------------------------------------------------------------------------------


CREATE TABLE Employees (
    id INT PRIMARY KEY,
    `name` VARCHAR(25));

INSERT INTO Employees (id, `name`)
VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');

CREATE TABLE EmployeeUNI (
    id INT PRIMARY KEY,
    unique_id INT);

INSERT INTO EmployeeUNI (id, unique_id)
VALUES(3, 1),
    (11, 2),
    (90, 3);
    
select * from Employees;
select * from EmployeeUNI;

#Q37.Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
#   show null.
select eu.unique_id, e.`name`
from EmployeeUNI as eu left join Employees as e
on eu.id=e.id
order by e.`name`;

#-------------------------------------------------------------------------------------------------------------


CREATE TABLE Departments (
    id INT PRIMARY KEY,
    `name` VARCHAR(100));

INSERT INTO Departments (id, `name`)
VALUES
    (1, 'Electrical Engineering'),
    (7, 'Computer Engineering'),
    (13, 'Business Administration');

CREATE TABLE Students (
    id INT PRIMARY KEY,
    `name` VARCHAR(50),
    department_id INT);

INSERT INTO Students (id, `name`, department_id)
VALUES(23, 'Alice', 1),
    (1, 'Bob', 7),
    (5, 'Jennifer', 13),
    (2, 'John', 14),
    (4, 'Jasmine', 77),
    (3, 'Steve', 74),
    (6, 'Luis', 1),
    (8, 'Jonathan', 7),
    (7, 'Daiana', 33),
    (11, 'Madelynn', 1);
    
select * from Departments;
select * from Students;


/*Q38. The table has information about the id of each student at a university and the id of the department
he/she studies at.
Write an SQL query to find the id and the name of all students who are enrolled in departments that no
longer exist.*/
select s.id, s.`name`
from Students as s left join Departments as d
on s.department_id=d.id
where d.id is null;

#---------------------------------------------------------------------------------------------------------------

CREATE TABLE Calls (
    from_id INT,
    to_id INT,
    duration INT);

INSERT INTO Calls (from_id, to_id, duration)
VALUES(1, 2, 59),
    (2, 1, 11),
    (1, 3, 20),
    (3, 4, 100),
    (3, 4, 200),
    (3, 4, 200),
    (4, 3, 499);
    
select * from calls;

/*Q39.Write an SQL query to report the number of calls and the total call duration between each pair of
distinct persons (person1, person2) where person1 < person2.*/
select least(from_id,to_id) as person1,
       greatest(from_id,to_id) as person2,
       count(duration) as call_count,
       sum(duration) as callduration
	from calls
    group by person1, person2;
    
#-------------------------------------------------------------------------------------------------------

CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date));

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES(1, '2019-02-17', '2019-02-28', 5),
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

#    Q40.Write an SQL query to find the average selling price for each product. average_price should be
#    rounded to 2 decimal places.

select p.product_id, 
round(sum(p.price*us.units)/sum(us.units), 2) as average_price
from prices as p, unitsSold as us
where us.purchase_date between p.start_date and p.end_date
and p.product_id=us.product_id
group by p.product_id;


