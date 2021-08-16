if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=284))
begin
	INSERT [dbo].[TA_RuleTemplate] ([RuleTmp_ID], [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible]) 
	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N'هیئت علمی - اعمال تعطیلات خاص بجز پنجشنبه و جمعه', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'3', 14645, 284, 0, CAST(554 AS Numeric(18, 0)), NULL)

	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'first',[RuleTmp_ID] ,'میزان کارکرد ',1,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=268
	
end


if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=285))
begin
	INSERT [dbo].[TA_RuleTemplate] ([RuleTmp_ID], [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible]) 
	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N'هیئت علمی - اعمال کارکرد روزانه ماهانه', N'موجود نیست', N'موجود نیست', N'موجود نیست', N'3', 14646, 285, 0, CAST(554 AS Numeric(18, 0)), NULL)
	
end
