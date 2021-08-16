--INSERT [dbo].[TA_SecurityResource] ([resource_ID],[resource_ResourceID], [resource_ParentID], [resource_PageID], [resource_Description], [resource_ParentPath], [resource_CheckKey], [resource_MethodPath], [resource_MethodFullName]) VALUES ( (select max(resource_ID) from [dbo].[TA_SecurityResource])+1,N'tlbItemMonthlyExceptionShifts_TlbMasterExceptionShifts', CAST(44 AS Numeric(18, 0)), N'MasterExceptionShifts.aspx', N'شيفت هاي استثناء ماهيانه', N',44,218,36,', NULL, N'GTS.Clock.Business.Shifts.BExceptionShift', N'Void CheckMonthlyExceptionShiftsLoadAccess()')
--GO
INSERT [dbo].[TA_SecurityResource] ([resource_ID],[resource_ResourceID], [resource_ParentID], [resource_PageID], [resource_Description], [resource_ParentPath], [resource_CheckKey], [resource_MethodPath], [resource_MethodFullName]) VALUES (1500 ,N'nvbItemConceptRuleMasterOperation_NavBarMain', CAST(52 AS Numeric(18, 0)), N'ConceptRuleMasterOperation.aspx', N'مديريت مفاهيم و قوانين', N',52,36,', NULL, N'GTS.Clock.Business.RuleDesigner.BConceptExpressions', N'Void CheckUsersLoadAccess()')
GO
INSERT [dbo].[TA_SecurityResource] ([resource_ID],[resource_ResourceID], [resource_ParentID], [resource_PageID], [resource_Description], [resource_ParentPath], [resource_CheckKey], [resource_MethodPath], [resource_MethodFullName]) VALUES (1501, N'nvbItemExpressionsOperation_NavBarMain', CAST(52 AS Numeric(18, 0)), N'ExpressionsManagement.aspx', N'"مديريت مولفه هاي ساخت مفاهيم و قوانين', N',52,36,', NULL, N'GTS.Clock.Business.RuleDesigner.BConceptExpressions', N'Void CheckUsersLoadAccess()')
GO
/*
  INSERT INTO [GhadirGTS].[dbo].[TA_SecurityAuthorize] VALUES(1,5207,1)
  INSERT INTO [GhadirGTS].[dbo].[TA_SecurityAuthorize] VALUES(1,5208,1)
*/
