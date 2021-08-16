if not exists(select * from sys.columns where Name = N'userSet_SubSystemID' and Object_ID = Object_ID(N'[dbo].[TA_UserSettings]'))
begin
	alter table [dbo].[TA_UserSettings] 
	add userSet_SubSystemID int default 1
end
