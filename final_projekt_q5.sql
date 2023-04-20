/*
 * 
 * Engeto SQL projekt otázka č. 5
 * 
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
 * ve stejném nebo následujícím roce výraznějším růstem?
 * 
 */


SELECT 
	*
FROM t_martinminceff_sql_primary_final tmspf ;




CREATE OR REPLACE TABLE temp_q5_avgpayrollprice_andgrowth
SELECT 
	tmspf .`year` ,
	ROUND(AVG(avg_month_payroll), 2) AS avg_payroll,
	ROUND(AVG(avg_year_price), 2) AS avg_product_price,
	GDP,
	year_GDP_growth 
FROM t_martinminceff_sql_primary_final tmspf 
GROUP BY `year` ;


SELECT 
	tqaa .`year` ,
	tqaa .avg_payroll ,
	tqaa .avg_product_price ,
	tqaa .GDP ,
	tqaa2 .`year` AS next_year,
	tqaa2 .avg_payroll AS nextyear_payroll,
	tqaa2 .avg_product_price AS nextyear_price,
	tqaa2 .GDP AS nextyear_gdp,
	ROUND((tqaa2.avg_payroll - tqaa.avg_payroll) / tqaa .avg_payroll  * 100, 2) AS payroll_growth,
	ROUND((tqaa2.avg_product_price-tqaa.avg_product_price)/tqaa .avg_product_price * 100, 2) AS product_price_growth,
	ROUND((tqaa2.GDP - tqaa.GDP) / tqaa .GDP * 100, 2) AS gdp_growth 
FROM temp_q5_avgpayrollprice_andgrowth tqaa 
JOIN temp_q5_avgpayrollprice_andgrowth tqaa2 
	ON tqaa .`year`+1 = tqaa2 .`year` ;


SELECT 
	tqaa .`year` ,
	ROUND((tqaa2.GDP - tqaa.GDP) / tqaa .GDP * 100, 2) AS gdp_growth,
	ROUND((tqaa2.avg_payroll - tqaa.avg_payroll) / tqaa .avg_payroll  * 100, 2) AS payroll_growth,
	ROUND((tqaa2.avg_product_price-tqaa.avg_product_price)/tqaa .avg_product_price * 100, 2) AS product_price_growth 
FROM temp_q5_avgpayrollprice_andgrowth tqaa 
JOIN temp_q5_avgpayrollprice_andgrowth tqaa2 
	ON tqaa .`year`+1 = tqaa2 .`year` ;





















