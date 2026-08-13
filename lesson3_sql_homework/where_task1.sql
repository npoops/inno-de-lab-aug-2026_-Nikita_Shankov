--Задача: клиенты из США старше 25
-- фильтруем по стране и возрасту.
SELECT 
	first_name, last_name, age, country
FROM 
	customers
WHERE 
	-- Оставляем только пользователей из Америки
	country = 'USA'
	-- И отсекаем всех, кому 25 или меньше
	AND age > 25;
