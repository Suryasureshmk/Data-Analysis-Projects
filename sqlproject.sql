create database pizzahut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));

create table orders_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));

-- Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales
select 
round(sum(orders_details.quantity * pizzas.price),0) as total_sales 
from orders_details join pizzas
on orders_details.pizza_id = pizzas.pizza_id;

-- identify the highest prized pizza.
select
pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- identify the most common pizza size orderd.
select
pizzas.size,count(orders_details.order_details_id) as order_count
from pizzas join orders_details
on pizzas.pizza_id=orders_details.pizza_id
group by pizzas.size order by order_count desc;

-- list the top 5 most orderd pizza types along with their quantities
select pizza_types.name,
sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5; 

-- join the necessary tables to find the total quantity of each pizza category orderd. 
select pizza_types.category,
sum(orders_details.quantity) as quantity 
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by quantity desc;

