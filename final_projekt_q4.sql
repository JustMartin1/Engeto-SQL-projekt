/*
 * 
 * Engeto SQL projekt otázka č. 4
 * Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
 * 
 */

SELECT
	*
FROM t_martinminceff_sql_primary_final pf;


CREATE OR REPLACE TABLE temp_q4payrollandprice_beta
SELECT
	pf.payroll_year AS `year`,
	pf.category_code,
	ROUND(AVG(pf.avg_month_payroll), 2) AS avg_payroll,
	ROUND(AVG(pf.avg_year_price), 2) AS avg_price
FROM t_martinminceff_sql_primary_final pf
WHERE pf.avg_year_price IS NOT NULL
GROUP BY pf.payroll_year;


SELECT
	tqb.`year`,
	tqb.avg_payroll,
	tqb.avg_price,
	tqb2.`year` AS next_year,
	tqb2.avg_payroll AS nextyear_payroll,
	tqb2.avg_price AS nextyear_price,
	ROUND((tqb2.avg_payroll - tqb.avg_payroll) / tqb.avg_payroll * 100, 2) AS payroll_growth,
	ROUND((tqb2.avg_price - tqb.avg_price) / tqb.avg_price * 100, 2) AS price_growth
FROM temp_q4payrollandprice_beta tqb
JOIN temp_q4payrollandprice_beta tqb2
	ON tqb.category_code = tqb2.category_code
	AND tqb.`year`+1 = tqb2.`year`
GROUP BY tqb.`year`;


WITH question4final AS
(
SELECT
	tqb.`year`,
	tqb.avg_payroll,
	tqb.avg_price,
	tqb2.`year` AS next_year,
	tqb2.avg_payroll AS nextyear_payroll,
	tqb2.avg_price AS nextyear_price,
	ROUND((tqb2.avg_payroll - tqb.avg_payroll) / tqb.avg_payroll * 100, 2) AS payroll_growth,
	ROUND((tqb2.avg_price - tqb.avg_price) / tqb.avg_price * 100, 2) AS price_growth
FROM temp_q4payrollandprice_beta tqb
JOIN temp_q4payrollandprice_beta tqb2
	ON tqb.category_code = tqb2.category_code
	AND tqb.`year`+1 = tqb2.`year`
GROUP BY tqb.`year`
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