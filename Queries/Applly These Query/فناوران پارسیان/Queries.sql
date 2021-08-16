
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=284))
begin
		
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_ID],[RuleTmp_Name], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined], [RuleTmp_Script], [RuleTmp_CSharpCode])
	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N' محاسبه کارکرد پرسنل اقماری',  N'1', 15000, 284, 0, CAST(554 AS Numeric(18, 0)), 0, N'', 1,'','')

end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=285))
begin
		
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_ID],[RuleTmp_Name], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined], [RuleTmp_Script], [RuleTmp_CSharpCode])
	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N' اگر کارکرد به .... رسید , کارکرد روزانه لحاظ گردد',  N'1', 120, 285, 0, CAST(554 AS Numeric(18, 0)), 0, N'', 1,'','')


	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'First',N'',N'',1,N'میزان کارکرد'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=285
end


