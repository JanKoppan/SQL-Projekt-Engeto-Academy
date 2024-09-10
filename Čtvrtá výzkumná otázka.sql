-- Čtvrtá výzkumná otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
-- 1. Krok: Meziroční nárůst cen potravin v procentech
WITH yearly_avg_price AS (
    SELECT 
        category_code,
        YEAR(date_from) AS year,
        AVG(value) AS avg_value
    FROM 
        czechia_price
    GROUP BY 
        category_code,
        YEAR(date_from)
),
yearly_change AS (
    SELECT 
        category_code,
        year,
        avg_value,
        LAG(avg_value) OVER (PARTITION BY category_code ORDER BY year) AS prev_avg_value
    FROM 
        yearly_avg_price
),
average_increase AS (
    SELECT 
        year,
        AVG((avg_value / prev_avg_value - 1) * 100) AS average_annual_increase 
    FROM 
        yearly_change
    WHERE 
        prev_avg_value IS NOT NULL
    GROUP BY 
        year
)
    SELECT 
        year,
        ROUND(average_annual_increase, 2) AS average_annual_increase
    FROM 
        average_increase
    ORDER BY
        year;
-- 2. Krok: Meziroční nárůst mezd v procentech
WITH yearly_avg_payroll AS (
    SELECT 
        industry_branch_code,
        payroll_year,
        AVG(value) AS avg_value,
        LAG(AVG(value)) OVER (PARTITION BY industry_branch_code ORDER BY payroll_year) AS prev_avg_value
    FROM 
        czechia_payroll
    WHERE 
        value_type_code = 5958 
        AND industry_branch_code IS NOT NULL 
        AND payroll_year BETWEEN 2006 AND 2018
    GROUP BY 
        industry_branch_code, 
        payroll_year
)
    SELECT 
        payroll_year,
        AVG(avg_value) AS avg_value,
        AVG(
        CASE 
            WHEN prev_avg_value IS NOT NULL AND prev_avg_value <> 0 THEN (avg_value - prev_avg_value) / prev_avg_value * 100
            ELSE NULL
        END
        ) AS avg_percent_change
    FROM 
        yearly_avg_payroll
    WHERE 
        prev_avg_value IS NOT NULL
    GROUP BY 
        payroll_year
    ORDER BY 
        payroll_year;
