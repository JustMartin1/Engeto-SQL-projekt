/*
 * 
 * Engeto SQL projekt otázka č. 1
 * Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 * 
 */

SELECT 									-- výpočet průměrné měsíční mzdy pro jednotlivá odvětví a roky
	cp.industry_branch_code,
	cpib.name,
	cp.payroll_year,
	ROUND(SUM(value)/COUNT(1) , 3) AS avg_month_payroll
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code 
WHERE cp.value_type_code = 5958
	AND industry_branch_code IS NOT NULL
GROUP BY payroll_year, industry_branch_code
ORDER BY industry_branch_code, payroll_year ;



CREATE OR REPLACE TABLE t_question1_year_avgpayroll_industrycodename
SELECT 
	cp.industry_branch_code,
	cpib.name,
	cp.payroll_year,
	ROUND(SUM(value)/COUNT(1) , 3) AS avg_month_payroll
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cp.industry_branch_code = cpib.code 
WHERE cp.value_type_code = 5958
	AND industry_branch_code IS NOT NULL
GROUP BY payroll_year, industry_branch_code;



SELECT 								-- výpočet růstu mezd v jednotlivých odvětvích vyjádřený v %
	tqyai.industry_branch_code,
	tqyai.name,
	tqyai.payroll_year,
	tqyai.avg_month_payroll,
	tqyai2.payroll_year AS payroll_next_year,
	tqyai2.avg_month_payroll AS avg_next_year_month_payroll,
	round(( tqyai2.avg_month_payroll  - tqyai.avg_month_payroll ) / tqyai.avg_month_payroll * 100, 2 ) as avg_payroll_growth
FROM t_question1_year_avgpayroll_industrycodename tqyai 
JOIN t_question1_year_avgpayroll_industrycodename tqyai2
	ON tqyai.industry_branch_code = tqyai2.industry_branch_code 
	AND tqyai.payroll_year + 1 = tqyai2.payroll_year
ORDER BY tqyai.industry_branch_code, tqyai.payroll_year;