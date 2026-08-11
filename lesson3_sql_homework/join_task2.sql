SELECT
	s.status, 
	c.first_name,
	c.last_name
FROM
	shippings s	
INNER JOIN 
	customers c
	ON s.customer = c.customer_id;