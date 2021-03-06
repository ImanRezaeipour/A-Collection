

CREATE TRIGGER trg_InsUpdDlt_Shifts_4InsUpdDltTA_Shift
   ON  [dbo].[Shifts]
   AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	begin try

	
	declare @insertedCount int,@deletedCount int
	declare @code int,@from1 int ,@to1 int,@from2 int ,@to2 int,@from3 int ,@to3 int,@name nvarchar(50),@shiftType int,@kind int ,@nesab int
	
	select @insertedCount=count(*) from inserted
	select @deletedCount=count(*) from inserted
	
	declare insertedCursor cursor
	for select sh_code,sh_name,sh_type,sh_from1,sh_to1,sh_from2,sh_to2,sh_from3,sh_to3,sh_Kind,sh_Nesab from inserted
	OPEN insertedCursor
	FETCH NEXT FROM insertedCursor
	INTO @code, @name,@shiftType,@from1,@to1,@from2,@to2,@from3,@to3,@kind,@nesab
	WHILE @@FETCH_STATUS = 0
	BEGIN			 
		if(exists(select * from ta_shift where Shift__ShiftID=@code))
		begin
			update ta_shift set shift_name=@name,shift_type=isnull(@shifttype,0),shift_nobatkari=@kind,shift_minnobatkari=@nesab WHERE shift__shiftid=@code
			
			delete from TA_ShiftPair where ShiftPair_ShiftId in (select shift_ID from ta_shift where Shift__ShiftID=@code)			
		end
		else  --insert
		begin
			SET IDENTITY_INSERT TA_Shift ON
			INSERT INTO TA_Shift (Shift_ID, Shift_Name,Shift_type, Shift__ShiftID,shift_nobatkari,shift_minnobatkari)
			values(@code,@name,isnull(@shifttype,0),@code,@kind,@nesab)
		end
		
		INSERT INTO TA_Shiftpair (ShiftPair_ShiftId, ShiftPair_From, ShiftPair_To)	
		values( @code,isnull(@from1,0), isnull(@to1,0))

		INSERT INTO TA_Shiftpair (ShiftPair_ShiftId, ShiftPair_From, ShiftPair_To)	
		values( @code,isnull(@from2,0),isnull( @to2,0))
		
		INSERT INTO TA_Shiftpair (ShiftPair_ShiftId, ShiftPair_From, ShiftPair_To)	
		values( @code,isnull(@from3,0),isnull( @to3,0))

		FETCH NEXT FROM insertedCursor
		INTO @code, @name,@shifttype,@from1,@to1,@from2,@to2,@from3,@to3,@kind,@nesab
	END
	
	CLOSE insertedCursor
	DEALLOCATE insertedCursor
	
	if(@insertedCount=0 and @deletedCount>0)--delete event
	begin
		delete from TA_Shift where shift__shiftid in  (select sh_code from deleted)
	end

	DELETE FROM TA_ShiftPair
	WHERE ShiftPair_From = 0
			OR
		  ShiftPair_To = 0
	
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END
GO
