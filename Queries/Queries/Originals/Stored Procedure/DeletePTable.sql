

ALTER PROC [dbo].[DeletePTable](@barCode varchar(20), @year varchar(4), @mounth varchar(4), @day varchar(4))
AS
BEGIN
	DECLARE @TableName varchar(10), 
			@sqlCommand nvarchar(200), 
			@result nvarchar
	SET @TableName = @year + @mounth
	
	IF EXISTS(SELECT name
			  FROM sys.objects
			  WHERE name = @TableName)
	BEGIN
		SET @sqlCommand = N'DELETE ' +
							   'FROM P' + @TableName + ' ' +
							   'WHERE Prc_PCode = ' + @barCode + 
							   ' AND (' + 
							   'Prc_Date >= ' + @year + '/' + @mounth + '/' + @day +
							   ' OR ' +
							   'Prc_Date = ' + @year + '/' + @mounth + '/00)'
							   
		EXEC sp_executesql @sqlCommand
	END
END


