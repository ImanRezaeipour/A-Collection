INSERT INTO TA_Request
(
	-- request_ID -- this column value is auto-generated,
	request_PrecardID,
	request_PersonID,
	request_FromDate,
	request_ToDate,
	request_FromTime,
	request_ToTime,
	request_TimeDuration,
	request_Description,
	request_RegisterDate,
	request_UserID,
	request_OperatorUser
)
Select
	/* request_PrecardID	*/Clock_RecState,
	/* request_PersonID	*/prs_ID,
	/* request_FromDate	*/dbo.GTS_ASM_ShamsiToMiladi(Clock_Date),
	/* request_ToDate	*/dbo.GTS_ASM_ShamsiToMiladi(Clock_Date),
	/* request_FromTime	*/0,
	/* request_ToTime	*/0,
	/* request_TimeDuration	*/0,
	/* request_Description	*/'',
	/* request_RegisterDate	*/'2012-10-21',
	/* request_UserID	*/35440,
	/* request_OperatorUser	*/'ادمين سيستم'
FROM TA_Person tp JOIN [clock].dbo.C139106 
ON clock_Barcode = Prs_Barcode
WHERE Clock_bRecState IN (32,41,42,43,61,62,63,64)