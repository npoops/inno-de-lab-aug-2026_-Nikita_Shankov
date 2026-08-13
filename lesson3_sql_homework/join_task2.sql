-- Смотрим, на каком этапе находятся отправки и к кому из пользователей они относятся
SELECT
	s.status, 
	c.first_name,
	c.last_name
FROM
	shippings s	
-- Джойним доставки с клиентами по ID.
-- Inner join отсечет посылки без привязанного клиента и клиентов без отправок
INNER JOIN 
	customers c
	ON s.customer = c.customer_id;
