-- sql retail sales Analysis
create database ana_project1;
use ana_project1;
-- create table
create table retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(15),
quantiy	int,
price_per_unit float,
cogs float,
total_sale float
);

-- Data Exploration 

-- How many sales we have?
select COUNT(*) as total_sale from retail_sales;

-- How many unique customer we have?
select COUNT(distinct customer_id) as unique_customer from retail_sales;

-- How many unique customer we have?
select distinct category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select 
*
from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than and equal to 4 in the month of Nov-2022
select 
transactions_id,
category,
quantity
from retail_sales
where 
	category = 'Clothing' 
	and quantity >= 4
    and sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
category,
sum(total_sale) as total_sale
from retail_sales
group by category
order by sum(total_sale) desc;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
round(avg(age),2)
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
transactions_id,
total_sale
from retail_sales
where total_sale > 1000
order by transactions_id;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
category,
gender,
count(transactions_id)
from retail_sales
group by category, gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
	year,
    month,
    avg_sale
from(
select 
	year(sale_date) as year,
	month(sale_date) as month,
	round(avg(total_sale),2) as avg_sale,
	rank() over(partition by year(sale_date) order by round(avg(total_sale),2) desc) as ranks
from retail_sales
group by 
	year(sale_date),
	month(sale_date)
)t
where ranks = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
category,
count(distinct customer_id) as unique_customer
from retail_sales
group by category
order by count(distinct customer_id) desc;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
	case
		when hour(sale_time) < 12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as shift,
    count(transactions_id) as no_of_orders
from retail_sales
group by shift;


-- End of the Project







