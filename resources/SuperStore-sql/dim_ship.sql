CREATE TABLE IF NOT EXISTS dim_ship (
    `Ship ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Ship Mode` ENUM('Second Class', 'Standard Class', 'First Class', 'Same Day')
)

INSERT INTO dim_ship (`Ship Mode`)
SELECT DISTINCT `Ship Mode`
FROM SuperStore.transaction_bronze;

SELECT * FROM dim_ship