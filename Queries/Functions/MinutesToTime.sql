create function [dbo].[MinutesToTime](@timeInMinutes int)
returns varchar(5)
begin
 set @timeInMinutes =isnull(@timeInMinutes,-1000)
if(@timeInMinutes =-1000)
begin
	return ''
end
declare @outOfDay  bit,@timeInDay int,@hour int ,@min int;
set @outOfDay=0;
set @timeInDay=1440;
if (@timeInMinutes > @timeInDay ) 
        begin
          set  @outOfDay = 1;
          set  @timeInMinutes = @timeInMinutes % @timeInDay;
        end
set @hour =@timeInMinutes /60;  
set @min = @timeInMinutes %60;
if(@outOfDay =0)
begin
return convert(nvarchar,@hour) + ':' + convert(nvarchar,@min) ;
end
if(@outOfDay=1)
begin
return '+'+convert(nvarchar,@hour) + ':' + convert(nvarchar,@min);
end
return '';
end
