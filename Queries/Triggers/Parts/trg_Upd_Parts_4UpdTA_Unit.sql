
CREATE TRIGGER trg_Upd_Parts_4UpdTA_Unit
   ON  parts
   AFTER Update
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	declare @name nvarchar(40), @customcode nvarchar(40), @code varchar(200)

DECLARE inserted_cursor CURSOR 
	FOR SELECT p_name,p_customcode,p_code
	FROM inserted
	
	OPEN inserted_cursor
	FETCH NEXT FROM inserted_cursor
	INTO @name,@customcode,@code

	
	WHILE @@FETCH_STATUS = 0
	BEGIN    
	
	UPDATE TA_Unit 
	SET Unit_Name = @name,
		Unit_CustomCode = @customcode 
	WHERE Unit_ID = @code

	FETCH NEXT FROM inserted_cursor
		INTO @name,@customcode,@code
	END	  
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor

	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END
GO
