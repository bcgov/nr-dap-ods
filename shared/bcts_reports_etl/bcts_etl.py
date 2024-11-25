#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys

start = time.time()

# Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler()
    ]
)

def run_sql_script(script_path):
    # Establish database connection
    try:
        connection = psycopg2.connect(
            dbname=postgres_database,
            user=postgres_username,
            password=postgres_password,
            host=postgres_host,
            port=postgres_port
        )
        cursor = connection.cursor()
        logging.info("Database connection established.")
    except psycopg2.Error as e:
        logging.error(f"Error connecting to the database: {e}")
        return

    # Read and execute the SQL script
    try:
        with open(script_path, 'r') as file:
            sql_script = file.read()
            sql_statements = sql_script.split(';')
            for statement in sql_statements:
                if statement.strip():
                    cursor.execute(statement.strip())
        connection.commit()
        logging.info(f"SQL script executed successfully from {script_path}.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
    except FileNotFoundError:
        logging.error(f"SQL script not found: {script_path}")
    finally:
        # Clean up
        cursor.close()
        connection.close()
        logging.info("Database connection closed.")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        filename = sys.argv[1]
        print(f"Processing file: {filename}")
        run_sql_script(filename)
    else:
        print("No filename provided.")
    
