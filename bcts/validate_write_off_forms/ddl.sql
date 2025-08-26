DROP TABLE IF EXISTS bcts_reporting.write_off_forms;

CREATE TABLE IF NOT EXISTS bcts_reporting.write_off_forms
(
    field_name text COLLATE pg_catalog."default",
    expected_value text COLLATE pg_catalog."default",
    filled_value text COLLATE pg_catalog."default",
    match text COLLATE pg_catalog."default",
    form text COLLATE pg_catalog."default",
    validated_date date,
    PRIMARY KEY (form, field_name)
);
