declare @personBarcode nvarchar(max)='11111111'  -- کد پرسنلی
declare @description nvarchar(max)=N'****'  -- توضیح درخواست

-----------------------------------------------------------------------------------
------DONT-----CHANGE--------------------------------------------------------------
declare @managerFlowID decimal(18,0)
set @managerFlowID= (select top(1) mngrFlow_ID from TA_ManagerFlow where mngrFlow_ManagerID =(select MasterMng_ID from TA_Manager where MasterMng_PersonID=dbo.GetPerson(@personBarcode)))
declare @request_ID numeric(18,0)
declare @request_PrecardID numeric(18,0)
declare @request_PersonID numeric(18,0)
declare @request_FromDate datetime
declare @request_ToDate datetime
declare @request_FromTime int
declare @request_ToTime int
declare @request_TimeDuration int
declare @request_Description nvarchar(100)
declare @request_RegisterDate datetime
declare @request_UserID numeric(18,0)
declare @request_OperatorUser nvarchar(200)
declare @request_AttachmentFile nvarchar(max)

declare cur cursor for
select [request_ID],[request_PrecardID],[request_PersonID],[request_FromDate],[request_ToDate],[request_FromTime],[request_ToTime],[request_TimeDuration],[request_Description],[request_RegisterDate],[request_UserID],[request_OperatorUser],[request_AttachmentFile] from ta_request

open cur
fetch next from cur into @request_ID,@request_PrecardID,@request_PersonID,@request_FromDate,@request_ToDate,@request_FromTime,@request_ToTime,@request_TimeDuration,@request_Description,@request_RegisterDate,@request_UserID,@request_OperatorUser,@request_AttachmentFile

while @@FETCH_STATUS=0
begin
print @request_Description

insert TA_Permit
select @request_PersonID,@request_FromDate,@request_ToDate,1
where @request_ID not in(select reqStat_RequestID from TA_RequestStatus)
and @request_Description=@description

insert TA_PermitPair
select (select top(1) Permit_ID from TA_Permit order by Permit_ID desc),@request_ID,@request_PrecardID,@request_FromTime,@request_ToTime,1,null,@request_TimeDuration,0
where @request_ID not in(select reqStat_RequestID from TA_RequestStatus)
and @request_Description=@description

insert TA_RequestStatus
select @managerFlowID,@request_ID,1,1,@request_Description,GETDATE(),0
where @request_ID not in(select reqStat_RequestID from TA_RequestStatus)
and @request_Description=@description

fetch next from cur
into @request_ID,@request_PrecardID,@request_PersonID,@request_FromDate,@request_ToDate,@request_FromTime,@request_ToTime,@request_TimeDuration,@request_Description,@request_RegisterDate,@request_UserID,@request_OperatorUser,@request_AttachmentFile
end
close cur
deallocate cur
-------------------------------------------------------------------------------------