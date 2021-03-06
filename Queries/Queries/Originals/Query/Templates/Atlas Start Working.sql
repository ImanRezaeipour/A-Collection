set IDENTITY_INSERT dbo.TA_department on;
delete from TA_department where dep_id=1
insert into TA_department(dep_ID,dep_Name)
values(1,'سازمان')
set IDENTITY_INSERT dbo.TA_department off;

delete from TA_PersonDetail where PrsDtl_ID=1
insert into TA_PersonDetail(PrsDtl_ID)
Values(1)

set IDENTITY_INSERT dbo.TA_Person on;
delete from TA_Person where Prs_Barcode='GhadirDataInitialize'
insert into TA_Person(prs_ID,Prs_Active,Prs_Barcode,Prs_FirstName,Prs_LastName,Prs_DepartmentId,Prs_PrsDtlID)
values(1,1,'GhadirDataInitialize','GHADIR','GHADIR',1,1)
set IDENTITY_INSERT dbo.TA_Person off;



delete from TA_SecurityRole where role_ID=1
set IDENTITY_INSERT dbo.TA_SecurityRole on;
insert into TA_SecurityRole(role_ID,role_Name,role_Customcode,role_Active)
values(1,'Root','1-1',1)
insert into TA_SecurityRole(role_ID,role_Name,role_Customcode,role_Active,role_ParentID)
values(2,'GHADIRADMIN','1-1',1,1)
set IDENTITY_INSERT dbo.TA_securityRole off;


delete from TA_OrganizationUnit where organ_ID=1
delete from TA_OrganizationUnit where organ_ID=2
set IDENTITY_INSERT dbo.TA_OrganizationUnit on;
insert into TA_OrganizationUnit(organ_ID,organ_Name)
values(1,'سازمان')
insert into TA_OrganizationUnit(organ_ID,organ_Name,organ_CustomCode,organ_ParentID,organ_ParentPath)
values(2,'مدیر سیستم','1-1',1,',1,')
set IDENTITY_INSERT dbo.TA_OrganizationUnit off;

set IDENTITY_INSERT dbo.TA_DutyPlace on;
delete from TA_DutyPlace where dutyPlc_ID=1
insert into TA_DutyPlace(dutyPlc_ID,dutyPlc_Name,dutyPlc_CustomCode,dutyPlc_ParentID)
values(1,'محلهای ماموریت','0-0',0)
set IDENTITY_INSERT dbo.TA_DutyPlace off;

insert into TA_SecurityAuthorize(Athorize_RoleID,Athorize_ResourceID,Athorize_Allow)
select  1,resource_ID,1
from TA_SecurityResource

set IDENTITY_INSERT dbo.TA_SecurityUser on;
insert into TA_SecurityUser (user_ID,user_PersonID,user_RoleID,user_Active,user_UserName,user_Password,user_IsADAuthenticateActive)
values(1,1,1,1,'GHADIRUSERNAME','14KqSTmb8PqnPJNotzyXfemIA5Y=',0)
set IDENTITY_INSERT dbo.TA_SecurityUser off;

insert into TA_DataAccessDepartment (DataAccessDep_UserID,DataAccessDep_All)
values(1,1)
