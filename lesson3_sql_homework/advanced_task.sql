-- Задача: Данные по клиентам, имеющим хотя бы одну доставленную посылку
-- Выводит суммарные показатели по заказам только для активных клиентов с минимум 2 заказами.
SELECT 
-- Объединение имени и фамилии клиента в единое поле
    c.first_name || ' ' || c.last_name AS full_name,
    c.country,
-- Считаем общее число заказов и сколько денег клиент суммарно занес
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM Customers c
-- Привязываем заказы к клиентам (выпадут те, кто ничего не заказывал)
JOIN Orders o ON c.customer_id = o.customer_id
WHERE EXISTS (
-- проверяем, что у клиента есть хотя бы одна доставка со статусом 'Delivered'
    SELECT 1 
    FROM Shippings s 
    WHERE s.customer = c.customer_id 
      AND s.status = 'Delivered'
)
-- группировка по клиентам, чтобы адекватно вывело count и sum
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
-- оставляем только тех, у кого 2 и более заказов
HAVING COUNT(o.order_id) >= 2;