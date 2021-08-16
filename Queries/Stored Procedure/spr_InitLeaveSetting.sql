create proc spr_InitLeaveSetting
as
	begin try
	
	--Leave Settings---------------------
	print 'ruleetc LeaveSetting Starting'				
	DECLARE @UseFutureMonth int,
			@MinutesInDay int

	DELETE FROM TA_LeaveSettings
	WHERE LeaveSet_PersonId IN (SELECT P.Prs_ID
			 		 FROM rulesetc i
							INNER JOIN TA_Person p
								ON P.Prs_BarCode IN (SELECT p_barcode FROM persons WHERE P_RuleGroup = i.Rule_Code))
	INSERT INTO TA_LeaveSettings(LeaveSet_PersonId, LeaveSet_UseFutureMounth, LeaveSet_MinutesInDay, LeaveSet_From)								 
		SELECT P.Prs_ID, i.Rule_motalab, i.Rule_mohr, GETDATE()
		FROM rulesetc i
				INNER JOIN TA_Person p
					ON P.Prs_BarCode IN (SELECT p_barcode FROM persons WHERE P_RuleGroup = i.Rule_Code)
	
	UPDATE TA_LeaveSettings SET LeaveSet_MinutesInDay = 480 WHERE LeaveSet_MinutesInDay=0
	print 'ruleetc CFP Starting'				
	INSERT INTO TA_Calculation_Flag_Persons(CFP_Barcode,CFP_Date)
	SELECT P_BarCode,LEFT(dbo.GTS_ASM_MiladiToShamsi(CONVERT(varchar(10),GetDate(),101)),4) +'/01/01' 
		FROM persons
		WHERE P_RuleGroup  in (SELECT Rule_Code FROM rulesetc)

	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch




