import psycopg2
import sqlalchemy
from sqlalchemy import create_engine
import pandas as pd
import sys
import io
import requests
import os
import boto3

postgres_username = os.environ["ODS_USERNAME"]
postgres_password = os.environ["ODS_PASSWORD"]
postgres_host = os.environ["ODS_HOST"]
postgres_port = os.environ["ODS_PORT"]
postgres_database = os.environ["ODS_DATABASE"]
postgres_schema = "bcts_staging"
postgres_table = "bcbids_tsl_weekly_report"

# Object storage (S3 Compatible credentials and configuration
aws_access_key_id = os.environ["AWS_ACCESS_KEY_ID"] 
aws_secret_access_key = os.environ["AWS_SECRET_ACCESS_KEY"] 
# S3 specific information
s3_endpoint_url = os.environ["S3_ENDPOINT_URL"] 

# S3 bucket name
bucket_name = 'wyprwt'


s3_client = boto3.client(
    's3',
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
    endpoint_url=s3_endpoint_url
)


def load_into_postgres(df, schema, table):
    try:
        # Build connection string using SQLAlchemy
        conn_str = (
            f"postgresql+psycopg2://{postgres_username}:{postgres_password}"
            f"@{postgres_host}:{postgres_port}/{postgres_database}"
        )

        engine = create_engine(conn_str)

        # Load the dataframe
        df.to_sql(
            name=table,
            con=engine,
            schema=schema,
            if_exists="replace",  
            index=False
        )
        print(f"✅ Loaded {len(df)} rows into {schema}.{table}")

    except Exception as e:
        print(f"❌ Error writing to PostgreSQL with to_sql: {e}")
        sys.exit(1)

def read_csv_from_s3():
    response = s3_client.get_object(Bucket='wyprwt', Key='bcbids_tsl_weekly_report.csv')
    df = pd.read_csv(io.BytesIO(response['Body'].read()))
    return df


def main():
    try:
        df = read_csv_from_s3()
        print(f"✅ Read {len(df)} rows from S3")
        load_into_postgres(df, postgres_schema, postgres_table)
    except Exception as e:
        print(f"❌ Error in main: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
