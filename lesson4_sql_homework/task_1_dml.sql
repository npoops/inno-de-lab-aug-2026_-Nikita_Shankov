-- закидываем двух новых 
INSERT INTO Employees (FirstName, LastName, Department, Salary) 
VALUES 
    ('John', 'Doe', 'HR', 55000.00),
    ('Jane', 'Williams', 'Finance', 60000.00);

-- выводим всех сотрудников
SELECT * FROM Employees;

-- достаем только имена и фамилии
SELECT FirstName, LastName
FROM Employees
WHERE Department = 'IT';

-- накидываем зп Элис
UPDATE Employees
SET salary = 65000.00
WHERE FirstName = 'Alice' AND LastName = 'Smith';

-- увольняем 
DELETE FROM Employees
WHERE FirstName = 'Eve' AND LastName = 'Davis';

-- чекаем итоговый результат
SELECT * FROM Employees;
