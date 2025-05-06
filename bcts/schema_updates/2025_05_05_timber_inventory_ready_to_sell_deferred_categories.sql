-- Add two new fields to breakdown the deferred categories
-- Add report_run_date for other reports
ALTER TABLE bcts_staging.timber_inventory_ready_to_sell_hist
ADD COLUMN deferred_activity TEXT,
ADD COLUMN latest_deferral_date DATE,
ADD COLUMN report_run_date DATE DEFAULT CURRENT_DATE;

ALTER TABLE bcts_staging.timber_inventory_ready_to_develop_hist
ADD COLUMN report_run_date DATE DEFAULT CURRENT_DATE;

ALTER TABLE bcts_staging.annual_developed_volume_hist
ADD COLUMN report_run_date DATE DEFAULT CURRENT_DATE;

ALTER TABLE bcts_staging.annual_development_ready_hist
ADD COLUMN report_run_date DATE DEFAULT CURRENT_DATE;
