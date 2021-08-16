declare @description nvarchar(max)=N'****'  -- توضیح درخواست
-----------------------------------------------------------------------------------
------DONT-----CHANGE--------------------------------------------------------------
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
print 'Person ID: '+cast(@request_PersonID as nvarchar(max))+' | Description: '+@request_Description

-- IsPairly ?
-- Hourly = True > 1
-- Ezafekari = if (To - From == Duration) = True > 1
-- Else 0

if(
((select Precrd_Hourly from TA_Precard where Precrd_ID=@request_PrecardID) = 1) 
and 
((select Precrd_pshcardGroupID from TA_Precard where Precrd_ID=@request_PrecardID) = (select PishcardGrp_ID from TA_PrecardGroups where PishcardGrp_LookupKey='overwork'))
)
begin 
	insert TA_Permit
	select @request_PersonID,@request_FromDate,@request_ToDate,1  -- Hourly
	where @request_ID not in(select request_ID from TA_Request where request_ID  in(select reqStat_RequestID from TA_RequestStatus))
	and @request_Description=@description
end

else
begin
insert TA_Permit
select @request_PersonID,@request_FromDate,@request_ToDate,0 -- Daily
where @request_ID not in(select request_ID from TA_Request where request_ID  in(select reqStat_RequestID from TA_RequestStatus))
and @request_Description=@description
end

insert TA_PermitPair
select (select top(1) Permit_ID from TA_Permit order by Permit_ID desc),@request_ID,@request_PrecardID,@request_FromTime,@request_ToTime,1,null,@request_TimeDuration,0
where @request_ID not in(select request_ID from TA_Request where request_ID  in(select reqStat_RequestID from TA_RequestStatus))
and @request_Description=@description

insert TA_RequestStatus
select '44285',@request_ID,1,1,@request_Description,GETDATE(),0
where @request_ID not in(select request_ID from TA_Request where request_ID  in(select reqStat_RequestID from TA_RequestStatus))
and @request_Description=@description

exec dbo.spr_UpdateCFP @request_PersonID,@request_FromDate

fetch next from cur into @request_ID,@request_PrecardID,@request_PersonID,@request_FromDate,@request_ToDate,@request_FromTime,@request_ToTime,@request_TimeDuration,@request_Description,@request_RegisterDate,@request_UserID,@request_OperatorUser,@request_AttachmentFile
end
close cur
deallocate cur
-------------------------------------------------------------------------------------

