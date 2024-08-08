-- sekundární tabulka - Evropské státy
CREATE TABLE T_JAN_KOPPAN_PROJECT_SQL_SECONDARY_FINAL AS
SELECT *
FROM economies e
WHERE country IN (
    'Albania', 'Andorra', 'Austria', 'Belarus', 'Belgium', 
    'Bosnia and Herzegovina', 'Bulgaria', 'Channel Islands', 
    'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 
    'Faroe Islands', 'Finland', 'France', 'Germany', 'Gibraltar', 
    'Greece', 'Greenland', 'Hungary', 'Iceland', 'Ireland', 
    'Isle of Man', 'Italy', 'Kosovo', 'Latvia', 'Liechtenstein', 
    'Lithuania', 'Luxembourg', 'Malta', 'Moldova', 'Monaco', 
    'Montenegro', 'Netherlands', 'North Macedonia', 'Norway', 
    'Poland', 'Portugal', 'Romania', 'Russia', 'San Marino', 
    'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 
    'Switzerland', 'Ukraine', 'United Kingdom', 'Vatican City')
AND year BETWEEN 2006 AND 2018;