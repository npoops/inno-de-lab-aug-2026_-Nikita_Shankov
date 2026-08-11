SELECT
	item,
	COUNT(*) AS count,
	avg(amount) as avg_amount
FROM
	orders
GROUP BY 
	item;