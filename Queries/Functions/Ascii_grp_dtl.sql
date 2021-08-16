
CREATE FUNCTION [dbo].[Ascii_grp_dtl](@str_in varchar(50),@Month_ int)
RETURNS varchar(200)
AS
BEGIN
declare @month_str varchar(2)
declare @str varchar(200)
declare @i_ int
if  @month_<10 set @month_str='0'+convert(varchar(1),@month_) else set @month_str=convert(varchar(2),@month_)
set @i_=1
set @str=''
while @i_<LEN(@str_in)
begin
 set @str=@str+@month_str+dbo.ZeroFixed(ASCII(SUBSTRING(@str_in,@i_,1)),3)+';'
 set @i_=@i_+1
end
return (@str)
END
