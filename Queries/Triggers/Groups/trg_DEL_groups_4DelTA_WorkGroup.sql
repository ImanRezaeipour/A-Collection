ALTER TRIGGER trg_INS_groups_4DelTA_WorkGroup
   ON  dbo.groups
   AFTER delete
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
    DECLARE @Grp_Code smallint
DECLARE inserted_cursor CURSOR 
	FOR SELECT Grp_Code
	FROM deleted
	
	OPEN inserted_cursor
	FETCH NEXT FROM inserted_cursor
	INTO @Grp_Code

	
	WHILE @@FETCH_STATUS = 0
	BEGIN
    
    DELETE TA_WorkGroup WHERE WorkGroup_ID=@Grp_Code
    DELETE grp_dtl WHERE Grd_Code = @Grp_Code

	FETCH NEXT FROM inserted_cursor
		INTO @Grp_Code
	END	  
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor
	
	end try
	begin catch	
	exec spr_GetTriggerLog 
	end catch
END
GO

