#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import logging
import sys
import pandas as pd
from sqlalchemy import create_engine, text

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


# Database connection details
DATABASE_URI = f'postgresql+psycopg2://{postgres_username}:{postgres_password}@{postgres_host}:{postgres_port}/{postgres_database}'

def apply_grants():
    # Connect to the database
    engine = create_engine(DATABASE_URI)

    # Query the master_access table and load data into a DataFrame
    query = f"SELECT * FROM lrm_replication.master_access"
    df = pd.read_sql(query, engine)

    # Generate all grant statements for each row in the DataFrame
    all_statements = []
    for _, row in df.iterrows():
        all_statements.extend(generate_grant_statements(row))
    
    # Execute the grant statements in PostgreSQL
    schema_roles_list = list(set([(x.split(' ON ')[1].split('.')[0], x.split(' TO ')[1].split(';')[0]) for x in all_statements]))
    usage_statements = []
    for (schema, role) in schema_roles_list:
        usage_statement = f"GRANT USAGE ON SCHEMA {schema} TO {role};"
        usage_statements.append(usage_statement)
    all_statements.extend(usage_statements)
    with engine.begin() as connection:
        for statement in all_statements:
            logging.info(statement)
            connection.execute(text(statement))

    logging.info("Grant statements executed successfully.")

# Function to generate grant statements based on role permissions
def generate_grant_statements(row):
    statements = []
    schema = row['SCHEMA']
    table_name = row['TABLE_NAME']
    
    # List of roles and their permissions in the DataFrame
    role_permissions = {
        'BCTS_DEV_ROLE': row['BCTS_DEV_ROLE'],
        'BCTS_STAGE_ANALYST_ROLE': row['BCTS_STAGE_ANALYST_ROLE'],
        'BCTS_STAGE_ANALYST_PI_ROLE': row['BCTS_STAGE_ANALYST_PI_ROLE'],
        'BCTS_ANALYST_ROLE': row['BCTS_ANALYST_ROLE'],
        'BCTS_ANALYST_PI_ROLE': row['BCTS_ANALYST_PI_ROLE']
    }
    
    # Generate grant statements based on role permissions
    for role, permission in role_permissions.items():
        if permission == "Read":
            statements.append(f"GRANT SELECT ON {schema}.{table_name} TO {role};")
        elif permission == "Read/Write":
            statements.append(f"GRANT SELECT, INSERT, UPDATE, DELETE ON {schema}.{table_name} TO {role};")
        # Ignore 'Deny' permissions
    
    # Grant permission to Power BI Proxy Account
    if schema.upper() == 'BCTS_REPORTING':
        statements.append(f"GRANT SELECT ON {schema}.{table_name} TO proxy_bcts_bi;")

    return statements


if __name__ == "__main__":
    apply_grants()





    
