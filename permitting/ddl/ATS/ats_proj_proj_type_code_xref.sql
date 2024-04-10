create table ats_replication.ats_proj_proj_type_code_xref (
	project_id decimal(38,0) not null,
	project_type_code varchar(6) not null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null
);