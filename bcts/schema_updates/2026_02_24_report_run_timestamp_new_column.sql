ALTER TABLE bcts_staging.currently_in_market_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.licence_issued_advertised_main_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.timber_inventory_development_in_progress_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.licence_issued_with_unbilled_volume_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.licence_sold_to_out_of_province_registrants_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.licence_transfer_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.annual_developed_volume_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.annual_development_ready_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.timber_inventory_ready_to_develop_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.timber_inventory_ready_to_sell_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.roads_constructed_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.roads_deactivated_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.roads_transferred_in_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.roads_transferred_out_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.silviliability_main_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.tsl_summary_main_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');

ALTER TABLE bcts_staging.volume_advertised_main_hist
  ADD COLUMN report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST');
