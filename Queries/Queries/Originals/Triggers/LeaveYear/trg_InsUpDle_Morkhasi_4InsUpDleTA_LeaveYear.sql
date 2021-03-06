
ALTER TRIGGER [dbo].[trg_InsUpDle_Morkhasi_4InsUpDleTA_LeaveYear]
   ON  [dbo].[morkhasi]
   AFTER  INSERT
AS 
BEGIN
	begin try
	DELETE FROM TA_BudgetYear 
	WHERE BudgetYear_ID IN (SELECT BudgetYear_ID 
						   FROM TA_BudgetYear l
									INNER JOIN inserted i
										ON l.BudgetYear_PersonId  = (SELECT prs_ID FROM TA_person WHERE Prs_barcode = i.Mor_PCode)
											AND
										   l.BudgetYear_Year  = i.Mor_Year)
	DELETE FROM TA_BudgetYear 
	WHERE BudgetYear_PersonId IS NULL
										   	
	INSERT INTO TA_BudgetYear(BudgetYear_Year, BudgetYear_PersonId, BudgetYear_CalculatedDemandTime, BudgetYear_DemandTime)
		SELECT Mor_Year, (SELECT prs_ID FROM TA_person WHERE Prs_barcode = Mor_PCode),
			   Mor_DRemain * 60 + Mor_HRemain, Mor_DRemainOk * 60 + Mor_HRemainOk 
		FROM inserted
		
	
	INSERT INTO TA_Budget (LeaveBud_ID)
		SELECT BudgetYear_ID 
						   FROM TA_BudgetYear l
									INNER JOIN inserted i
										ON l.BudgetYear_PersonId  = (SELECT prs_ID FROM TA_person WHERE Prs_barcode = i.Mor_PCode)
											AND
										   l.BudgetYear_Year  = i.Mor_Year
	
			  		
	INSERT INTO TA_UsedBudget (UsedBudget_ID)
		SELECT BudgetYear_ID 
						   FROM TA_BudgetYear l
									INNER JOIN inserted i
										ON l.BudgetYear_PersonId  = (SELECT prs_ID FROM TA_person WHERE Prs_barcode = i.Mor_PCode)
											AND
										   l.BudgetYear_Year  = i.Mor_Year	
    end try
	begin catch	
		exec spr_GetTriggerLog 
	end catch
END
