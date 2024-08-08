-- První výzkumná otázka: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
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
    GROUP BY 
        industry_branch_code, 
        payroll_year
        )
    SELECT 
        industry_branch_code,
        payroll_year,
        avg_value
    FROM 
        yearly_avg
    WHERE 
        avg_value < prev_avg_value;
