# nr-dap-ods
This repository holds code and artifacts for DAP ODS

File structure

- DDL:	nr-dap-ods/{source system}/ddl/{application name}/{Filename = name of the table}

- Replication DAGs: nr-dap-ods/{source system}/af/DAG/{Filename} (only replication DAGs. controller DAGs are kept in nr-dap-dlh)

- Custom replication SQL: nr-dap-ods/{source system}/af/SQL/{Filename}

- Roles:	nr-dap-ods/{source system}/Roles/{Filename}

- Replication, audit, and JSON flatten container: nr-dap-ods/shared/{Files}

- Views: nr-dap-ods/shared/views/{Files}


##  Use of GHCR
Container image is built automatically and pushed to the GHCR any time there is a push or PR to the **main** branch. Images are named according to the file path and tagged with the branch name. Use the image name in an Airflow DAG to create a job using the nr-permitting-pipelines container. See Airflow example here: [permitting_pipeline_ats.py](https://github.com/bcgov/nr-airflow/blob/e45c83f933d1f96e479a36a3e765dabd61e1ff2e/dags/permitting_pipeline_ats.py#L18C16-L18C58)

Usage example:
```sh
docker pull ghcr.io/bcgov/nr-dap-ods:main
```
