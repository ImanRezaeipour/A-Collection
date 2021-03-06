USE [msdb]
GO

/****** Object:  Job [BioStar_TransferToAtlasDB_Job]    Script Date: 09/17/2012 15:15:05 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 09/17/2012 15:15:05 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'BioStar_TransferToAtlasDB_Job', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'BioStar', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'farhad', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Transfer Data]    Script Date: 09/17/2012 15:15:06 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Transfer Data', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BEGIN TRY
	DECLARE @nIndex int
	DECLARE @DeviceId int ---   شناسه دستگاه
	DECLARE @dtDateTime datetime ---  تاریخ زمان
	DECLARE @Date date
	DECLARE @minute varchar(10)--زمان برحسب دقیقه
	DECLARE @UserID int   ---شماره پرسنلی
	DECLARE @prsId numeric
	DECLARE @bioPrecard varchar(10)
	DECLARE @UsualPrecardId numeric

SELECT @UsualPrecardId=Precrd_ID FROM [appsrv].[GhadirGTS].dbo.TA_Precard
WHERE Precrd_Code=''0''

DECLARE ReportsList_Cursor CURSOR
For
SELECT nEventLogIdn [ID], nReaderIdn [Device Id], nUserID [Barcode], nTNAEvent [Traffic Type], 
	   DATEADD(s, nDateTime , ''1970-01-01'') as [date]
FROM [BioStar].dbo.TB_EVENT_LOG
WHERE  --nUserID=2155 and
	  nUserID <> 0
	    AND
	  DATEADD(s, nDateTime , ''1970-01-01'') >= ''2012-07-22''
	  AND	
	  nEventLogIdn not in 
		(SELECT ISNULL(BasicTraffic_ReportsListId, 0) FROM [appsrv].[GhadirGTS].dbo.TA_BaseTraffic)
		
ORDER BY nUserID,nDateTime

OPEN ReportsList_Cursor	
	FETCH FROM ReportsList_Cursor
	INTO @nIndex,@DeviceId, @UserID, @bioPrecard,@dtDateTime
	
	WHILE @@FETCH_STATUS = 0
	BEGIN			

	select @prsId=prs_ID from [appsrv].[GhadirGTS].dbo.TA_Person where CONVERT(int,Prs_Barcode)= CONVERT(int,@UserID)

	IF @prsId IS NOT Null        
			AND
		@bioPrecard = 255 -- فقط پیشکارت عادی
	BEGIN		
		set @Date = CONVERT(date, @dtDateTime , 103)
		set @minute= DATEPART(HH, @dtDateTime) * 60 + DATEPART(MI, @dtDateTime)
		IF NOT Exists(SELECT BasicTraffic_ID FROM [appsrv].[GhadirGTS].dbo.TA_BaseTraffic 
						WHERE  BasicTraffic_Date=@Date and BasicTraffic_Time=@minute and BasicTraffic_PrecardId=@UsualPrecardId
						and BasicTraffic_PersonID=@prsId
					)
		BEGIN
			INSERT INTO [appsrv].[GhadirGTS].dbo.TA_BaseTraffic ([BasicTraffic_PrecardId]
														  ,[BasicTraffic_PersonID]
														  ,[BasicTraffic_Date]
														  ,[BasicTraffic_Time]
														  ,[BasicTraffic_Used]
														  ,[BasicTraffic_Active]
														  ,[BasicTraffic_Manual]														 
														  ,[BasicTraffic_ReportsListId]
														  ,[BasicTraffic_ClockCustomCode])
		VALUES (@UsualPrecardId, @prsId, @Date, @minute, 0, 1, 0, @nIndex,@DeviceId) 
		
		EXEC dbo.spr_UpdateCFP(@prsId,@Date);
		
		
		END	
	END
		
	SET @prsId=NULL	
	
	FETCH NEXT FROM ReportsList_Cursor
		INTO @nIndex,@DeviceId, @UserID, @bioPrecard,@dtDateTime
	END
	CLOSE ReportsList_Cursor
	DEALLOCATE ReportsList_Cursor
END TRY
BEGIN CATCH
	CLOSE ReportsList_Cursor
	DEALLOCATE ReportsList_Cursor
	exec spr_GetTriggerLog 
END CATCH', 
		@database_name=N'BioStar', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'BioStar_ToAtlas', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=15, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120917, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=200059, 
		@schedule_uid=N'51530b6f-4b4e-4025-b9ba-7dd55f9e6a45'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


