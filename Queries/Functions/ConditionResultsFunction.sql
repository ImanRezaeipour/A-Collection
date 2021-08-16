
CREATE FUNCTION ConditionResults(@Rule_Code smallint)
RETURNS @results TABLE
(
	ConditionID numeric(18, 0),
	OldRule_Code smallint,
	Result bit
)
AS
BEGIN
	DECLARE @conditionID numeric(18, 0), 
		@tableName nvarchar(50), 
		@columnName nvarchar(50), 
		@comparativeOperation smallint, 
		@expectedValue decimal(18, 0),
		@ANDConditionID numeric,
		@sqlCommand nvarchar(MAX)
		
	DECLARE condition_cursor CURSOR
		FOR SELECT TmpCondition_ID, TmpCondition_TableName, TmpCondition_ColumnName,
					 TmpCondition_ComparativeOperation, TmpCondition_ExpectedValue,
					 TmpCondition_AndRleTmpConditionId
			FROM TA_TemplateCondition	
	OPEN condition_cursor	
	FETCH NEXT FROM condition_cursor
	INTO @conditionID, @tableName, @columnName, @comparativeOperation, @expectedValue, @ANDConditionID

	WHILE @@FETCH_STATUS = 0
	BEGIN

		DECLARE @result decimal	
		DECLARE @ANDcomparativeOperation smallint
		DECLARE @ANDexpectedValue decimal(18, 0)	
		DECLARE @ANDResult bit
		SET @ANDcomparativeOperation = -1000
		-----------------------------------------------
		SELECT @sqlCommand = N'SELECT ' + TmpCondition_ColumnName + ' ' +
							  'FROM ' + TmpCondition_TableName + ' ' +
							  'WHERE Rule_Code = ' + Convert(nvarchar(20), @Rule_Code),
			  @ANDcomparativeOperation = ISNULL(TmpCondition_ComparativeOperation, -1000),
			  @ANDexpectedValue = ISNULL(TmpCondition_ExpectedValue, -1000)  
		FROM TA_TemplateCondition
		WHERE TmpCondition_ID = @ANDConditionID
		
		SELECT @result = dbo.GTS_ASM_ExecuteSQL(@sqlCommand)
		
		SELECT @ANDResult = CASE @ANDcomparativeOperation
									WHEN 0 THEN
												CASE WHEN @result = @ANDexpectedValue THEN 1 ELSE 0 END		
									WHEN 1 THEN 
												CASE WHEN @result > @ANDexpectedValue THEN 1 ELSE 0 END					
									WHEN 2 THEN 
												CASE WHEN @result < @ANDexpectedValue THEN 1 ELSE 0 END					
									WHEN 3 THEN 
												CASE WHEN @result <> @ANDexpectedValue THEN 1 ELSE 0 END					
									ELSE 1
							END
		IF @ANDResult = 1
		BEGIN									
			SET @sqlCommand = N'SELECT ' + @ColumnName + ' ' +
							   'FROM ' + @TableName + ' ' +
							   'WHERE Rule_Code = ' + Convert(nvarchar(20), @Rule_Code)
			SELECT @result = dbo.GTS_ASM_ExecuteSQL(@sqlCommand)						   
		 
			INSERT INTO @results
			SELECT @conditionID ConditionID, 
				   @Rule_Code OldRule_Code,
				   CASE @ComparativeOperation
					WHEN 0 THEN
								CASE WHEN @result = @ExpectedValue THEN 1 ELSE 0 END		
					WHEN 1 THEN 
								CASE WHEN @result > @ExpectedValue THEN 1 ELSE 0 END					
					WHEN 2 THEN 
								CASE WHEN @result < @ExpectedValue THEN 1 ELSE 0 END					
					WHEN 3 THEN 
								CASE WHEN @result <> @ExpectedValue THEN 1 ELSE 0 END					
					ELSE 0
				   END Reuslt
		END
		
		FETCH NEXT FROM condition_cursor
		INTO @conditionID, @tableName, @columnName, @comparativeOperation, @expectedValue, @ANDConditionID
	END

	CLOSE condition_cursor
	DEALLOCATE condition_cursor
	RETURN
END
