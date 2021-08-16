SET NOCOUNT ON

BEGIN TRANSACTION ImportRequests

PRINT 'انتقال درخواست ها'
BEGIN

	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TCTemp]') AND type in (N'U'))
		CREATE TABLE [TCTemp]([Clock_BarCode] [varchar](8) NULL,[Clock_Date] [varchar](10) NULL,[Clock_SendDate] [varchar](10) NULL,[Clock_AgreeDate] [varchar](21) NULL,[Clock_Time] [bigint] NULL,[Clock_eTime] [bigint] NULL,[Clock_RdrCode] [bigint] NULL,[Clock_Chg] [bigint] NULL,[Clock_RecState] [bigint] NULL,[Clock_User] [varchar](15) NULL,[Clock_RecDes] [nvarchar](1000) NULL,[Clock_FirstlyAgree] [bigint] NULL,[Clock_FirstlyAgree_BarCode] [varchar](16) NULL,[Clock_FinallyAgree] [bigint] NULL) ON [PRIMARY]

	declare @TCTable nvarchar(max)
	declare cur cursor for
	SELECT TABLE_NAME FROM clock.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG='clock' AND TABLE_NAME lIKE N'TC139___'
	
	open cur
	fetch next from cur into @TCTable
	while @@FETCH_STATUS=0
	BEGIN
		declare @query nvarchar(max) = 'INSERT INTO [TCTemp] ([Clock_BarCode],[Clock_Date],[Clock_SendDate],[Clock_AgreeDate],[Clock_Time],[Clock_eTime],[Clock_RdrCode],[Clock_Chg],[Clock_RecState],[Clock_User],[Clock_RecDes],[Clock_FirstlyAgree],[Clock_FirstlyAgree_BarCode],[Clock_FinallyAgree]) SELECT [Clock_BarCode],[Clock_Date],[Clock_SendDate],[Clock_AgreeDate],[Clock_Time],[Clock_eTime],[Clock_RdrCode],[Clock_Chg],[Clock_RecState],[Clock_User],[Clock_RecDes],[Clock_FirstlyAgree],[Clock_FirstlyAgree_BarCode],[Clock_FinallyAgree] FROM Clock.dbo.' + @TCTable
		exec(@query)
		fetch next from cur into @TCTable
	end
	close cur
	deallocate cur

	INSERT INTO [dbo].[TA_Request] ([request_PrecardID],[request_PersonID],[request_FromDate],[request_ToDate],[request_FromTime],[request_ToTime],[request_TimeDuration],[request_Description],[request_RegisterDate],[request_UserID],[request_OperatorUser],[request_AttachmentFile],[request_EndFlow],[request_IsEdited])
	SELECT
	           (select top 1 Precrd_ID from TA_Precard where Precrd_Code=t.Clock_RecState)
	           ,(select top 1 prs_id from TA_Person where cast(Prs_Barcode as nvarchar(max))=substring(t.Clock_BarCode, patindex('%[^0]%',t.Clock_BarCode), 10))
	           ,case charindex( '-', [Clock_AgreeDate] ) when 0 then dbo.GTS_ASM_ShamsiToMiladi([Clock_AgreeDate]) when 11 then dbo.GTS_ASM_ShamsiToMiladi(SUBSTRING([Clock_AgreeDate],1, 10 )) end
	           ,case charindex( '-', [Clock_AgreeDate] ) when 0 then dbo.GTS_ASM_ShamsiToMiladi([Clock_AgreeDate]) when 11 then dbo.GTS_ASM_ShamsiToMiladi(SUBSTRING([Clock_AgreeDate],12, 21 )) end
	           ,t.Clock_Time
	           ,t.Clock_eTime
	           ,case t.Clock_eTime-t.Clock_Time when 0 then '-1000' else t.Clock_eTime-t.Clock_Time end
	           ,'Converted'
	           ,dbo.GTS_ASM_ShamsiToMiladi(t.Clock_SendDate)
	           ,111111
	           ,t.Clock_User
	           ,null,0,0
	FROM [TCTemp] T
	WHERE t.Clock_BarCode <> '' AND t.Clock_FinallyAgree = 1

	DROP TABLE [TCTemp]

END

PRINT 'تایید درخواست ها'
BEGIN
	
	declare @description nvarchar(max) = N'Converted'

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
	
	declare cur_2 cursor for
	select [request_ID],[request_PrecardID],[request_PersonID],[request_FromDate],[request_ToDate],[request_FromTime],[request_ToTime],[request_TimeDuration],[request_Description],[request_RegisterDate],[request_UserID],[request_OperatorUser],[request_AttachmentFile] from ta_request
	
	open cur_2
	fetch next from cur_2 into @request_ID,@request_PrecardID,@request_PersonID,@request_FromDate,@request_ToDate,@request_FromTime,@request_ToTime,@request_TimeDuration,@request_Description,@request_RegisterDate,@request_UserID,@request_OperatorUser,@request_AttachmentFile
	while @@FETCH_STATUS=0
	begin
	
		if(((select Precrd_Hourly from TA_Precard where Precrd_ID=@request_PrecardID) = 1) and ((select Precrd_pshcardGroupID from TA_Precard where Precrd_ID=@request_PrecardID) = (select PishcardGrp_ID from TA_PrecardGroups where PishcardGrp_LookupKey='overwork')))
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
		select '111111',@request_ID,1,1,@request_Description,GETDATE(),0
		where @request_ID not in(select request_ID from TA_Request where request_ID  in(select reqStat_RequestID from TA_RequestStatus))
		and @request_Description=@description
		
		fetch next from cur_2 into @request_ID,@request_PrecardID,@request_PersonID,@request_FromDate,@request_ToDate,@request_FromTime,@request_ToTime,@request_TimeDuration,@request_Description,@request_RegisterDate,@request_UserID,@request_OperatorUser,@request_AttachmentFile
	end
	close cur_2
	deallocate cur_2

END

COMMIT TRANSACTION ImportRequests
