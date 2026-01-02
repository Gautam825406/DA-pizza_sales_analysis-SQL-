create database pizzahut;
use pizzahut;
create table orders(
order_id int, 
order_date date,
order_time time
);


create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null
);

-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders
FROM orders;


-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
	FROM order_details od
	JOIN pizzas p 
		ON od.pizza_id = p.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pt.name AS pizza_name,
    p.size,
    p.price
FROM pizzas p
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    p.size,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name AS pizza_type,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;



-- Intermediate:
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day.
SELECT 
    EXTRACT(HOUR FROM order_time) AS order_hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pt.category,
    SUM(od.quantity) AS total_pizzas_ordered
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_pizzas_ordered DESC;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(daily_total), 2) AS avg_pizzas_per_day
FROM (
    SELECT 
        o.order_date,
        SUM(od.quantity) AS daily_total
    FROM orders o
    JOIN order_details od 
        ON o.order_id = od.order_id
    GROUP BY o.order_date
) daily_orders;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


-- Advanced:
-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.name AS pizza_type,
    ROUND(
        (SUM(od.quantity * p.price) 
        / SUM(SUM(od.quantity * p.price)) OVER ()) * 100, 
        2
    ) AS revenue_percentage
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue_percentage DESC;

-- Analyze the cumulative revenue generated over time.
WITH daily_revenue AS (
    SELECT 
        o.order_date,
        SUM(od.quantity * p.price) AS revenue
    FROM orders o
    JOIN order_details od 
        ON o.order_id = od.order_id
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    GROUP BY o.order_date
)
SELECT 
    order_date,
    revenue,
    SUM(revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM daily_revenue
ORDER BY order_date;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
WITH category_revenue AS (
    SELECT 
        pt.category,
        pt.name AS pizza_type,
        SUM(od.quantity * p.price) AS total_revenue
    FROM order_details od
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt 
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
),
ranked_pizzas AS (
    SELECT 
        *,
        RANK() OVER (
            PARTITION BY category 
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM category_revenue
)
SELECT 
    category,
    pizza_type,
    ROUND(total_revenue, 2) AS total_revenue
FROM ranked_pizzas
WHERE revenue_rank <= 3
ORDER BY category, revenue_rank;
