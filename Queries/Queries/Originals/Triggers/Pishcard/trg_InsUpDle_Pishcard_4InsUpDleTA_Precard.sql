CREATE TRIGGER [dbo].[trg_InsUpDle_Pishcard_4InsUpDleTA_Precard]
   ON  [dbo].[pishcard]
   AFTER INSERT, UPDATE
AS 
BEGIN
	declare @code int,@name nvarchar(100),@active int
	--DELETE FROM TA_Precard
	begin try
	
		DECLARE cursor_inserted CURSOR 
		FOR SELECT Pish_Code,Pish_Name,Pish_active FROM inserted
		OPEN cursor_inserted
		FETCH NEXT FROM cursor_inserted
		INTO @code, @name, @active
		WHILE @@FETCH_STATUS = 0
		BEGIN
		
			if(exists(select * from ta_precard where precrd_ID =@code))
			begin
				UPDATE ta_precard set precrd_Name=@name,precrd_Active=@active where precrd_ID=@code
			end
			else
			begin			
				INSERT INTO TA_Precard (precrd_ID,precrd_Name,precrd_Active)
				values( @code,@name,@active)
			end
			FETCH NEXT FROM cursor_inserted
			INTO @code, @name, @active
		END
		CLOSE cursor_inserted
		DEALLOCATE cursor_inserted
		
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch

END
