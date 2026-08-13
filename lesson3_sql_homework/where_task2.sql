-- фильруем заказы так, чтобы остались только где в чеке кэша оставили больше 1000
SELECT 
	order_id, amount, customer_id, item
FROM 
	orders
WHERE 
-- вот условие для выборки таких заказов
	amount > 1000;
