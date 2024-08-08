-- Pátá výzkumná otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
WITH yearly_avg AS (
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
            WHEN prev_avg_value IS NOT NULL THEN (avg_value - prev_avg_value) / prev_avg_value * 100
            ELSE 0 
        END
    ) AS avg_percent_change
    FROM 
        yearly_avg
    GROUP BY 
        payroll_year
    ORDER BY 
        payroll_year;