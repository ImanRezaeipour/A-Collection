CREATE TRIGGER trg_UPD_addfree
   ON  addfree
   AFTER update
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
    insert into TA_Calculation_Flag_Persons select Add_PCode,convert(varchar(4),Add_Year)+'/'+dbo.zerofixed(Add_Month,2)+'/01' from inserted
    end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END

GO
