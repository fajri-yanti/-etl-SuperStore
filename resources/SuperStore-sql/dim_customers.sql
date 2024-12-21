CREATE TABLE IF NOT EXISTS dim_customer (
    `Customer ID` VARCHAR(100),
    `Customer Name` VARCHAR(100),
    `Segment` ENUM("Consumer", "Corporate", "Home Office"),
    `Country` VARCHAR(100),
    `State` VARCHAR(100),
    `Region` VARCHAR(100),
    `City` VARCHAR(100),
    `Postal Code` VARCHAR(10),
    PRIMARY KEY (`Customer ID`)
);

INSERT IGNORE INTO dim_customer (`Customer ID`, `Customer Name`, `Segment`, `Country`, `State`, `Region`, `City`, `Postal Code`)
SELECT DISTINCT 
    `Customer ID`,
    `Customer Name`,
    `Segment`,
    `Country`,
    `State`,
    `Region`,
    `City`,
    `Postal Code`
FROM SuperStore.transaction_bronze;

SELECT * FROM dim_customer;