-- drop table fta_replication.harvesting_authority
CREATE TABLE fta_replication.harvesting_authority (
	hva_skey bigint NOT NULL,
	forest_file_id VARCHAR(10) NOT NULL,
	cutting_permit_id VARCHAR(3),
	harvesting_authority_id VARCHAR(30),
	forest_district bigint NOT NULL,
	district_admn_zone VARCHAR(4),
	geographic_district bigint NOT NULL,
	mgmt_unit_id VARCHAR(4),
	mgmt_unit_type_code VARCHAR(1),
	licence_to_cut_code VARCHAR(2),
	harvest_type_code VARCHAR(1) NOT NULL,
	harvest_auth_status_code VARCHAR(3),
	tenure_term INT,
	status_date TIMESTAMP(0),
	issue_date TIMESTAMP(0),
	expiry_date TIMESTAMP(0),
	extend_date TIMESTAMP(0),
	extend_count bigint,
	harvest_auth_extend_reas_code VARCHAR(1),
	quota_type_code VARCHAR(1),
	crown_lands_region_code VARCHAR(1),
	salvage_type_code VARCHAR(3),
	cascade_split_code VARCHAR(1),
	catastrophic_ind VARCHAR(1),
	crown_granted_ind VARCHAR(1) NOT NULL,
	cruise_based_ind VARCHAR(1) NOT NULL,
	deciduous_ind VARCHAR(1) NOT NULL,
	bcaa_folio_number VARCHAR(23),
	location VARCHAR(100),
	higher_level_plan_reference VARCHAR(30),
	harvest_area DECIMAL(11, 4),
	retirement_date TIMESTAMP(0),
	revision_count INT NOT NULL,
	entry_userid VARCHAR(30) NOT NULL,
	entry_timestamp TIMESTAMP(0) NOT NULL,
	update_userid VARCHAR(30) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL,
	is_waste_assessment_required VARCHAR(1) DEFAULT 'u' NOT NULL,
	is_cp_extensn_appl_fee_waived VARCHAR(1) DEFAULT 'u' NOT NULL,
	is_cp_extension_appl_fee_paid VARCHAR(1) DEFAULT 'u' NOT NULL,
	is_within_fibre_recovery_zone VARCHAR(1) DEFAULT 'u' NOT NULL,
	harvesting_authority_guid bytea NOT NULL
);

COMMENT ON TABLE fta_replication.harvesting_authority IS 'information about the timber cutting permission  for a timber tenure.';

COMMENT ON column fta_replication.harvesting_authority.is_waste_assessment_required IS 'a value indicating whether a harvesting authority record requires waste assessment or not.';

COMMENT ON column fta_replication.harvesting_authority.is_cp_extensn_appl_fee_waived IS 'a value that is mandatory on extension to indicate if the extension application fee has been waived.';

COMMENT ON column fta_replication.harvesting_authority.is_cp_extension_appl_fee_paid IS 'a value to show if the extension application fee has been paid.n if is_ext_app_fee_waived  = ''y'',''u'' otherwise. not mandatory on extension';

COMMENT ON column fta_replication.harvesting_authority.is_within_fibre_recovery_zone IS 'a value to show whether a cutting permit is in fibre recovery zones or not.
the valid values include:
''y'' it''s within the fibre recovery zones
''n'' it''s not within the fibre recovery zones
''u'' unknown.';

COMMENT ON column fta_replication.harvesting_authority.harvesting_authority_guid IS 'contains harvesting authority global unique identifier';
