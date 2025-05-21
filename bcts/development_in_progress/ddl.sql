CREATE TABLE lrm_replication.cut_block_shape (
    objectid NUMERIC,
    transaction_id VARCHAR(50),
    cutb_seq_nbr NUMERIC(16),
    bufferdist NUMERIC(38, 8),
    objectid_1 NUMERIC(10),
    transactio VARCHAR(50),
    objectid_2 NUMERIC(10),
    hectares NUMERIC(38, 8),
    feature_len NUMERIC(38, 8),
    feature_area NUMERIC(38, 8),
    shape_len NUMERIC(38, 8),
    shape_area NUMERIC(38, 8),
    shape TEXT,
    licn_seq_nbr NUMERIC(16),
    manu_seq_nbr NUMERIC(16),
    mark_seq_nbr NUMERIC(16),
    perm_seq_nbr NUMERIC(16),
    modifiedby VARCHAR(30),
    modifiedon TIMESTAMP,
    modifiedusing VARCHAR(30),
    createdby VARCHAR(30),
    createdon TIMESTAMP,
    createdusing VARCHAR(30)
);

CREATE OR REPLACE VIEW bcts_staging.forest_cut_block_shape AS
SELECT * FROM lrm_replication.cut_block_shape;


-- DROP TABLE IF EXISTS bcts_staging.old_growth_tap_deferral_categories;

-- Added to store static Old Growth TAP deferral categories (Ancient, Remnant, Big Tree) used in DIP timber inventory reporting.
-- These categories are derived from GIS analysis and do not change over time, supporting consistent dashboard reporting.

CREATE TABLE IF NOT EXISTS bcts_staging.old_growth_tap_deferral_categories
(
    ubi text COLLATE pg_catalog."default",
    ancient text COLLATE pg_catalog."default",
    remanant text COLLATE pg_catalog."default",
    big_treed text COLLATE pg_catalog."default"
)
