FROM python:3.11.9-slim-bookworm

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2

WORKDIR /app

COPY requirements.txt .

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

