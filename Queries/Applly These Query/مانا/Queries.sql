
if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=291))
begin
		
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_ID],[RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N'اعمال اضافه کار 24 ساعته', N'', N'', NULL, N'3', 1700, 291, 0, CAST(553 AS Numeric(18, 0)), 0, N'', 1)

	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'First',N'',N'',0,N'روز کاری'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=291

	 	INSERT INTO [dbo].[TA_RuleTemplateParameter]
			([RuleTmpParam_RuleTemplateId],[RuleTmpParam_Name],[RuleTmpParam_ColumnName],[RuleTmpParam_TableName],[RuleTmpParam_Type],[RuleTmpParam_Title])
     select [RuleTmp_ID],N'Second',N'',N'',0,N'روز غیر کاری'	from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=291
end

if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=292))
begin
		
	INSERT [dbo].[TA_RuleTemplate] ( [RuleTmp_ID],[RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible], [RuleTmp_JsonObject], [RuleTmp_UserDefined])
	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N'اعمال کارکرد در صورت تردد', N'', N'', NULL, N'1', 0, 292, 0, CAST(554 AS Numeric(18, 0)), 0, N'', 0)
end


update ta_concepttemplate 
set concepttmp_type=0,concepttmp_datatype=1
where concepttmp_identifiercode=4023