if not exists(select * from sys.columns where Name = N'offish_CreationDate' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
   alter table CL_Offish
   add offish_CreationDate datetime not null default getdate()
end

if not exists(select * from sys.columns where name = N'offish_CustomCode' and OBJECT_ID = OBJECT_ID('N[dbo].[CL_Offish]'))
begin
    alter table CL_Offish
	add offish_CustomCode nvarchar(200) 
end
