

create table product(
product_id int primary key,
product_name varchar(25),
unit_price int);

insert into product(product_id, product_name, unit_price)
values(1, 'S8', 1000),(2, 'G4', 800),(3, 'iPhone', 1400);

select * from product;

create table sales(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
foreign key(product_id) references product(product_id));

insert into sales(seller_id, product_id, buyer_id, sale_date, quantity, price)
values(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);

select * from sales;
desc sales;


#Q17.Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
#   between 2019-01-01 and 2019-03-31 inclusive.
select product_name, product_id
from product 
where product_id not in (select product_id
      from sales 
      where sale_date not between '2019-01-01' and '2019-03-31');



#---------------------------------------------------------------------------------------------------------





select * from article_views;

create table article_views(
article_id int,
author_id int,
viewer_id int,
view_date date
);
                                 
insert into article_views values (1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');


#Q18.Write an SQL query to find all the authors that viewed at least one of their own articles.
#    Return the result table sorted by id in ascending order.
select distinct author_id  from article_views 
where author_id=viewer_id
order by author_id;



#-------------------------------------------------------------------------------------------------------------



create table Delivery (
delivery_id int primary key,
customer_id int,
order_date date,
customer_pref_delivery_date date
);

insert into Delivery values (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');
    
select * from Delivery;

# Q19.If the customer's preferred delivery date is the same as the order date, then the order is called 
#immediately; otherwise, it is called scheduled.
#Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.

select round(avg(order_date=customer_pref_delivery_date) * 100,2) 
as immediate_orders
from Delivery;


#-----------------------------------------------------------------------------------------------------



create table Ads (
    ad_id INT,
    user_id INT,
    action enum('Clicked', 'Viewed', 'Ignored'),
    primary key (ad_id, user_id)
);

insert into Ads values (1, 1, 'Clicked'),
(2, 2, 'Clicked'),
(3, 3, 'Viewed'),
(5, 5, 'Ignored'),
(1, 7, 'Ignored'),
(2, 7, 'Viewed'),
(3, 5, 'Clicked'),
(1, 4, 'Viewed'),
(2, 11, 'Viewed'),
(1, 2, 'Clicked');

#Q20.Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
#Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
#tie.

select ad_id,
ifnull(round(avg(case when action="Clicked" then 1 
               when action="Viewed" then 0 end)*100,2),0)
as ctr
from Ads
group by ad_id
order by ctr desc, ad_id asc;