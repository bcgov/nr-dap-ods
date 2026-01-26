#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
from sqlalchemy import create_engine
import logging
import sys
import boto3
from pypdf import PdfReader
import io
import oracledb
import pandas as pd
from sqlalchemy import text
from datetime import datetime
import numpy as np
import math


# Retrieve Oracle database configuration
oracle_username = os.environ['DB_USERNAME']
oracle_password = os.environ['DB_PASSWORD']
oracle_host = os.environ['DB_HOST']
oracle_port = os.environ['DB_PORT']
oracle_database = os.environ['DATABASE']

postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']
postgres_schema = 'bcts_reporting'
postgres_table = 'write_off_forms'

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


# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler()
    ]
)

def get_connection():
    try:
        oracle_dsn = oracledb.makedsn(
            host=oracle_host,
            port=oracle_port,
            service_name=oracle_database
        )
        connection = oracledb.connect(
            user=oracle_username,
            password=oracle_password,
            dsn=oracle_dsn
        )
        logging.info("Oracle database connection established.")
        return connection
    except oracledb.DatabaseError as e:
        logging.error(f"Error connecting to Oracle database: {e}")
        sys.exit(1)

def run_query_oracle(sql_statement):
    connection = get_connection()
    try:
        logging.info(f"Executing SQL script in Oracle...")
        cursor = connection.cursor()
        cursor.execute(sql_statement)
        rows = cursor.fetchall()
        # get column names from cursor.description
        col_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(rows, columns=col_names)
        connection.commit()
        connection.close()
        logging.info(f"SQL script executed successfully in Oracle.")
        return df
    except oracledb.DatabaseError as e:
        logging.error(f"Error executing SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def fetch_forms_from_object_storage():
    # Get list of all objects
    response = s3_client.list_objects_v2(
        Bucket='wyprwt',
        Prefix='Write Off Forms'
    )

    if 'Contents' in response:
        objects = response['Contents']
        forms = [obj['Key'] for obj in objects if obj['Key'].endswith('.pdf')]
        if forms:
            logging.info(f"Found {len(forms)} write-off forms in the bucket.")
            return forms
        else:
            logging.warning("No write-off forms found in the bucket.")
            return []
    else:
        print("No objects found in the bucket.")

def parse_forms(form):
    try:
        logging.info(f"Parsing form: {form}")
        response = s3_client.get_object(Bucket='wyprwt',  Key=form)
        reader = PdfReader(io.BytesIO(response['Body'].read()))
        form = reader.trailer["/Root"].get("/AcroForm", None)
        if not form:
            logging.info("No form found in PDF")
            return pd.DataFrame()

        fields = form.get("/Fields", [])
        field_values = {}

        for f in fields:
            field = f.get_object()
            field_name = field.get("/T")
            # For dropdowns, /V contains the selected value
            value = field.get("/V")
            if value:
                value = value.strip() if isinstance(value, str) else str(value)
            else:
                value = "Not filled"
            field_values[field_name] = value

        filled_dict = {}
        filled_dict['Business Area'] = 'Error parsing filled form'
        filled_dict['TSA or Management Unit'] = field_values['eg Cascades TSA or Management Unit 18']
        filled_dict['Current date'] = field_values['Current date']
        filled_dict['Location of the Block'] = field_values['Location of block']
        filled_dict['UBI'] = field_values['UBI (N/A if UBI not assigned)']
        filled_dict['Block ID/Name'] = field_values['Block ID / Name']
        filled_dict['TSL (if applicable)'] = field_values['TSL # (if applicable)']
        filled_dict['Cruise volume from LRM block allocation tab'] = field_values['Crusie volume from LRM block allocation tab m3']
        filled_dict['Gross area from LRM block shape'] = field_values['Gross area from LRM block shape (ha)']
        filled_dict['Fiscal year block was created'] = field_values['Fiscal yar block was created (estimate if unknown)']
        filled_dict['Fiscal year included in inventory in LRM'] = field_values['Fiscal year included in inventory in LRM']
        filled_dict['Spatial data linked'] = field_values['Spatial Data Linked']
        filled_dict['Category of WO'] = field_values['Category of Write off']
        filled_dict['Development Started Block Activity Status'] = "NA"
        filled_dict['Development Completed Block Activity Status'] = "NA"
        logging.info(f"Parsing form: {form} is complete!")
        return pd.DataFrame(filled_dict, index=(1,))

    except Exception as e:
        logging.info(f"Error reading PDF: {e}")
        sys.exit(1)

def fetch_from_ods(ubi):
    logging.info(f"Fetching expected values for UBI: {ubi}")
    logging.info(f"Fetching block details from V_BLOCK for UBI: {ubi}")
    # Get block details from V_BLOCK 
    sql_statement = \
        f"""
        select TSO_NAME || '(' || TSO_CODE || ')' as "Business Area",
        field_team_desc as "TSA or Management Unit",
        null as "Current date",
        opar_operating_area_name as "Location of the Block",
        '{ubi}' as "UBI",
        block_id as "Block ID/Name",
        CRUISE_VOL as "Cruise volume from LRM block allocation tab",
        GROSS_AREA as "Gross area from LRM block shape",
        null as "Fiscal year block was created",
        cutb_seq_nbr 
        from forestview.v_block
        where ubi = '{ubi}'
        """

    df1 = run_query_oracle(sql_statement)
    cutb_seq_nbr = df1['CUTB_SEQ_NBR'][0]
    logging.info("Block details fetched successfully.")

    logging.info(f"Fetching spatial and activity details from CUT_BLOCK_SHAPE and V_BLOCK_ACTIVITY_ALL for CUTB_SEQ_NBR: {cutb_seq_nbr} and UBI: {ubi}")
    # Get SPATIAL_LINKED
    sql_statement = \
        f"""
        select DECODE(CUTB_SEQ_NBR, NULL, 'NO', 'YES') AS "Spatial data linked"
        from FOREST.CUT_BLOCK_SHAPE
        where  cutb_seq_nbr={cutb_seq_nbr} 
        """

    df2 = run_query_oracle(sql_statement)
    logging.info("Spatial and activity details fetched successfully.")

    logging.info(f"Fetching fiscal year included in inventory and category of WO for UBI: {ubi}")
    # Get Fiscal year
    sql_statement = \
        f"""
        with max_date as
            (select  max(activity_date) as earliest_date
            from FORESTVIEW.v_block_activity_all
            where ubi = '{ubi}'
            and actt_key_ind in ('DVC', 'DVS', 'DR')
            and acti_status_ind = 'D'
            )
            select 
                CASE 
                    WHEN TO_CHAR(earliest_date, 'MM') >= '04' 
                    THEN TO_NUMBER(TO_CHAR(earliest_date, 'YYYY'))
                    ELSE TO_NUMBER(TO_CHAR(earliest_date, 'YYYY')) - 1
                END AS "Fiscal year included in inventory in LRM"
            from max_date

        """

    df3 = run_query_oracle(sql_statement)
    logging.info("Fiscal year included in inventory and category of WO fetched successfully.")

    logging.info(f"Fetching category of WO for UBI: {ubi}")
    # Get Category of WO
    sql_statement = \
        f"""
        WITH activity AS 
        (
                SELECT *
                FROM FORESTVIEW.v_block_activity_all
                WHERE ubi = '{ubi}'
            ),
            activity_status as
            (
                SELECT MAX(CASE WHEN actt_key_ind = 'DVS' THEN acti_status_ind END) AS dvs_status,
                    MAX(CASE WHEN actt_key_ind = 'DVC' THEN acti_status_ind END) AS dvc_status
                FROM activity
            )
            select
			dvs_status as "Development Started Block Activity Status",
			dvc_status as "Development Completed Block Activity Status",
            case when dvs_status = 'P' and (dvc_status = 'P' or dvc_status is null) then 'Cat 1: Pre DIP-DVS NOT done'
                when dvs_status = 'D' and (dvc_status = 'P' or dvc_status is null) then 'Cat 2: DIP-DVS done and DVC NOT done'
                when dvc_status = 'D' and exists(SELECT 1
											FROM FORESTVIEW.v_licence_activity_all
											where actt_key_ind = 'HS' 
											and licn_seq_nbr = (select distinct licn_seq_nbr from FORESTVIEW.v_block WHERE ubi = '{ubi}' and rownum = 1 )
											)
									   then 'Cat 4: Surrendered TSL'
				when dvc_status = 'D' then 'Cat 3: RTS Timber Inventory - DVC done'
            end as "Category of WO"
            from activity_status

        """

    df4 = run_query_oracle(sql_statement)
    logging.info("Category of WO fetched successfully.")
    df = pd.concat([df1, df2, df3, df4], axis=1)
    logging.info(df.to_string())
    return df

def load_into_ods(df):
    logging.info("Loading data into PostgreSQL...")
    try:
        # Create the SQLAlchemy engine
        engine = create_engine(
            f"postgresql://{postgres_username}:{postgres_password}@{postgres_host}:{postgres_port}/{postgres_database}"
        )
       # Convert all values to native Python types to avoid numpy issues
        df_clean = df.astype(object).where(pd.notnull(df), None)
        df_clean = df_clean.map(lambda x: x.item() if hasattr(x, "item") else x)

        # Build the insert query
        insert_sql = """
        INSERT INTO bcts_reporting.write_off_forms
            (field_name, expected_value, filled_value, match, form, validated_date)
        VALUES
            (:field_name, :expected_value, :filled_value, :match, :form, :validated_date)
        ON CONFLICT (form, field_name)
        DO UPDATE SET
            field_name = EXCLUDED.field_name,
            expected_value = EXCLUDED.expected_value,
            filled_value = EXCLUDED.filled_value,
            match = EXCLUDED.match,
            validated_date = EXCLUDED.validated_date
        """

        # Execute row by row
        with engine.begin() as conn:  # transaction
            for row in df_clean.to_dict(orient="records"):
                conn.execute(text(insert_sql), row)

        logging.info("✅ Data successfully written to PostgreSQL.")

    except Exception as e:
        print(f"❌ Error writing to PostgreSQL: {e}")
        sys.exit(1)

def normalize(val):
    if pd.isna(val):
        return np.nan
    # Try to treat as number
    try:
        return math.ceil(float(str(val).strip()))
    except (ValueError, TypeError):
        # Not numeric, treat as string
        return str(val).strip().lower()

def validate_write_off_forms():
    forms = fetch_forms_from_object_storage()
    for form in forms:
        try:
            logging.info(f"Validating form: {form}")
            filled_fields = parse_forms(form)
            logging.info(filled_fields.shape)
            expected_fields = fetch_from_ods(filled_fields['UBI'].values[0])
            expected_fields['TSL (if applicable)'] = 'Not fetched from ODS'
            # Match the columns
            expected_fields = expected_fields[filled_fields.columns]

            logging.info(expected_fields.shape)
            expected_row = expected_fields.iloc[0]
            filled_row = filled_fields.iloc[0]

            df_summary = pd.DataFrame({
                "field_name": expected_fields.columns,
                "expected_value": expected_row.values,
                "filled_value": filled_row.values
            })
            df_summary['form'] = form.split('/')[-1]
            df_summary['expected_norm'] = df_summary['expected_value'].apply(normalize)
            df_summary['filled_norm']   = df_summary['filled_value'].apply(normalize)

            df_summary['match'] = df_summary['expected_norm'] == df_summary['filled_norm']
            df_summary['validated_date'] = datetime.now().date()
            df_summary = df_summary.drop(columns=['expected_norm', 'filled_norm'])
            load_into_ods(df_summary)
            logging.info(f"Form {form} validated successfully.")
        except Exception as e:
            logging.error(f"Error validating form {form}: {e}")
            sys.exit(1)

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch FTA tables from FTA_REPLICATION
    validate_write_off_forms()
    logging.info("All forms validated successfully.")

    # Clean up
    cursor.close()
    connection.close()
        
