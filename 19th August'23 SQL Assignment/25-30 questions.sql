
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(30),
    product_category VARCHAR(25));

INSERT INTO Products (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions', 'Book'),
    (2, 'Jewels of Stringology', 'Book'),
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
    
#Q26.Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
#   and their amount.

select product_name, sum(o.unit) as unit
from Products as p join Orders as o
on p.product_id=o.product_id
where order_date between '2020-02-01' and '2020-02-28'
group by p.product_name
having sum(o.unit)>=100;

#--------------------------------------------------------------------------------------------------------


CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    `name` VARCHAR(25),
    mail VARCHAR(100));

INSERT INTO Users (user_id, `name`, mail)
VALUES
    (1, 'Winston', 'winston@leetcode.com'),
    (2, 'Jonathan', 'jonathanisgreat'),
    (3, 'Annabelle', 'bella-@leetcode.com'),
    (4, 'Sally', 'sally.come@leetcode.com'),
    (5, 'Marwan', 'quarz#2020@leetcode.com'),
    (6, 'David', 'david69@gmail.com'),
    (7, 'Shapiro', '.shapo@leetcode.com');
    
/*Q27.Write an SQL query to find the users who have valid emails.
A valid e-mail has a prefix name and a domain where:
● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
'_', period '.', and/or dash '-'. The prefix name must start with a letter.
● The domain is '@leetcode.com'.*/

select * from Users;

SELECT user_id, mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';

#---------------------------------------------------------------------------------------------------------


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    `name` VARCHAR(25),
    country VARCHAR(25));

INSERT INTO Customers (customer_id, `name`, country)
VALUES(1, 'Winston', 'USA'),
    (2, 'Jonathan', 'Peru'),
    (3, 'Moustafa', 'Egypt');
    
CREATE TABLE Products1 (
    product_id INT PRIMARY KEY,
    `description` VARCHAR(25),
    price INT);

INSERT INTO Products1 (product_id, `description`, price)
VALUES(10, 'LC Phone', 300),
    (20, 'LC T-Shirt', 10),
    (30, 'LC Book', 45),
    (40, 'LC Keychain', 2);
    
CREATE TABLE Orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT);

INSERT INTO Orders1 (order_id, customer_id, product_id, order_date, quantity)
VALUES(1, 1, 10, '2020-06-10', 1),
    (2, 1, 20, '2020-07-01', 1),
    (3, 1, 30, '2020-07-08', 2),
    (4, 2, 10, '2020-06-15', 2),
    (5, 2, 40, '2020-07-01', 10),
    (6, 3, 20, '2020-06-24', 2),
    (7, 3, 30, '2020-06-25', 2),
    (9, 3, 30, '2020-05-08', 3);

select * from Orders1;
select * from Products1;
select * from Customers;

# Q28.Write an SQL query to report the customer_id and customer_name of customers who have spent at
#    least $100 in each month of June and July 2020.

select customer_id, name as customer_name
from( 
select customer_id, c.name as customer_name,
sum(case when  o.order_date between '2020-06-01' and '2020-06-30' then sum(p.price * o.quantity) end) as JuneSpend,
     sum(case when o.order_date between '2020-07-01' and '2020-07-31' then sum(p.price * o.quantity) end) as JulySpend
from Orders1
leFt join Customers as c on o.customer_id=c.customer_id
leFt join Products1 as p on o.product_id=p.product_id
group by o.customer_id
having JuneSpend >= 100 and JulySpend >= 100
) as final_table;

#--------------------------------------------------------------------------------------------------


CREATE TABLE Content (
    content_id INT PRIMARY KEY,
    title VARCHAR(50),
    Kids_content ENUM('Y', 'N'),
    content_type VARCHAR(25)
);

INSERT INTO Content (content_id, title, Kids_content, content_type)
VALUES
    (1, 'Leetcode Movie', 'N', 'Movies'),
    (2, 'Alg. for Kids', 'Y', 'Series'),
    (3, 'Database Sols', 'N', 'Series'),
    (4, 'Aladdin', 'Y', 'Movies'),
    (5, 'Cinderella', 'Y', 'Movies');
    
    CREATE TABLE TVProgram (
    program_date DATE,
    content_id INT,
    `channel` VARCHAR(50),
    PRIMARY KEY (program_date, content_id)
);

INSERT INTO TVProgram (program_date, content_id, channel)
VALUES
    ('2020-06-10 08:00', 1, 'LC-Channel'),
    ('2020-05-11 12:00', 2, 'LC-Channel'),
    ('2020-05-12 12:00', 3, 'LC-Channel'),
    ('2020-05-13 14:00', 4, 'Disney Ch'),
    ('2020-06-18 14:00', 4, 'Disney Ch'),
    ('2020-07-15 16:00', 5, 'Disney Ch');
    
    select * from Content;
    select * from TVProgram;
    
# Q29.Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
select distinct title
from Content c, TVProgram tv
where c.content_id = tv.content_id
        and Kids_content = 'Y'
        and content_type = 'Movies'
        and program_date between '2020-06-01' and '2020-06-30';


#----------------------------------------------------------------------------------------------------

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

#Q30.Write an SQL query to find the npv of each query of the Queries table.

select n.id, n.year, ifnull(n.npv,0) as npv
from NPV as n right join Queries as q 
on n.id=q.id and n.year=q.year;

