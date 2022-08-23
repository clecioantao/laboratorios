FROM apache/airflow:2.3.3
LABEL maintainer="clecio.antao@gmail.com"
USER root
RUN apt-get update -y
RUN python -m pip install --upgrade pip
COPY requirements.txt .
USER airflow
RUN pip install -r requirements.txt