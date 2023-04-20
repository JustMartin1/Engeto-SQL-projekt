/*
 * 
 * Engeto SQL projekt otázka č. 2
 * Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
 * 
 */

SELECT 
	*
FROM t_martinminceff_sql_primary_final tmspf ;


SELECT 
	tmspf .`year` ,
	tmspf .product_name ,
	ROUND(AVG(tmspf .avg_month_payroll), 2) AS avg_month_payroll_allindustries,
	ROUND(AVG(tmspf .avg_month_payroll)*12, 2) AS avg_year_payroll,
	ROUND(AVG(tmspf .avg_year_price), 2) AS avg_year_product_price ,
	ROUND(AVG((tmspf .avg_month_payroll)*12) / (tmspf .avg_year_price), 2) AS value,
	tmspf .price_unit 
FROM t_martinminceff_sql_primary_final tmspf
WHERE tmspf .payroll_year IN(2006, 2018)
	AND tmspf .category_code IN(111301, 114201)
GROUP BY tmspf .`year`, tmspf .product_name  
ORDER BY tmspf .`year`;






























