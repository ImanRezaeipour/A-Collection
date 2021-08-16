if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=192))
begin
	INSERT [dbo].[TA_RuleTemplate] ([RuleTmp_ID], [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible]) 
	VALUES (select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N'ماهانه بیش از ------ ساعت اضافه کار  تا سقف ---------- ساعات بعنوان اضافه کار ویژه لحاظ گردد', N'', N'', N'', N'5', 14648, 192, 1, CAST(552 AS Numeric(18, 0)), NULL)

	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'first',[RuleTmp_ID] ,'از مدت  ',1,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=192
	
	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'second',[RuleTmp_ID] ,'تا سقف  ',1,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=192

	insert into TA_RuleTemplateParameter(RuleTmpParam_Name,RuleTmpParam_RuleTemplateId,RuleTmpParam_Title,RuleTmpParam_Type,RuleTmpParam_ColumnName,RuleTmpParam_TableName)
	select 'second',[RuleTmp_ID] ,'کاهش از اضافه کار عادي  ',0,'','' from [dbo].[TA_RuleTemplate] where RuleTmp_IdentifierCode=192
end

if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=4033))
begin
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'اضافه کار ویژه ', N'', N'', 4032, NULL, 5, 0, 0, NULL, 0, 1, NULL, 'اضافه کار ویژه', N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'اضافه کار ویژه ماهانه', N'', N'', 4033, NULL, 5, 1, 1, NULL, 2, 1, NULL, 'اضافه کار ویژه ', N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=4033 and c2.ConceptTmp_IdentifierCode=4032
end