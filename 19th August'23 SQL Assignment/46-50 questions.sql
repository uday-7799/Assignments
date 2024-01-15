
CREATE TABLE Product (
    product_key INT PRIMARY KEY);

INSERT INTO Product (product_key)
VALUES(5),(6);

CREATE TABLE Customer (
    customer_id INT,
    product_key INT,
    FOREIGN KEY (product_key) REFERENCES Product (product_key));

INSERT INTO Customer (customer_id, product_key)
VALUES(1, 5),(2, 6),(3, 5),(3, 6),(1, 6);

select * from product;
select * from Customer;
    
#Q46.Write an SQL query to report the customer ids from the Customer table that bought all the products in
#    the Product table.
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product);

#-----------------------------------------------------------------------------------------------------

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    `name` VARCHAR(25),
    experience_years INT);

INSERT INTO Employee (employee_id, `name`, experience_years)
VALUES(1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);

CREATE TABLE Project (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (employee_id) REFERENCES Employee (employee_id));

INSERT INTO Project (project_id, employee_id)
VALUES(1, 1),(1, 2),(1, 3),(2, 1),(2, 4);

select * from Employee;
select * from Project;

#Q47.Write an SQL query that reports the most experienced employees in each project. In case of a tie,
#    report all employees with the maximum number of experience years.
select project_id, employee_id
from Project
join Employee
using (employee_id)
where (project_id, experience_years) in (
    select project_id, max(experience_years)
    from Project
    join Employee
    using (employee_id)
    group by project_id);
    
#---------------------------------------------------------------------------------------------------------------

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    `name` VARCHAR(100),
    available_from DATE);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    dispatch_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id));

INSERT INTO Books (book_id, `name`, available_from) VALUES
(1, 'Kalila And Demna', '2010-01-01'),
(2, '28 Letters', '2012-05-12'),
(3, 'The Hobbit', '2019-06-10'),
(4, '13 Reasons Why', '2019-06-01'),
(5, 'The Hunger Games', '2008-09-21');


INSERT INTO Orders (order_id, book_id, quantity, dispatch_date) VALUES
(1, 1, 2, '2018-07-26'),
(2, 1, 1, '2018-11-05'),
(3, 3, 8, '2019-06-11'),
(4, 4, 6, '2019-06-05'),
(5, 4, 5, '2019-06-20'),
(6, 5, 9, '2009-02-02'),
(7, 5, 8, '2010-04-13');


#Q48.Write an SQL query that reports the books that have sold less than 10 copies in the last year,
#excluding books that have been available for less than one month from today. Assume today is
#2019-06-23.

select book_id, `name`
from books
left join orders using(book_id)
where available_from < '2019-05-23' 
group by book_id
having sum(if (dispatch_date >= '2018-06-23' , quantity, 0))<10;

#--------------------------------------------------------------------------------------------------------------


CREATE TABLE Enrollments (
    student_id int,
    course_id int,
    grade int,
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO Enrollments (student_id, course_id, grade) VALUES
(2, 2, 95),
(2, 3, 95),
(1, 1, 90),
(1, 2, 99),
(3, 1, 80),
(3, 2, 75),
(3, 3, 82);

#Q49.Write a SQL query to find the highest grade with its corresponding course for each student. In case of
#    a tie, you should find the course with the smallest course_id.
#     Return the result table ordered by student_id in ascending order.

select student_id, min(course_id) as course_id, grade
from Enrollments
where (student_id, grade) in 
    (select student_id, max(grade)
    from Enrollments
    group by student_id)
group by student_id
order by student_id asc;

#----------------------------------------------------------------------------------

CREATE TABLE Players (
    player_id INT PRIMARY KEY,
    group_id INT);

INSERT INTO Players (player_id, group_id)
VALUES
    (15, 1),
    (25, 1),
    (30, 1),
    (45, 1),
    (10, 2),
    (35, 2),
    (50, 2),
    (20, 3),
    (40, 3);


CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT);

INSERT INTO Matches (match_id, first_player, second_player, first_score, second_score)
VALUES
    (1, 15, 45, 3, 0),
    (2, 30, 25, 1, 2),
    (3, 30, 15, 2, 0),
    (4, 40, 20, 5, 2),
    (5, 35, 50, 1, 1);
    
/*Each row is a record of a match, first_player and second_player contain the player_id of each match.
first_score and second_score contain the number of points of the first_player and second_player respectively.
You may assume that, in each match, players belongs to the same group.
The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.

Write an SQL query to find the winner in each group.*/


select group_id,player_id from 
(select group_id,player_id,sum(
    case when player_id = first_player then first_score
         when player_id = second_player then second_score
         end
) as totalScores
from Players p,Matches m
where p.player_id = m.first_player
or p.player_id = m.second_player
group by group_id,player_id
order by group_id,totalScores desc,player_id) as temp
group by group_id
order by group_id,totalScores desc,player_id;


