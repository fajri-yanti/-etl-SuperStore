from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.operators.empty import EmptyOperator
import pandas as pd
from sqlalchemy import create_engine
from datetime import datetime


def insert_data_from_excel():
    file_path = './data/SuperStore/Superstore.csv'
    df = pd.read_csv(file_path, encoding="latin1")

    engine = create_engine("mysql+mysqlconnector://root:pass@host:port/SuperStore")

    df.to_sql('transaction_data', con=engine, if_exists='append', index=False)
    print("Data successfully inserted into MySQL.")

with DAG(
    dag_id='load_excel_to_mysql',
    schedule_interval=None,
    start_date=datetime(2024, 12, 19),
    catchup=False,
) as dag:
    start_task = EmptyOperator(task_id="start_task")
    insert_data_task = PythonOperator(
        task_id='insert_data_from_excel',
        python_callable=insert_data_from_excel
    )
    end_task = EmptyOperator(task_id="end_task")

    start_task >> insert_data_task >> end_task
