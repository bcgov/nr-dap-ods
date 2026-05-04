
CREATE TABLE IF NOT EXISTS bcts_staging.bcts_sales_targets_hist (
    BUSINESS_AREA_REGION_CATEGORY TEXT,
    BUSINESS_AREA_REGION TEXT,
    BUSINESS_AREA TEXT,
    Q1_YTD_Sales_Target_Volume NUMERIC,
    Q2_YTD_Sales_Target_Volume NUMERIC,
    Q3_YTD_Sales_Target_Volume NUMERIC,
    Total_Fiscal_Year_Sales_Target_Volume NUMERIC,
    rationalized_apportionment NUMERIC,
    full_apportionment NUMERIC,
    Q1_YTD_Sales_Target_Volume_Cat_4 NUMERIC,
    Q2_YTD_Sales_Target_Volume_Cat_4 NUMERIC,
    Q3_YTD_Sales_Target_Volume_Cat_4 NUMERIC,
    Total_Fiscal_Year_Sales_Target_Volume_Cat_4 NUMERIC,
    Fiscal_Year INTEGER,
    date_updated timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST')
);

CREATE OR REPLACE VIEW bcts_reporting.bcts_sales_targets AS
SELECT
    BUSINESS_AREA_REGION_CATEGORY,
    BUSINESS_AREA_REGION,
    BUSINESS_AREA,
    Q1_YTD_Sales_Target_Volume,
    Q2_YTD_Sales_Target_Volume,
    Q3_YTD_Sales_Target_Volume,
    Total_Fiscal_Year_Sales_Target_Volume,
    Q1_YTD_Sales_Target_Volume_Cat_4,
    Q2_YTD_Sales_Target_Volume_Cat_4,
    Q3_YTD_Sales_Target_Volume_Cat_4,
    Total_Fiscal_Year_Sales_Target_Volume_Cat_4
    FROM bcts_staging.bcts_sales_targets_hist
    WHERE date_updated = (SELECT MAX(date_updated) FROM bcts_staging.bcts_sales_targets_hist);

CREATE OR REPLACE VIEW bcts_staging.bcts_sales_targets AS
SELECT
    BUSINESS_AREA_REGION_CATEGORY,
    BUSINESS_AREA_REGION,
    BUSINESS_AREA,
    Q1_YTD_Sales_Target_Volume,
    Q2_YTD_Sales_Target_Volume,
    Q3_YTD_Sales_Target_Volume,
    Total_Fiscal_Year_Sales_Target_Volume,
    Q1_YTD_Sales_Target_Volume_Cat_4,
    Q2_YTD_Sales_Target_Volume_Cat_4,
    Q3_YTD_Sales_Target_Volume_Cat_4,
    Total_Fiscal_Year_Sales_Target_Volume_Cat_4
    FROM bcts_staging.bcts_sales_targets_hist
    WHERE date_updated = (SELECT MAX(date_updated) FROM bcts_staging.bcts_sales_targets_hist);


GRANT SELECT ON bcts_staging.bcts_sales_targets TO BCTS_DEV_ROLE;
GRANT SELECT ON BCTS_REPORTING.bcts_sales_targets TO proxy_bcts_bi;
