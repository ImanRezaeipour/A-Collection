if exists (select * from sys.columns where Name = N'offish_offishTypeId' and OBJECT_ID = OBJECT_ID(N'[dbo].[CL_Offish]'))
begin
    if exists (select * from sys.objects where OBJECT_ID = OBJECT_ID(N'FK_CL_Offish_CL_OffishType'))
	begin
	    alter table CL_Offish 
		drop constraint FK_CL_Offish_CL_OffishType
	end
    alter table CL_Offish
	drop column offish_offishTypeId 
	alter table CL_Offish
	add offish_offishTypeId numeric(18, 0) 
    alter table CL_Offish
    with check add constraint FK_CL_Offish_CL_OffishType foreign key (offish_offishTypeId) references CL_OffishType (offishType_ID)
end

if exists (select * from sys.columns where Name = N'offish_MeetingPersonId' and OBJECT_ID = OBJECT_ID(N'[dbo].[CL_Offish]'))
begin
    if exists (select * from sys.objects where OBJECT_ID = OBJECT_ID(N'FK_CL_Offish_TA_Person'))
	begin
	    alter table CL_Offish 
		drop constraint FK_CL_Offish_TA_Person
	end
    alter table CL_Offish
	drop column offish_MeetingPersonId 
	alter table CL_Offish
	add offish_MeetingPersonId numeric(18, 0) 
    alter table CL_Offish
    with check add constraint FK_CL_Offish_TA_Person foreign key (offish_MeetingPersonId) references TA_Person (Prs_ID)
end

if exists (select * from sys.columns where Name = N'offish_FromDate' and OBJECT_ID = OBJECT_ID(N'[dbo].[CL_Offish]'))
begin
   alter table CL_Offish
   alter column offish_FromDate datetime null
end

if exists (select * from sys.columns where Name = N'offish_ToDate' and OBJECT_ID = OBJECT_ID(N'[dbo].[CL_Offish]'))
begin
   alter table CL_Offish
   alter column offish_ToDate datetime null
end

if exists (select * from sys.columns where Name = N'offish_Active' and OBJECT_ID = OBJECT_ID(N'[dbo].[CL_Offish]'))
begin
   alter table CL_Offish
   alter column offish_Active bit null
end

