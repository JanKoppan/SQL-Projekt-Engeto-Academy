-- Pátá výzkumná otázka: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem? 
SELECT
    country,
    year,
    GDP,
    avg_annual_growth_percent
FROM (
    SELECT
        country,
        year,
        GDP,
        ROUND((GDP / LAG(GDP) OVER (ORDER BY year) - 1) * 100, 2) AS avg_annual_growth_percent
    FROM 
        economies e 
    WHERE 
        country = 'European Union'
        AND year BETWEEN 2006 AND 2018
) AS subquery
WHERE 
    avg_annual_growth_percent IS NOT NULL
ORDER BY 
    year ASC;
