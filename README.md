# Pizza Hut Sales Analysis (SQL Project)

## Overview
This project analyzes Pizza Hut sales data using SQL to uncover meaningful business insights.  
The goal is to understand customer ordering behavior, revenue trends, product performance, and time-based sales patterns using real-world relational data.

The analysis is structured into **Basic, Intermediate, and Advanced SQL queries**, demonstrating strong command over joins, aggregations, subqueries, and window functions.

---

## Dataset Description
The database represents a typical pizza ordering system and consists of four related tables:

### 1. Orders
Stores order-level information.
- `order_id`
- `order_date`
- `order_time`

### 2. Order_Details
Stores item-level details for each order.
- `order_details_id`
- `order_id`
- `pizza_id`
- `quantity`

### 3. Pizzas
Contains pricing and size details for each pizza.
- `pizza_id`
- `pizza_type_id`
- `size`
- `price`

### 4. Pizza_Types
Stores descriptive information about pizzas.
- `pizza_type_id`
- `name`
- `category`
- `ingredients`

---

## Database Setup
```sql
CREATE DATABASE pizzahut;
USE pizzahut;
```
```Tables were created and populated using CSV files (orders.csv, order_details.csv, pizzas.csv, pizza_types.csv).

Analysis Performed
Basic Analysis
Total number of orders placed

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

Cumulative revenue over time

Top 3 revenue-generating pizzas within each category

Key Insights
Certain pizza categories consistently outperform others in both volume and revenue.

Order volume peaks during specific hours, indicating clear customer behavior patterns.

A small number of pizza types contribute a significant portion of total revenue.

Revenue growth over time shows steady business performance with identifiable peak periods.

SQL Concepts Used
INNER JOINs

Aggregate functions (SUM, COUNT, AVG)

GROUP BY and ORDER BY

Subqueries

Window functions (RANK(), SUM() OVER)

Common Table Expressions (CTEs)

Conclusion
This project demonstrates how SQL can be used to analyze transactional business data and extract actionable insights.
The results can help support decisions related to pricing, inventory planning, marketing strategy, and operational efficiency.

How to Use
Import the CSV files into your SQL database

Create the tables as defined above

Run the queries section by section

Analyze results and insights
```

Author
Gautam Keshri
Data Analyst | SQL | Data Science Enthusiast
