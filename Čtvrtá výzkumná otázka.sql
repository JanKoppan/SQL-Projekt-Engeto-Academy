-- Čtvrtá výzkumná otázka: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
WITH yearly_avg AS (
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
        yearly_avg
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
