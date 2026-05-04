
-- Data is received manually from the data team when changes
CREATE TABLE bcts_reporting.licence_issued_ra_apportionment (
    fiscal_year               text,
    licence_issued            numeric,
    ra                         numeric,
    full_apportionment        numeric,
    actual_fte_count          numeric,
    annual_developed_volume   numeric,
    volume_harvested          numeric
);
