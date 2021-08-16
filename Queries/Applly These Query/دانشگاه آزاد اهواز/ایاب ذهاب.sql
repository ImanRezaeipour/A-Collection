--if(not exists(select * from [TA_RuleTemplate]  where [RuleTmp_IdentifierCode]=225))
--begin
--	INSERT [dbo].[TA_RuleTemplate] ([RuleTmp_ID], [RuleTmp_Name], [RuleTmp_Script], [RuleTmp_CSharpCode], [RuleTmp_CustomCode], [RuleTmp_CustomCategoryCode], [RuleTmp_Order], [RuleTmp_IdentifierCode], [RuleTmp_IsPeriodic], [RuleTmp_RuleTypeId], [RuleTmp_IsForcible]) 
--	VALUES ((select MAX([RuleTmp_ID]) from [dbo].[TA_RuleTemplate]) +1, N'اعمال ایاب ذهاب', N'', N'', N'', N'1', 14700, 225, 0, CAST(554 AS Numeric(18, 0)), NULL)
--end

if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=5019))
begin
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ایاب ذهاب ', N'', N'', 5001, NULL, 1, 0, 0, NULL, 0, 1, NULL, 'ایاب ذهاب', N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ایاب ذهاب ماهانه', N'', N'', 5019, NULL, 1, 1, 1, NULL, 2, 1, NULL, 'ایاب ذهاب ', N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=5019 and c2.ConceptTmp_IdentifierCode=5001
end