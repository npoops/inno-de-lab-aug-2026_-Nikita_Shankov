-- Находим проекты, где Bob Johnson работал больше 150 часов
SELECT p.ProjectName
FROM Projects p
INNER JOIN EmployeeProjects ep ON p.ProjectID = ep.ProjectID
INNER JOIN Employees e ON ep.EmployeeID = e.EmployeeID
WHERE e.FirstName = 'Bob' 
  AND e.LastName = 'Johnson' 
  AND ep.HoursWorked > 150;
-- Увеличиваем бюджет на 10% для проектов с хотя бы одним IT сотрудником
UPDATE Projects
SET Budget = Budget * 1.10
WHERE ProjectID IN (
    SELECT DISTINCT ep.ProjectID
    FROM EmployeeProjects ep
    INNER JOIN Employees e ON ep.EmployeeID = e.EmployeeID
    WHERE e.Department = 'IT'
);
UPDATE Projects
SET EndDate = StartDate + INTERVAL '1 year'
WHERE EndDate IS NULL;
-- вставляем сотрудника и назначаем на проект
BEGIN;
-- Вставляем нового сотрудника и получаем его ID
INSERT INTO Employees (FirstName, LastName, Department, Salary, Email)
VALUES ('Michael', 'Scott', 'Sales', 70000.00, 'michael.scott@company.com')
RETURNING EmployeeID;
-- Назначаем его на проект Website Redesign
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
VALUES (9, 1, 80);
COMMIT;

