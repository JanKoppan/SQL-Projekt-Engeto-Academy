-- Druhá výzkumná otázka: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
-- Poslední období - mléko
SELECT 
    cz_price.*, 
    cz_payroll.*, 
    cz_payroll.value / cz_price.value AS posledni_obdobi_mleko
FROM 
    czechia_price cz_price 
JOIN 
    czechia_payroll cz_payroll 
ON 
    cz_payroll.payroll_year = YEAR(cz_price.date_from)
WHERE 
    cz_price.category_code = 114201 
    AND cz_payroll.value_type_code = 5958 
    AND cz_price.value IS NOT NULL 
    AND cz_price.value != 0
    AND INDUSTRY_BRANCH_CODE  IS NOT NULL
ORDER BY 
    cz_price.date_from DESC;
-- První období - mléko
SELECT 
    cz_price.*, 
    cz_payroll.*, 
    cz_payroll.value / cz_price.value AS prvni_obdobi_mleko
FROM 
    czechia_price cz_price 
JOIN 
    czechia_payroll cz_payroll 
ON 
    cz_payroll.payroll_year = YEAR(cz_price.date_from)
WHERE 
    cz_price.category_code = 114201 
    AND cz_payroll.value_type_code = 5958 
    AND cz_price.value IS NOT NULL 
    AND cz_price.value != 0
ORDER BY 
    cz_price.date_from ASC;  
-- Poslední období - chleba
SELECT 
    cz_price.*, 
    cz_payroll.*, 
    cz_payroll.value / cz_price.value AS posledni_obdobi_chleba
FROM 
    czechia_price cz_price 
JOIN 
    czechia_payroll cz_payroll 
ON 
    cz_payroll.payroll_year = YEAR(cz_price.date_from)
WHERE 
    cz_price.category_code = 111301 
    AND cz_payroll.value_type_code = 5958 
    AND cz_price.value IS NOT NULL 
    AND cz_price.value != 0
ORDER BY 
    cz_price.date_from DESC;
-- První období - chleba
SELECT 
    cz_price.*, 
    cz_payroll.*, 
    cz_payroll.value / cz_price.value AS prvni_obdobi_chleba
FROM 
    czechia_price cz_price 
JOIN 
    czechia_payroll cz_payroll 
ON 
    cz_payroll.payroll_year = YEAR(cz_price.date_from)
WHERE 
    cz_price.category_code = 111301 
    AND cz_payroll.value_type_code = 5958 
    AND cz_price.value IS NOT NULL 
    AND cz_price.value != 0
ORDER BY 
    cz_price.date_from ASC;
