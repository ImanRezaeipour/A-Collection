

if(not exists(select * from TA_ConceptTemplate  where ConceptTmp_IdentifierCode=501))
begin
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'حق التدریس ', N'', N'', 501, NULL, 1, 0, 0, NULL, 0, 1, NULL, 'حق التدریس', N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_CustomCode], [ConceptTmp_CustomCategoryCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_PColumn], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_EngName], [ConceptTmp_FnName], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'حق التدریس ماهانه', N'', N'', 502, NULL, 1, 1, 1, NULL, 2, 1, NULL, 'حق التدریس', N'', N'', 0, N'', 0)

	insert into TA_PeriodicCnpTmpDetail(PrdCnpTmpDetail_PrdCnpTmpId,PrdCnpTmpDetail_DtlCnpTmpId)
	select c1.ConceptTmp_ID,c2.ConceptTmp_ID from TA_ConceptTemplate as c1
	join TA_ConceptTemplate as c2 on c1.ConceptTmp_IdentifierCode=502 and c2.ConceptTmp_IdentifierCode=501
end