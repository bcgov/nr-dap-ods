FROM python:3.11.9-slim-bookworm


# PostgreSQL library

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2 \
    && pip install pandas

WORKDIR /app

COPY . .

