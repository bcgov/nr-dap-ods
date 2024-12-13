create materialized view bcts_staging.mv_licence_issued_advertised_lrm as
/* qLicenceIssuedAdvertised_LRM */

 /* Licence Info */
with licence as
    (
        select
            licn_seq_nbr,
            case
                when
                    TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
                then
                    'Interior'
                when
                    TSO_CODE in ('TCH', 'TST', 'TSG')
                then
                    'Coast'
                end as BUSINESS_AREA_REGION_CATEGORY,
            case
                when
                    TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
                then
                    'North Interior'
                when
                    TSO_CODE in ('TCC', 'TKA', 'TKO', 'TOC')
                then
                    'South Interior'
                when
                    TSO_CODE in ('TCH', 'TST', 'TSG')
                then
                    'Coast'
                end as BUSINESS_AREA_REGION,
				(CASE 
				WHEN TSO_NAME = 'Seaward' THEN 'Seaward-Tlasta' 
				ELSE TSO_NAME 
				END) || ' (' || TSO_CODE || ')' AS BUSINESS_AREA,

            Licence_ID,
            nav_name as Management_Unit,
            District_Name as District,
            Licn_Category_ID as Category_ID_LRM,
            Category as Category_LRM
        from
            bcts_staging.forestview_v_licence),
    /* Total Licence Info -- Info about all blocks in licence */
    total_licence_info as
    (
         select
            B.LICN_SEQ_NBR,
            count(*) as count_all_blocks_in_licence,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME
        from
            BCTS_STAGING.FORESTVIEW_V_BLOCK B
        group by
            b.licn_seq_nbr
    ),
        /*
    salvage_all_fire_year

    Volume of blocks within licence that have any SFIRE## activities.
    If a block has multiple salvage fire years, the block volume is only
    included once in the total; no double-counting.
    */
    salvage_all_fire_year as
    (
        select
            B.LICN_SEQ_NBR,
            count(*) as count_blocks_salvage_any_fire_year,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_ALL_FIRE_YEARS,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_ALL_FIRE_YEARS,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_ALL_FIRE_YEARS
        from
            BCTS_STAGING.FORESTVIEW_V_BLOCK B
			INNER JOIN
            (
                /*
                This distinct clause ensures each block is only counted once
                if it has any SFIRE activities.
                */
                select distinct
                    cutb_seq_nbr

                from
                    BCTS_STAGING.forestview_v_block_activity_all

                where
                    activity_class = 'CSB'
                    and actt_key_ind like 'SFIRE%'
            ) block_with_any_sfire_year
        ON
            b.cutb_seq_nbr = block_with_any_sfire_year.cutb_seq_nbr
        group by
            B.TSO_CODE,
            B.TSO_NAME,
            licn_seq_nbr
    ),

    /*
    salvage21fire

    Volume within licence that is salvage from a 2021 fire.
    Only blocks with SFIRE21 activity are included.

    */
    salvage21fire as
    (
    SELECT
            B.LICN_SEQ_NBR,
            count(*) as count_blocks_salvage_21_fire,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2021_FIRE,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2021_FIRE,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2021_FIRE
        FROM
            BCTS_STAGING.FORESTVIEW_V_BLOCK B
			INNER JOIN
            (
                /*
                The SFIRE21 activity can be entered multiple times for the same
                block. The SFIRE21 activity is meant to be present for
                blocks that are salvage from 2021 fires, and absent for those
                that are not. Multiple entries of the activity on one block are
                meaningless. For the purposes of this query, we assume that
                multiple entries are intended to indicate the block is salvage.
                This DISTINCT query ensures we only count the block volume once
                for each SFIRE21 activity on the block.
                */
                select distinct
                    cutb_seq_nbr
                from
                    BCTS_STAGING.forestview_v_block_activity_all
                where
                    activity_class = 'CSB'
                    and actt_key_ind = 'SFIRE21'
            ) block_with_sfire21
        ON
            b.cutb_seq_nbr = block_with_sfire21.cutb_seq_nbr
        GROUP BY
            B.LICN_SEQ_NBR
    ),
    
    salvage22fire as
    /*
    salvage22fire

    Volume within licence that is salvage from a 2022 fire.
    Only blocks with SFIRE22 activity are included.

    */
    (
        SELECT
            B.LICN_SEQ_NBR,
            count(*) as count_blocks_salvage_22_fire,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2022_FIRE,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2022_FIRE,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2022_FIRE
        FROM
            bcts_staging.FORESTVIEW_V_BLOCK B
            INNER JOIN
            (
                /*
                The SFIRE22 activity can be entered multiple times for the same
                block. The SFIRE22 activity is meant to be present for
                blocks that are salvage from 2022 fires, and absent for those
                that are not. Multiple entries of the activity on one block are
                meaningless. For the purposes of this query, we assume that
                multiple entries are intended to indicate the block is salvage.
                This DISTINCT query ensures we only count the block volume once
                for each SFIRE22 activity on the block.
                */
                select distinct
                    cutb_seq_nbr
                from
                    bcts_staging.forestview_v_block_activity_all
                where
                    activity_class = 'CSB'
                    and actt_key_ind = 'SFIRE22'
            ) block_with_sfire22
        ON
            b.cutb_seq_nbr = block_with_sfire22.cutb_seq_nbr
        GROUP BY
            B.LICN_SEQ_NBR
    ),

    /*
    salvage23fire

    Volume within licence that is salvage from a 2023 fire.
    Only blocks with SFIRE23 activity are included.
    */
    salvage23fire as
    (
        SELECT
            B.LICN_SEQ_NBR,
            count(*) as count_blocks_salvage_23_fire,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2023_FIRE,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2023_FIRE,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2023_FIRE
        FROM
            bcts_staging.FORESTVIEW_V_BLOCK B
            INNER JOIN
            (
                /*
                The SFIRE23 activity can be entered multiple times for the same
                block. The SFIRE23 activity is meant to be present for
                blocks that are salvage from 2023 fires, and absent for those
                that are not. Multiple entries of the activity on one block are
                meaningless. For the purposes of this query, we assume that
                multiple entries are intended to indicate the block is salvage.
                This DISTINCT query ensures we only count the block volume once
                for each SFIRE23 activity on the block.
                */
                select distinct
                    cutb_seq_nbr
                from
                    bcts_staging.forestview_v_block_activity_all
                where
                    activity_class = 'CSB'
                    and actt_key_ind = 'SFIRE23'
            ) block_with_sfire23
        ON
            b.cutb_seq_nbr = block_with_sfire23.cutb_seq_nbr
        GROUP BY
            B.LICN_SEQ_NBR
    ),

    /*
    salvage24fire

    Volume within licence that is salvage from a 2024 fire.
    Only blocks with SFIRE24 activity are included.

    As at 2024-02-13, this activity code has not been deployed;
    it is scripted here in anticipation of future deployment.
    */
    salvage24fire as
    (
        SELECT
            B.LICN_SEQ_NBR,
            count(*) as count_blocks_salvage_24_fire,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2024_FIRE,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2024_FIRE,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2024_FIRE
        FROM
            bcts_staging.FORESTVIEW_V_BLOCK B
            INNER JOIN
            (
                /*
                The SFIRE24 activity can be entered multiple times for the same
                block. The SFIRE24 activity is meant to be present for
                blocks that are salvage from 2024 fires, and absent for those
                that are not. Multiple entries of the activity on one block are
                meaningless. For the purposes of this query, we assume that
                multiple entries are intended to indicate the block is salvage.
                This DISTINCT query ensures we only count the block volume once
                for each SFIRE24 activity on the block.
                */
                select distinct
                    cutb_seq_nbr
                from
                    bcts_staging.forestview_v_block_activity_all
                where
                    activity_class = 'CSB'
                    and actt_key_ind = 'SFIRE24'
            ) block_with_sfire24
        ON
            b.cutb_seq_nbr = block_with_sfire24.cutb_seq_nbr
        GROUP BY
            B.LICN_SEQ_NBR
    ),
    /*
    salvage25fire

    Volume within licence that is salvage from a 2025 fire.
    Only blocks with SFIRE25 activity are included.

    As at 2024-02-13, this activity code has not been deployed;
    it is scripted here in anticipation of future deployment.
    */
    salvage25fire as
    (
        SELECT
            B.LICN_SEQ_NBR,
            count(*) as count_blocks_salvage_25_fire,
            Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2025_FIRE,
            Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2025_FIRE,
            Sum(COALESCE(CRUISE_VOL,0) + COALESCE(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2025_FIRE
        FROM
            bcts_staging.FORESTVIEW_V_BLOCK B
            INNER JOIN
            (
                /*
                The SFIRE25 activity can be entered multiple times for the same
                block. The SFIRE25 activity is meant to be present for
                blocks that are salvage from 2025 fires, and absent for those
                that are not. Multiple entries of the activity on one block are
                meaningless. For the purposes of this query, we assume that
                multiple entries are intended to indicate the block is salvage.
                This DISTINCT query ensures we only count the block volume once
                for each SFIRE25 activity on the block.
                */
                select distinct
                    cutb_seq_nbr
                from
                    bcts_staging.forestview_v_block_activity_all
                where
                    activity_class = 'CSB'
                    and actt_key_ind = 'SFIRE25'
            ) block_with_sfire25
        ON
            b.cutb_seq_nbr = block_with_sfire25.cutb_seq_nbr
        GROUP BY
            B.LICN_SEQ_NBR
    ) 


select
    licence.business_area_region_category,
    licence.business_area_region,
    licence.business_area,
    licence.licence_id,
    licence.Management_Unit,
    licence.District,
    licence.Category_ID_LRM,
    total_licence_info.LRM_TOTAL_VOLUME,
    total_licence_info.count_all_blocks_in_licence,
    salvage_all_fire_year.LRM_TOTAL_VOLUME_SALVAGE_ALL_FIRE_YEARS,
    salvage_all_fire_year.count_blocks_salvage_any_fire_year,
    salvage21fire.LRM_TOTAL_VOLUME_SALVAGE_2021_FIRE,
    salvage21fire.count_blocks_salvage_21_fire,
    salvage22fire.LRM_TOTAL_VOLUME_SALVAGE_2022_FIRE,
    salvage22fire.count_blocks_salvage_22_fire,
    salvage23fire.LRM_TOTAL_VOLUME_SALVAGE_2023_FIRE,
    salvage23fire.count_blocks_salvage_23_fire,
    salvage24fire.LRM_TOTAL_VOLUME_SALVAGE_2024_FIRE,
    salvage24fire.count_blocks_salvage_24_fire,
    salvage25fire.LRM_TOTAL_VOLUME_SALVAGE_2025_FIRE,
    salvage25fire.count_blocks_salvage_25_fire,
    licence.licn_seq_nbr

from licence
left join total_licence_info
on licence.licn_seq_nbr = total_licence_info.licn_seq_nbr 
left join salvage_all_fire_year
on licence.licn_seq_nbr = salvage_all_fire_year.licn_seq_nbr 
left join salvage21fire
on licence.licn_seq_nbr = salvage21fire.licn_seq_nbr 
left join salvage22fire
on licence.licn_seq_nbr = salvage22fire.licn_seq_nbr 
left join salvage23fire
on licence.licn_seq_nbr = salvage23fire.licn_seq_nbr 
left join salvage24fire
on licence.licn_seq_nbr = salvage24fire.licn_seq_nbr 
left join salvage25fire
on licence.licn_seq_nbr = salvage25fire.licn_seq_nbr
   
order by
    business_area_region_category desc,
    business_area_region,
    business_area,
    licence_id
;
