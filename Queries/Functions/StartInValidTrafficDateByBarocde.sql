ALTER function [dbo].[fn_StartInValidTrafficDateByBarcode](@barcode varchar(10))
returns varchar(50)
as 
begin
declare @basicTraficDate datetime,@cfpDate varchar(10)
select @cfpDate= MIN(CFP_Date) from TA_Calculation_Flag_Persons where CFP_Barcode=@barcode
select @basicTraficDate = MIN(BasicTraffic_Date) from TA_BaseTraffic  where BasicTraffic_PersonID in (Select Prs_Id from TA_person where Prs_barcode=@barcode) 
	AND (BasicTraffic_Used=0 OR BasicTraffic_Active=0)
if @cfpDate is null and @basicTraficDate is null
	return Convert(varchar(10), GetDate(),101)
else if  @cfpDate is null
	return @basicTraficDate
else if @basicTraficDate is null
	return dbo.GTS_ASM_ShamsiToMiladi( Convert(varchar(10),@cfpDate,101))
else if @basicTraficDate <=  dbo.GTS_ASM_ShamsiToMiladi( Convert(varchar(10),@cfpDate,101))
	return 	@basicTraficDate
else 
	return 	dbo.GTS_ASM_ShamsiToMiladi( Convert(varchar(10),@cfpDate,101))
return ''		
end

