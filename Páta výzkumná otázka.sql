-- Pátá výzkumná otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
-- CTE pro výpočet meziročního růstu HDP
WITH GDP_growth AS (
    SELECT
        country,
        year,
        GDP,
        ROUND((GDP / LAG(GDP) OVER (PARTITION BY country ORDER BY year) - 1) * 100, 2) AS avg_annual_growth_percent
    FROM 
        economies
    WHERE 
        country = 'European Union'
        AND year BETWEEN 2006 AND 2018
)
-- Finální dotaz využívající CTE
SELECT
    country,
    year,
    GDP,
    avg_annual_growth_percent
FROM 
    GDP_growth
WHERE 
    avg_annual_growth_percent IS NOT NULL
ORDER BY 
    year ASC;
