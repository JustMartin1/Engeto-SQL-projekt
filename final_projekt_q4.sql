/*
 * 
 * Engeto SQL projekt otázka č. 4
 * Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 * 
 */



SELECT 
	*
FROM t_martinminceff_sql_primary_final tmspf ;

CREATE OR REPLACE TABLE temp_q4_payrollandprice
SELECT 
	tmspf .`year` ,
	tmspf .category_code ,
	ROUND(AVG(avg_month_payroll), 2) AS avg_payroll ,
	ROUND(AVG(avg_year_price), 2) AS avg_price 
FROM t_martinminceff_sql_primary_final tmspf 
WHERE tmspf.avg_year_price IS NOT NULL 
GROUP BY tmspf .`year` ;

SELECT 
	tqp .`year` ,
	tqp .avg_payroll ,
	tqp .avg_price ,
	tqp2 .`year` AS next_year,
	tqp2 .avg_payroll AS nextyear_payroll,
	tqp2 .avg_price AS nextyear_price,
	ROUND((tqp2 .avg_payroll-tqp.avg_payroll)/ tqp .avg_payroll * 100, 2) AS payroll_growth,
	ROUND((tqp2.avg_price-tqp.avg_price)/ tqp .avg_price * 100, 2) AS price_growth
FROM temp_q4_payrollandprice tqp 
JOIN temp_q4_payrollandprice tqp2 
	ON tqp.category_code = tqp2 .category_code 
	AND tqp .`year` +1 = tqp2 .`year` 
GROUP BY tqp .`year` ;


WITH question4final AS
	(
		SELECT 
			tqp .`year` ,
			tqp .avg_payroll ,
			tqp .avg_price ,
			tqp2 .`year` AS next_year,
			tqp2 .avg_payroll AS nextyear_payroll,
			tqp2 .avg_price AS nextyear_price,
			ROUND((tqp2 .avg_payroll-tqp.avg_payroll)/ tqp .avg_payroll * 100, 2) AS payroll_growth,
			ROUND((tqp2.avg_price-tqp.avg_price)/ tqp .avg_price * 100, 2) AS price_growth
		FROM temp_q4_payrollandprice tqp 
		JOIN temp_q4_payrollandprice tqp2 
			ON tqp.category_code = tqp2 .category_code 
			AND tqp .`year` +1 = tqp2 .`year` 
		GROUP BY tqp .`year` 
	)
SELECT
	`year`,
	payroll_growth,
	price_growth,
	price_growth - payroll_growth AS diff,
		CASE
			WHEN price_growth - payroll_growth <= -10 THEN 1
			ELSE 0
		END AS higher_than_10percent_yes_no		
FROM question4final;

























