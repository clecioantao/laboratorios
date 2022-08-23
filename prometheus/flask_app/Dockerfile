FROM tiangolo/uwsgi-nginx-flask:python3.7
RUN pip install prometheus_client
ENV LISTEN_PORT 5005
EXPOSE 5005
COPY ./app /app
WORKDIR /app