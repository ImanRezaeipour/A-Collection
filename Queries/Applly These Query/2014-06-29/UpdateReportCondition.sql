--use[ghadirgts]

if not exists(select * from sys.columns 
            where Name = N'DesignedReportCondition_OrderText' and Object_ID = Object_ID(N'TA_DesignedReportCondition')) 
            alter table [dbo].[TA_DesignedReportCondition]
            ADD DesignedReportCondition_OrderText nvarchar(MAX) 

if not exists(select * from sys.columns 
            where Name = N'DesignedReportCondition_OrderValue' and Object_ID = Object_ID(N'TA_DesignedReportCondition')) 
            alter table [dbo].[TA_DesignedReportCondition]
            ADD DesignedReportCondition_OrderValue nvarchar(MAX) 


if not exists(select * from sys.columns 
            where Name = N'ReportParameter_rptParamDesID' and Object_ID = Object_ID(N'TA_Report')) 
            alter table [dbo].[TA_Report]
            ADD ReportParameter_rptParamDesID numeric(18, 0) 
			GO

/****** Object:  Table [dbo].[TA_ReportParameterDesigned]    Script Date: 6/30/2014 11:46:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF (not EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE  
                   TABLE_NAME = 'TA_ReportParameterDesigned'))
BEGIN

CREATE TABLE [dbo].[TA_ReportParameterDesigned](
	[ReportParameterDes_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ReportParameterDes_FnName] [nvarchar](50) NOT NULL,
	[ReportParameterDes_EnName] [nvarchar](50) NOT NULL,
	[ReportParameterDes_ReportUIParameterID] [numeric](18, 0) NOT NULL,
	[ReportParameterDes_CustomCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TA_ReportParameterDesigned] PRIMARY KEY CLUSTERED 
(
	[ReportParameterDes_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
End
GO


GO

/****** Object:  Table [dbo].[TA_ReportParameterDesignedParam]    Script Date: 6/30/2014 11:47:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
IF (not EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE  
                   TABLE_NAME = 'TA_ReportParameterDesignedParam'))
BEGIN
CREATE TABLE [dbo].[TA_ReportParameterDesignedParam](
	[ReportParameterDesParam_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ReportParameterDesParam_rptParamDesID] [numeric](18, 0) NOT NULL,
	[ReportParameterDesParam_Parameter] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TA_ReportParameterDesignedParam] PRIMARY KEY CLUSTERED 
(
	[ReportParameterDesParam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



ALTER TABLE [dbo].[TA_ReportParameterDesignedParam]  WITH CHECK ADD  CONSTRAINT [FK_TA_ReportParameterDesignedParam_TA_ReportParameterDesigned] FOREIGN KEY([ReportParameterDesParam_rptParamDesID])
REFERENCES [dbo].[TA_ReportParameterDesigned] ([ReportParameterDes_ID])


ALTER TABLE [dbo].[TA_ReportParameterDesignedParam] CHECK CONSTRAINT [FK_TA_ReportParameterDesignedParam_TA_ReportParameterDesigned]

end
GO
delete from TA_ReportParameterDesignedParam
delete from TA_ReportParameterDesigned

GO
SET IDENTITY_INSERT [dbo].[TA_ReportParameterDesigned] ON 

GO
INSERT [dbo].[TA_ReportParameterDesigned] ([ReportParameterDes_ID], [ReportParameterDes_FnName], [ReportParameterDes_EnName], [ReportParameterDes_ReportUIParameterID], [ReportParameterDes_CustomCode]) VALUES (CAST(1 AS Numeric(18, 0)), N'«‰ Œ«» „«Â', N'«‰ Œ«» „«Â', CAST(14 AS Numeric(18, 0)), N'DateRange')
GO
INSERT [dbo].[TA_ReportParameterDesigned] ([ReportParameterDes_ID], [ReportParameterDes_FnName], [ReportParameterDes_EnName], [ReportParameterDes_ReportUIParameterID], [ReportParameterDes_CustomCode]) VALUES (CAST(2 AS Numeric(18, 0)), N'»«“Â  «—ÌŒ', N'»«“Â  «—ÌŒ', CAST(19 AS Numeric(18, 0)), N'FromToDate')
GO
SET IDENTITY_INSERT [dbo].[TA_ReportParameterDesigned] OFF
GO
SET IDENTITY_INSERT [dbo].[TA_ReportParameterDesignedParam] ON 

GO
INSERT [dbo].[TA_ReportParameterDesignedParam] ([ReportParameterDesParam_ID], [ReportParameterDesParam_rptParamDesID], [ReportParameterDesParam_Parameter]) VALUES (CAST(1 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'@Order')
GO
INSERT [dbo].[TA_ReportParameterDesignedParam] ([ReportParameterDesParam_ID], [ReportParameterDesParam_rptParamDesID], [ReportParameterDesParam_Parameter]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(1 AS Numeric(18, 0)), N'@ToDate')
GO
INSERT [dbo].[TA_ReportParameterDesignedParam] ([ReportParameterDesParam_ID], [ReportParameterDesParam_rptParamDesID], [ReportParameterDesParam_Parameter]) VALUES (CAST(3 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'@fromDate')
GO
INSERT [dbo].[TA_ReportParameterDesignedParam] ([ReportParameterDesParam_ID], [ReportParameterDesParam_rptParamDesID], [ReportParameterDesParam_Parameter]) VALUES (CAST(4 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), N'@toDate')
GO
SET IDENTITY_INSERT [dbo].[TA_ReportParameterDesignedParam] OFF
GO

update TA_Report set ReportParameter_rptParamDesID=1

where Report_IsDesignedReport=1 and ReportParameter_rptParamDesID is NULL