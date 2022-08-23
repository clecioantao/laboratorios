# -*- coding: utf-8 -*-
"""
Created on Fri Feb 12 13:31:57 2021
@author: Clecio Antao
Rotina para leitura de API Desk Manager para popular tabela SQL Server
"""

from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.operators.email_operator import EmailOperator
#from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago

from utils.callables import popula_elastic_finalizados, popula_elastic_aguardando


dag = DAG(
    "elastic_desk",
    default_args={
        "owner": "airflow",
        'email': ['clecio.antao@gmail.com'],
        'email_on_failure': True,
    },
    schedule_interval='*/5 * * * *',
    start_date=days_ago(1),
    dagrun_timeout=timedelta(minutes=120),
    catchup=False,
    tags=['etl'],
)

t1 = PythonOperator(
    task_id='popula_elastic_finalizados', 
    python_callable=popula_elastic_finalizados,
    #params={"rel": "868","tab":"DeskManagerAF"},
    dag=dag
)

t2 = PythonOperator(
    task_id='popula_elastic_aguardando', 
    python_callable=popula_elastic_aguardando,
    #params={"rel": "868","tab":"DeskManagerAF"},
    dag=dag
)

t1 >> t2