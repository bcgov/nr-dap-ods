-- Table: fta_replication.harvesting_authority

-- DROP TABLE IF EXISTS fta_replication.harvesting_authority;

CREATE TABLE IF NOT EXISTS fta_replication.harvesting_authority
(
    hva_skey bigint NOT NULL,
    forest_file_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    cutting_permit_id character varying(3) COLLATE pg_catalog."default",
    harvesting_authority_id character varying(30) COLLATE pg_catalog."default",
    forest_district bigint NOT NULL,
    district_admn_zone character varying(4) COLLATE pg_catalog."default",
    geographic_district bigint NOT NULL,
    mgmt_unit_id character varying(4) COLLATE pg_catalog."default",
    mgmt_unit_type_code character varying(1) COLLATE pg_catalog."default",
    licence_to_cut_code character varying(2) COLLATE pg_catalog."default",
    harvest_type_code character varying(1) COLLATE pg_catalog."default" NOT NULL,
    harvest_auth_status_code character varying(3) COLLATE pg_catalog."default",
    tenure_term integer,
    status_date timestamp(0) without time zone,
    issue_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    extend_date timestamp(0) without time zone,
    extend_count bigint,
    harvest_auth_extend_reas_code character varying(1) COLLATE pg_catalog."default",
    quota_type_code character varying(1) COLLATE pg_catalog."default",
    crown_lands_region_code character varying(1) COLLATE pg_catalog."default",
    salvage_type_code character varying(3) COLLATE pg_catalog."default",
    cascade_split_code character varying(1) COLLATE pg_catalog."default",
    catastrophic_ind character varying(1) COLLATE pg_catalog."default",
    crown_granted_ind character varying(1) COLLATE pg_catalog."default" NOT NULL,
    cruise_based_ind character varying(1) COLLATE pg_catalog."default" NOT NULL,
    deciduous_ind character varying(1) COLLATE pg_catalog."default" NOT NULL,
    bcaa_folio_number character varying(23) COLLATE pg_catalog."default",
    location character varying(100) COLLATE pg_catalog."default",
    higher_level_plan_reference character varying(30) COLLATE pg_catalog."default",
    harvest_area numeric(11,4),
    retirement_date timestamp(0) without time zone,
    revision_count integer NOT NULL,
    entry_userid character varying(30) COLLATE pg_catalog."default" NOT NULL,
    entry_timestamp timestamp(0) without time zone NOT NULL,
    update_userid character varying(30) COLLATE pg_catalog."default" NOT NULL,
    update_timestamp timestamp(0) without time zone NOT NULL,
    is_waste_assessment_required character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'u'::character varying,
    is_cp_extensn_appl_fee_waived character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'u'::character varying,
    is_cp_extension_appl_fee_paid character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'u'::character varying,
    is_within_fibre_recovery_zone character varying(1) COLLATE pg_catalog."default" NOT NULL DEFAULT 'u'::character varying,
    harvesting_authority_guid bytea NOT NULL,
    CONSTRAINT hva_pk PRIMARY KEY (hva_skey)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS fta_replication.harvesting_authority
    OWNER to ods_admin_user;

REVOKE ALL ON TABLE fta_replication.harvesting_authority FROM ods_read_role;

GRANT ALL ON TABLE fta_replication.harvesting_authority TO ods_admin_user;

GRANT SELECT ON TABLE fta_replication.harvesting_authority TO ods_read_role;

COMMENT ON TABLE fta_replication.harvesting_authority
    IS 'information about the timber cutting permission  for a timber tenure.';

COMMENT ON COLUMN fta_replication.harvesting_authority.hva_skey
    IS 'The unique identifer for the harvesting authority.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.forest_file_id
    IS 'File identification assigned to Provincial Forest Use files. Assigned file number. Usually the Licence, Tenure or Private Mark number.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.cutting_permit_id
    IS 'Identifier for a cutting permit associated with a quota type harvesting tenure.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.harvesting_authority_id
    IS 'The licensee provided identifier for non-cp related harvesting tenure. E.g. Fort St. John harvesting authority.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.forest_district
    IS 'Unique identifier for the ministry organization unit.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.district_admn_zone
    IS 'District Admin Zone is a free format field used internally by the districts to group files within a district for reporting purposes. Examples of use are setting the field to a geographic area or to a persons initials. Reports can be pulled off by District Admin Zone to aid work management. This field is not used by all districts.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.geographic_district
    IS 'Unique identifier for the ministry organization unit.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.mgmt_unit_id
    IS 'The administrative management unit identifier defined by the ministry for managing the forest tenure, eg. 41 - Dawson Creek TSA.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.mgmt_unit_type_code
    IS 'Describes the type of MGMT UNIT TYPE	';

COMMENT ON COLUMN fta_replication.harvesting_authority.licence_to_cut_code
    IS 'The purpose or reason that the licence to cut was granted, eg., right of way.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.harvest_type_code
    IS 'Identifies the type of harvesting authority. Valid values include ''Green'', ''Road'', ''Multi-Mark'', and ''Fort St. John''.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.harvest_auth_status_code
    IS 'The after status image of the harvesting authority. The status indicates the point the harvesting authority is at in it''s lifecycle. Examples are: PP - Planning, HA - Harvesting, LC - Logging Complete, and S - Silviculture.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.tenure_term
    IS 'Term of the tenure (in months).	';

COMMENT ON COLUMN fta_replication.harvesting_authority.status_date
    IS 'The date that the harvest authorization status was last updated.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.issue_date
    IS 'Date the harvest authorization was issued.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.expiry_date
    IS 'Initial expiry date set upon activation of the harvest authorization.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.extend_date
    IS 'Date to which the harvest authorization validity has been extended. Current expiry date.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.extend_count
    IS 'Count of the number of extensions to the expiry date that the harvest authorization has had.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.harvest_auth_extend_reas_code
    IS 'Code to indicate the reason to extend the life of the timber mark.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.quota_type_code
    IS 'A Timber Supply Area will have volumes assigned to one or more partitions, which are in effect different timber type classifications, or geographic locations. Under each partition are the different apportionments. Examples of Partitions are Conventional	';

COMMENT ON COLUMN fta_replication.harvesting_authority.crown_lands_region_code
    IS 'Describes the CROWN LANDS REGION	';

COMMENT ON COLUMN fta_replication.harvesting_authority.salvage_type_code
    IS 'Code describing the salvage type.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.cascade_split_code
    IS 'Code to indicate the administrative split for the timber mark, east or west of the Cascade Mountains, for tracking timber volume information.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.catastrophic_ind
    IS 'Indicates if the damage to the stand of timber is catastrophic. Otherwise, it is endemic.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.crown_granted_ind
    IS 'Indicator to signify whether the land that the timber mark pertains to has a verifiable crown grant document.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.cruise_based_ind
    IS 'Indicates whether a cruise was used for billing purposes.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.deciduous_ind
    IS 'Indicates whether the timber mark is primarily for harvesting deciduous species. Otherwise, coniferous.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.bcaa_folio_number
    IS 'BC Assessment Authority Folio Number for the land that the cutting permit/Timber Mark pertains to, if applicable, or the LTO number. BCAA Folio Numbers are in the format C15 733 06604.140-1-2; the format for LTO numbers is nnn-nnn-nnn.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.location
    IS 'Contains the land legal information for the harvest authority. Land legal information indicates where the land is legally located, such as "Lot 3 of DL 343, Plan 3422".	';

COMMENT ON COLUMN fta_replication.harvesting_authority.higher_level_plan_reference
    IS 'Indicates the higher level plan reference for the given harvest authority. E.g. For Fort St. John, this could be "Sustainable Forest Management Plan".	';

COMMENT ON COLUMN fta_replication.harvesting_authority.harvest_area
    IS 'Identifes the harvest area in hectares for harvesting authorites without spatial.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.retirement_date
    IS 'The date the harvesting authority was retired from the spatial conflict layer.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.revision_count
    IS 'A count of the number of times an entry in the entity has been modified. Used to validate if the current information displayed on a user''s web browser is the most current.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.entry_userid
    IS 'The unique user id of the resource who initially added the entry.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.entry_timestamp
    IS 'Timestamp when the event information was entered.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.update_userid
    IS 'The userid of the individual who last updated this information.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.update_timestamp
    IS 'The date and time of the last update.	';

COMMENT ON COLUMN fta_replication.harvesting_authority.is_waste_assessment_required
    IS 'a value indicating whether a harvesting authority record requires waste assessment or not.';

COMMENT ON COLUMN fta_replication.harvesting_authority.is_cp_extensn_appl_fee_waived
    IS 'a value that is mandatory on extension to indicate if the extension application fee has been waived.';

COMMENT ON COLUMN fta_replication.harvesting_authority.is_cp_extension_appl_fee_paid
    IS 'a value to show if the extension application fee has been paid.n if is_ext_app_fee_waived  = ''y'',''u'' otherwise. not mandatory on extension';

COMMENT ON COLUMN fta_replication.harvesting_authority.is_within_fibre_recovery_zone
    IS 'a value to show whether a cutting permit is in fibre recovery zones or not.
the valid values include:
''y'' it''s within the fibre recovery zones
''n'' it''s not within the fibre recovery zones
''u'' unknown.';

COMMENT ON COLUMN fta_replication.harvesting_authority.harvesting_authority_guid
    IS 'contains harvesting authority global unique identifier';