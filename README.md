# Superstore Data Pipeline Project

## Overview
This project implements an automated data pipeline using Apache Airflow to extract Superstore dataset from MySQL database and load it into PostgreSQL database for further analysis. The pipeline handles retail data including orders, customers, products, and sales information.

## Prerequisites
- Python 3.8+
- Apache Airflow 2.5+
- MySQL 8.0+
- PostgreSQL 13+
- Docker (optional)

## Dataset Information 
[source](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)<br></br>
The Superstore dataset  contains retail information with the following key features:
- Sales and order information
- Customer demographics
- Product categories and sub-categories
- Regional data
- Profit and discount details

### ERD

![ERD](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/SuperStoreERD.png)

### Graph Airflow
![Graph](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/graph.png)

### List Tabele - YAML config
![Config](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/list_table_yaml.png)

### Output PostgreSQL
- Table dim_customer<br></br>
![dim_customer](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/pg_dim_customer.png) <br>

- Table dim_product<br></br>
![dim_product](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/pg_dim_product.png)

- Table dim_customer<br></br>
![dim_ship](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/pg_dim_ship.png)

- Table fact_transaction<br></br>
![fact_transaction](https://github.com/fajri-yanti/Data-Pipeline-SuperStore/blob/main/pg_fact_transaction.png)
