CREATE TABLE fact_transaction (
    `Row ID` INT,
    `Order ID` VARCHAR(100),
    `Order Date Key` DATE,
    `Ship Date Key` DATE,
    `Customer ID` VARCHAR(100),
    `Product ID` VARCHAR(100),
    `Sales` DECIMAL(10, 2),
    `Profit` DECIMAL(10, 2),
    `Discount` DECIMAL(4, 2),
    `Quantity` INT,
    FOREIGN KEY (`Order Date Key`) REFERENCES dim_date(`Date Key`),
    FOREIGN KEY (`Ship Date Key`) REFERENCES dim_date(`Date Key`),
    FOREIGN KEY (`Customer ID`) REFERENCES dim_customer(`Customer ID`),
    FOREIGN KEY (`Product ID`) REFERENCES dim_product(`Product ID`),
    PRIMARY KEY (`Order ID`, `Product ID`, `Row ID`)
);
INSERT INTO fact_transaction (
    `Row ID`,
    `Order ID`,
    `Order Date Key`,
    `Ship Date Key`,
    `Customer ID`,
    `Product ID`,
    `Sales`,
    `Profit`,
    `Discount`,
    `Quantity`
)
SELECT 
    tb.`Row ID`,
    tb.`Order ID`,
    STR_TO_DATE(tb.`Order Date`, '%d-%m-%Y') AS `Order Date Key`,
    STR_TO_DATE(tb.`Ship Date`, '%d-%m-%Y') AS `Ship Date Key`,
    tb.`Customer ID`,
    tb.`Product ID`,
    tb.`Sales`,
    tb.`Profit`,
    tb.`Discount`,
    tb.`Quantity`
FROM transaction_bronze tb
JOIN dim_date od 
    ON STR_TO_DATE(tb.`Order Date`, '%d-%m-%Y') = od.`Date Key`
JOIN dim_date sd 
    ON STR_TO_DATE(tb.`Ship Date`, '%d-%m-%Y') = sd.`Date Key`;
-- SELECT * FROM fact_transaction