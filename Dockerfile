FROM python:3.11.4-slim-buster

# Oracle instant client

WORKDIR    /opt/oracle
RUN        apt-get update && apt-get install -y libaio1 wget unzip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
            && unzip instantclient-basiclite-linuxx64.zip \
            && rm -f instantclient-basiclite-linuxx64.zip \
            && cd /opt/oracle/instantclient* \
            && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
            && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
            && ldconfig

WORKDIR    /app

# PostgreSQL library 

RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2

ADD *.py .

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

CMD ["python3", "./data_replication_parametrized_audit_os.py"]