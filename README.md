# nr-dap-ods
This repository holds code and artifacts for the Data Analytics Platform (DAP).

The Operational Data Store (ODS) provides access to exact copies of data assets residing in Line of Business databases, as well as data constructs (views, materialized views); that are refreshed on pre-defined schedules (nightly by default, other schedules by exception).

## File Structure

- **DDL (Data Definition Language)** Includes commands like CREATE, ALTER, and COMMENT that define and modify database structure.
  `nr-dap-ods/{domain}/ddl/{application name}/{Filename = name of the table}`

- **DQL (Data Query Language) / DML (Data Manipulation Language)** Includes commands like SELECT, INSERT, UPDATE, and DELETE that manipulate data within the database.
  `nr-dap-ods/{domain}/dml/{application name, if more than 1 within the domain}/{Files}`

- **DCL (Data Control Language)** Includes commands like GRANT and REVOKE that control access to the data in the database.
  `nr-dap-ods/{domain}/dcl/{Files}`

- **Custom Replication Containers:**
  `nr-dap-ods/{source system}/replication/{Files}`

- **Shared Replication Containers:**
  `nr-dap-ods/shared/{Files}`

- **Shared ETL Tools:**
  `nr-dap-ods/shared/tools/{name of tool}/{Files}`

##  Use of GitHub Container Registry
Container images under the 'shared' folder are built automatically and pushed to the GHCR any time there is a push to the **main** branch. Images are named according to the file path and tagged with the branch name. Use the image name in an Airflow DAG to create a job using the shared containers. See Airflow example here: [permitting_ats.py](https://github.com/bcgov/nr-airflow/blob/main/dags/permitting_ats.py)

Usage example:
```sh
docker pull ghcr.io/bcgov/nr-dap-ods-ora2pg:main
```
