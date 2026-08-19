-- Create dimension tables
CREATE TABLE dim_project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    budget DECIMAL(15, 2),
    status VARCHAR(50)
);

CREATE TABLE dim_task (
    task_id INT PRIMARY KEY,
    task_name VARCHAR(100),
    task_type VARCHAR(50)
);

CREATE TABLE dim_contractor (
    contractor_id INT PRIMARY KEY,
    contractor_name VARCHAR(100),
    specialization VARCHAR(50)
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    month INT,
    year INT
);

-- Create fact table

CREATE TABLE fact_daily_progress (
    progress_id INT PRIMARY KEY,
    date_id INT,
    project_id INT,
    task_id INT,
    contractor_id INT,
    hours_worked DECIMAL(5, 2),
    labor_cost DECIMAL(10, 2),
    material_cost DECIMAL(10, 2),
    progress_percent DECIMAL(5, 2),
    FOREIGN KEY (project_id) REFERENCES dim_project(project_id),
    FOREIGN KEY (task_id) REFERENCES dim_task(task_id),
    FOREIGN KEY (contractor_id) REFERENCES dim_contractor(contractor_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- Analytical Queries

-- the total cost for each project to compare with the budget
SELECT 
    dp.project_name,
    dp.budget,
    SUM(fp.labor_cost + fp.material_cost) AS total_spent
FROM fact_daily_progress fp
JOIN dim_project dp ON fp.project_id = dp.project_id
GROUP BY dp.project_name, dp.budget;

-- which contractor worked the most hours in 2026
SELECT 
    dc.contractor_name,
    SUM(fp.hours_worked) AS total_hours
FROM fact_daily_progress fp
JOIN dim_contractor dc ON fp.contractor_id = dc.contractor_id
JOIN dim_date dd ON fp.date_id = dd.date_id
WHERE dd.year = 2026
GROUP BY dc.contractor_name
ORDER BY total_hours DESC;

-- top 3 most expensive tasks
SELECT 
    dt.task_name,
    SUM(fp.labor_cost + fp.material_cost) AS total_task_cost
FROM fact_daily_progress fp
JOIN dim_task dt ON fp.task_id = dt.task_id
GROUP BY dt.task_name
ORDER BY total_task_cost DESC
LIMIT 3;

-- shows the latest reported progress for each task
SELECT 
    dt.task_name,
    MAX(fp.progress_percent) AS current_progress
FROM fact_daily_progress fp
JOIN dim_task dt ON fp.task_id = dt.task_id
WHERE fp.project_id = 1
GROUP BY dt.task_name;