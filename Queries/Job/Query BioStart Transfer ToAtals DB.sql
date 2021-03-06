BEGIN TRY
	DECLARE @nIndex numeric
	DECLARE @DeviceId int ---   شناسه دستگاه
	DECLARE @dtDateTime datetime ---  تاریخ زمان
	DECLARE @Date date
	DECLARE @MinDate date
	DECLARE @minute varchar(10)--زمان برحسب دقیقه
	DECLARE @UserID int   ---شماره پرسنلی
	DECLARE @LastUserID int
	DECLARE @prsId numeric
	DECLARE @bioPrecard varchar(10)
	DECLARE @UsualPrecardId numeric
	DECLARE @BIOStarId varchar(50)
	DECLARE @Inserted bit
	
SELECT top(1) @BIOStarId=CONVERT(varchar(50),softwareid) FROM [appserver27].[BIOSTAR].dbo.TA_BioStarID

SELECT @UsualPrecardId=Precrd_ID FROM [appserver24].[FalatGTS].dbo.TA_Precard
WHERE Precrd_Code='0'

print 'Retriving BioStar Traffics Started ' +Convert(varchar(100), CURRENT_TIMESTAMP)
DECLARE ReportsList_Cursor CURSOR
For
SELECT nEventLogIdn [ID], nReaderIdn [Device Id], nUserID [Barcode], nTNAEvent [Traffic Type], 
	   DATEADD(s, nDateTime , '1970-01-01') as [date]
FROM [appserver27].[BIOSTAR].dbo.TB_EVENT_LOG
WHERE  
	  len(isnull(nUserID,0)) > 2 -- exclude device barcode
	    AND
	  nEventIdn in (55,39,47,49,58,98,99,151) AND nTNAEvent=255
		AND
	  isnull(GTS_Transfered,0)=0
	    AND
	  DATEADD(s, nDateTime , '1970-01-01') >= '2012-10-01'
		AND 
	nUserID in (select Prs_Barcode from   [appserver24].[FalatGTS].dbo.TA_Person where prs_IsDeleted=0 and Prs_Active=1)
	   AND	
	  nEventLogIdn not in 
		(SELECT BasicTraffic_ReportsListId FROM [appserver24].[FalatGTS].dbo.TA_BaseTraffic 
		 WHERE BasicTraffic_ReportsListId is not null and BasicTraffic_BioStarId=@BIOStarId)

ORDER BY nUserID,nDateTime

OPEN ReportsList_Cursor	
	FETCH FROM ReportsList_Cursor
	INTO @nIndex,@DeviceId, @UserID, @bioPrecard,@dtDateTime


	print 'Retriving BioStar Traffics Finished ' +Convert(varchar(100), CURRENT_TIMESTAMP)	

	SET @Inserted=0;
	SET @LastUserID=@UserID;
	SET @MinDate=CONVERT(date, @dtDateTime , 103)
	select @prsId=ISNULL(prs_ID,0) from [appserver24].[FalatGTS].dbo.TA_Person where CONVERT(numeric,Prs_Barcode)= CONVERT(numeric,@UserID)		

	WHILE @@FETCH_STATUS = 0
	BEGIN			

	set @Date = CONVERT(date, @dtDateTime , 103)

    IF isnull(@LastUserID,0) <> isnull(@UserID,0)
    BEGIN
		print @UserID
		IF @prsId IS NOT NULL AND @prsId<>0	AND @Inserted=1
		begin
			EXEC[appserver24].[FalatGTS].dbo.spr_UpdateCFP @prsId,@MinDate
			set @Inserted=0
		end

		set @prsId=null;
		SELECT @prsId=ISNULL(prs_ID,0) FROM [appserver24].[FalatGTS].dbo.TA_Person WHERE CONVERT(numeric,Prs_Barcode)= CONVERT(numeric,@UserID)		
		
		SET @LastUserID=@UserID;		
    END
    ELSE IF @MinDate > @Date
    BEGIN
		SET @MinDate= @Date;
    END
		
	
	IF @prsId IS NOT Null AND @prsId<>0       
			AND
		@bioPrecard = 255 -- فقط پیشکارت عادی
	BEGIN				
		set @minute= DATEPART(HH, @dtDateTime) * 60 + DATEPART(MI, @dtDateTime)
		IF NOT Exists(SELECT BasicTraffic_ID FROM [appserver24].[FalatGTS].dbo.TA_BaseTraffic 
						WHERE  BasicTraffic_Date=@Date and BasicTraffic_Time=@minute and BasicTraffic_PrecardId=@UsualPrecardId
						and BasicTraffic_PersonID=@prsId
					)
		BEGIN
			INSERT INTO[appserver24].[FalatGTS].dbo.TA_BaseTraffic ([BasicTraffic_PrecardId]
														  ,[BasicTraffic_PersonID]
														  ,[BasicTraffic_Date]
														  ,[BasicTraffic_Time]
														  ,[BasicTraffic_Used]
														  ,[BasicTraffic_Active]
														  ,[BasicTraffic_Manual]														 
														  ,[BasicTraffic_ReportsListId]
														  ,[BasicTraffic_ClockCustomCode]
														  ,[BasicTraffic_BioStarId])
			VALUES (@UsualPrecardId, @prsId, @Date, @minute, 0, 1, 0, @nIndex,@DeviceId,@BIOStarId) 
			Insert INTO [appserver24].[FalatGTS].dbo.TA_BioTmpIds(nEventIdn,BioStarId) VALUES (@nIndex,@BIOStarId)
			set @Inserted=1;		
		END	
	END

	FETCH NEXT FROM ReportsList_Cursor
		INTO @nIndex,@DeviceId, @UserID, @bioPrecard,@dtDateTime
	END

	print @UserID
	IF @prsId IS NOT NULL AND @prsId<>0	AND @Inserted=1
	begin
		EXEC[appserver24].[FalatGTS].dbo.spr_UpdateCFP @prsId,@MinDate
		set @Inserted=0
	end	

	UPDATE [appserver27].[BIOSTAR].dbo.TB_EVENT_LOG SET GTS_Transfered=1 
	WHERE nEventLogIdn in (SELECT nEventIdn FROM [appserver24].[FalatGTS].dbo.TA_BioTmpIds WHERE BioStarId=@BIOStarId)
	DELETE FROM [appserver24].[FalatGTS].dbo.TA_BioTmpIds WHERE BioStarId=@BIOStarId

	CLOSE ReportsList_Cursor
	DEALLOCATE ReportsList_Cursor
END TRY
BEGIN CATCH
	CLOSE ReportsList_Cursor
	DEALLOCATE ReportsList_Cursor
	exec spr_GetTriggerLog 
END CATCH