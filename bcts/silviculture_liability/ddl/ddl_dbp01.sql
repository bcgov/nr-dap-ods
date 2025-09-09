CREATE TABLE IF NOT EXISTS results_replication.silviliability_results
(
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    cut_block_id character varying(10) COLLATE pg_catalog."default",
    opening numeric,
    opening_count bigint,
    results_fg_declared timestamp without time zone
)
