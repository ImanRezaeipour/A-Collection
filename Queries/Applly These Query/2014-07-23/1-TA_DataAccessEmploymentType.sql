
/****** Object:  Table [dbo].[TA_DataAccessEmploymentType]    Script Date: 7/23/2014 2:52:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA_DataAccessEmploymentType](
	[DataAccessEmploymentType_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DataAccessEmploymentType_UserID] [numeric](18, 0) NOT NULL,
	[DataAccessEmploymentType_EmploymentTypeID] [numeric](18, 0) NULL,
	[DataAccessEmploymentType_All] [bit] NULL,
 CONSTRAINT [PK_TA_DataAccessEmploymentType] PRIMARY KEY CLUSTERED 
(
	[DataAccessEmploymentType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[TA_DataAccessEmploymentType]  WITH CHECK ADD  CONSTRAINT [FK_TA_DataAccessEmploymentType_TA_EmploymentType] FOREIGN KEY([DataAccessEmploymentType_EmploymentTypeID])
REFERENCES [dbo].[TA_EmploymentType] ([emply_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TA_DataAccessEmploymentType] CHECK CONSTRAINT [FK_TA_DataAccessEmploymentType_TA_EmploymentType]
GO
ALTER TABLE [dbo].[TA_DataAccessEmploymentType]  WITH CHECK ADD  CONSTRAINT [FK_TA_DataAccessEmploymentType_TA_SecurityUser] FOREIGN KEY([DataAccessEmploymentType_UserID])
REFERENCES [dbo].[TA_SecurityUser] ([user_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TA_DataAccessEmploymentType] CHECK CONSTRAINT [FK_TA_DataAccessEmploymentType_TA_SecurityUser]
GO
