
ALTER FUNCTION [dbo].[ConceptParams](@CnpTmpID numeric,
								  @ScnCnpId numeric,								   
								  @Rule_Code smallint)
RETURNS  @ConceptParams TABLE
(
	ScnCnpId numeric(18, 0),
	Name nvarchar(50),
	Value decimal
)
AS
BEGIN	
	DECLARE @paramName nvarchar(50),
			@tableName nvarchar(50), 
			@columnName nvarchar(50)	
			
	DECLARE CnpTmp_cursor CURSOR
		FOR SELECT ConceptTmpParam_Name, ConceptTmpParam_TableName, ConceptTmpParam_ColumnName 
			FROM TA_CocneptTemplateParameter 
			WHERE ConceptTmpParam_ConceptTemplateId = @CnpTmpID
			
	OPEN CnpTmp_cursor	
	FETCH NEXT FROM CnpTmp_cursor
	INTO @paramName, @tableName, @columnName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @sqlCommand nvarchar(MAX)
		DECLARE @result decimal
		
		SET @sqlCommand = N'SELECT ' + @columnName + ' ' +
						   'FROM ' + @tableName + ' ' +
						   'WHERE Rule_Code = ' + Convert(nvarchar(20), @Rule_Code)
		SELECT @result = dbo.GTS_ASM_ExecuteSQL(@sqlCommand)						   
			
		INSERT INTO @ConceptParams VALUES(@ScnCnpId, 
											  @paramName,
											  @result)
									
		FETCH NEXT FROM CnpTmp_cursor
		INTO @paramName, @tableName, @columnName
	END

	CLOSE CnpTmp_cursor
	DEALLOCATE CnpTmp_cursor
	RETURN
END	
