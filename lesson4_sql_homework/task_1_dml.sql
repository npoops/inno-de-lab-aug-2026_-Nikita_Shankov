INSERT INTO Employees (FirstName, LastName, Department, Salary) 
VALUES 
    ('John', 'Doe', 'HR', 55000.00),
    ('Jane', 'Williams', 'Finance', 60000.00);

SELECT
	FirstName,
	LastName
FROM
	Employees
WHERE
	Department = 'IT';

UPDATE Employees
SET salary = '65000'
WHERE FirstName = 'Alice' AND LastName = 'Smith';

DELETE FROM  Employees
WHERE FirstName = 'Eve' AND LastName = 'Davis';

SELECT * FROM Employees;