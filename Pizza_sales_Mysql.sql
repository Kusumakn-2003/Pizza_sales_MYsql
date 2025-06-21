create database pizza_sales;
use pizza_sales;

select count(price) as total  from pizzas;

create table orders( 
order_id int not null, 
order_date date not null,
order_time time not null,
primary key(order_id));



# 1 Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

# 2 Calculate the total revenue generated from pizza sales.
select round(sum(order_details.quantity * pizzas.price),2)as revenue
from order_details join pizzas
on pizzas.pizza_id =order_details.pizza_id

# 3 Identify the highest priced pizza

select pizza_types.name ,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
order by pizzas.price desc;

# 4 Identify the most common pizza size orderd
select count(order_details.quantity),pizzas.size
from order_details join pizzas on
order_details.pizza_id=pizzas.pizza_id
group by pizzas.size 
order by count(quantity) desc;

# 5 list the top 5 most ordered pizza and types along with their quantites 

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;


# 6 Total quantity of each pizza category
select pizza_types.category,sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by quantity desc;


# 7 Determine the distribution of orders by hour of the day
select hour(orders.time) as hour,count(order_id) as order_count from orders
group by hour(orders.time);

# 8 Join relevant tables to find the category wise distribution of pizza quantity
select pizza_types.category,sum(order_details.quantity) as quantity
from order_details join pizzas
on order_details.pizza_id =pizzas.pizza_id
join pizza_types
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
group by  pizza_types.category order by quantity desc;

# 9  Join relevant tables to find the category wise distribution of pizza
 select category,count(name ) as names from pizza_types
 group by category;
 
 # 10 group the orders by date and calculate the average number of pizzas
 # ordered per day
 
 select round(avg(quantity) ,0) as average_orders from
 (select sum(order_details.quantity) as quantity, orders.date 
 from order_details join orders
 on order_details.order_id= orders.order_id
 group by  orders.date) as order_quantity ; 
 
 
 # 11 Determine Top 3 ordered pizza types based on revenue
 select pizza_types.name,sum(pizzas.price*order_details.quantity) as revenue
 from pizza_types join pizzas
 on pizza_types.pizza_type_id=pizzas.pizza_type_id 
 join order_details
 on order_details.pizza_id=pizzas.pizza_id
 group by pizza_types.name order by revenue desc limit 3;
 
 
 # 12 calculate the percentage contiribution of each pizza type to
 # total revenue
 
 
 SELECT 
    pizza_types.category,
    ROUND(SUM(pizzas.price * order_details.quantity) * 100.0 / 
         (SELECT SUM(pizza.price * order_details.quantity)
          FROM pizzas AS pizza
          JOIN order_details ON pizza.pizza_id = order_details.pizza_id), 2) AS revenue
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;






 

 
 
























