/*
 * 
 * Engeto SQL projekt otázka č. 2
 * Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 * 
 */

SELECT 
	*
FROM t_martinminceff_sql_primary_final pf;


SELECT
	pf.payroll_year AS `year`,
	pf.product_name,
	ROUND(AVG(pf.avg_month_payroll), 2) AS avg_month_payroll_allindustries,
	ROUND(AVG(pf.avg_month_payroll)*12, 2) AS avg_year_payroll,
	ROUND(AVG(pf.avg_year_price), 2) AS avg_year_product_price,
	ROUND(AVG(pf.avg_month_payroll) / (pf.avg_year_price), 2) AS value_month,
	ROUND(AVG((pf.avg_month_payroll)*12) / (pf.avg_year_price), 2) AS value_year,
	pf.price_unit
FROM t_martinminceff_sql_primary_final pf
WHERE pf.payroll_year IN(2006, 2018)
	AND pf.category_code IN(111301, 114201)
GROUP BY pf.payroll_year, pf.product_name
ORDER BY pf.payroll_year;