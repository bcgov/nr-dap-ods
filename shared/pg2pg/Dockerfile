FROM python:3.11.4-slim-buster

WORKDIR /app

# PostgreSQL library

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2

COPY . .

RUN pip3 install -r requirements.txt

CMD ["python3", "./data_replication_pg2pg.py"]
