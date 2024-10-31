#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import logging
import pandas as pd
from sqlalchemy import create_engine

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler()
    ]
)

# Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']


MASTER_FILE_PATH = "./BCTS_ACCESS_CATALOG.csv"


# Database connection details
DATABASE_URI = f'postgresql+psycopg2://{postgres_username}:{postgres_password}@{postgres_host}:{postgres_port}/{postgres_database}'


def export_access_catalog():
    # Create SQLAlchemy engine
    engine = create_engine(DATABASE_URI)

    # Read the master grant file into a pandas DataFrame
    df = pd.read_csv(MASTER_FILE_PATH)

    # Write DataFrame to the target table in PostgreSQL, replacing the table if it exists
    df.to_sql(
        'master_access',  # Target table name
        engine,
        schema='lrm_replication',  
        if_exists='replace',  
        index=False  # Do not write DataFrame index as a column
    )

    logging.info("Data has been successfully written to the master_access table in PostgreSQL.")

if __name__ == "__main__":
    export_access_catalog()
    