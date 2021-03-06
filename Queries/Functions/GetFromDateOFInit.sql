
ALTER FUNCTION [dbo].[GetFromDateOFInit](@Init_Code int,
								  @Year int,
								  @Month int)								  
RETURNS varchar(10)
AS
BEGIN
	DECLARE @Day int
	IF (@Month = 1)
	BEGIN		
		SET @Year = @Year - 1
		SET @Month = 12
	END
	ELSE 
		SET @Month = @Month - 1
			
	SELECT @Day = SUBSTRING(Init_Value, LEN(Init_Value) - 1, LEN(Init_Value))
	FROM init
	WHERE Init_Title = 'monthends'
			AND
		  Init_Code = @Init_Code				    
		    AND
		  SUBSTRING(Init_Value, 1, LEN(Init_Value) - 2) = @Month
	RETURN dbo.GTS_ASM_AddShamsiDay(Convert(varchar(4), @Year), Convert(varchar(2), @Month), Convert(varchar(2), @Day), 1)
END

