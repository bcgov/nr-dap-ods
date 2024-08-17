import os
import io
import sys
import oracledb
import boto3
import pandas

objurl = os.environ['objurl']
objbucket = os.environ['objbucket']
objid = os.environ['objid']
objkey = os.environ['objkey']
s3key = os.environ['s3key']

username = os.environ['username']
password = os.environ['password']
host = os.environ['host']
port = os.environ['port']
database = os.environ['database']
sql_query = os.environ['sql_query']


def extract_from_oracle(username, password, host, port, database, sql_query):
    dsn = oracledb.makedsn(host=host, port=port, service_name=database)
    print(dsn)
    connection_pool = oracledb.SessionPool(
        user=username, password=password, dsn=dsn, encoding="UTF-8")
    connection = connection_pool.acquire()
    cursor = connection.cursor()
    try:
        # with open('query.sql', 'r') as sql_file:
        # sql_query = sql_file.read()
        print(sql_query)
        cursor.execute(sql_query)
        rows = cursor.fetchall()
        column_names = [col[0] for col in cursor.description]
        connection_pool.release(connection)
        return rows, column_names
    except Exception as e:
        print(f"Error extracting data from Oracle: {str(e)}")
        return []


def create_excel_dataframe(rows, column_names):
    df = pandas.DataFrame(rows, columns=column_names)
    with io.BytesIO() as output:
        with pandas.ExcelWriter(output, engine='xlsxwriter') as writer:
            df.to_excel(writer, index=False)
        exceldata = output.getvalue()
    return exceldata


def upload_to_s3(objbucket, objid, objkey, s3key, exceldata):
    try:
        session = boto3.Session(aws_access_key_id=objid,
                                aws_secret_access_key=objkey)
        s3_client = boto3.client(
            's3', endpoint_url=objurl, aws_access_key_id=objid, aws_secret_access_key=objkey)
        s3_resource = session.resource('s3', endpoint_url=objurl)
        s3_client.delete_object(Bucket=objbucket, Key=s3key)
        bucket = s3_resource.Bucket(objbucket)
        bucket.put_object(Key=s3key, Body=exceldata)
    except Exception as e:
        raise Exception(f"S3 Error: {str(e)}")


try:
    rows, column_names = extract_from_oracle(
        username, password, host, port, database, sql_query)
    exceldata = create_excel_dataframe(rows, column_names)
    upload_to_s3(objbucket, objid, objkey, s3key, exceldata)
    print(f'Successfully uploaded to S3 bucket {objbucket} with key {s3key}.')
    sys.exit(0)

except Exception as e:
    print(f"Error: {str(e)}")
    sys.exit(1)
