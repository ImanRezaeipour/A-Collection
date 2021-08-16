alter table [dbo].[TA_DashboardSettings] drop constraint [FK_TA_DashboardSettings_TA_UserSettings] 

ALTER TABLE [dbo].[TA_DashboardSettings]  WITH CHECK ADD  CONSTRAINT [FK_TA_DashboardSettings_TA_UserSettings] FOREIGN KEY([DashboardSet_ID])
REFERENCES [dbo].[TA_UserSettings] ([userSet_ID])
ON DELETE cascade
GO