alter table lrm_replication.v_block
    add column if not exists cutb_rc_risk_comments text;

alter table lrm_replication.silviculture_stratum
    add column if not exists dep_ind text;
