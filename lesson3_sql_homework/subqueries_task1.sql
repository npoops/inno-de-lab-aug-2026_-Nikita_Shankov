-- Задача: найти клиента с самым жирным кошельком
-- Вытягиваем имя, фамилию и сумму из чека с максималкой
SELECT
	c.first_name,
	c.last_name,
	o.amount
FROM
	orders o
-- Привязываем покупателей к заказам, чтобы узнать, чей это чек
INNER JOIN
	customers c 
	ON o.customer_id = c.customer_id 
WHERE 
	-- Подзапросом находим максимальный чек по всей таблице orders
	-- и оставляем только те заказы, где сумма совпала с этим максимумом
	o.amount =(
		SELECT MAX(amount)
		FROM orders
);
