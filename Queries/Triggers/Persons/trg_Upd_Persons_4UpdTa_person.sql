create TRIGGER trg_Upd_Persons_4UpdTa_person
   ON   persons
   AFTER Update
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
  declare @barcode varchar(8), @param smallint,@active bit
 
DECLARE inserted_cursor CURSOR 
	FOR SELECT p_param,p_barcode,p_isvalid
	FROM inserted
	
	OPEN inserted_cursor
	FETCH NEXT FROM inserted_cursor
	INTO @param,@barcode,@active
	
	WHILE @@FETCH_STATUS = 0
	BEGIN

    update TA_Person set Prs__param=@param,prs_active=@active where Prs_Barcode=@barcode

	FETCH NEXT FROM inserted_cursor
		INTO @param,@barcode,@active
	END	  
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END
GO
