ALTER TRIGGER trg_INS_groups_4InsTA_WorkGroup
   ON  dbo.groups
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	SET IDENTITY_INSERT TA_WorkGroup on
    INSERT INTO  TA_WorkGroup (WorkGroup_ID, WorkGroup_Name, WorkGroup__grpsCode) 
		SELECT Grp_Code, Grp_Name, Grp_Code  
		FROM inserted		
		
	end try
	begin catch	
	exec spr_GetTriggerLog 
	end catch
END

