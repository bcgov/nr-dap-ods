CREATE TABLE FTA_REPLICATION.TENURE_TERM (
	FOREST_FILE_ID VARCHAR(10),
	TENURE_TERM NUMERIC(22, 5),
	LEGAL_EFFECTIVE_DT DATE,
	INITIAL_EXPIRY_DT DATE,
	CURRENT_EXPIRY_DT DATE,
	TENURE_EXTEND_CNT NUMERIC(22, 10),
	TENR_EXTEND_RSN_ST VARCHAR(1),
	ENTRY_USERID VARCHAR(30),
	ENTRY_TIMESTAMP DATE,
	UPDATE_USERID VARCHAR(30),
	UPDATE_TIMESTAMP DATE,
	REVISION_COUNT NUMERIC(22, 5)
)
ALTER TABLE
	FTA_REPLICATION.TENURE_TERM
ADD
	CONSTRAINT TENT_PK PRIMARY KEY (FOREST_FILE_ID);
