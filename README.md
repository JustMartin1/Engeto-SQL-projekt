# Engeto-SQL-projekt
Nick na discordu Martin M.#3472

Úvod do projektu

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, 
jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, 
které adresují dostupnost základních potravin široké veřejnosti. 
Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout 
tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující 
konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět 
porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších 
evropských států ve stejném období, jako primární přehled pro ČR.

Datové sady, které je možné použít pro získání vhodného datového podkladu
Primární tabulky:

czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

Dodatečné tabulky:

countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.

V ramci projektu jsem pripravil pozadovane dve tabulky: t_martinminceff_primary_final, kde jsem si
vyselektoval potrebne informace z tabulek czechia_price a czechia_category. Tuto tabulku jsem pouzil 
pro ziskani odpovedi na otazky 1 - 4.

Druhou tabulku t_martinminceff_secondary_final jsem vytvoril z tabulek countries a economies. Tuto tabulku
jsem pouzil pro ziskani odpovedi na posledni otazku c. 5.


Výzkumné otázky
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední 
srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd
(větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste 
výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném 
nebo následujícím roce výraznějším růstem?


Vyzkumne odpovedi:

1. Z vysledku muzeme videt, ze v prubehu sledovanych let mzdy rostou ve vsech odvetvich v prumeru 
kolem 4-5% rocne. Nejvyssi rust jsme zaznamenali v odvetvi Zdravotni a socialni pece - v prumeru 6.7%
rocne a nejnizsi rust mezd  ve sledovanem obdobi byl v oblasti Tezby a dobyvani nerostnych surovin,
kde mzdy rostly v prumeru 4.11%.

2. V roce 2006 jakozto prvnim srovnatelnem obdobi byla prumerna rocni mzda 249 tisic Kc, za kterou se
dalo koupit pres 15 tun chleba nebo 17 tisic litru mleka. Posledni srovnatelne obdobi rok 2018
byla prumerna rocni mzda 390 tisic Kc, za ktere se dalo poridit pres 16 tun chleba nebo pres 
19 tisic litru mleka.

3. Ve sledovanem obdobi byl nejnizsi percentualni mezirocni narust cen u cukru, u ktereho hodnota
klesala prumerne o necele 2% rocne, takze na konci (2018) sledovaneho obdobi byl levnejsi nez na 
jeho zacatku (2006). Ze sledovanych kategorii byly na konci sledovaneho obdobi levnejsi jeste 
cervena jablka, ktera zlevnovala o 0.74% rocne. Na opacne strane nejvyssi percentualni mezirocni 
narust cen nastal u paprik (7.29%), masla (6.68) a slepicich vajec (5.56%).

4. Mezi lety 2006 - 2017 nebyl zaznamenan mezirocni narust cen potravin oproti mzdam vyssi nez 10%.
Nejblize tomu byl rok 2008, kdy ceny potravin rostly oproti mzdam v prumeru o vice nez 9%. Na opacne
strane je rok 2012, kdy rostly mzdy oproti potravinam o 6.6%.

5. Z vysledne tabulky jsem nevypozoroval zadnou spojitost mezi zmenami HDP, vysi mezd nebo
rustem cen potravin.


