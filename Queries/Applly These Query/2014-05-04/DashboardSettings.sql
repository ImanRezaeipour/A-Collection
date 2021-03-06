/****** Object:  Table [dbo].[TA_DashboardSettings]    Script Date: 5/4/2014 2:45:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TA_DashboardSettings](
	[DashboardSet_ID] [numeric](18, 0) NOT NULL,
	[DashboardSet_SetID] [numeric](18, 0) NOT NULL,
	[DashboardSet_DashID1] [numeric](18, 0) NULL,
	[DashboardSet_DashID2] [numeric](18, 0) NULL,
	[DashboardSet_DashID3] [numeric](18, 0) NULL,
	[DashboardSet_DashID4] [numeric](18, 0) NULL,
 CONSTRAINT [PK_TA_DashboardSetting] PRIMARY KEY CLUSTERED 
(
	[DashboardSet_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[TA_DashboardSettings]  WITH CHECK ADD  CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards] FOREIGN KEY([DashboardSet_DashID1])
REFERENCES [dbo].[TA_Dashboards] ([Dashboards_ID])
GO
ALTER TABLE [dbo].[TA_DashboardSettings] CHECK CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards]
GO
ALTER TABLE [dbo].[TA_DashboardSettings]  WITH CHECK ADD  CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards1] FOREIGN KEY([DashboardSet_DashID2])
REFERENCES [dbo].[TA_Dashboards] ([Dashboards_ID])
GO
ALTER TABLE [dbo].[TA_DashboardSettings] CHECK CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards1]
GO
ALTER TABLE [dbo].[TA_DashboardSettings]  WITH CHECK ADD  CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards2] FOREIGN KEY([DashboardSet_DashID3])
REFERENCES [dbo].[TA_Dashboards] ([Dashboards_ID])
GO
ALTER TABLE [dbo].[TA_DashboardSettings] CHECK CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards2]
GO
ALTER TABLE [dbo].[TA_DashboardSettings]  WITH CHECK ADD  CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards3] FOREIGN KEY([DashboardSet_DashID4])
REFERENCES [dbo].[TA_Dashboards] ([Dashboards_ID])
GO
ALTER TABLE [dbo].[TA_DashboardSettings] CHECK CONSTRAINT [FK_TA_DashboardSettings_TA_Dashboards3]
GO
ALTER TABLE [dbo].[TA_DashboardSettings]  WITH CHECK ADD  CONSTRAINT [FK_TA_DashboardSettings_TA_UserSettings] FOREIGN KEY([DashboardSet_ID])
REFERENCES [dbo].[TA_UserSettings] ([userSet_ID])
GO
ALTER TABLE [dbo].[TA_DashboardSettings] CHECK CONSTRAINT [FK_TA_DashboardSettings_TA_UserSettings]
GO
