
/****** Object:  Table [dbo].[TA_Dashboards]    Script Date: 5/4/2014 2:44:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA_Dashboards](
	[Dashboards_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Dashboards_Name] [nvarchar](100) NOT NULL,
	[Dashboards_Title] [nvarchar](max) NOT NULL,
	[Dashboards_Description] [nvarchar](max) NULL,
	[Dashboards_SubSystemID] [int] NOT NULL,
 CONSTRAINT [PK_TA_Dashboards] PRIMARY KEY CLUSTERED 
(
	[Dashboards_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[TA_Dashboards] ON 

INSERT [dbo].[TA_Dashboards] ([Dashboards_ID], [Dashboards_Name], [Dashboards_Title], [Dashboards_Description], [Dashboards_SubSystemID]) VALUES (CAST(5 AS Numeric(18, 0)), N'PrivateNews.aspx', N'خلاصه کارتابل', NULL, 1)
INSERT [dbo].[TA_Dashboards] ([Dashboards_ID], [Dashboards_Name], [Dashboards_Title], [Dashboards_Description], [Dashboards_SubSystemID]) VALUES (CAST(6 AS Numeric(18, 0)), N'PersonnelInformationSummary.aspx', N'چکیده اطلاعات پرسنل', NULL, 1)
INSERT [dbo].[TA_Dashboards] ([Dashboards_ID], [Dashboards_Name], [Dashboards_Title], [Dashboards_Description], [Dashboards_SubSystemID]) VALUES (CAST(7 AS Numeric(18, 0)), N'PublicNews.aspx', N'پیغام های عمومی', NULL, 1)
INSERT [dbo].[TA_Dashboards] ([Dashboards_ID], [Dashboards_Name], [Dashboards_Title], [Dashboards_Description], [Dashboards_SubSystemID]) VALUES (CAST(8 AS Numeric(18, 0)), N'LocalDateTime.aspx', N'زمان و تاریخ', NULL, 1)
SET IDENTITY_INSERT [dbo].[TA_Dashboards] OFF
ALTER TABLE [dbo].[TA_Dashboards] ADD  CONSTRAINT [DF_TA_Dashboards_DashboardSet_SubSystemID]  DEFAULT ((1)) FOR [Dashboards_SubSystemID]
GO
