
ALTER FUNCTION [dbo].[AfterMonthDate](@pdate varchar(6))

RETURNS varchar(6)
AS
BEGIN
return case 
           when RIGHT(@pdate,2)<9 then LEFT(@pdate,LEN(@pdate)-2)+ '0'+convert(char(1),convert(int,right(@pdate,2))+1) 
           when RIGHT(@pdate,2)<12 then LEFT(@pdate,LEN(@pdate)-2)+ convert(char(2),convert(int,right(@pdate,2))+1) 
           when RIGHT(@pdate,2)=12 then  convert(varchar(5),convert(int,LEFT(@pdate,LEN(@pdate)-2))+1) +'01'
       end 
END
