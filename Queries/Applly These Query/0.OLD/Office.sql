if not exists(select * from sys.columns where Name = N'offish_Sex' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
    alter table [dbo].[CL_Offish] 
	add offish_Sex bit 
end

if not exists(select * from sys.columns where Name = N'offish_MeetingLocation' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish]
	add offish_MeetingLocation nvarchar(max) 
end

if not exists(select * from sys.columns where Name = N'offish_FoodRecieve' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish] 
	add offish_FoodRecieve bit 
end

if not exists(select * from sys.columns where Name = N'offish_Attachment' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish]
	with check add offish_Attachment nvarchar(max) 
end 

if not exists(select * from sys.columns where Name = N'offish_ActiveDirectoryUserName' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish]
	with check add offish_ActiveDirectoryUserName bit 
end

if not exists(select * from sys.columns where Name = N'offish_MeetingPersonId' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish]
	add offish_MeetingPersonId numeric(18,0) 
end

if not exists(select * from sys.objects  where Object_ID = Object_ID(N'[dbo].[FK_CL_Offish_TA_Person]'))
begin
	alter table [dbo].[CL_Offish]  with check add constraint [FK_CL_Offish_TA_Person] foreign key([offish_MeetingPersonId])
	references [dbo].[TA_Person] ([Prs_ID])
end

if not exists(select * from sys.columns where Name = N'offish_SubstituteMeetingPersonId' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish]
	add offish_SubstituteMeetingPersonId numeric(18,0) not null
end

if not exists(select * from sys.objects  where Object_ID = Object_ID(N'[dbo].[FK_CL_Offish_TA_SubstituePerson]'))
begin
	alter table [dbo].[CL_Offish]  with check add constraint [FK_CL_Offish_TA_SubstituePerson] foreign key([offish_SubstituteMeetingPersonId])
	references [dbo].[TA_Person] ([Prs_ID])
end

if not exists(select * from sys.columns where Name = N'offish_ControlStationId' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
	alter table [dbo].[CL_Offish]
	add offish_ControlStationId numeric(18,0) 
end

if not exists(select * from sys.objects  where Object_ID = Object_ID(N'[dbo].[FK_CL_Offish_TA_ControlStation]'))
begin
	alter table [dbo].[CL_Offish]  with check add constraint [FK_CL_Offish_TA_ControlStation] foreign key([offish_ControlStationId])
	references [dbo].[TA_ControlStation] ([Station_ID])
end

if not exists(select * from sys.objects  where Object_ID = Object_ID(N'[dbo].[FK_CL_Equipment_CL_Offish]'))
begin
	alter table [dbo].[CL_Equipment]  with check add constraint [FK_CL_Equipment_CL_Offish] foreign key([Eqp_OffishId])
	references [dbo].[CL_Offish] ([offish_ID])
	on delete cascade
end

if not exists(select * from sys.objects  where Object_ID = Object_ID(N'[dbo].[FK_CL_Car_CL_Offish]'))
begin
	alter table [dbo].[CL_Car]  with check add constraint [FK_CL_Car_CL_Offish] foreign key([Car_OffishId])
	references [dbo].[CL_Offish] ([offish_ID])
	on delete cascade
end
