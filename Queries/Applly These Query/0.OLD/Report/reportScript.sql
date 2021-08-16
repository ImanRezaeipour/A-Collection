--USE [GhadirGTS]
GO

/****** Object:  Table [dbo].[TA_DesignedReportColumn]    Script Date: 11/12/2013 11:41:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if not exists(select * from sys.columns 
            where Name = N'Report_IsDesignedReport' and Object_ID = Object_ID(N'TA_Report')) 
            alter table [dbo].[TA_Report]
            ADD Report_IsDesignedReport bit 

if not exists(select * from sys.columns 
            where Name = N'Report_Description' and Object_ID = Object_ID(N'TA_Report')) 
            alter table [dbo].[TA_Report]
            ADD Report_Description nvarchar(MAX) 

if not exists(select * from sys.columns 
            where Name = N'Report_DesignedReportTypeID' and Object_ID = Object_ID(N'TA_Report')) 
            alter table [dbo].[TA_Report]
            ADD Report_DesignedReportTypeID numeric(18, 0) 

if not exists(select * from sys.columns 
            where Name = N'ReportParameter_RptID' and Object_ID = Object_ID(N'TA_ReportParameter')) 
            alter table [dbo].[TA_ReportParameter]
            ADD ReportParameter_RptID numeric(18, 0) 

if not exists(select * from sys.columns 
            where Name = N'ConceptTmp_ShowInReport' and Object_ID = Object_ID(N'TA_ConceptTemplate')) 
            alter table [dbo].[TA_ConceptTemplate]
            ADD ConceptTmp_ShowInReport numeric(18, 0) 

if not exists(select * from sys.columns 
            where Name = N'ConceptTmp_IsHourly' and Object_ID = Object_ID(N'TA_ConceptTemplate')) 
            alter table [dbo].[TA_ConceptTemplate]
            ADD ConceptTmp_IsHourly numeric(18, 0) 

CREATE TABLE [dbo].[TA_DesignedReportColumn](
	[DesignedReportColumns_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DesignedReportColumns_ConceptTmpID] [numeric](18, 0) NOT NULL,
	[DesignedReportColumns_Title] [nvarchar](200) NOT NULL,
	[DesignedReportColumns_ReportID] [numeric](18, 0) NOT NULL,
	[DesignedReportColumns_IsActive] [bit] NOT NULL,
	[DesignedReportColumns_Order] [smallint] NULL,
 CONSTRAINT [PK_DesignedReportColumns] PRIMARY KEY CLUSTERED 
(
	[DesignedReportColumns_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[TA_DesignedReportColumn]  WITH CHECK ADD  CONSTRAINT [FK_TA_DesignedReportColumn_TA_ConceptTemplate] FOREIGN KEY([DesignedReportColumns_ConceptTmpID])
REFERENCES [dbo].[TA_ConceptTemplate] ([ConceptTmp_ID])
GO

ALTER TABLE [dbo].[TA_DesignedReportColumn] CHECK CONSTRAINT [FK_TA_DesignedReportColumn_TA_ConceptTemplate]
GO

ALTER TABLE [dbo].[TA_DesignedReportColumn]  WITH CHECK ADD  CONSTRAINT [FK_TA_DesignedReportColumn_TA_Report] FOREIGN KEY([DesignedReportColumns_ReportID])
REFERENCES [dbo].[TA_Report] ([Report_ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TA_DesignedReportColumn] CHECK CONSTRAINT [FK_TA_DesignedReportColumn_TA_Report]
GO


CREATE TABLE [dbo].[TA_DesignedReportCondition](
	[DesignedReportCondition_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DesignedReportCondition_ReportID] [numeric](18, 0) NOT NULL,
	[DesignedReportCondition_ConditionText] [nvarchar](max) NOT NULL,
	[DesignedReportCondition_ConditionValue] [nvarchar](max) NOT NULL,
	[DesignedReportCondition_PersonID] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_DesignedReportCondition] PRIMARY KEY CLUSTERED 
(
	[DesignedReportCondition_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[TA_DesignedReportCondition]  WITH CHECK ADD  CONSTRAINT [FK_TA_DesignedReportCondition_TA_Person] FOREIGN KEY([DesignedReportCondition_PersonID])
REFERENCES [dbo].[TA_Person] ([Prs_ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TA_DesignedReportCondition] CHECK CONSTRAINT [FK_TA_DesignedReportCondition_TA_Person]
GO

ALTER TABLE [dbo].[TA_DesignedReportCondition]  WITH CHECK ADD  CONSTRAINT [FK_TA_DesignedReportCondition_TA_Report] FOREIGN KEY([DesignedReportCondition_ReportID])
REFERENCES [dbo].[TA_Report] ([Report_ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TA_DesignedReportCondition] CHECK CONSTRAINT [FK_TA_DesignedReportCondition_TA_Report]
GO


CREATE TABLE [dbo].[TA_DesignedReportType](
	[DesignedReportType_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DesignedReportType_Name] [nvarchar](100) NOT NULL,
	[DesignedReportType_CustomCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TA_DesignedReportType] PRIMARY KEY CLUSTERED 
(
	[DesignedReportType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


INSERT [dbo].[TA_DesignedReportType] ( [DesignedReportType_Name], [DesignedReportType_CustomCode]) VALUES ( N'خلاصه ماهانه', N'Monthly')
GO
INSERT [dbo].[TA_DesignedReportType] ( [DesignedReportType_Name], [DesignedReportType_CustomCode]) VALUES ( N'مشروح', N'Daily')
GO

