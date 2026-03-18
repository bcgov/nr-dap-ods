CREATE TABLE bcts_reporting.dim_date (
    date_key              INT PRIMARY KEY,        -- YYYYMMDD
    full_date             DATE NOT NULL,

    -- Day level
    day                   INT NOT NULL,
    day_suffix            VARCHAR(4),             -- 1st, 2nd, 3rd, etc.
    day_name              VARCHAR(10),            -- Monday, Tuesday
    day_of_week           INT,                    -- 1=Monday … 7=Sunday
    day_of_month          INT,
    day_of_year           INT,
    is_weekend            BOOLEAN,

    -- Week level
    week_of_year          INT,
    week_of_month         INT,
    iso_week              INT,
    iso_year              INT,

    -- Month level
    month                 INT,
    month_name            VARCHAR(10),
    month_abbrev          VARCHAR(3),
    month_year            VARCHAR(7),             -- YYYY-MM
    first_day_of_month    DATE,
    last_day_of_month     DATE,

    -- Quarter level
    quarter               INT,
    quarter_name          VARCHAR(6),             -- Q1, Q2...
    year_quarter          VARCHAR(7),             -- YYYY-Qn
    first_day_of_quarter  DATE,
    last_day_of_quarter   DATE,

    -- Year level
    year                  INT,
    is_leap_year          BOOLEAN,
    first_day_of_year     DATE,
    last_day_of_year      DATE,

    -- Fiscal (customize as needed)
    fiscal_year           INT,
    fiscal_quarter        INT,
    fiscal_month          INT,

    -- Flags
    is_holiday            BOOLEAN DEFAULT FALSE,
    holiday_name          VARCHAR(50),

    -- Audit
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_dim_date_full_date ON bcts_reporting.dim_date(full_date);
CREATE INDEX idx_dim_date_year_month ON bcts_reporting.dim_date(year, month);
CREATE INDEX idx_dim_date_fiscal_year ON bcts_reporting.dim_date(fiscal_year);  



GRANT SELECT ON BCTS_REPORTING.dim_date TO BCTS_DEV_ROLE;

GRANT SELECT ON BCTS_REPORTING.dim_date TO proxy_bcts_bi;
