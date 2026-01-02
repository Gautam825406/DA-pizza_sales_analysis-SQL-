# Pizza Hut Sales Analysis (SQL)

## Overview
This project analyzes Pizza Hut sales data using SQL to extract meaningful business insights.  
The objective is to understand customer ordering behavior, revenue patterns, product performance, and time-based sales trends using a real-world relational database.

The analysis is divided into **Basic, Intermediate, and Advanced SQL queries**, showcasing practical use of SQL for business analytics.

---

## Database Structure

The database represents a pizza ordering system and consists of four related tables.

### Orders
Stores order-level information.
- order_id
- order_date
- order_time

### Order_Details
Stores item-level details for each order.
- order_details_id
- order_id
- pizza_id
- quantity

### Pizzas
Stores pricing and size information.
- pizza_id
- pizza_type_id
- size
- price

### Pizza_Types
Stores descriptive information about pizzas.
- pizza_type_id
- name
- category
- ingredients

---

## Database Setup

```sql
CREATE DATABASE pizzahut;
USE pizzahut;

CREATE TABLE orders(
    order_id INT,
    order_date DATE,
    order_time TIME
);

CREATE TABLE order_details(
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL
);
The remaining tables (pizzas and pizza_types) were imported using CSV files.

Data Import (CSV Files)
orders.csv → orders

order_details.csv → order_details

pizzas.csv → pizzas

pizza_types.csv → pizza_types

Data was imported using LOAD DATA INFILE to ensure efficient loading and consistency.

Analysis Performed
Basic Analysis
Total number of orders

Total revenue generated

Highest-priced pizza

Most commonly ordered pizza size

Top 5 most ordered pizza types

Intermediate Analysis
Total quantity ordered by pizza category

Order distribution by hour of the day

Category-wise pizza distribution

Average number of pizzas ordered per day

Top 3 pizza types based on revenue

Advanced Analysis
Percentage contribution of each pizza type to total revenue

Cumulative revenue generated over time

Top 3 revenue-generating pizzas within each category

Sample Queries
Total Revenue Generated
sql
Copy code
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p 
ON od.pizza_id = p.pizza_id;
Top 3 Pizza Types by Revenue
sql
Copy code
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
Key Insights
A small number of pizza types contribute a large share of total revenue.

Certain categories consistently outperform others in sales volume.

Orders peak during specific hours, indicating strong time-based customer behavior.

Revenue shows steady growth with identifiable high-demand periods.

SQL Concepts Used
INNER JOIN

Aggregate functions (SUM, COUNT, AVG)

GROUP BY and ORDER BY

Subqueries

Window functions (RANK, SUM OVER)

Common Table Expressions (CTEs)

Conclusion
This project demonstrates how SQL can be effectively used to analyze transactional business data and generate actionable insights.
The analysis supports data-driven decision-making in areas such as pricing strategy, inventory management, marketing planning, and operational optimization.

How to Run This Project
Create the database and tables

Import the CSV files

Execute the queries section by section

Analyze results and insights

Author
Gautam Keshri
Data Analyst | SQL | Data Science Enthusiast
