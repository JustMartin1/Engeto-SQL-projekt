CREATE OR REPLACE TABLE t_martinminceff_sql_primary_final
SELECT
        jedna.industry_branch_code,
        jedna.name AS industry_name,
        jedna.payroll_year,
        jedna.avg_month_payroll,
        dva.category_code,
        dva.name AS product_name,
        dva.avg_year_price,
        dva.price_unit,
        tri.`year`,
        tri.GDP,
        tri.next_year,
        tri.GDP_next_year,
        tri.year_GDP_growth
FROM (
          SELECT 														-- osekana tabulka czechiapayroll + czechiapayroll_industry_branch (1/3)
				cp.industry_branch_code ,
				cpib.name ,
				cp.payroll_year,
				ROUND(AVG(cp.value), 2) AS avg_month_payroll
			FROM czechia_payroll cp
			JOIN czechia_payroll_industry_branch cpib 
				ON cp.industry_branch_code = cpib.code
			WHERE cp.value_type_code = 5958
				AND cp.industry_branch_code IS NOT NULL
			GROUP BY cp.payroll_year, cp.industry_branch_code	
		 ) jedna
LEFT JOIN 
         (
          SELECT 														-- osekana tabulka czechiaprice + czechiaprice category (2/3)
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
         ) dva
ON jedna.payroll_year = dva.year
JOIN 
		 (
          SELECT 														-- osekana tabulka economies pro cesko (3/3)
				e.country,
				e.`year` AS year,
				e.GDP,
				e2.`year` AS next_year,
				e2.GDP AS GDP_next_year,
				ROUND(( e2.GDP - e.GDP ) / e.GDP  * 100, 2 ) as year_GDP_growth
			FROM economies e 
			JOIN economies e2 
				ON e.country = e2.country 
				AND e.`year`+1 = e2.`year`
			WHERE e.country = 'Czech Republic'
				AND e.`year` BETWEEN 2000 AND 2022 
         ) tri
ON jedna.payroll_year = tri.YEAR
ORDER BY jedna.industry_branch_code, jedna.payroll_year, dva.name;










