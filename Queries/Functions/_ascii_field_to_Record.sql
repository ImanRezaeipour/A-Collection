
alter FUNCTION [dbo].[ascii_field_to_Record]
(@month_ int, @grd_code int, @grd_year varchar(4), @grd_m1 varchar(31))
RETURNS 
@tbl_ table (GRD_code int, 
			 GRD_Shift int,
			 GRD_Date varchar(10))
AS
BEGIN
	DECLARE @i_ int,
	        @decrement int,@sh_ID varchar(50)
	SET @i_ = 1
	IF @month_ <= 6 SET @decrement = 1
	IF @month_ > 6 SET @decrement = 0
	IF @month_ = 12 SET @decrement = -1	
	
	WHILE @i_< LEN(@grd_m1) + @decrement
	BEGIN
		IF ascii(SUBSTRING(@grd_m1, @i_, 1)) - 1 <> 0
		BEGIN
	    set @sh_ID =  ISNULL((SELECT ISNULL(SH_Code, 0)
							 FROM shifts
							 WHERE SH_Code = (ascii(SUBSTRING(@grd_m1, @i_, 1)) - 1)), 0);
		  INSERT INTO @tbl_ 
			VALUES(@grd_code, 
					 @sh_ID, 					
					dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10), @grd_year + '/' + dbo.ZeroFixed(@month_, 2) + '/' + dbo.ZeroFixed(@i_, 2),101)))		  
		END
		SET @i_= @i_ + 1	  
	END
	RETURN 
END
