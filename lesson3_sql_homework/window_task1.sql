-- через оконку закидываем итоговую сумму прямо в каждую строчку с заказом
SELECT
	order_id,
	customer_id,
	item,
	amount,
	-- Оконка: считает общую сумму всех заказов конкретного customer_id,
	-- не схлопывая при этом сами строки (в отличие от обычного GROUP BY)
	SUM(amount) OVER(PARTITION BY customer_id) AS total_by_customer
FROM
	orders
-- Сортируем результат, чтобы заказы одного и того же клиента шли подряд
ORDER BY 
	customer_id, order_id;
