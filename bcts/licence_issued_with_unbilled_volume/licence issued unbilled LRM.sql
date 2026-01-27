CREATE OR REPLACE VIEW bcts_staging.licence_issued_with_unbilled_volume_lrm AS

WITH licence AS
/* 0. Licence info */
    (
        SELECT
            licn_seq_nbr,
            max(tso_name) AS business_area,
            max(licence_id) AS licence_id,
            max(field_team) AS field_team,
            max(tenure) AS tenure
        FROM
            lrm_replication.v_licence
        GROUP BY
            licn_seq_nbr
    ),
    issued AS
    /* 1. Licence Issued Done */
    (
        SELECT
            licn_seq_nbr,
            max(activity_date) AS Issued_Done_LRM
        FROM
            lrm_replication.v_licence_activity_all
        WHERE
            activity_class = 'CML' -- Corporate Mandatory Licence activity
            AND actt_key_ind = 'HI' -- Licence Issued
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            licn_seq_nbr
    ),
    closed AS
    /* 2. Licence Closed Done */
    (
        SELECT
            licn_seq_nbr,
            max(activity_date) AS Closed_Done_LRM
        FROM
            lrm_replication.v_licence_activity_all
        WHERE
            activity_class = 'CML' -- Corporate Mandatory Licence activity
            AND actt_key_ind = 'HC' -- Licence Closed
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            licn_seq_nbr
    ),
    substantial_completion AS
    /* 3. Licence Substantial Completion Done */
    (
        SELECT
            licn_seq_nbr,
            max(activity_date) AS Substantial_Completion_Done_LRM
        FROM
            lrm_replication.v_licence_activity_all
        WHERE
            activity_class = 'CML' -- Corporate Mandatory Licence activity
            AND actt_key_ind = 'LC' -- Substantial Completion
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            licn_seq_nbr
    ),
    surrendered AS
    /* 4. Licence Surrendered Done */
    (
        SELECT
            licn_seq_nbr,
            max(activity_date) AS Surrendered_Done_LRM
        FROM
            lrm_replication.v_licence_activity_all
        WHERE
            activity_class = 'CML' -- Corporate Mandatory Licence activity
            AND actt_key_ind = 'HS' -- Licence Surrendered
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            licn_seq_nbr
    ),
    cancelled AS
    /* 5. Licence Cancelled Done */
    (
        SELECT
            licn_seq_nbr,
            max(activity_date) AS Cancelled_Done_LRM
        FROM
            lrm_replication.v_licence_activity_all
        WHERE
            activity_class = 'CML' -- Corporate Mandatory Licence activity
            AND actt_key_ind = 'HX' -- Licence Cancelled
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            licn_seq_nbr
    ),
    expire_extend AS
    /* 6. Licence Expiry: the later of the EXPIRE and EXTEND activities */
    (
        SELECT
            licn_seq_nbr,
            max(activity_date) AS Expire_Extend_LRM -- The later of the two dates
        FROM
            lrm_replication.v_licence_activity_all
        WHERE
            activity_class = 'CML' -- Corporate Mandatory Licence activity
            AND actt_key_ind IN (
                'EXPIRE', -- Licence Expiry Date
                'EXTEND' -- Licence Extension Date
            )
        GROUP BY
            licn_seq_nbr
    ),
    logging_started AS
    (
        SELECT
            LICN_SEQ_NBR,
            MAX(activity_date) AS Logging_Started_Date
        FROM
            lrm_replication.v_block_activity_all
        WHERE
            actt_key_ind = 'HVS' -- Logging Started
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            LICN_SEQ_NBR
    ),
    logging_completed AS
    (
        SELECT
            LICN_SEQ_NBR,
            MAX(activity_date) AS Logging_Completed_Date
        FROM
            lrm_replication.v_block_activity_all
        WHERE
            actt_key_ind = 'HVC' -- Logging Completed
            AND acti_status_ind = 'D' -- Done
        GROUP BY
            LICN_SEQ_NBR
    ) 

SELECT
    licence.licn_seq_nbr,
    licence.business_area,
    licence.licence_id,
    logging_started.Logging_Started_Date AS Last_Logging_Started_Date,
    logging_completed.Logging_Completed_Date AS Last_Logging_Completed_Date,
    CASE
        WHEN logging_started.Logging_Started_Date IS NULL
        AND logging_completed.Logging_Completed_Date IS NULL THEN NULL
        ELSE 'Active_Harvesting'
    END AS Harvesting_Status,
    licence.field_team,
    licence.tenure,
    issued.Issued_Done_LRM, -- 1.
    substantial_completion.Substantial_Completion_Done_LRM, -- 3.
    
    CASE
        WHEN issued.Issued_Done_LRM IS NULL THEN NULL
        ELSE
            'Fiscal '
            || (EXTRACT(YEAR FROM issued.Issued_Done_LRM + INTERVAL '9 months') - 1)::int
            || '/'
            || EXTRACT(YEAR FROM issued.Issued_Done_LRM + INTERVAL '9 months')::int
    END AS Issued_Done_Fiscal_LRM,
    expire_extend.Expire_Extend_LRM -- 6.
    
FROM licence
LEFT JOIN issued
  ON licence.licn_seq_nbr = issued.licn_seq_nbr
LEFT JOIN closed
  ON licence.licn_seq_nbr = closed.licn_seq_nbr
LEFT JOIN substantial_completion
  ON licence.licn_seq_nbr = substantial_completion.licn_seq_nbr
LEFT JOIN surrendered
  ON licence.licn_seq_nbr = surrendered.licn_seq_nbr
LEFT JOIN cancelled
  ON licence.licn_seq_nbr = cancelled.licn_seq_nbr
LEFT JOIN expire_extend
  ON licence.licn_seq_nbr = expire_extend.licn_seq_nbr
LEFT JOIN logging_started
  ON licence.licn_seq_nbr = logging_started.licn_seq_nbr
LEFT JOIN logging_completed
  ON licence.licn_seq_nbr = logging_completed.licn_seq_nbr;
