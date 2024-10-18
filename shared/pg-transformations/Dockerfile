FROM python:3.11.4-slim-buster

# PostgreSQL library

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2

WORKDIR /app

COPY . .

