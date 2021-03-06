--USE [GhadirGTS]
GO
/****** Object:  Table [dbo].[TA_ConceptExpression]    Script Date: 7/1/2013 10:13:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA_ConceptExpression](
	[Expression_ID] [int] IDENTITY(1,1) NOT NULL,
	[Parent_ID] [int] NULL,
	[ScriptBeginEn] [nvarchar](max) NULL,
	[ScriptEndEn] [nvarchar](max) NULL,
	[ScriptBeginFa] [nvarchar](300) NOT NULL,
	[ScriptEndFa] [nvarchar](300) NULL,
	[AddOnParentCreation] [bit] NOT NULL,
	[SortOrder] [tinyint] NOT NULL,
	[CandAddToFinal] [bit] NOT NULL,
	[CandEditInFinal] [bit] NOT NULL,
	[Visible] [bit] NOT NULL,
 CONSTRAINT [PK_TA_ConceptExpressions] PRIMARY KEY CLUSTERED 
(
	[Expression_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[TA_ConceptExpression] ON 

GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (2, 27, N'if(', N')', N'اگر(', N')', 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (3, 30, N'&&', NULL, N'و', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (4, 30, N'||', NULL, N'يا', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (5, 30, N'==', NULL, N'برابر', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (6, 30, N'!=', NULL, N'نابرابر', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (7, 32, N'null', NULL, N'نال', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (8, 12, NULL, NULL, N'حلقه', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (9, 8, N'foreach(', N')', N'.براي هر(', NULL, 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (10, 9, NULL, NULL, N'.مجموعه', NULL, 1, 3, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (11, 9, N'{', N'}', N'.بدنه{', N'}', 1, 4, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (12, 61, NULL, NULL, N'كلمات كليدي', NULL, 0, 1, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (13, 61, NULL, NULL, N'اجزاي كاربردي', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (14, 13, N'this.Person', NULL, N'شخص', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (15, 14, N'this.Person.GetProceedTraficByDate(this.ConceptCalculateDate)', NULL, N'.ترددهاي تاريخ مفهوم', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (16, 14, N'this.Person.GetProceedTraficByDate(this.ConceptCalculateDate).Pairs', NULL, N'.دوتايي ها', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (17, 14, N'this.Person.GetProceedTraficByDate(this.ConceptCalculateDate).HasHourlyItem', NULL, N'.آيتم ساعتي دارد', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (18, 13, N'ProceedTrafficPair', NULL, N'تردد جفت', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (19, 18, N'ProceedTrafficPair.PishcardCode', NULL, N'.كد پيشكارت', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (20, 13, N'PairableScndCnpValue', NULL, N'مقدار مفهوم ثانويه دوتايي', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (21, 20, N'PairableScndCnpValue.AppendPairToScndCnpValue', NULL, N'.افزودن به ليست', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (22, 20, NULL, NULL, N'.دوتايي', NULL, 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (23, 20, NULL, NULL, N'.نتيجه', NULL, 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (24, 32, N'true', NULL, N'درست', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (25, 32, N'false', NULL, N'نادرست', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (26, 18, N'ProceedTrafficPair.IsFilled', NULL, N'تردد جفت.پرشده', NULL, 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (27, 12, NULL, N'', N'شرط', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (28, 27, N'{', N'}', N'آنگاه{', N'}', 0, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (29, 9, NULL, NULL, N'.متغير', NULL, 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (30, 27, NULL, NULL, N'عملگر شرطي', NULL, 0, 3, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (32, 12, NULL, NULL, N'عملوند', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (38, 13, NULL, NULL, N'مفهوم', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (40, 38, N'this.DoConcept(', N').Value', N'مقدار مفهوم(', N')', 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (41, 13, NULL, NULL, N'شماره مفهوم را وارد كنيد', NULL, 1, 0, 1, 1, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (42, 30, N'>', NULL, N'بزرگتر', NULL, 1, 5, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (43, 30, N'<', NULL, N'كوچكتر', NULL, 1, 6, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (44, 30, N'>=', NULL, N'بزرگتر مساوي', NULL, 1, 7, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (47, 30, N'<=', NULL, N'كوچكتر مساوي', NULL, 1, 8, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (48, 27, N'else {', N'}', N'در غير اينصورت{', N'}', 1, 2, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (49, 12, NULL, NULL, N'عملگر رياضي', NULL, 1, 1, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (50, 49, N'=', NULL, N'مساوي', NULL, 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (51, 49, N'-', NULL, N'منهاي', NULL, 1, 1, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (52, 49, N'+', NULL, N'باضافه', NULL, 1, 2, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (53, 49, N'*', NULL, N'ضربدر', NULL, 1, 3, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (55, 49, N'/', NULL, N'تقسيم', NULL, 1, 4, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (56, 12, N';', N'', N';', N';', 1, 0, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (57, 40, N'4', NULL, N'كاركرد خالص روزانه_4', NULL, 1, 4, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (58, 40, N'6', NULL, N'كاردكرد لازم_6', NULL, 1, 6, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (59, 40, N'7', NULL, N'كاركرد در روز_7', NULL, 1, 7, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (60, 40, N'132', NULL, N'غيبت روزانه_132', NULL, 1, 132, 1, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (61, NULL, NULL, NULL, N'...', NULL, 0, 0, 0, 0, 1)
GO
INSERT [dbo].[TA_ConceptExpression] ([Expression_ID], [Parent_ID], [ScriptBeginEn], [ScriptEndEn], [ScriptBeginFa], [ScriptEndFa], [AddOnParentCreation], [SortOrder], [CandAddToFinal], [CandEditInFinal], [Visible]) VALUES (62, 38, N'            PersistedScndCnpPrdValue tmp = this.Person.GetPeriodicScndCnpValue(Result, this.ConceptCalculateDate);
            Result.Value = tmp.Value;
            Result.FromDate = tmp.FromDate;
            Result.ToDate = tmp.ToDate;
            Result.CalculationDate = this.ConceptCalculateDate;', N'', N'محتويات مفهوم ماهانه', N'', 1, 1, 1, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[TA_ConceptExpression] OFF
GO
ALTER TABLE [dbo].[TA_ConceptExpression] ADD  CONSTRAINT [DF_TA_ConceptExpressions_CandAddToFinal]  DEFAULT ((0)) FOR [CandAddToFinal]
GO
ALTER TABLE [dbo].[TA_ConceptExpression] ADD  CONSTRAINT [DF_TA_ConceptExpressions_CandEditInFinal]  DEFAULT ((0)) FOR [CandEditInFinal]
GO
ALTER TABLE [dbo].[TA_ConceptExpression] ADD  CONSTRAINT [DF_TA_ConceptExpression_Visible]  DEFAULT ((1)) FOR [Visible]
GO
