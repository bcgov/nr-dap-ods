-- ETL Error: null value in column "divi_div_nbr" of relation "tenure_type" violates not-null constraint
-- DETAIL:  Failing row contains (160001440, null, B07, Forestry Licence to Cut (R/W), PUBLIC, Y, null, null, null, null, null, null).
-- CONTEXT:  COPY tenure_type, line 506: "160001440	\N	B07	Forestry Licence to Cut (R/W)	PUBLIC	Y	\N	\N	\N	\N	\N	\N"
ALTER TABLE lrm_replication.tenure_type
ALTER COLUMN tent_seq_nbr DROP NOT NULL;
ALTER TABLE lrm_replication.tenure_type
ALTER COLUMN divi_div_nbr DROP NOT NULL;
ALTER TABLE lrm_replication.tenure_type
ALTER COLUMN tent_tenure_id DROP NOT NULL;

-- Extra data after last expected column
-- Add new columns 
ALTER TABLE lrm_replication.activity
ADD COLUMN acti_variable_cost_upset NUMERIC(15, 2),
ADD COLUMN acti_total_cost_upset NUMERIC(15, 2),
ADD COLUMN acti_mps70 NUMERIC(15, 2);

-- invalid input syntax for type integer: "31.5"
ALTER TABLE lrm_replication.v_lrm_licence
ALTER COLUMN gross_area TYPE NUMERIC,
ALTER COLUMN merchantable_area TYPE NUMERIC,
ALTER COLUMN harvested_area TYPE NUMERIC,
ALTER COLUMN standing_area TYPE NUMERIC,
ALTER COLUMN cruise_volume TYPE NUMERIC,
ALTER COLUMN harvested_volume TYPE NUMERIC,
ALTER COLUMN standing_volume TYPE NUMERIC,
ALTER COLUMN cruise_variance TYPE NUMERIC,
ALTER COLUMN no_shape TYPE NUMERIC;
