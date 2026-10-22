-----Data cleaning
select * from retail_sales_report 
where transactions_id IS NULL
 OR
 gender IS NULL
 OR
 age IS NULL
 OR
 quantity IS NULL
 OR
 sale_date is NULL
 OR
 cogs IS NULL
 
delete from retail_sales_report
where age IS NULL

------Total sales
select count(transactions_id) AS total_sales
from retail_sales_report

-----Total customers
select count(distinct customer_id) AS total_customers 
from retail_sales_report

----Total categories
select count(distinct category) As total_category
from retail_sales_report

----Data Analysis 
---1 Retrieve all columns for sales made on '2022-11-05
select *
from retail_sales_report
where sale_date='2022-11-05'

--2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
 select *from retail_sales_report
 where category='Clothing'
   AND
sale_date BETWEEN '2022-11-01' AND '2022-11-30'
   AND
quantity>=4

---3 calculate the total sales (total_sale) for each category.
select category,sum(total_sale) AS total_sales_per_category
from retail_sales_report
group by category 

---4 Find the average age of customers who purchased items from the 'Beauty' category.
 select round(avg(age),2)AS average_age from retail_sales_report
 where category='Beauty'


---Find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender,count(*) AS total_transactions
from retail_sales_report
group by category,gender
order by category

----calculate the average sale for each month. Find out best selling month in each year
select extract(Year from sale_date) AS Year,extract(month from sale_date)AS Month,
round(avg(total_sale),2)AS average_sale
from retail_sales_report
group by extract(Year from sale_date),extract(month from sale_date)
order by year,Month,average_sale desc

----Find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale)AS total_sales_per_customer
from retail_sales_report
group by customer_id
order by total_sales_per_customer desc
limit 5

-----Find the number of unique customers who purchased items from each category.
select category, count(distinct customer_id)AS total_customers 
from retail_sales_report
group by category

----Create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

select
case
when EXTRACT(hour from sale_time)<=12 THEN 'Morning'
when EXTRACT(hour from sale_time)>12 AND  EXTRACT(hour from sale_time)<=17 THEN 'Afternoon'
else 'Evening'
end AS shift,
count (distinct transactions_id)AS total_orders
from retail_sales_report
group by shift


