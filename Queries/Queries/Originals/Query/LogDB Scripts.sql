USE [ClockLogDB]
GO
/****** Object:  Table [dbo].[TA_WinSvcLog]    Script Date: 05/15/2010 10:24:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TA_WinSvcLog](
	[WinSvcLog_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[WinSvcLog_Date] [datetime] NOT NULL,
	[WinSvcLog_Thread] [varchar](255) NOT NULL,
	[WinSvcLog_Level] [varchar](50) NOT NULL,
	[WinSvcLog_Logger] [varchar](255) NOT NULL,
	[WinSvcLog_Message] [varchar](4000) NOT NULL,
	[WinSvcLog_Exception] [varchar](2000) NULL,
 CONSTRAINT [PK_TA_WinSvcLog] PRIMARY KEY CLUSTERED 
(
	[WinSvcLog_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RuleLog]    Script Date: 05/15/2010 10:24:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RuleLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonBarcode] [varchar](50) NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Log]    Script Date: 05/15/2010 10:24:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PersonBarcode] [varchar](50) NULL,
	[Date] [datetime] NOT NULL,
	[Thread] [varchar](255) NOT NULL,
	[Level] [varchar](50) NOT NULL,
	[Logger] [varchar](255) NOT NULL,
	[Message] [varchar](4000) NOT NULL,
	[Exception] [varchar](2000) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
