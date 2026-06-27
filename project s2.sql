-- SQL retail sales analysis -p1
CREATE DATABASE sql_project_p1;
use sql_project_p1;


-- crate Tablle
drop table if  exists retail_sales;
create table retail_sales ( transactions_id int primary key, sale_date date, sale_time time, customer_id int, gender varchar(15), age int, 
category varchar(15), quantiy int, price_per_unit float, cogs float, total_sale float
);
 select* from retail_sales
 Limit 10; 
 
 select COUNT(*) from retail_sales;
 
 -- use to check multipl columns null value 
select * from retail_sales
where
    transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    gender is null
    or
    category is null
    or
    quantiy is null
    or
    cogs is null
    or 
    total_sale is null;
 
--  use to delet all column null value rows
delete from retail
where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    gender is null
    or
    category is null
    or
    quantiy is null
    or
    cogs is null
    or 
    total_sale is null;
    
-- data exploration
 
-- how many sales we have?
select count(*) as total_sales from retail_sales;
 
-- how many customer we heve?
select count(distinct customer_id) as total_sales from retail_sales;

select distinct category from retail_sales;

-- dta analysis & business key problem & answers

-- Q.1 write a sql query to retieve all columns for sales made '2022-11-05'

select * from retail_sales where sale_date = '2022-11-05';
-- ans q1. there are 11 sales in that date. 

-- Q.2 write a sql query to retrieve all transaction where the category is 'clothing' and the quntity sold is more than 10 in the mont of nov-2022
select * from retail_sales where category = 'clothing' and quantiy >= 4 and sale_date >= '2022-11-01' and sale_date < '2022-12-01';

-- Q.3 writ a sql query to calculate the total sales (total_sales) for each category 
select  category, sum(total_sale), count(*) as total_orders from retail_sales group by 1;

-- Q.4 write a sql query to find the average age of customers who purchased items from the 'beauty' category. 
select avg(age) from retail_sales where category = 'beauty';

-- Q.5 Write a sql query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales where total_sale > 1000; 

-- Q.6  write a sql query to find the total number of transcation (tansacation_id) made by each gender in category. 
select category, gender, count(*) as total_trans from retail_sales group by category , gender order by 1;

-- Q.7 write a sql query to calculate  the average sale for each month. find out best selling in each year
select year, month, avg_sale from ( select year(sale_date) as year, month(sale_date) as month, avg(total_sale) as avg_sale, rank() over (partition by year(sale_date) order by avg (total_sale) desc) as rnk from retail_sales group by year(sale_date), month(sale_date)) as t1;

-- Q.8 write a sql query to find top 5 customer based on yhe highest total sales
select customer_id, sum(total_sale) from retail_sales group by 1 order by 2 desc limit 5;

-- Q.9 write a sql to find the number of unique customers who purchased items from each category. 
select category, count(distinct customer_id) from retail_sales group by category;
 
 -- Q.10 write a sql query to each shift and number of orders( example morning < 12, afternoon between 12 & 17, evening >17). 
with hourly_sale as (select *, case when hour(sale_time) < 12 then 'morning' when hour(sale_time) between 12 and 17 then 'afternoon' else 'evening' end as shift_name from retail_sales )
select shift_name, count(*) as total_orders from hourly_sale group by shift_name;

-- End of Project

