use sample1;

# QUESTION 1

create table candidates(
id int,
technology varchar(25)
);

insert into candidates values(1,"DS"),(1,"Tableau"),(1,"SQL"),(2,"R"),(2,"Power bi");
insert into candidates values(1,"Python");
select * from candidates;


# SELECT CANDIDATE HAVING ALL SKILLS

select id
from candidates
where technology in ('DS', 'Tableau', 'Python', 'SQL')
group by id
having count(distinct technology)=4;



#QUESTION 2

create table product_info(
product_id int primary key,
product_name varchar(35));

insert into product_info values(1001,"Blog"),
(1002,"Youtube"),
(1003,"Education");

select * from product_info;
desc product_info;


create table product_info_likes(
User_id int primary key,
product_id int,
Liked_date date,
foreign key(product_id) references product_info(product_id));

insert into product_info_likes values (1, 1001, '2023-08-19'),
(2, 1003, '2023-01-18');

select * from product_info_likes;
desc product_info_likes;

select product_id from product_info where product_id not in (select product_id from product_info_likes);