-- drop table fta_replication.harvesting_authority 
create table fta_replication.harvesting_authority 
   (	hva_skey bigint not null, 
	forest_file_id varchar(10) not null, 
	cutting_permit_id varchar(3), 
	harvesting_authority_id varchar(30), 
	forest_district bigint not null, 
	district_admn_zone varchar(4), 
	geographic_district bigint not null, 
	mgmt_unit_id varchar(4), 
	mgmt_unit_type_code varchar(1), 
	licence_to_cut_code varchar(2), 
	harvest_type_code varchar(1) not null, 
	harvest_auth_status_code varchar(3), 
	tenure_term int, 
	status_date timestamp(0), 
	issue_date timestamp(0), 
	expiry_date timestamp(0), 
	extend_date timestamp(0), 
	extend_count bigint, 
	harvest_auth_extend_reas_code varchar(1), 
	quota_type_code varchar(1), 
	crown_lands_region_code varchar(1), 
	salvage_type_code varchar(3), 
	cascade_split_code varchar(1), 
	catastrophic_ind varchar(1), 
	crown_granted_ind varchar(1) not null, 
	cruise_based_ind varchar(1) not null, 
	deciduous_ind varchar(1) not null, 
	bcaa_folio_number varchar(23), 
	location varchar(100), 
	higher_level_plan_reference varchar(30), 
	harvest_area decimal(11,4), 
	retirement_date timestamp(0), 
	revision_count int not null, 
	entry_userid varchar(30) not null, 
	entry_timestamp timestamp(0) not null, 
	update_userid varchar(30) not null, 
	update_timestamp timestamp(0) not null, 
	is_waste_assessment_required varchar(1) default 'u' not null, 
	is_cp_extensn_appl_fee_waived varchar(1) default 'u' not null, 
	is_cp_extension_appl_fee_paid varchar(1) default 'u' not null, 
	is_within_fibre_recovery_zone varchar(1) default 'u' not null, 
	harvesting_authority_guid bytea not null
   ) 
   ;

comment on table fta_replication.harvesting_authority is 'information about the timber cutting permission  for a timber tenure.';
comment on column fta_replication.harvesting_authority.is_waste_assessment_required is 'a value indicating whether a harvesting authority record requires waste assessment or not.';
comment on column fta_replication.harvesting_authority.is_cp_extensn_appl_fee_waived is 'a value that is mandatory on extension to indicate if the extension application fee has been waived.';
comment on column fta_replication.harvesting_authority.is_cp_extension_appl_fee_paid is 'a value to show if the extension application fee has been paid.n if is_ext_app_fee_waived  = ''y'',''u'' otherwise. not mandatory on extension';
comment on column fta_replication.harvesting_authority.is_within_fibre_recovery_zone is 'a value to show whether a cutting permit is in fibre recovery zones or not.
the valid values include:
''y'' it''s within the fibre recovery zones
''n'' it''s not within the fibre recovery zones
''u'' unknown.';
comment on column fta_replication.harvesting_authority.harvesting_authority_guid is 'contains harvesting authority global unique identifier';
