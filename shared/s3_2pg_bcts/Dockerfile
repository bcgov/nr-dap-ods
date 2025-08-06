FROM python:3.11.9-slim-bookworm

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2 \
    && pip install pandas \
    && pip install boto3

# Setup working directory
WORKDIR /app

# Copy project files
COPY . .



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
            if_exists="replace",  # or "append" if you prefer
            index=False
        )
        print(f"✅ Loaded {len(df)} rows into {schema}.{table}")

    except Exception as e:
        print(f"❌ Error writing to PostgreSQL with to_sql: {e}")
        sys.exit(1)
