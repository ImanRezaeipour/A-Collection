if(not exists(select * from [TA_ConceptTemplate] where ConceptTmp_IdentifierCode=2503))
begin	
	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماموریت روزانه تعطیل', N'', N'', 2503, 0, 1, 0, 1, N'', N'', 0, N'', 0)

	INSERT [dbo].[TA_ConceptTemplate] ( [ConceptTmp_Name], [ConceptTmp_Script], [ConceptTmp_CSharpCode], [ConceptTmp_IdentifierCode], [ConceptTmp_IsPeriodic], [ConceptTmp_Type], [ConceptTmp_CalcSituationType], [ConceptTmp_PersistSituationType], [ConceptTmp_KeyColumnName], [ConceptTmp_Color], [ConceptTmp_UserDefined], [ConceptTmp_JsonObject], [concepttmp_datatype])
	VALUES ( N'ماموریت روزانه تعطیل ماهانه', N'', N'', 2504, 1, 1, 0, 1, N'', N'', 0, N'', 0)
end