--DELETE FROM TA_BaseTraffic
INSERT INTO TA_BaseTraffic
(
	-- BasicTraffic_ID -- this column value is auto-generated,
	BasicTraffic_PrecardId,
	BasicTraffic_PersonID,
	BasicTraffic_Date,
	BasicTraffic_Time,
	BasicTraffic_Used,
	BasicTraffic_Active,
	BasicTraffic_Manual,
	BasicTraffic_State,
	BasicTraffic_ReportsListId,
	BasicTraffic_OperatorPersonID,
	BasicTraffic_Description,
	BasicTraffic_ClockCustomCode
)
SELECT
	/* BasicTraffic_PrecardId	*/8832,
	/* BasicTraffic_PersonID	*/prs_ID,
	/* BasicTraffic_Date	*/dbo.GTS_ASM_ShamsiToMiladi(Clock_Date),
	/* BasicTraffic_Time	*/clock_Time,
	/* BasicTraffic_Used	*/0,
	/* BasicTraffic_Active	*/1,
	/* BasicTraffic_Manual	*/0,
	/* BasicTraffic_State	*/0,
	/* BasicTraffic_ReportsListId	*/null,
	/* BasicTraffic_OperatorPersonID	*/0,
	/* BasicTraffic_Description	*/'',
	/* BasicTraffic_ClockCustomCode	*/null
FROM TA_Person JOIN 
[clock].dbo.C139108 c ON Convert(numeric,c.Clock_BarCode)=Convert(numeric,TA_Person.Prs_Barcode)
WHERE Clock_RecState =0