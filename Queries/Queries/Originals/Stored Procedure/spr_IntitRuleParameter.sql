alter proc spr_IntitRuleParameter @assignRuleParamID numeric
AS

	DECLARE @paramName nvarchar(200),@columnName nvarchar(200),@tableName nvarchar(200),@paramDataType int,
			@value nvarchar(200)

	DECLARE ruleParams_cursor CURSOR 
		FOR	
			select RuleTmpParam_Name,RuleTmpParam_ColumnName,RuleTmpParam_TableName,RuleTmpParam_Type from TA_RuleTemplateParameter where RuleTmpParam_RuleTemplateId in 
			(select rule_ruletmpId from TA_Rule where Rule_ID in
			(select AsgRuleParam_RuleId from TA_AssignRuleParameter where AsgRuleParam_ID=@assignRuleParamID))
			
	OPEN ruleParams_cursor	
		FETCH NEXT FROM ruleParams_cursor
		INTO @paramName,@columnName,@tableName,@paramDataType
		
	WHILE @@FETCH_STATUS = 0
		BEGIN
			if @paramDataType = 0 or @paramDataType = 1
				set @value = '0';
			else if @paramDataType = 2
				set @value= '1900/01/01';
			insert into TA_RuleParameter(RuleParam_AsgRuleParamId,RuleParam_Name,RuleParam_Type,RuleParam_Value)
				values(@assignRuleParamID,@paramName,@paramDataType	,@value)		
			
			FETCH NEXT FROM ruleParams_cursor
			INTO @paramName,@columnName,@tableName,@paramDataType
		END
	
	CLOSE ruleParams_cursor
	DEALLOCATE ruleParams_cursor
	

