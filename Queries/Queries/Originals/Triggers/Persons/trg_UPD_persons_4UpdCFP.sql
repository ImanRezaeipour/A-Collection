CREATE TRIGGER trg_Upd_persons_4UpdCFP
   ON  [dbo].[persons]
   AFTER  UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	declare @barcode varchar(8);
	
	IF UPDATE(P_ShiftGroup) or UPDATE(P_RuleGroup)  
	begin
declare inserted_cursor cursor 
	for select p_barcode
	from inserted
	
	open inserted_cursor
	fetch next from inserted_cursor
	into @barcode
	while @@fetch_status = 0
	begin		
		insert into TA_Calculation_Flag_Persons 
		values(@barcode,convert(varchar(4),(substring(dbo.GTS_ASM_MiladiToShamsi( Convert(varchar(10),Getdate(),101)),1,4)-1))+substring(dbo.GTS_ASM_MiladiToShamsi( Convert(varchar(10),Getdate(),101)),5,10) )
	    
		fetch next from inserted_cursor
		into @barcode
	end	  
	close inserted_cursor
	deallocate inserted_cursor
	end
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END




