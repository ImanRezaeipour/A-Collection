
alter TRIGGER [dbo].[trg_Upd_Shifts_4UpdTA_Calculation_Flag_Persons]
   ON  [dbo].[shifts]
   AFTER UPDATE
AS 
BEGIN
	begin try
	DECLARE @sh_code varchar(3)

	DECLARE inserted_cursor CURSOR 
	FOR SELECT SH_Code
	FROM deleted
	
	OPEN inserted_cursor
	FETCH NEXT FROM inserted_cursor
	INTO @sh_code

	
	WHILE @@FETCH_STATUS = 0
	BEGIN
    	

	SET @sh_code=dbo.ZeroFixed((@sh_code),3)
	INSERT INTO TA_Calculation_Flag_Persons 
		SELECT P_BarCode, date_
		FROM  dbo.GetGroupsOfShifCode(@sh_code)      
				INNER JOIN dbo.persons 
					ON Grd_Code = P_ShiftGroup

	FETCH NEXT FROM inserted_cursor
		INTO @sh_code
	END	  
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor
	
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
				
END

GO


