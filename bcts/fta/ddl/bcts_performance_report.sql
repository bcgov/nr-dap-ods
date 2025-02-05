-- Data fetch from other business areas. Materialized as tables
CREATE OR REPLACE TABLE bcts_staging.fta_tenure_term AS
SELECT * FROM fta_replication.pmt_tenure_term_vw;

CREATE OR REPLACE TABLE bcts_staging.fta_prov_forest_use AS
SELECT * FROM fta_replication.pmt_prov_forest_use_vw;

CREATE OR REPLACE TABLE bcts_staging.fta_tenure_file_status_code AS
SELECT * FROM fta_replication.pmt_tenure_file_status_code_vw;
