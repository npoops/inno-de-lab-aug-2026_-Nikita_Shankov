SELECT 
	order_id, amount, customer_id, item
FROM 
	orders
WHERE 
	amount > 1000;
