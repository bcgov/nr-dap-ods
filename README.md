# nr-dap-ods
This repository holds code and artifacts for DAP ODS

File structure

DDL:	nr-dap-ods/{source system}/DDL/{Filename = name of the table} 

Replication DAGs: nr-dap-ods/{source system}/af/DAG/{Filename} (only replication DAGs. controller DAGs are kept in nr-dap-dlh)

Custom replication SQL: nr-dap-ods/{source system}/af/SQL/{Filename}

Roles:	nr-dap-ods/{source system}/Roles/{Filename}

Replication and audit container: nr-dap-ods/shared/{Files}

Views: nr-dap-ods/shared/views/{Files}
