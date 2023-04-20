/*
 * 
 * Engeto SQL projekt otázka č. 1
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 * 
 */


SELECT 
	*
FROM t_martinminceff_sql_primary_final tmspf ;


SELECT DISTINCT 
	tmspf.industry_branch_code,
	tmspf .industry_name ,
	tmspf .payroll_year ,
	tmspf .avg_month_payroll ,
	tmspf2 .payroll_year AS payroll_nextyear ,
	tmspf2 .avg_month_payroll AS payroll_nextyear ,
	round(( tmspf2 .avg_month_payroll  - tmspf .avg_month_payroll ) / tmspf .avg_month_payroll * 100, 2 ) as avg_payroll_growth
FROM t_martinminceff_sql_primary_final tmspf
JOIN t_martinminceff_sql_primary_final tmspf2 
	ON tmspf .industry_branch_code = tmspf2 .industry_branch_code 
	AND tmspf .payroll_year + 1 = tmspf2 .payroll_year 
;



WITH avg_payroll_dude AS
(
	SELECT DISTINCT 
		tmspf.industry_branch_code,
		tmspf .industry_name ,
		tmspf .payroll_year ,
		tmspf .avg_month_payroll ,
		tmspf2 .payroll_year AS payroll_nextyear ,
		tmspf2 .avg_month_payroll AS avg_monthpayroll_nextyear ,
		round(( tmspf2 .avg_month_payroll  - tmspf .avg_month_payroll ) / tmspf .avg_month_payroll * 100, 2 ) as avg_payroll_growth
	FROM t_martinminceff_sql_primary_final tmspf
	JOIN t_martinminceff_sql_primary_final tmspf2 
		ON tmspf .industry_branch_code = tmspf2 .industry_branch_code 
		AND tmspf .industry_name = tmspf2 .industry_name 
		AND tmspf .payroll_year + 1 = tmspf2 .payroll_year 
)
SELECT 
	industry_branch_code ,
	industry_name ,
	ROUND(AVG(avg_payroll_growth), 2) AS alltime_payroll_growth
FROM avg_payroll_dude
GROUP BY industry_branch_code 
ORDER BY industry_branch_code ;