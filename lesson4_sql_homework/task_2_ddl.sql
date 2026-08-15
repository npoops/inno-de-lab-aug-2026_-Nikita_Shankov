CREATE TABLE Departments (
	DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(50) UNIQUE NOT NULL,
    Location VARCHAR(50)
);

-- Добавляем колонку Email в таблицу Employees
ALTER TABLE Employees 
ADD COLUMN Email VARCHAR(100);

-- Заполняем колонку Email
UPDATE Employees 
SET Email = LOWER(FirstName || '.' || LastName || '@company.com');

-- Добавляем ограничение UNIQUE на колонку Email
ALTER TABLE Employees 
ADD CONSTRAINT unique_email UNIQUE (Email);

-- Переименовываем колонку Location в OfficeLocation в таблице Departments
ALTER TABLE Departments 
RENAME COLUMN Location TO OfficeLocation;

SELECT * FROM Employees;
SELECT * FROM Departments;