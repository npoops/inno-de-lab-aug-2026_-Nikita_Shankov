SELECT
	c.first_name,
	c.last_name,
	o.amount
FROM
	orders o
INNER JOIN
	customers c 
	ON o.customer_id = c.customer_id 
WHERE 
	o.amount =(
		SELECT MAX(amount)
		FROM orders
);