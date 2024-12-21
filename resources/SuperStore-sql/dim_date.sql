CREATE TABLE IF NOT EXISTS dim_date (
    `Date Key` DATE PRIMARY KEY, 
    `Year` INT,
    `Month` INT,
    `Month Name` VARCHAR(20),
    `Quarter` INT,
    `Day` INT,
    `Day Name` VARCHAR(20),
    `Week` INT
);


INSERT IGNORE INTO dim_date (`Date Key`, `Year`, `Month`, `Month Name`, `Quarter`, `Day`, `Day Name`, `Week`)
SELECT DISTINCT
    d.`Date Key`,
    YEAR(d.`Date Key`) AS `Year`,
    MONTH(d.`Date Key`) AS `Month`,
    MONTHNAME(d.`Date Key`) AS `Month Name`,
    QUARTER(d.`Date Key`) AS `Quarter`,
    DAY(d.`Date Key`) AS `Day`,
    DAYNAME(d.`Date Key`) AS `Day Name`,
    WEEK(d.`Date Key`, 1) AS `Week`
FROM (
    SELECT DISTINCT STR_TO_DATE(`Order Date`, '%d-%m-%Y') AS `Date Key` FROM SuperStore.transaction_bronze
    UNION
    SELECT DISTINCT STR_TO_DATE(`Ship Date`, '%d-%m-%Y') AS `Date Key` FROM SuperStore.transaction_bronze
) d;
`