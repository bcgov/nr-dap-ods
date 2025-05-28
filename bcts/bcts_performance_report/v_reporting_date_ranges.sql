CREATE OR REPLACE VIEW bcts_staging.report_date_ranges AS
SELECT 
    -- 1. Fiscal year (April 1) to 15th/end of current/last month
    CASE 
        WHEN EXTRACT(MONTH FROM CURRENT_DATE) < 4 THEN DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '9 months'
        ELSE DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '3 months'
    END AS start_date,
    CASE
        WHEN EXTRACT(DAY FROM CURRENT_DATE) > 15 THEN DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '15 days'
        ELSE DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 day'
    END AS end_date,
    CASE 
        WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
        ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
    END AS fiscal_year,
    'Fiscal Year to Date' AS report_frequency,
    'Y' AS is_report_valid

UNION ALL

SELECT 
    -- 2. Most recent half month
    CASE
        WHEN EXTRACT(DAY FROM CURRENT_DATE) > 15 THEN DATE_TRUNC('month', CURRENT_DATE)
        ELSE DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' + INTERVAL '15 days'
    END AS start_date,
    CASE
        WHEN EXTRACT(DAY FROM CURRENT_DATE) > 15 THEN DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '15 days'
        ELSE DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 day'
    END AS end_date,
    CASE 
        WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
        ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
    END AS fiscal_year,
    'Current Half Month' AS report_frequency,
    'Y' AS is_report_valid

-- UNION ALL

-- SELECT 
--     -- 3. Last finished 3 months
--     DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '3 months' AS start_date,
--     DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 day' AS end_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
--         ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
--     END AS fiscal_year,
--     'Last 3 Months' AS report_frequency,
--     'Y' AS is_report_valid

-- UNION ALL

-- SELECT 
--     -- 4. Last finished 6 months
--     DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '6 months' AS start_date,
--     DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 day' AS end_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
--         ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
--     END AS fiscal_year,
--     'Last 6 Months' AS report_frequency,
--     'Y' AS is_report_valid

-- UNION ALL

-- SELECT 
--     -- Q1 (April 1 to June 30)
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '3 months'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '9 months'
--     END AS start_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '6 months' - INTERVAL '1 day'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '6 months' - INTERVAL '1 day'
--     END AS end_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
--         ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
--     END AS fiscal_year,
--     'Q1 Fiscal Year' AS report_frequency,
--      CASE 
-- 		WHEN (CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '6 months' - INTERVAL '1 day'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '6 months' - INTERVAL '1 day'
--     END) < NOW() THEN 'Y' 
-- 		ELSE 'N' 
-- 	END AS is_report_valid

-- UNION ALL

-- SELECT 
--     -- Q2 (July 1 to September 30)
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '6 months'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '6 months'
--     END AS start_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '9 months' - INTERVAL '1 day'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '3 months' - INTERVAL '1 day'
--     END AS end_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
--         ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
--     END fiscal_year,
--     'Q2 Fiscal Year' AS report_frequency,
--      CASE 
-- 		WHEN ( CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '9 months' - INTERVAL '1 day'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '3 months' - INTERVAL '1 day'
--     END) < NOW() THEN 'Y' 
-- 		ELSE 'N' 
-- 	END AS is_report_valid

-- UNION ALL

-- SELECT 
--     -- Q3 (October 1 to December 31)
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '9 months'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '3 months'
--     END AS start_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '12 months' - INTERVAL '1 day'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 day'
--     END AS end_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
--         ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
--     END fiscal_year,
--     'Q3 Fiscal Year' AS report_frequency,
--     CASE 
-- 		WHEN (CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '12 months' - INTERVAL '1 day'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 day'
--     END) < NOW() THEN 'Y' 
-- 		ELSE 'N' 
-- 	END AS is_report_valid

-- UNION ALL

-- SELECT 
--     -- Q4 (January 1 to March 31)
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '9 months'
--         ELSE DATE_TRUNC('year', CURRENT_DATE) 
--     END AS start_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' + INTERVAL '3 months' 
--         ELSE DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '3 months' - INTERVAL '1 day'
--     END AS end_date,
--     CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN EXTRACT(YEAR FROM CURRENT_DATE)
--         ELSE EXTRACT(YEAR FROM CURRENT_DATE) - 1
--     END fiscal_year,
--     'Q4 Fiscal Year' AS report_frequency,
-- 	CASE 
-- 		WHEN (CASE 
--         WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '1 year' + INTERVAL '3 months' 
--         ELSE DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '3 months' - INTERVAL '1 day'
--     END) < now() THEN 'Y'
--     ELSE 'N'
-- 	END AS is_report_valid;
