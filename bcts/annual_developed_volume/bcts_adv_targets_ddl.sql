-- Create the ADV targets table
CREATE TABLE IF NOT EXISTS bcts_staging.bcts_adv_targets (
    business_area_region   text        NOT NULL,  -- e.g., North | South | Coast
    business_area          text        NOT NULL,  -- e.g., "Babine (TBA)"
    adv_target_m3             numeric(12,0) NOT NULL, -- volume in m3; whole numbers
    fiscal_year            text        NOT NULL  -- e.g., "2025-26"
);


