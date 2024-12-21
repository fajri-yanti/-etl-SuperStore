CREATE TABLE IF NOT EXISTS dim_product (
    `Product ID` VARCHAR(255),
    `Product Name` VARCHAR(255),
    `Category` VARCHAR(255),
    `Sub-Category` VARCHAR(255),
    PRIMARY KEY (`Product ID`)
);

INSERT IGNORE INTO dim_product (`Product ID`, `Product Name`, `Category`, `Sub-Category`)
SELECT DISTINCT 
    `Product ID`,
    `Product Name`,
    `Category`,
    `Sub-Category`
FROM SuperStore.transaction_bronze;
