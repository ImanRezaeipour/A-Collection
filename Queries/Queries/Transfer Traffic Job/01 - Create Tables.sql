USE [BioStar]
GO
ALTER TABLE [BIOSTAR].dbo.TB_EVENT_LOG
ADD GTS_Transfered BIT  


USE [BioStar]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TA_TriggerLog]
    (
      [TrgLog_ID] [numeric](18, 0) IDENTITY(1, 1)
                                   NOT NULL ,
      [TrgLog_TriggerName] [varchar](200) NULL ,
      [TrgLog_Message] [varchar](250) NULL ,
      [TrgLog_LineNumber] [int] NULL ,
      [TrgLog_ErrorNumber] [int] NULL ,
      CONSTRAINT [PK_TriggerLog] PRIMARY KEY CLUSTERED ( [TrgLog_ID] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
               IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
               ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY]
GO
SET ANSI_PADDING OFF
GO


USE [BioStar]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA_BioStarID]
    (
      [SoftwareID] [int] NULL
    )
ON  [PRIMARY]
GO


USE [DeyGTS]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA_BioTmpIds]
    (
      [nEventIdn] [numeric](18, 0) NULL ,
      [BioStarId] [int] NULL
    )
ON  [PRIMARY]
GO


