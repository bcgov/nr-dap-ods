FROM python:3.11.9-slim-bookworm

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2 \
    && pip install pandas \
    && pip install boto3 \
    && pip install requests \
    && pip install sqlalchemy

# Setup working directory
WORKDIR /app

# Copy project files
COPY . .



