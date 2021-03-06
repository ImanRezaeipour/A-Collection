BEGIN TRY
    DECLARE @nIndex NUMERIC
    DECLARE @DeviceId INT -- شناسه دستگاه
    DECLARE @dtDateTime DATETIME -- تاریخ زمان
    DECLARE @Date DATE
    DECLARE @MinDate DATE
    DECLARE @minute VARCHAR(10) -- زمان برحسب دقیقه 
    DECLARE @UserID INT -- شماره پرسنلی
    DECLARE @LastUserID INT
    DECLARE @prsId NUMERIC
    DECLARE @bioPrecard VARCHAR(10)
    DECLARE @UsualPrecardId NUMERIC
    DECLARE @BIOStarId VARCHAR(50)
    DECLARE @Inserted BIT
	
    SELECT TOP ( 1 )
            @BIOStarId = CONVERT(VARCHAR(50), softwareid)
    FROM    [10.0.2.65].[BIOSTAR].dbo.TA_BioStarID

    SELECT  @UsualPrecardId = Precrd_ID
    FROM    [DeyGTS].dbo.TA_Precard
    WHERE   Precrd_Code = '0'

    PRINT 'Retriving BioStar Traffics Started '
        + CONVERT(VARCHAR(100), CURRENT_TIMESTAMP)
    DECLARE ReportsList_Cursor CURSOR
    FOR
        SELECT  nEventLogIdn [ID] ,
                nReaderIdn [Device Id] ,
                nUserID [Barcode] ,
                nTNAEvent [Traffic Type] ,
                DATEADD(s, nDateTime, '1970-01-01') AS [date]
        FROM    [10.0.2.65].[BIOSTAR].dbo.TB_EVENT_LOG
        WHERE   LEN(ISNULL(nUserID, 0)) > 2 -- exclude device barcode
                AND nEventIdn IN ( 55, 39, 47, 49, 58, 98, 99, 151 )
                AND nTNAEvent = 255
                AND ISNULL(GTS_Transfered, 0) = 0
                AND DATEADD(s, nDateTime, '1970-01-01') >= '2014-03-21'
                AND nUserID IN ( SELECT Prs_Barcode
                                 FROM   [DeyGTS].dbo.TA_Person
                                 WHERE  prs_IsDeleted = 0
                                        AND Prs_Active = 1 )
                AND nEventLogIdn NOT IN (
                SELECT  BasicTraffic_ReportsListId
                FROM    [DeyGTS].dbo.TA_BaseTraffic
                WHERE   BasicTraffic_ReportsListId IS NOT NULL
                        AND BasicTraffic_BioStarId = @BIOStarId )
        ORDER BY nUserID ,
                nDateTime

    OPEN ReportsList_Cursor	
    FETCH FROM ReportsList_Cursor
	INTO @nIndex, @DeviceId, @UserID, @bioPrecard, @dtDateTime


    PRINT 'Retriving BioStar Traffics Finished '
        + CONVERT(VARCHAR(100), CURRENT_TIMESTAMP)	

    SET @Inserted = 0;
    SET @LastUserID = @UserID;
    SET @MinDate = CONVERT(DATE, @dtDateTime, 103)
    SELECT  @prsId = ISNULL(prs_ID, 0)
    FROM    [DeyGTS].dbo.TA_Person
    WHERE   CONVERT(NUMERIC, Prs_Barcode) = CONVERT(NUMERIC, @UserID)		

    WHILE @@FETCH_STATUS = 0 
        BEGIN			

            SET @Date = CONVERT(DATE, @dtDateTime, 103)

            IF ISNULL(@LastUserID, 0) <> ISNULL(@UserID, 0) 
                BEGIN
                    PRINT @UserID
                    IF @prsId IS NOT NULL
                        AND @prsId <> 0
                        AND @Inserted = 1 
                        BEGIN
                            EXEC [DeyGTS].dbo.spr_UpdateCFP @prsId, @MinDate
                            SET @Inserted = 0
                        END

                    SET @prsId = NULL;
                    SELECT  @prsId = ISNULL(prs_ID, 0)
                    FROM    [DeyGTS].dbo.TA_Person
                    WHERE   CONVERT(NUMERIC, Prs_Barcode) = CONVERT(NUMERIC, @UserID)		
		
                    SET @LastUserID = @UserID;		
                END
            ELSE 
                IF @MinDate > @Date 
                    BEGIN
                        SET @MinDate = @Date;
                    END
		
	
            IF @prsId IS NOT NULL
                AND @prsId <> 0
                AND @bioPrecard = 255 -- فقط پیشکارت عادی
                BEGIN				
                    SET @minute = DATEPART(HH, @dtDateTime) * 60 + DATEPART(MI,
                                                              @dtDateTime)
                    IF NOT EXISTS ( SELECT  BasicTraffic_ID
                                    FROM    [DeyGTS].dbo.TA_BaseTraffic
                                    WHERE   BasicTraffic_Date = @Date
                                            AND BasicTraffic_Time = @minute
                                            AND BasicTraffic_PrecardId = @UsualPrecardId
                                            AND BasicTraffic_PersonID = @prsId ) 
                        BEGIN
                            INSERT  INTO [DeyGTS].dbo.TA_BaseTraffic
                                    ( [BasicTraffic_PrecardId] ,
                                      [BasicTraffic_PersonID] ,
                                      [BasicTraffic_Date] ,
                                      [BasicTraffic_Time] ,
                                      [BasicTraffic_Used] ,
                                      [BasicTraffic_Active] ,
                                      [BasicTraffic_Manual] ,
                                      [BasicTraffic_ReportsListId] ,
                                      [BasicTraffic_ClockCustomCode] ,
                                      [BasicTraffic_BioStarId]
                                    )
                            VALUES  ( @UsualPrecardId ,
                                      @prsId ,
                                      @Date ,
                                      @minute ,
                                      0 ,
                                      1 ,
                                      0 ,
                                      @nIndex ,
                                      @DeviceId ,
                                      @BIOStarId
                                    ) 
                            INSERT  INTO [DeyGTS].dbo.TA_BioTmpIds
                                    ( nEventIdn, BioStarId )
                            VALUES  ( @nIndex, @BIOStarId )
                            SET @Inserted = 1;		
                        END	
                END

            FETCH NEXT FROM ReportsList_Cursor
		INTO @nIndex, @DeviceId, @UserID, @bioPrecard, @dtDateTime
        END

    PRINT @UserID
    IF @prsId IS NOT NULL
        AND @prsId <> 0
        AND @Inserted = 1 
        BEGIN
            EXEC [DeyGTS].dbo.spr_UpdateCFP @prsId, @MinDate
            SET @Inserted = 0
        END	

    UPDATE  [10.0.2.65].[BIOSTAR].dbo.TB_EVENT_LOG
    SET     GTS_Transfered = 1
    WHERE   nEventLogIdn IN ( SELECT    nEventIdn
                              FROM      [DeyGTS].dbo.TA_BioTmpIds
                              WHERE     BioStarId = @BIOStarId )
    DELETE  FROM [DeyGTS].dbo.TA_BioTmpIds
    WHERE   BioStarId = @BIOStarId

    CLOSE ReportsList_Cursor
    DEALLOCATE ReportsList_Cursor
END TRY
BEGIN CATCH
    CLOSE ReportsList_Cursor
    DEALLOCATE ReportsList_Cursor
    EXEC [DeyGTS].dbo.spr_GetTriggerLog 
END CATCH