-- DCL операции, Работа с правами доступа и пользователями

-- Создаем нового пользователя hr_user с паролем
CREATE ROLE hr_user WITH LOGIN PASSWORD 'hr_password123';

--Даем hr_user право SELECT на таблицу Employees
GRANT SELECT ON TABLE Employees TO hr_user;

-- Также нужно дать права на использование последовательности (для полного доступа)
GRANT USAGE ON SCHEMA public TO hr_user;

-- Даем hr_user права INSERT и UPDATE
GRANT INSERT, UPDATE ON TABLE Employees TO hr_user;

-- Также даем права на использование sequence для INSERT
GRANT USAGE, SELECT ON SEQUENCE employees_employeeid_seq TO hr_user;

