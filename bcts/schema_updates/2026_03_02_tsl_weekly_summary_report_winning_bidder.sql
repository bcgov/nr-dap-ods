ALTER TABLE bcts_staging.tsl_summary_main_hist
ADD COLUMN client_name text;

UPDATE bcts_staging.tsl_summary_main_hist h
SET client_name = src.client_name
FROM (
    SELECT
        t.forest_file_id,
        fc.client_name
    FROM (
        SELECT
            tb.forest_file_id,
            tb.client_number,
            tb.auction_date,
            ROW_NUMBER() OVER (
                PARTITION BY tb.forest_file_id
                ORDER BY tb.auction_date DESC
            ) AS rn
        FROM bctsadmin_replication.bcts_tenure_bidder tb
        WHERE tb.sale_awarded_ind = 'Y'
    ) t
    JOIN mofclient_replication.v_client_public fc
      ON fc.client_number = t.client_number
    WHERE t.rn = 1
) src
WHERE h.licence_number = src.forest_file_id;
