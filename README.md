# 🛒 SQL Retail Sales Analysis Project

## 📌 Project Description
This project performs **Retail Sales Data Analysis using SQL**.  
It focuses on extracting meaningful business insights such as **sales performance, customer behavior, product category trends, and time-based analysis**.

This project demonstrates **practical SQL skills** required for **Data Analyst / MIS Executive roles**.

---

## 🛠️ Tech Stack
- Database: MySQL  
- Language: SQL  
- Tools: MySQL Workbench / phpMyAdmin  

---

## 📂 Project Files
- `retail_sales_analysis.sql`  
  - Database creation  
  - Table creation  
  - Data analysis queries  

---

## 🗄️ Database Information
**Database Name:** `ana_project1`  
**Table Name:** `retail_sales`

### Table Structure
| Column Name | Data Type |
|------------|----------|
| transactions_id | INT (Primary Key) |
| sale_date | DATE |
| sale_time | TIME |
| customer_id | INT |
| gender | VARCHAR |
| age | INT |
| category | VARCHAR |
| quantiy | INT |
| price_per_unit | FLOAT |
| cogs | FLOAT |
| total_sale | FLOAT |

---

## Data Exploration 
1. **How many sales we have?**
2. **How many unique customer we have?**
3. **How many unique customer we have?**
   '''sql
   select COUNT(*) as total_sale from retail_sales;
   select COUNT(distinct customer_id) as unique_customer from retail_sales;
   select distinct category from retail_sales;
   '''

## Data Analysis & Business Key Problems & Answers

-- Q.1 **Write a SQL query to retrieve all columns for sales made on '2022-11-05**

    SELECT 
    *
    from retail_sales
    where sale_date = '2022-11-05';

-- Q.2 **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than and equal to 4 in the month of Nov-2022**
    
    select 
      transactions_id,
      category,
      quantity
    from retail_sales
    where 
    	category = 'Clothing' 
    	and quantity >= 4
      and sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 **Write a SQL query to calculate the total sales (total_sale) for each category.**

    select 
    category,
    sum(total_sale) as total_sale
    from retail_sales
    group by category
    order by sum(total_sale) desc;

-- Q.4 **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**

    select 
    round(avg(age),2)
    from retail_sales
    where category = 'Beauty';

-- Q.5 **Write a SQL query to find all transactions where the total_sale is greater than 1000.**

    select 
    transactions_id,
    total_sale
    from retail_sales
    where total_sale > 1000
    order by transactions_id;

-- Q.6 **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**

    select 
    category,
    gender,
    count(transactions_id)
    from retail_sales
    group by category, gender
    order by 1;

-- Q.7 **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
    
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

-- Q.8 **Write a SQL query to find the top 5 customers based on the highest total sales**

    select
    customer_id,
    sum(total_sale) as total_sales
    from retail_sales
    group by customer_id
    order by sum(total_sale) desc
    limit 5;

-- Q.9 **Write a SQL query to find the number of unique customers who purchased items from each category.**

    select 
    category,
    count(distinct customer_id) as unique_customer
    from retail_sales
    group by category
    order by count(distinct customer_id) desc;

-- Q.10 **Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)**
    
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



## 📊 Analysis Performed
- Total revenue and sales analysis  
- Category-wise performance  
- Gender-based customer analysis  
- Daily and monthly sales trends  
- Average order value  
- High-value transactions  
- Customer behavior analysis  
- Shift-wise sales (Morning / Afternoon / Evening)

---

## 🧠 SQL Concepts Used
- CREATE DATABASE & TABLE  
- PRIMARY KEY  
- WHERE, GROUP BY, ORDER BY  
- Aggregate functions (SUM, COUNT, AVG)  
- CASE WHEN  
- Date & time analysis  

---

## ▶️ How to Run
1. Open MySQL Workbench or phpMyAdmin  
2. Open the SQL file  
3. Run the script  

```sql
SOURCE retail_sales_analysis.sql;
```

---

## 🎯 Business Use Case
Helps businesses to:
- Identify top-selling categories  
- Understand customer demographics  
- Improve sales strategy by time shift  
- Optimize pricing and inventory  

---

## 👤 Author
**Suman Acharya**  
- Experience in MIS Reporting & Data Handling  
- Skilled in SQL, Excel, Power BI  
- Aspiring Data Analyst  

---

## 📌 Notes
- Data used is sample / dummy data  
- Project created for learning and portfolio purposes  
- Queries are written in an interview-ready format  
