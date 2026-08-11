SELECT
	country,
	COUNT(*) AS count
FROM
	customers	
GROUP BY 
	country 
