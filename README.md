# nr-dap-ods
This repository holds code and artifacts for the Data Analytics Platform (DAP).

The Operational Data Store (ODS) provides access to exact copies of data assets residing in Line of Business databases, as well as data constructs (views, materialized views); that are refreshed on pre-defined schedules (nightly by default, other schedules by exception).

## File Structure

- **DDLs:**
  `nr-dap-ods/{domain}/ddl/{application name}/{Filename = name of the table}`

- **Custom Replication Containers:**
  `nr-dap-ods/{source system}/replication/{Files}`

- **Shared Replication Containers:**
  `nr-dap-ods/shared/{Files}`

- **Shared ETL Tools:**
  `nr-dap-ods/shared/tools/{name of tool}/{Files}`

##  Use of GitHub Container Registry
Container images under the 'shared' folder are built automatically and pushed to the GHCR any time there is a push or PR to the **main** branch. Images are named according to the file path and tagged with the branch name. Use the image name in an Airflow DAG to create a job using the shared containers. See Airflow example here: [permitting_ats.py](https://github.com/bcgov/nr-airflow/blob/main/dags/permitting_ats.py)

Usage example:
```sh
docker pull ghcr.io/bcgov/nr-dap-ods-ora2pg:main
```
