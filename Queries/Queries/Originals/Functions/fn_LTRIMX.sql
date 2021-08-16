
ALTER FUNCTION [dbo].[LTRIMEX] (@SOURCE nvarchar(8), @CHAR char) 
 RETURNS nvarchar(8)  
 AS
  BEGIN 
  	DECLARE @I int 	
  	SET @I = 1 
  		WHILE (LEFT(@SOURCE, 1) = @CHAR) AND (@I <= 8) 
  			BEGIN 
  					SET @SOURCE = RIGHT(@SOURCE, LEN(@SOURCE) - 1) 	
  					SET @I = @I + 1 	
  			END 
  		RETURN @SOURCE
   END 



