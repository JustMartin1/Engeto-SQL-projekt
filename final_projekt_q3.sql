/*
 * 
 * Engeto SQL projekt otázka č. 3
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 * 
 */

SELECT
	*
FROM t_martinminceff_sql_primary_final pf;


CREATE OR REPLACE TABLE temp_averagefoodprice_beta
SELECT DISTINCT 								-- average annual price OF food categories
	pf.payroll_year AS `year`,
	pf.category_code,
	pf.product_name,
	pf.avg_year_price
FROM t_martinminceff_sql_primary_final pf
WHERE pf.category_code IS NOT NULL
ORDER BY pf.product_name, pf.payroll_year;


SELECT
	tab.product_name,
	tab.`year`,
	tab.avg_year_price,
	tab2.`year` AS next_year,
	tab2.avg_year_price AS next_year_price,
	ROUND((tab2.avg_year_price - tab.avg_year_price ) / tab.avg_year_price * 100, 2) AS year_price_growth
FROM temp_averagefoodprice_beta tab
JOIN temp_averagefoodprice_beta tab2
	ON tab.category_code = tab2.category_code
	AND tab.`year`+1 = tab2.`year`;


WITH question3final AS
(
SELECT
	tab.product_name,
	tab.`year`,
	tab.avg_year_price,
	tab2.`year` AS next_year,
	tab2.avg_year_price AS next_year_price,
	ROUND((tab2.avg_year_price - tab.avg_year_price ) / tab.avg_year_price * 100, 2) AS year_price_growth
FROM temp_averagefoodprice_beta tab
JOIN temp_averagefoodprice_beta tab2
	ON tab.category_code = tab2.category_code
	AND tab.`year`+1 = tab2.`year`
)
SELECT
	product_name,
	ROUND(AVG(year_price_growth), 2) AS fulltime_growth
FROM question3final
GROUP BY product_name
ORDER BY ROUND(AVG(year_price_growth), 2);