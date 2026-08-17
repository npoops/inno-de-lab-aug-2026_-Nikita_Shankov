-- поднимаем зп всем эйчарам на 10%
UPDATE Employees 
SET Salary = Salary * 1.10 
WHERE Department = 'HR';

-- тех, кто зарабатывает больше 70к, переводим в Senior IT
UPDATE Employees 
SET Department = 'Senior IT' 
WHERE Salary > 70000.00;

-- удаляем тех, кого нет в таблице проектов
DELETE FROM Employees 
WHERE NOT EXISTS (
    SELECT 1 
    FROM EmployeeProjects 
    WHERE EmployeeProjects.EmployeeID = Employees.EmployeeID
);

-- в одной транзакции создаем проект и кидаем туда двоих людей
BEGIN;

-- создаем проект и через WITH ловим его сгенерированный ID
WITH new_project AS (
    INSERT INTO Projects (ProjectName, StartDate, Budget) 
    VALUES ('Super New Project', CURRENT_DATE, 100000.00) 
    RETURNING ProjectID
)
-- цепляем первых попавшихся двух сотрудников на этот новый проект
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
SELECT e.EmployeeID, np.ProjectID, 10
FROM Employees e
CROSS JOIN new_project np
LIMIT 2;

COMMIT;