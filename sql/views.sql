CREATE VIEW customer_revenue AS
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





CREATE VIEW product_revenue AS

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





CREATE VIEW country_revenue AS

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



--to validate 
SELECT *
FROM customer_revenue;


SELECT *
FROM product_revenue;


SELECT *
FROM country_revenue;



