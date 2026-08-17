-- находим проекты, где Боб пахал больше 150 часов
SELECT p.ProjectName
FROM Projects p
INNER JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
INNER JOIN Employees e ON ep.EmployeeID = e.EmployeeID
WHERE e.FirstName = 'Bob' 
  AND e.LastName = 'Johnson' 
  AND ep.HoursWorked > 150;

-- увеличиваем бюджет на 10% для проектов с хотя бы одним айтишником
UPDATE Projects
SET Budget = Budget * 1.10
WHERE ProjectID IN (
    SELECT DISTINCT ep.ProjectID
    FROM EmployeeProjects ep
    INNER JOIN Employees e ON ep.EmployeeID = e.EmployeeID
    WHERE e.Department = 'IT'
);

-- если дата окончания пустая, ставим ее на год позже старта
UPDATE Projects
SET EndDate = StartDate + INTERVAL '1 year'
WHERE EndDate IS NULL;

-- транзакция: добавляем сотрудника и сразу кидаем на проект
BEGIN;

-- создаем Майкла и сразу забираем его айдишник
WITH new_emp AS (
    INSERT INTO Employees (FirstName, LastName, Department, Salary, Email)
    VALUES ('Michael', 'Scott', 'Sales', 70000.00, 'michael.scott@company.com')
    RETURNING EmployeeID
)
-- назначаем его на редизайн сайта
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
SELECT 
    ne.EmployeeID, 
    (SELECT ProjectID FROM Projects WHERE ProjectName = 'Website Redesign'), 
    80
FROM new_emp ne;

COMMIT;