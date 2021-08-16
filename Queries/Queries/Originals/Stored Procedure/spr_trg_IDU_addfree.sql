alter PROCEDURE spr_trg_IDU_addfree
AS
BEGIN
	SET NOCOUNT ON;
    declare @str_ varchar(1000)
--------------------------------------
    if not exists(select id from sysobjects where xtype='tr' and name='trg_DEL_addfree')
	Begin
		set @str_=
		' CREATE TRIGGER trg_DEL_addfree '+
		' ON  addfree '+
		' AFTER DELETE AS '+
		' BEGIN '+
		' SET NOCOUNT ON; '+
		' insert into TA_Calculation_Flag_Persons select Add_PCode,convert(varchar(4),Add_Year)+'''+'/'+'''+dbo.zerofixed(Add_Month,2)+'''+'/01'+''' from deleted   '+
		' END '
        exec(@str_)
     END   
----------------------------------------        
    if not exists(select id from sysobjects where xtype='tr' and name='trg_INS_addfree')
	Begin
		set @str_=
		' CREATE TRIGGER trg_INS_addfree '+
		' ON  addfree '+
		' AFTER insert AS '+
		' BEGIN '+
		' SET NOCOUNT ON; '+
		' insert into TA_Calculation_Flag_Persons select Add_PCode,convert(varchar(4),Add_Year)+'''+'/'+'''+dbo.zerofixed(Add_Month,2)+'''+'/01'+''' from inserted   '+
		' END '
        exec(@str_)
    END
----------------------------------------        
    if not exists(select id from sysobjects where xtype='tr' and name='trg_UPD_addfree')
	Begin
		set @str_=
		' create TRIGGER trg_UPD_addfree '+
		' ON  addfree '+
		' AFTER update AS '+
		' BEGIN '+
		' SET NOCOUNT ON; '+
		' insert into TA_Calculation_Flag_Persons select Add_PCode,convert(varchar(4),Add_Year)+'''+'/'+'''+dbo.zerofixed(Add_Month,2)+'''+'/01'+''' from inserted   '+
		' END '
        exec(@str_)
    END
END
GO
