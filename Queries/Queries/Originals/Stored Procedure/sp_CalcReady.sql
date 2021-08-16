alter procedure [dbo].[CalcReady] @barcode varchar(10),@date varchar(10)
AS
begin

--1
--delete from TA_SecondaryConceptValue where ScndCnpValue_PersonId in ( select prs_ID from TA_Person where Prs_Barcode=@barcode )

--2
delete from TA_Calculation_Flag_Persons where CFP_Barcode=@barcode 

--3
declare @i int,@j int,@ptable varchar(100),@script varchar(500)
set @i=85;
set @j=1;

while @i<90
begin 
	set @j=1;
	while @j<13
	begin
	begin try
		set @ptable = '13'+convert(varchar(2),@i)+RIGHT('00'+ convert(varchar(2),@j),2)		
		set @script='delete from p'+@ptable +' where Prc_PCode='''+@barcode+ '''';
		exec ( @script )
	
		end try
		begin catch
		end catch
		set @j=@j+1;
	end
	set @i=@i+1;
end 
--delete from P138801 where Prc_PCode=@barcode 
--delete from P138802 where Prc_PCode=@barcode 
--delete from P138803 where Prc_PCode=@barcode 
--delete from P138804 where Prc_PCode=@barcode 
--delete from P138805 where Prc_PCode=@barcode 
--delete from P138806 where Prc_PCode=@barcode 
--delete from P138807 where Prc_PCode=@barcode 
--delete from P138808 where Prc_PCode=@barcode 
--delete from P138809 where Prc_PCode=@barcode 
--delete from P138810 where Prc_PCode=@barcode 
--delete from P138811 where Prc_PCode=@barcode 
--delete from P138812 where Prc_PCode=@barcode 

--delete from P138901 where Prc_PCode=@barcode 
--delete from P138902 where Prc_PCode=@barcode 
--delete from P138903 where Prc_PCode=@barcode 
--delete from P138904 where Prc_PCode=@barcode 
--delete from P138905 where Prc_PCode=@barcode 
--delete from P138906 where Prc_PCode=@barcode 
--delete from P138907 where Prc_PCode=@barcode 
--delete from P138908 where Prc_PCode=@barcode 
--delete from P138909 where Prc_PCode=@barcode 
--delete from P138910 where Prc_PCode=@barcode 
--delete from P138911 where Prc_PCode=@barcode 
--delete from P138912 where Prc_PCode=@barcode 


--4
insert into TA_Calculation_Flag_Persons
VALUES(@barcode, @date)
end



