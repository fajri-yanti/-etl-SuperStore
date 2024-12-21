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

### Data Schema
The dataset includes the following main tables:
1. orders
2. customers
3. products
4. sales

