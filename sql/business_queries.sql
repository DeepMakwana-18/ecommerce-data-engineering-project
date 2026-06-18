--1. Total Revenue
select 
	sum(sales) as Revenue
from 
	orders;


--2. Revenue by Country
select 
	c.country,
	sum(o.sales) as Revenue
from
	customers c
join 
	orders o
on 
	c.customer_id = o.customer_id
group by 
	c.country 
order by 	
	Revenue DESC;


--3. Revenue by City
select 
	c.city,
	sum(o.sales) as Revenue
from 
	customers c 
join 
	orders o 
on 
	c.customer_id = o.customer_id 
group by 
	c.city 
order by 
	Revenue DESC;


--4. Daily Revenue Trend
WITH CTE AS(
select 
	o.order_date,
	sum(o.sales) as Revenue
from
	orders o
group by 
	order_date
)
SELECT 	
	*,
	case
	when Revenue - (LAG(Revenue) over(ORDER BY order_date)) < 0 then 'Declining'
	when Revenue - (LAG(Revenue) over(ORDER BY order_date)) > 0 then 'Inclining'
	else 'Same as Previous' 
	end as "Daily Revenue Trend" 
from
	cte ;



--5. Cumulative Revenue
select 
	order_date,
	sum(sales) over(ORDER BY order_date ROWS BETWEEN unbounded preceding AND current row) as "Cumulative Revenue"
from 
	orders;


--6. Top 3 Customers by Revenue
select 
	c.customer_name,
	sum(o.sales) as Revenue
from 	
	customers c 
join 
	orders o
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
order by 
	Revenue DESC
LIMIT 
	3;


--7. Customer Lifetime Value (CLV)
select 
	c.customer_name,
	sum(o.sales) as CLV
from 
	customers c 
join 
	orders o 
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
Order by 
	CLV DESC;


--8. Customers Above Average Revenue
with cte as 
(select 
	c.customer_name,
	sum(o.sales) as Revenue
from 
	customers c 
join 
	orders o
on  
	c.customer_id = o.customer_id 
group by
	c.customer_id,
	c.customer_name
)
select 
	customer_name
from
	cte
where
	cte.revenue > (select avg(Revenue) over(ROWS BETWEEN unbounded preceding AND unbounded following) from cte limit 1);

--9. Repeat Customers
select 
	c.customer_name
from	
	customers c 
join 
	orders o 
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
having
	count(o.customer_id) > 1;


--10. Customer Revenue Contribution %
with cte as 
(select 
	c.customer_name,
	sum(o.sales) as Revenue
from
	customers c
join 
	orders o 
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
)
select 
	*,
	round(Revenue/sum(Revenue) over( ROWS BETWEEN unbounded preceding AND unbounded following)*100,2) as Revenue_Contribution_Percentage
from
	cte
order by 
	Revenue_Contribution_Percentage DESC;


--11. Top Products by Revenue
select 
	p.product_name,
	sum(o.sales) as Revenue
from
	products p 
join 
	orders o 
on 
	p.product_id = o.product_id
group by 
	p.product_id,
	p.product_name
order by 
	Revenue DESC
Limit 
	3;


--12. Top Products by Quantity Sold
select 
	p.product_name,
	sum(o.quantity) as quantity_sold
from
	products p 
join 
	orders o 
on 
	p.product_id = o.product_id
group by 
	p.product_id,
	p.product_name
order by 
	quantity_sold DESC
Limit 
	3;


--13. Revenue by Category
select 
	p.category,
	sum(o.sales) as Revenue
from
	products p
join 
	orders o
on 
	p.product_id = o.product_id
group by
	p.category
order by 
	Revenue DESC;


--14. Average Product Revenue
select
	avg(o.sales) as AVG_product_Rvenue
from 
	orders o;


--15. Product Revenue Ranking
with cte as
(
select 
	p.product_name,
	sum(o.sales) as Revenue
from
	products p
join 
	orders o
on 
	p.product_id = o.product_id
group by 
	p.product_id,
	p.product_name
)
select 
	*,
	rank() over(order by Revenue DESC) as "Rank"
from
	cte;


--16. Revenue by Payment Method
select 
	p.payment_method,
	sum(p.amount) as Revenue
from	
	payments p
group by 
	p.payment_method


--17. Most Popular Payment Method
with cte as 
(select 
	p.payment_method,
	dense_rank() over( order by count(payment_method) DESC) as Rank_no
from	
	payments p
group by 
	p.payment_method
)
select 
	payment_method 
from
	cte 
where 
	Rank_no = 1;


--18. Average Transaction Value by Payment Method
select 
	p.payment_method,
	avg(p.amount)
from	
	payments p
group by 
	p.payment_method;
	

--19. Payment Method Revenue Contribution
with cte as 
(select 
	p.payment_method,
	sum(p.amount) as Revenue
from 
	payments p 
group by 
	payment_method
)
select
	*,
	round(Revenue/sum(Revenue) over(ROWS BETWEEN unbounded preceding AND unbounded following)*100,2) as Revenue_Contribution
from
	cte 
order by 
	Revenue_Contribution desc;


--20. Daily Payment Volume
select 	
	p.payment_date,
	count(p.payment_id) as Volume
from
	payments p 
group by 
	p.payment_date
	
	
--21. Rank Customers by Revenue
with cte as 
(select
	c.customer_name,
	sum(o.sales) as Revenue
from
	customers c
join 
	orders o
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
)
select 
	*,
	rank() over(order by Revenue DESC) as "RANK"
from
	cte;


--22. Highest Revenue Customer per Country
with cte as
(select 
	c.customer_name,
	sum(o.sales) as Revenue,
	c.country,
	dense_rank() over(partition by country order by sum(o.sales) DESC) as RankNO
from
	customers c
join 
	orders o
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
)
select 
	*
from
	cte
where 	
	rankno = 1;


--23. Running Revenue Total
select 
	o.order_date,
	SUM(o.sales) OVER (ORDER BY order_date) AS RunningTotal
from
	orders o;
	


--24. Revenue Difference from Average Customer Revenue
with cte as 
(select 
	c.customer_name,
	sum(o.sales) as Revenue
from	
	customers c
join 
	orders o
on 
	c.customer_id = o.customer_id
group by 
	c.customer_id,
	c.customer_name
)
select 
	*,
	avg(Revenue) over(ROWS BETWEEN unbounded preceding AND unbounded following),
	(Revenue - avg(Revenue) over(ROWS BETWEEN unbounded preceding AND unbounded following)) as Difference
from
	cte ;


--25. Revenue Growth %
WITH CTE AS(
select 
	o.order_date,
	sum(o.sales) as Revenue
from
	orders o
group by 
	order_date
)
SELECT 	
	*,
	round((( Revenue - (LAG(Revenue) over(ORDER BY order_date)) ) / Revenue )*100,2) as " Daily Revenue Growth %"
from
	cte ;
	







	

