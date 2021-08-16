
alter PROCEDURE spr_OverTimeTrigetCreator

AS
BEGIN
	declare @ystr varchar(6)
	declare @str varchar(Max)

	set @ystr='137901'
	
	while @ystr<'140601'
		begin
		   if exists(select id from sysobjects where type='u' and name='E'+@ystr) 
			  begin
				if not exists(select name,id,type from sysobjects where type='tr' and name='OverTimeTriget'+@ystr)
				set @str='CREATE TRIGGER OverTimeTriget'+@ystr+'
	   ON  e'+@ystr+'
	   AFTER INSERT,DELETE,UPDATE
	AS 
	BEGIN
		declare @prsID numeric,@barcode varchar(20), @year varchar(5),@mounth varchar(5)
		set @year = '+LEFT(@ystr,4)+'; set @mounth = '+RIGHT(@ystr,2)+'; 
		select @barcode=E_PCode from inserted
		select @prsID=Prs_ID from TA_Person where prs_barcode=@barcode	
		delete  [TA_OverTimePermit] where [OverTimePrm_PersonId]=@prsID and [OverTimePrm_Year]=@year and [OverTimePrm_Mounth]=@mounth
		INSERT INTO [Falat].[dbo].[TA_OverTimePermit]
			   ([OverTimePrm_PersonId]
			   ,[OverTimePrm_Year]
			   ,[OverTimePrm_Mounth]
			   ,[OverTimePrm_D01],[OverTimePrm_D02],[OverTimePrm_D03],[OverTimePrm_D04],[OverTimePrm_D05]
			   ,[OverTimePrm_D06],[OverTimePrm_D07],[OverTimePrm_D08],[OverTimePrm_D09],[OverTimePrm_D10]
			   ,[OverTimePrm_D11],[OverTimePrm_D12],[OverTimePrm_D13],[OverTimePrm_D14],[OverTimePrm_D15]
			   ,[OverTimePrm_D16],[OverTimePrm_D17],[OverTimePrm_D18],[OverTimePrm_D19],[OverTimePrm_D20]
			   ,[OverTimePrm_D21],[OverTimePrm_D22],[OverTimePrm_D23],[OverTimePrm_D24],[OverTimePrm_D25]
			   ,[OverTimePrm_D26],[OverTimePrm_D27],[OverTimePrm_D28],[OverTimePrm_D29],[OverTimePrm_D30]
			   ,[OverTimePrm_D31])
	    
			   (SELECT @prsID ,@year,@mounth
		  ,[E_D01],[E_D02],[E_D03],[E_D04],[E_D05]
		  ,[E_D06],[E_D07],[E_D08],[E_D09],[E_D10]
		  ,[E_D11],[E_D12],[E_D13],[E_D14],[E_D15]
		  ,[E_D16],[E_D17],[E_D18],[E_D19],[E_D20]
		  ,[E_D21],[E_D22],[E_D23],[E_D24],[E_D25]
		  ,[E_D26],[E_D27],[E_D28],[E_D29],[E_D30]
		  ,[E_D31] 
		  from inserted)
		

	END'
				exec(@str)				
			  end
			set @ystr=dbo.AfterMonthDate(@ystr)
		end
END
GO
