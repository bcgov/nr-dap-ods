CREATE OR REPLACE VIEW bcts_reporting.vw_stumpage_rate_main AS
SELECT
    official.*,
    lrm.*
FROM
    bcts_staging.vw_stumpage_rate_official_view AS official
    LEFT JOIN BCTS_STAGING.STUMPAGE_RATE_LRM AS lrm ON official.forest_file_id = lrm.LICENCE_ID
ORDER BY
    official.auction_date DESC;


GRANT SELECT ON BCTS_REPORTING.vw_stumpage_rate_main TO BCTS_DEV_ROLE;
GRANT SELECT ON BCTS_REPORTING.vw_stumpage_rate_main TO proxy_bcts_bi;
