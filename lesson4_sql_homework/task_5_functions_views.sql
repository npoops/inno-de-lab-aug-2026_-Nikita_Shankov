-- Создание функции для расчета бонуса
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

-- Используем функцию в SELECT для просмотра бонусов всех сотрудников
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CalculateAnnualBonus(EmployeeID, Salary) AS AnnualBonus
FROM Employees
ORDER BY EmployeeID;
-- Создаем представление для сотрудников из IT отдела
CREATE VIEW IT_Department_View AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Department = 'IT';