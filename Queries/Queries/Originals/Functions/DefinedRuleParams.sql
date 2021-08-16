
CREATE FUNCTION DefinedRuleParams(@RuleTmpID numeric,
								  @DefinedRuleId numeric,								   
								  @Rule_Code smallint)
RETURNS  @DefinedRuleParams TABLE
(
	DefinedRuleId numeric(18, 0),
	Name nvarchar(50),
	Value decimal
)
AS
BEGIN	
	DECLARE @paramName nvarchar(50),
			@tableName nvarchar(50), 
			@columnName nvarchar(50)	
			
	DECLARE RuleTmp_cursor CURSOR
		FOR SELECT RleTmpParam_Name, RleTmpParam_TableName, RleTmpParam_ColumnName
			FROM TA_RuleTemplateParameter
			WHERE RleTmpParam_RuleTemplateId = @RuleTmpID
			
	OPEN RuleTmp_cursor	
	FETCH NEXT FROM RuleTmp_cursor
	INTO @paramName, @tableName, @columnName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @sqlCommand nvarchar(MAX)
		DECLARE @result decimal
		
		SET @sqlCommand = N'SELECT ' + @columnName + ' ' +
						   'FROM ' + @tableName + ' ' +
						   'WHERE Rule_Code = ' + Convert(nvarchar(20), @Rule_Code)
		SELECT @result = dbo.GTS_ASM_ExecuteSQL(@sqlCommand)						   
			
		INSERT INTO @DefinedRuleParams VALUES(@DefinedRuleId, 
											  @paramName,
											  @result)
									
		FETCH NEXT FROM RuleTmp_cursor
		INTO @paramName, @tableName, @columnName
	END

	CLOSE RuleTmp_cursor
	DEALLOCATE RuleTmp_cursor
	RETURN
END	

 
		
