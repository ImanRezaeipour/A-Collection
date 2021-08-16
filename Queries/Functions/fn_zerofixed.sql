
CREATE FUNCTION [dbo].[ZeroFixed](@no_ int,@count_ int)
RETURNS varchar(50)
AS
BEGIN
  RETURN REPLICATE('0',@count_-LEN(convert(varchar(10),@no_)))+convert(varchar(10),@no_)
END
