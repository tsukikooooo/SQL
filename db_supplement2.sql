create database db_supplement;

use db_supplement;

create table products(
	id int,
    brand varchar(50),
    product varchar(50)
);

insert into products(id, brand, product) values (1, 'NOW Foods', 'Selenium');
insert into products(id, brand, product) values (2, 'NOW Foods', 'Apple Pectin');
insert into products(id, brand, product) values (3, 'NOW Foods', 'Green tea Extract');
insert into products(id, brand, product) values (4, 'NOW Foods', 'L-Arginine');
insert into products(id, brand, product) values (5, 'Doctors Best', 'Curcumin');
insert into products(id, brand, product) values (6, 'Life Extension', 'Bromelain');
insert into products(id, brand, product) values (7, 'Life Extension', 'N-Acetyl-L-Cysteine');
insert into products(id, brand, product) values (8, 'Life Extension', 'Selenium');
insert into products(id, brand, product) values (9, 'Doctors Best', 'Green tea Extract');
insert into products(id, brand, product) values (10, 'Econugenics', 'Apple pectin');

select * from products;
select * from products where brand = 'Life Extension';
select * from products where brand = 'Doctors Best' or brand =  'NOW Foods';  
select * from products where brand = 'Doctors Best' and brand =  'NOW Foods';  -- None
select * from products where brand = 'NOW Foods';

select * from products order by id;
select * from products order by product;
select * from products order by product desc;

select * from products WHERE brand = 'NOW Foods' AND product = 'Apple Pectin';


use db_supplement;
select * from product_prices;
create table product_prices(
	product_id int,
    price numeric(10,2),
	currency ENUM('HKD')
);


insert into product_prices(product_id, price, currency) values(1, 50.5,'HKD');
insert into product_prices(product_id, price, currency) values(2, 267,'HKD');
insert into product_prices(product_id, price, currency) values(3, 799,'HKD');
insert into product_prices(product_id, price, currency) values(4, 2080,'HKD');
insert into product_prices(product_id, price, currency) values(5, 99,'HKD');
insert into product_prices(product_id, price, currency) values(6, 7.99,'HKD');
insert into product_prices(product_id, price, currency) values(7, 20.39,'HKD');
insert into product_prices(product_id, price, currency) values(8, 89, 'HKD');
insert into product_prices(product_id, price, currency) values(9, 979,'HKD');
insert into product_prices(product_id, price, currency) values(10, 10.78,'HKD');

create table sales(
	sale_no int,
    customer_name varchar(50),
    product_number int,
	qty int,
    total_amount numeric(10,2)
);

insert into sales(sale_no, customer_name, product_number, qty, total_amount) values (1, 'May Chan', 5, 2, 198);
insert into sales(sale_no, customer_name, product_number, qty, total_amount) values (2, 'Pearl Cheung', 7, 3, 61.17);
insert into sales(sale_no, customer_name, product_number, qty, total_amount) values (3, 'May Chan', 2, 1, 267);
insert into sales(sale_no, customer_name, product_number, qty, total_amount) values (4, 'Vinny Kwan', 8, 4, 356);
insert into sales(sale_no, customer_name, product_number, qty, total_amount) values (5, 'Pearl Cheung', 4, 1, 2080);

select * from sales;
select * from product_prices;
select * from sales where customer_name like '%May Chan%' or customer_name like '%Pearl Cheung%';

select s.customer_name, sum(s.total_amount) from sales s group by s.customer_name ;
select  sum(s.qty) as total_qty from sales s;

SELECT s.customer_name, SUM(s.total_amount) as sum_amount
FROM sales s
WHERE s.customer_name LIKE '%May Chan%' OR s.customer_name LIKE '%Pearl Cheung%'  -- need to use OR
GROUP BY customer_name
HAVING SUM(s.total_amount) > 100 
ORDER BY sum(s.total_amount);  -- sum_amount also OK!

select * from sales;
alter table sales add column tran_date date;
update sales;


SELECT p.id as product_list_no, p.brand, p.product, pp.price, s.customer_name, s.qty, s.total_amount
FROM products p
JOIN product_prices pp ON p.id = pp.product_id
JOIN sales s ON p.id = s.product_number;

