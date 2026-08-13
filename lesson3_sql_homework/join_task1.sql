-- Собираем покупателей вместе с их заказами в одну таблицу.
SELECT
	c.first_name,
	c.last_name, 
	o.item,     
	o.amount 
FROM
	orders o
-- Соединяем заказы с клиентами по их ID.
-- Inner join оставляет только те записи, где есть совпадение (если у клиента нет заказов — он не попадет)
INNER JOIN 
	customers c 
	ON o.customer_id = c.customer_id;

