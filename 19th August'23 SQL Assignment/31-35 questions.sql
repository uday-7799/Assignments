
CREATE TABLE NPV (
    id INT,
    `year` INT,
    npv INT,
    PRIMARY KEY (id, `year`));

INSERT INTO NPV (id, `year`, npv)
VALUES
    (1, 2018, 100),
    (7, 2020, 30),
    (13, 2019, 40),
    (1, 2019, 113),
    (2, 2008, 121),
    (3, 2009, 12),
    (11, 2020, 99),
    (7, 2019, 0);

CREATE TABLE Queries (
    id INT,
    `year` INT,
    PRIMARY KEY (id, `year`));

INSERT INTO Queries (id, `year`)
VALUES
    (1, 2019),
    (2, 2008),
    (3, 2009),
    (7, 2018),
    (7, 2019),
    (7, 2020),
    (13, 2019);
    
select * from NPV;
select * from Queries;

#Q31.Write an SQL query to find the npv of each query of the Queries table.

select n.id, n.year, ifnull(n.npv,0) as npv
from NPV as n right join Queries as q 
on n.id=q.id and n.year=q.year;

#---------------------------------------------------------------------------------------------------------------


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
VALUES
    (3, 1),
    (11, 2),
    (90, 3);
    
    select * from Employees;
    select * from EmployeeUNI;
    
#Q32.Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
#   show null.
select unique_id, name from
EmployeeUNI as eu right join Employees as e 
on eu.id=e.id
order by e.name;

#---------------------------------------------------------------------------------------------------------------

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
    
select * from Users;
select * from Rides;
    
#Q33.Write an SQL query to report the distance travelled by each user.
#    Return the result table ordered by travelled_distance in descending order, if two or more users
#    travelled the same distance, order them by their name in ascending order.

select u.`name`, 
ifnull(sum(r.distance), 0)as travelled_distance
from users u left join rides r
on u.id = r.user_id
group by u.`name`
order by travelled_distance desc, `name` asc;

#--------------------------------------------------------------------------------------------------------------


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_category VARCHAR(255));

INSERT INTO Products (product_id, product_name, product_category)
VALUES(1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Laptop'),
    (4, 'Lenovo Laptop', 'Laptop'),
    (5, 'Leetcode Kit ', 'T-shirt');

CREATE TABLE Orders (
    product_id INT,
    order_date DATE,
    unit INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id));
    
INSERT INTO Orders (product_id, order_date, unit)
VALUES
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);
    
select * from Products;
select * from Orders;
    
/*Q34.Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.*/

select product_name ,sum(o.unit) as unit
from Products as p join Orders as o
on p.product_id=o.product_id
where o.order_date between '2020-02-01' and '2020-02-29'
group by product_name
having sum(o.unit)>=100;

#------------------------------------------------------------------------------------------------------------------


CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(25));

INSERT INTO Movies (movie_id, title)
VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    `name` VARCHAR(25));

INSERT INTO Users (user_id, `name`)
VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');
    
CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE,
    PRIMARY KEY (movie_id, user_id));

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');
    
/*Q35.Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie,
return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return
the lexicographically smaller movie name.*/

(select u.`name` as results from 
users u, MovieRating m
where u.user_id=m.user_id
group by u.`name`
having count(m.user_id)=(
     select max(rating_count)
	 from(
          select count(m.user_id) as rating_count
           from MovieRating m
           group by m.user_id
          ) as max_rating
)
order by u.`name`
limit 1)

union

(select m.title as results from 
movies m, MovieRating mr
where m.movie_id=mr.movie_id
and mr.created_at between '2020-02-01' and '2020-02-29'
group by mr.movie_id
having avg(mr.rating)=(
     select max(avg_rating)
	 from(
          select avg(mr.rating) as avg_rating
           from MovieRating mr
           group by mr.movie_id
          ) as avg_ratingtt
)
order by m.title
limit 1);

