-- создаем функцию для расчета бонуса
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
    emp_id INT,
    emp_salary DECIMAL
) 
RETURNS DECIMAL AS $$
DECLARE
    bonus DECIMAL;
BEGIN
    -- считаем бонус как 10% от зп
    bonus := emp_salary * 0.10;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

-- смотрим потенциальные бонусы всех сотрудников
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CalculateAnnualBonus(EmployeeID, Salary) AS AnnualBonus
FROM Employees
ORDER BY EmployeeID;

-- делаем вьюху чисто для айти отдела
CREATE VIEW IT_Department_View AS
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE Department = 'IT';

-- выбираем данные из вьюхи 
SELECT * FROM IT_Department_View;