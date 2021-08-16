
CREATE PROCEDURE [dbo].[asciicode_]
@p_barcode varchar(8),@month int ,@year int
AS
BEGIN
	SET NOCOUNT ON;
-------------------
declare @tbl_temp table (grd_str varchar(31))
declare @str33 varchar(200)
declare @str34 varchar(200)
declare @grd_code varchar(3)
set @grd_code=(select P_ShiftGroup from persons  where P_BarCode=@p_barcode)
set @str33=' select  Grd_M'+convert(varchar(2),@month)+' into tbl_temp from grp_dtl where Grd_Code='+@grd_code+' and Grd_Year='+convert(varchar(4),@year)
execute(@str33)
insert into @tbl_temp select * from tbl_temp
drop table tbl_temp
set @str33=(select * from @tbl_temp)
declare @i_ int
set @i_=1
set @str34=SPACE(0)
while @i_<LEN(@str33)
begin
 set @str34=@str34+dbo.ZeroFixed(@month,2)+dbo.ZeroFixed(ASCII(SUBSTRING(@str33,@i_,1)),3)+';'
 set @i_=@i_+1
end
select (@str34) asciicode
END

