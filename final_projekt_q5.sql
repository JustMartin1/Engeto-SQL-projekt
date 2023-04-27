/*
 * 
 * Engeto SQL projekt otázka č. 5
 * 
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
 * ve stejném nebo následujícím roce výraznějším růstem?
 * 
 */

CREATE OR REPLACE TABLE temp_beta_payrollpricegdp
SELECT
	pf .`year`,
	ROUND(AVG(pf.avg_month_payroll), 2) AS avg_payroll,
	ROUND(AVG(pf.avg_year_price), 2) AS avg_product_price,
	sf.GDP
FROM t_martinminceff_sql_primary_final pf
JOIN t_martinminceff_sql_secondary_final sf
	ON pf.payroll_year = sf.`year`
WHERE sf.country = 'Czech Republic'
GROUP BY `year`;


SELECT
	*
FROM temp_beta_payrollpricegdp tbp;


SELECT
	tbp.`year`,
	tbp.avg_payroll,
	tbp.avg_product_price,
	tbp.GDP,
	tbp2.`year` AS next_year,
	tbp2.avg_payroll AS nextyear_payroll,
	tbp2.avg_product_price AS nextyear_price,
	tbp2.GDP AS nextyear_gdp,
	ROUND((tbp2.avg_payroll - tbp.avg_payroll) / tbp.avg_payroll * 100, 2) AS payroll_growth,
	ROUND((tbp2.avg_product_price - tbp.avg_product_price) / tbp.avg_product_price * 100, 2) AS product_price_growth,
	ROUND((tbp2.GDP - tbp.GDP) / tbp.GDP * 100, 2) AS gdp_growth
FROM temp_beta_payrollpricegdp tbp
JOIN temp_beta_payrollpricegdp tbp2
	ON tbp.`year`+1 = tbp2.`year`;


SELECT
	tbp.`year` ,
	ROUND((tbp2.GDP - tbp.GDP) / tbp.GDP * 100, 2) AS gdp_growth,
	ROUND((tbp2.avg_payroll - tbp.avg_payroll) / tbp.avg_payroll  * 100, 2) AS payroll_growth,
	ROUND((tbp2.avg_product_price - tbp.avg_product_price) / tbp.avg_product_price * 100, 2) AS product_price_growth
FROM temp_beta_payrollpricegdp tbp
JOIN temp_beta_payrollpricegdp tbp2
	ON tbp.`year`+1 = tbp2.`year`;