-- топ по возрасту: от самого старшего к самому молодому
SELECT
	first_name,
	age
FROM
	customers
-- Сортируем по возрасту.
-- desc - по убыванию
ORDER BY
	age desc;
