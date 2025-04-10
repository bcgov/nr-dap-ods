CREATE TABLE FTA_REPLICATION.FOREST_FILE_CLIENT (
	FOREST_FILE_CLIENT_SKEY NUMERIC(22, 10),
	FOREST_FILE_ID VARCHAR(10),
	CLIENT_NUMBER VARCHAR(8),
	CLIENT_LOCN_CODE VARCHAR(2),
	FOREST_FILE_CLIENT_TYPE_CODE VARCHAR(1),
	LICENSEE_START_DATE DATE,
	LICENSEE_END_DATE DATE,
	REVISION_COUNT NUMERIC(22, 5),
	ENTRY_USERID VARCHAR(30),
	ENTRY_TIMESTAMP DATE,
	UPDATE_USERID VARCHAR(30),
	UPDATE_TIMESTAMP DATE
);

ALTER TABLE
	FTA_REPLICATION.FOREST_FILE_CLIENT
ADD
	CONSTRAINT FFC_CL_PK PRIMARY KEY (FOREST_FILE_CLIENT_SKEY);
