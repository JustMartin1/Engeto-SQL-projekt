/*
 * 
 * Engeto SQL projekt otázka č. 1
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 * 
 */


SELECT 
	*
FROM t_martinminceff_sql_primary_final pf;


SELECT DISTINCT
	pf.industry_branch_code,
	pf.industry_name,
	pf.payroll_year,
	pf.avg_month_payroll,
	pf2.payroll_year AS payroll_nextyear,
	pf2.avg_month_payroll AS payroll_nextyear,
	ROUND((pf2.avg_month_payroll - pf.avg_month_payroll) / pf.avg_month_payroll * 100, 2) as avg_payroll_growth
FROM t_martinminceff_sql_primary_final pf
JOIN t_martinminceff_sql_primary_final pf2
	ON pf.industry_branch_code = pf2.industry_branch_code
	AND pf.payroll_year + 1 = pf2.payroll_year;


WITH avg_payroll_dude AS
(
SELECT DISTINCT
	pf.industry_branch_code,
	pf.industry_name,
	pf.payroll_year,
	pf.avg_month_payroll,
	pf2.payroll_year AS payroll_nextyear,
	pf2.avg_month_payroll AS month_payroll_nextyear,
	ROUND((pf2.avg_month_payroll - pf.avg_month_payroll) / pf.avg_month_payroll * 100, 2) as avg_payroll_growth
FROM t_martinminceff_sql_primary_final pf
JOIN t_martinminceff_sql_primary_final pf2
	ON pf.industry_branch_code = pf2.industry_branch_code
	AND pf.payroll_year + 1 = pf2.payroll_year
)
SELECT
	industry_branch_code,
	industry_name,
	ROUND(AVG(avg_payroll_growth), 2) AS alltime_payroll_growth
FROM avg_payroll_dude
GROUP BY industry_branch_code
ORDER BY industry_branch_code;