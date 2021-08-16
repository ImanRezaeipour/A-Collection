alter TRIGGER trg_UPD_groups_4UpdTA_WorkGroup
   ON  dbo.groups
   AFTER Update
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
    DECLARE @Grp_Code smallint, @Grp_Name nvarchar(40)
  
	DECLARE inserted_cursor CURSOR 
	FOR SELECT Grp_Code,Grp_Name FROM inserted
	
	OPEN inserted_cursor
	FETCH NEXT FROM inserted_cursor
	INTO @Grp_Code,@Grp_Name

	
	WHILE @@FETCH_STATUS = 0
	BEGIN
    

    UPDATE TA_WorkGroup 
    SET WorkGroup_Name=@Grp_Name 
    WHERE WorkGroup_ID=@Grp_Code

	FETCH NEXT FROM inserted_cursor
		INTO @Grp_Code,@Grp_Name
	END	  
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor

	end try
	begin catch

	exec spr_GetTriggerLog 
	end catch
END
