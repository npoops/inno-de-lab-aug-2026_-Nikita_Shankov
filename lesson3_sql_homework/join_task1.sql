SELECT
	c.first_name,
	c.last_name, 
	o.item,     
	o.amount 
FROM
	orders o
INNER JOIN 
	customers c 
	ON o.customer_id = c.customer_id;
	
