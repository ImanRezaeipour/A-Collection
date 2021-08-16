if exists(select * from sys.columns where Name = N'ofishType_ID' and Object_ID = Object_ID(N'[dbo].[CL_OffishType]'))
begin
    EXEC sp_RENAME '[dbo].[CL_OffishType].ofishType_ID' , 'offishType_ID', 'COLUMN'
end

if exists(select * from sys.columns where Name = N'ofishType_Title' and Object_ID = Object_ID(N'[dbo].[CL_OffishType]'))
begin
    EXEC sp_RENAME '[dbo].[CL_OffishType].ofishType_Title' , 'offishType_Title', 'COLUMN'
end

if exists(select * from sys.columns where Name = N'ofishType_CustomCode' and Object_ID = Object_ID(N'[dbo].[CL_OffishType]'))
begin
    EXEC sp_RENAME '[dbo].[CL_OffishType].ofishType_CustomCode' , 'offishType_CustomCode', 'COLUMN'
end

if exists(select * from sys.columns where Name = N'ofishType_Active' and Object_ID = Object_ID(N'[dbo].[CL_OffishType]'))
begin
    EXEC sp_RENAME '[dbo].[CL_OffishType].ofishType_Active' , 'offishType_Active', 'COLUMN'
end

if exists(select * from sys.columns where Name = N'ofishType_Deleted' and Object_ID = Object_ID(N'[dbo].[CL_OffishType]'))
begin
    EXEC sp_RENAME '[dbo].[CL_OffishType].ofishType_Deleted' , 'offishType_Deleted', 'COLUMN'
end

if exists(select * from sys.columns where Name = N'offish_ofishTypeId' and Object_ID = Object_ID(N'[dbo].[CL_Offish]'))
begin
    EXEC sp_RENAME '[dbo].[CL_Offish].offish_ofishTypeId' , 'offish_offishTypeId', 'COLUMN'
end
