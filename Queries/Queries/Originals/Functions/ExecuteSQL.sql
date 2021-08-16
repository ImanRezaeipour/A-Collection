
ALTER FUNCTION [dbo].[ExecuteSQL](@SQL [nvarchar](4000))
RETURNS INT WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [GTS.Clock.Model.SQLServerFunctions].[UserDefinedFunctions].[ExecuteSQL]



