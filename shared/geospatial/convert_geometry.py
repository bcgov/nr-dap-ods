# Convert Oracle geometry to WKT: SDO_UTIL.TO_WKTGEOMETRY()
# Convert WKT to PostgreSQL: ST_GeomFromText()
# Call columns 'geom' in Postgres?
import oracledb
import psycopg2
import os
import io
import time
import json

# Grab config map
json_file = os.environ['extract.json']
config_data = json.loads(json_file)
print(config_data)

# Extract configuration data
source_schema = config_data['init']['source_schema']
target_schema = config_data['init']['target_schema']
source_table = config_data['init']['source_table']
target_table = source_table.lower()
source_columns = config_data['source_columns']
target_columns = source_columns.lower()

# oracledb.init_oracle_client(lib_dir="/opt/oracle/instantclient_21_11")

# record start time
start = time.time() 

# Retrieve Oracle database configuration
oracle_username = os.environ['DB_USERNAME']
oracle_password = os.environ['DB_PASSWORD']
oracle_host = os.environ['DB_HOST']
oracle_port = os.environ['DB_PORT']
oracle_database = os.environ['DATABASE']

# Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']

# Set up Oracle database connection
dsn = oracledb.makedsn(host=oracle_host, port=oracle_port, service_name=oracle_database)
oracle_connection = oracledb.connect(user=oracle_username, password=oracle_password, dsn=dsn)

# Set up Postgres database connection
postgres_connection = psycopg2.connect(user=postgres_username, password=postgres_password,
                                      host=postgres_host, port=postgres_port, database=postgres_database)

# Create Oracle cursor
oracle_cursor = oracle_connection.cursor()

# Create PostgreSQL cursor
postgres_cursor = postgres_connection.cursor()

# Query Oracle for geometry data and convert it to WKT
oracle_cursor.execute(f"SELECT SDO_UTIL.TO_WKTGEOMETRY(GEOMETRY) AS GEOMETRY, {source_columns} FROM {source_schema}.{source_table} WHERE GEOMETRY IS NOT NULL")

# Fetch all geometry data from Oracle
oracle_geometry_data = oracle_cursor.fetchall()

# Delete existing data in the target table
delete_query = f'TRUNCATE TABLE {target_schema}.{target_table}'
postgres_cursor.execute(delete_query)

# Insert geometry data into PostgreSQL
for geometry_data in oracle_geometry_data:

    # Extract LOB geometry data from Oracle result
    oracle_geometry_lob = geometry_data[0]

    # Convert LOB to text
    oracle_geometry_wkt = oracle_geometry_lob.read()

    # Create list with remaining values
    other_values = geometry_data[1:]

    # Convert the list to a string without parentheses
    other_values_text = ', '.join(map(str, other_values))

    # Insert the data into PostgreSQL
    postgres_cursor.execute(f"INSERT INTO {target_schema}.{target_table} (geometry, {target_columns}) VALUES ((ST_GeomFromText('{oracle_geometry_wkt}', 3005)), {other_values_text})")

# Commit the changes and close the connections
postgres_connection.commit()

# record end time
end = time.time()

print("Geometry conversion completed successfully.")
print("The time of execution of the program is:", (end - start) , "seconds")