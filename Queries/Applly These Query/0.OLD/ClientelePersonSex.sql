if not exists(select * from sys.columns where Name = N'clientelePrs_Sex' and Object_ID = Object_ID(N'[dbo].[CL_ClientelePerson]'))
begin
	alter table [dbo].[CL_ClientelePerson] 
	add clientelePrs_Sex int 
end
