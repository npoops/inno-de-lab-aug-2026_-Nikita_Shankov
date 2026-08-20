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
    date_id INT NOT NULL,
    project_id INT NOT NULL,
    task_id INT NOT NULL,
    contractor_id INT NOT NULL,
    hours_worked DECIMAL(5, 2),
    labor_cost DECIMAL(10, 2),
    material_cost DECIMAL(10, 2),
    progress_percent DECIMAL(5, 2),
    FOREIGN KEY (project_id) REFERENCES dim_project(project_id),
    FOREIGN KEY (task_id) REFERENCES dim_task(task_id),
    FOREIGN KEY (contractor_id) REFERENCES dim_contractor(contractor_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    -- setting strict grain level
    UNIQUE (date_id, project_id, task_id, contractor_id)
);


-- Analytical Queries

-- Total cost and budget variance for each project.
SELECT 
    dp.project_name,
    dp.budget,
    SUM(COALESCE(fp.labor_cost, 0) + COALESCE(fp.material_cost, 0)) AS total_spent,
    dp.budget - SUM(COALESCE(fp.labor_cost, 0) + COALESCE(fp.material_cost, 0)) AS budget_variance
FROM fact_daily_progress fp
JOIN dim_project dp ON fp.project_id = dp.project_id
GROUP BY dp.project_name, dp.budget;

-- Which contractor worked the most hours in 2026
SELECT 
    dc.contractor_name,
    SUM(fp.hours_worked) AS total_hours
FROM fact_daily_progress fp
JOIN dim_contractor dc ON fp.contractor_id = dc.contractor_id
JOIN dim_date dd ON fp.date_id = dd.date_id
WHERE dd.year = 2026
GROUP BY dc.contractor_name
ORDER BY total_hours DESC
LIMIT 1;

-- Top 3 most expensive tasks
SELECT 
    dt.task_name,
    SUM(COALESCE(fp.labor_cost, 0) + COALESCE(fp.material_cost, 0)) AS total_task_cost
FROM fact_daily_progress fp
JOIN dim_task dt ON fp.task_id = dt.task_id
GROUP BY dt.task_name
ORDER BY total_task_cost DESC
LIMIT 3;

-- Getting the latest progress value by time
WITH RankedProgress AS (
    SELECT 
        dt.task_name,
        fp.progress_percent,
        ROW_NUMBER() OVER (PARTITION BY fp.task_id ORDER BY dd.full_date DESC) as row_num
    FROM fact_daily_progress fp
    JOIN dim_task dt ON fp.task_id = dt.task_id
    JOIN dim_date dd ON fp.date_id = dd.date_id
    WHERE fp.project_id = 1
)
SELECT 
    task_name, 
    progress_percent AS latest_progress
FROM RankedProgress
WHERE row_num = 1;
