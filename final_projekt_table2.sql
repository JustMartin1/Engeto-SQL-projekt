CREATE OR REPLACE TABLE t_martinminceff_sql_secondary_final 
SELECT 
	c.country ,
	e.`year` ,
	e.GDP ,
	e.gini ,
	e.population ,
	e.taxes 
FROM countries c
JOIN economies e 
	ON c.country = e.country 
WHERE continent = 'Europe'
	AND e.`year` BETWEEN 2000 AND 2022
ORDER BY c.country, e.`year`;