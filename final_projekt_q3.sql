/*
 * 
 * Engeto SQL projekt otázka č. 3
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
 * 
 */



SELECT 
	*
FROM t_martinminceff_sql_primary_final tmspf ;


CREATE OR REPLACE TABLE temp_average_food_price 
SELECT DISTINCT 												-- průměrna roční cena potravin pro jednotlivé roky
	tmspf .`year` ,
	tmspf .category_code ,
	tmspf .product_name ,
	tmspf .avg_year_price 
FROM t_martinminceff_sql_primary_final tmspf
WHERE tmspf .category_code IS NOT NULL 
ORDER BY tmspf .product_name, tmspf .`year`  ;


SELECT 
	tafp .product_name ,
	tafp .`year` ,
	tafp .avg_year_price ,
	tafp2 .`year` AS next_year,
	tafp2 .avg_year_price AS next_year_price,
	ROUND(( tafp2.avg_year_price-tafp.avg_year_price ) / tafp.avg_year_price * 100, 2) AS year_price_growth
FROM temp_average_food_price tafp
JOIN temp_average_food_price tafp2 
	ON tafp.category_code = tafp2 .category_code 
	AND tafp .`year` +1 = tafp2 .`year` ;


WITH question3final AS
	(
		SELECT 
			tafp .product_name ,
			tafp .`year` ,
			tafp .avg_year_price ,
			tafp2 .`year` AS next_year,
			tafp2 .avg_year_price AS next_year_price,
			ROUND(( tafp2.avg_year_price-tafp.avg_year_price ) / tafp.avg_year_price * 100, 2) AS year_price_growth
		FROM temp_average_food_price tafp
		JOIN temp_average_food_price tafp2 
			ON tafp.category_code = tafp2 .category_code 
			AND tafp .`year` +1 = tafp2 .`year`
	)
SELECT
	product_name,
	ROUND(AVG(year_price_growth), 2) AS fulltime_growth
FROM question3final
GROUP BY product_name
ORDER BY ROUND(AVG(year_price_growth), 2);





























