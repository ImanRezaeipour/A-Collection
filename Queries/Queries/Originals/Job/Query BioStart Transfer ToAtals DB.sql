BEGIN TRY
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
WHERE Precrd_Code='0'

DECLARE ReportsList_Cursor CURSOR
For
SELECT nEventLogIdn [ID], nReaderIdn [Device Id], nUserID [Barcode], nTNAEvent [Traffic Type], 
	   DATEADD(s, nDateTime , '1970-01-01') as [date]
FROM [BioStar].dbo.TB_EVENT_LOG
WHERE  --nUserID=2155 and
	  nUserID <> 0
	    AND
	  DATEADD(s, nDateTime , '1970-01-01') >= '2012-07-22'
	  AND	
	  nEventLogIdn not in 
		(SELECT ISNULL(BasicTraffic_ReportsListId, 0) FROM [appsrv].[GhadirGTS].dbo.TA_BaseTraffic)
		
ORDER BY nUserID,nDateTime

OPEN ReportsList_Cursor	
	FETCH FROM ReportsList_Cursor
	INTO @nIndex,@DeviceId, @UserID, @bioPrecard,@dtDateTime
	
	WHILE @@FETCH_STATUS = 0
	BEGIN			

	select @prsId=prs_ID from [appsrv].[GhadirGTS].dbo.TA_Person where Prs_Barcode=RIGHT('00000000' + CONVERT(VARCHAR,@UserID), 8)

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
		END	
	END
		
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
END CATCH