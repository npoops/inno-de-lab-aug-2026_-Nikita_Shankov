-- Функции и представления, создание пользовательских функций и view

-- Создаем функцию для расчета годового бонуса (10% от зарплаты)
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
    emp_id INT,
    emp_salary DECIMAL
) 
RETURNS DECIMAL AS $$
DECLARE
    bonus DECIMAL;
BEGIN
    -- Считаем бонус как 10% от зарплаты
    bonus := emp_salary * 0.10;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

-- 2. Используем функцию в SELECT для просмотра бонусов всех сотрудников
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CalculateAnnualBonus(EmployeeID, Salary) AS AnnualBonus
FROM Employees;

-- 3. Создаем представление для сотрудников из IT отдела
CREATE VIEW IT_Department_View AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Department = 'IT';

-- 4. Выбираем данные из представления
SELECT * FROM IT_Department_View;
