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

