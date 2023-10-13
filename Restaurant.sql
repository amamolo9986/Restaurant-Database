-- create database

create database restaurant;

-- customer table details

create table `customers` (
  `customer_id` int not null,
  `customer_name` varchar(100) null,
  `customer_phone_number` varchar(12) null,
  PRIMARY KEY (`customer_id`)
  );
  
insert into customers (customer_id, customer_name, customer_phone_number)
values (1, 'Trevor Page', '226-555-4982');
insert into customers (customer_id, customer_name, customer_phone_number)
values (2, 'John Doe', '555-555-9498');

select * from customers;

-- customer order join table details

 create table `customer_order`(
	`customer_id` int not null, 
    `order_number` int not null,
    foreign key (customer_id) references customers (customer_id),
    foreign key (order_number) references orders (order_number)
 );
 
insert into customer_order (customer_id, order_number) 
value (1, 1);
insert into customer_order (customer_id, order_number)
value (2, 2);
insert into customer_order (customer_id, order_number)
value (1, 3);

select * from customer_order;

-- order table details

create table `orders` (
  `order_number` int not null,
  `order_details` varchar(250) null,
  `order_date` datetime null,
  primary key (`order_number`)
  );
  
insert into orders (order_number, order_details, order_date)
values (1, '1x Pepperoni & Cheese Pizza, 1x Meat Lovers Pizza', '2014-09-10 09:47:00');
insert into orders (order_number, order_details, order_date)
values (2, '1x Vegetarian Pizza, 2x Meat Lovers Pizza', '2014-09-10 13:20:00');
insert into orders (order_number, order_details, order_date)
values (3, '1x Meat Lovers Pizza, 1x Hawaiian Pizza', '2014-09-10 09:47:00');

select * from orders;

-- order pizza join table details

 create table `order_pizza`(
	`order_number` int not null, 
    `pizza_id` int not null,
    foreign key (order_number) references orders (order_number),
    foreign key (pizza_id) references pizza (pizza_id)
 );
 
insert into order_pizza (order_number, pizza_id)
value (1, 1);
insert into order_pizza (order_number, pizza_id)
value (1, 3);
insert into order_pizza (order_number, pizza_id)
value (2, 2);
insert into order_pizza (order_number, pizza_id)
value (2, 3);
insert into order_pizza (order_number, pizza_id)
value (2, 3);
insert into order_pizza (order_number, pizza_id)
value (3, 3);
insert into order_pizza (order_number, pizza_id)
value (3, 4);

select * from order_pizza;

-- pizza table details

create table `pizza` (
  `pizza_id` int not null,
  `pizza` varchar(50) null,
  `price` decimal(4,2) null,
  primary key (`pizza_id`)
  );
  
insert into pizza (pizza_id, pizza, price)
values (1, 'Pepperoni and Cheese Pizza', 7.99);
insert into pizza (pizza_id, pizza, price)
values (2, 'Vegetarian Pizza', 9.99);
insert into pizza (pizza_id, pizza, price)
values (3, 'Meat Lovers Pizza', 14.99);
insert into pizza (pizza_id, pizza, price)
values (4, 'Hawaiian Pizza', 12.99);

select * from pizza;

-- fully joined

select * from customers
join customer_order on customers.customer_id = customer_order.customer_id
join orders on orders.order_number = customer_order.order_number
join order_pizza on order_pizza.order_number = customer_order.order_number
join pizza on pizza.pizza_id = order_pizza.pizza_id;

-- Q3 joined

select orders.order_number,
	   customers.customer_name,
       customers.customer_phone_number,
       orders.order_details as order_description,
       orders.order_date from orders
join customer_order on orders.order_number = customer_order.order_number
join customers on customer_order.customer_id = customers.customer_id;
    
-- Q4

select customers.customer_name, sum(pizza.price) as total_spending from customers 
join customer_order on customers.customer_id = customer_order.customer_id
join orders on customer_order.order_number = orders.order_number
join order_pizza on orders.order_number = order_pizza.order_number
join pizza on order_pizza.pizza_id = pizza.pizza_id
group by customers.customer_name, customers.customer_phone_number;

-- All tables must be joined to associate customer name (customers table)
-- with total spent on pizza (order_pizza & pizza tables). Only three tables 
-- needed, but to form these relationships we need to join all since tables
-- are on opposite ends

-- Q5

select customers.customer_name, 
	   orders.order_number,
	   orders.order_date, 
	   sum(pizza.price) as total_spending from customers 
join customer_order on customers.customer_id = customer_order.customer_id
left join orders on customer_order.order_number = orders.order_number
join order_pizza on orders.order_number = order_pizza.order_number
join pizza on order_pizza.pizza_id = pizza.pizza_id
group by customers.customer_name, orders.order_number, orders.order_date;

-- Had trouble with this one, i was able to add the date and time but i wasnt
-- able to separate sum by order versus sum by person. I realized that i wasnt 
-- adding the order number to the select and the group

-- I have a little bit of diffuculty when it comes to selecting multiple columns
-- before joining tables.

-- **Select** is where you specify the columns you want to work with
-- **Join** is where you connect the data from the select statement
-- **Group** is what puts all data in the same buckets, or organizes it by group









