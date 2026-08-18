-- 1. Добавляем двух новых сотрудников, главное чтобы не в IT-отдел
INSERT INTO Employees (FirstName, LastName, Department, Salary) 
VALUES 
    ('John', 'Doe', 'HR', 55000.00),
    ('Jane', 'Williams', 'Finance', 60000.00);

-- 2. Выводим вообще всех сотрудников из таблицы, чтобы проверить, что новички добавились
SELECT * FROM Employees;

-- 3. Вытаскиваем только имена и фамилии тех, кто работает в IT
SELECT FirstName, LastName
FROM Employees
WHERE Department = 'IT';

-- 4. Поднимаем зарплату для Alice Smith до 65 тысяч
UPDATE Employees
SET salary = 65000.00
WHERE FirstName = 'Alice' AND LastName = 'Smith';

-- 5. Удаляем сотрудника Eve Davis из базы
DELETE FROM Employees
WHERE FirstName = 'Eve' AND LastName = 'Davis';

-- 6. Еще раз выводим всю таблицу
SELECT * FROM Employees;
