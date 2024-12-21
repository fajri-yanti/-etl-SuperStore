import yaml
from airflow.decorators import dag
from airflow.operators.python import PythonOperator
from airflow.operators.empty import EmptyOperator
import pandas as pd
from airflow.providers.mysql.hooks.mysql import MySqlHook
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime

with open("dags/resources/dynamic-dag/list_tables.yaml") as f:
    list_tables = yaml.safe_load(f)

db_mysql = "SuperStore"
db_postgre = "superstore"
def extract_data(ti, table):
    mysql_hook = MySqlHook("mysql_dibimbing")
    engine = mysql_hook.get_sqlalchemy_engine()
    query = f"SELECT * FROM {db_mysql}.{table}"
    
    with engine.connect() as conn:
        df = pd.read_sql(query, conn)
    
    ti.xcom_push(key=f'extract_table_{table}', value=df.to_json())

def load_data(ti, table, db_postgre):
    df_json = ti.xcom_pull(key=f'extract_table_{table}', task_ids=f'extract_{table}')
    df = pd.read_json(df_json)
    
    postgres_hook = PostgresHook("postgres_dibimbing", schema=db_postgre)
    engine = postgres_hook.get_sqlalchemy_engine()
    
    with engine.connect() as conn:
        df.to_sql(table, con=conn, if_exists='append', index=False)

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1
}

@dag(
    dag_id="mysql_to_postgres",
    default_args=default_args,
    description="Simple DAG for Extract Load",
    schedule_interval="15 9-21/2 * * 5#1,5#3",  
    catchup=False,
    max_active_runs=1,
    start_date=datetime(2024, 12, 20),  
)

def dynamic_dag_SuperStore():
    start_task = EmptyOperator(task_id="start_task")
    end_task = EmptyOperator(task_id="end_task")

    for table in list_tables:
        extract = PythonOperator(
            task_id=f"extract_{table}",
            python_callable=extract_data,
            op_kwargs={"table": table},
        )
        
        load = PythonOperator(
            task_id=f"load_{table}",
            python_callable=load_data,
            op_kwargs={"table": table},
        )
        
        start_task >> extract >> load >> end_task

dynamic_dag_SuperStore()
