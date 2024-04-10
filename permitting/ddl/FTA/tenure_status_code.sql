DROP TABLE if exists fta_replication.TENURE_STATUS_CODE ;
CREATE TABLE fta_replication.TENURE_STATUS_CODE
(
   TENURE_STATUS_CODE  VARCHAR(3)     NOT NULL,
   DESCRIPTION         VARCHAR(120)   NOT NULL,
   EFFECTIVE_DATE      DATE                 NOT NULL,
   EXPIRY_DATE         DATE                 NOT NULL,
   UPDATE_TIMESTAMP    DATE                 NOT NULL
)
;
ALTER TABLE fta_replication.TENURE_STATUS_CODE owner to ods_admin_user;