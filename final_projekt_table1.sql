CREATE OR REPLACE TABLE t_martinminceff_sql_primary_final
SELECT
	payroll.industry_branch_code,
	payroll.name AS industry_name,
	payroll.payroll_year,
	payroll.avg_month_payroll,
	price.category_code,
	price.name AS product_name,
	price.avg_year_price,
	price.price_unit
FROM
(
SELECT 								-- tables czechiapayroll + czechiapayroll_industry_branch (1/2)
	cp.industry_branch_code,
	cpib.name,
	cp.payroll_year,
ROUND(AVG(cp.value), 2) AS avg_month_payroll
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code
WHERE cp.value_type_code = 5958
	AND cp.industry_branch_code IS NOT NULL
GROUP BY cp.payroll_year, cp.industry_branch_code
) payroll
LEFT JOIN
	(
	SELECT 								-- tables czechiaprice + czechiaprice category (2/2)
		cp2.category_code,
		cpc.name,
		YEAR(cp2.date_from) AS year,
		ROUND(AVG(cp2.value), 2) AS avg_year_price,
		cpc.price_unit
	FROM czechia_price cp2
	JOIN czechia_price_category cpc
		ON cp2.category_code = cpc.code
	GROUP BY cp2.category_code, YEAR(cp2.date_from)
	ORDER BY cp2.category_code, YEAR(cp2.date_from)
	) price
	ON payroll.payroll_year = price.year
ORDER BY payroll.industry_branch_code, payroll.payroll_year, price.name;