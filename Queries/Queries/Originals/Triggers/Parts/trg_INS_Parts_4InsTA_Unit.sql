
ALTER TRIGGER trg_INS_Parts_4InsTA_Unit
   ON  parts
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	DECLARE @ChartId numeric
	-----------------------
	DELETE FROM TA_Chart
	INSERT INTO TA_Chart (OrgCh_Name)
		VALUES('چارت سازمانی')
	SET @ChartId = Scope_Identity()
	-----------------------
	
	SET IDENTITY_INSERT TA_Unit ON
	
    insert into TA_Unit (Unit_ID, Unit_OrganChartId, Unit_Name, Unit_ParentId,															    
							Unit_Path, Unit_CustomCode)
		select P_Code, @ChartId, P_Name, P_Father, P_Code, P_CustomCode  
		from inserted
		
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END
GO

	