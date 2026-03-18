INSERT INTO bcts_reporting.dim_date (
    date_key,
    full_date,

    day,
    day_suffix,
    day_name,
    day_of_week,
    day_of_month,
    day_of_year,
    is_weekend,

    week_of_year,
    week_of_month,
    iso_week,
    iso_year,

    month,
    month_name,
    month_abbrev,
    month_year,
    first_day_of_month,
    last_day_of_month,

    quarter,
    quarter_name,
    year_quarter,
    first_day_of_quarter,
    last_day_of_quarter,

    year,
    is_leap_year,
    first_day_of_year,
    last_day_of_year,

    fiscal_year,
    fiscal_quarter,
    fiscal_month,

    is_holiday,
    holiday_name
)
SELECT
    TO_CHAR(d, 'YYYYMMDD')::INT AS date_key,
    d AS full_date,

    EXTRACT(DAY FROM d) AS day,

    CASE
        WHEN EXTRACT(DAY FROM d) IN (11,12,13) THEN EXTRACT(DAY FROM d) || 'th'
        WHEN EXTRACT(DAY FROM d) % 10 = 1 THEN EXTRACT(DAY FROM d) || 'st'
        WHEN EXTRACT(DAY FROM d) % 10 = 2 THEN EXTRACT(DAY FROM d) || 'nd'
        WHEN EXTRACT(DAY FROM d) % 10 = 3 THEN EXTRACT(DAY FROM d) || 'rd'
        ELSE EXTRACT(DAY FROM d) || 'th'
    END AS day_suffix,

    TO_CHAR(d, 'FMDay') AS day_name,
    EXTRACT(ISODOW FROM d) AS day_of_week,
    EXTRACT(DAY FROM d) AS day_of_month,
    EXTRACT(DOY FROM d) AS day_of_year,
    CASE WHEN EXTRACT(ISODOW FROM d) IN (6,7) THEN TRUE ELSE FALSE END AS is_weekend,

    EXTRACT(WEEK FROM d) AS week_of_year,
    EXTRACT(WEEK FROM d) - EXTRACT(WEEK FROM DATE_TRUNC('month', d)) + 1 AS week_of_month,
    EXTRACT(WEEK FROM d) AS iso_week,
    EXTRACT(ISOYEAR FROM d) AS iso_year,

    EXTRACT(MONTH FROM d) AS month,
    TO_CHAR(d, 'FMMonth') AS month_name,
    TO_CHAR(d, 'Mon') AS month_abbrev,
    TO_CHAR(d, 'YYYY-MM') AS month_year,
    DATE_TRUNC('month', d)::DATE AS first_day_of_month,
    (DATE_TRUNC('month', d) + INTERVAL '1 month - 1 day')::DATE AS last_day_of_month,

    EXTRACT(QUARTER FROM d) AS quarter,
    'Q' || EXTRACT(QUARTER FROM d) AS quarter_name,
    TO_CHAR(d, 'YYYY') || '-Q' || EXTRACT(QUARTER FROM d) AS year_quarter,
    DATE_TRUNC('quarter', d)::DATE AS first_day_of_quarter,
    (DATE_TRUNC('quarter', d) + INTERVAL '3 month - 1 day')::DATE AS last_day_of_quarter,

    EXTRACT(YEAR FROM d) AS year,
    CASE 
        WHEN (EXTRACT(YEAR FROM d) % 4 = 0 AND EXTRACT(YEAR FROM d) % 100 <> 0)
          OR (EXTRACT(YEAR FROM d) % 400 = 0)
        THEN TRUE ELSE FALSE
    END AS is_leap_year,
    DATE_TRUNC('year', d)::DATE AS first_day_of_year,
    (DATE_TRUNC('year', d) + INTERVAL '1 year - 1 day')::DATE AS last_day_of_year,

    -- Fiscal (example: April–March fiscal year)
    CASE 
        WHEN EXTRACT(MONTH FROM d) >= 4 THEN EXTRACT(YEAR FROM d)
        ELSE EXTRACT(YEAR FROM d) - 1
    END AS fiscal_year,

    CASE 
        WHEN EXTRACT(MONTH FROM d) BETWEEN 4 AND 6 THEN 1
        WHEN EXTRACT(MONTH FROM d) BETWEEN 7 AND 9 THEN 2
        WHEN EXTRACT(MONTH FROM d) BETWEEN 10 AND 12 THEN 3
        ELSE 4
    END AS fiscal_quarter,

    CASE 
        WHEN EXTRACT(MONTH FROM d) >= 4 THEN EXTRACT(MONTH FROM d) - 3
        ELSE EXTRACT(MONTH FROM d) + 9
    END AS fiscal_month,

    FALSE AS is_holiday,
    NULL AS holiday_name

FROM GENERATE_SERIES(
    DATE '1900-01-01',
    DATE '2100-12-31',
    INTERVAL '1 day'
) AS d;
