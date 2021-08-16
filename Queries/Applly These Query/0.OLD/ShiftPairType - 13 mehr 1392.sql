
/****** Object:  Table [dbo].[TA_ShiftPairType]    Script Date: 10/5/2013 8:40:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TA_ShiftPairType](
	[shiftPairType_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[shiftPairType_Title] [nvarchar](200) NOT NULL,
	[shiftPairType_Active] [bit] NOT NULL,
	[shiftPairType_CustomCode] [nvarchar](50) NOT NULL,
	[shiftPairType_Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_TA_ShiftPairType] PRIMARY KEY CLUSTERED 
(
	[shiftPairType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


