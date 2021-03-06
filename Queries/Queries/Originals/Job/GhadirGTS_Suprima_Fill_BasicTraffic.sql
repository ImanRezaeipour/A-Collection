BEGIN TRY
	DECLARE @nIndex int
	DECLARE @nEvent int ---   رویداد
	DECLARE @dtDateTime datetime ---  تاریخ زمان
	DECLARE @Date varchar(10)
	DECLARE @minute varchar(10)--زمان برحسب دقیقه
	DECLARE @UserID int   ---شماره پرسنلی
	DECLARE @nTNAEvent varchar(10)
	
	

	DECLARE ReportsList_Cursor CURSOR
	For SELECT nIndex, dtDateTime, nEvent, nUserID, NTNAEvent
		FROM tb_reportsList
		WHERE nIndex not in (SELECT ISNULL(BasicTraffic_ReportsListId, 0) FROM GhadirGTS.dbo.TA_BaseTraffic)
				AND
			  nUserID <> 0
			    AND
			  dtDateTime >= '2012-05-21 00:00:00.000'

	OPEN ReportsList_Cursor	
	FETCH NEXT FROM ReportsList_Cursor
	INTO @nIndex, @dtDateTime, @nEvent, @UserID, @nTNAEvent
	WHILE @@FETCH_STATUS = 0
	BEGIN			
		DECLARE @PreCard int   --پیش کارت کلاک 
		DECLARE @GTSPreCard int --پیش کارت جی تی اس
		
		IF @nEvent=55 or @nEvent=39      -- عادی    55  کارت   39    
		BEGIN	
			 IF @nTNAEvent = 65535 OR @nTNAEvent = 0 
				SET @PreCard = 0  
			 ELSE    
			 BEGIN 
				SET @PreCard = (SELECT  Pish_Code
								FROM dbo.pishcard 
								WHERE  Pish_key <> 0 
										AND 
									   Pish_key = @nTNAEvent)
				IF @PreCard is null 
					SET @PreCard = 0
			 END 		  
			 SET @GTSPreCard = (SELECT precrd_id 
								FROM GhadirGTS.dbo.TA_Precard 
								WHERE Precrd_Code = @PreCard)
								
			 SET @minute  = (SELECT DATEPART(HOUR, @dtDateTime) * 60 + DATEPART(minute, @dtDateTime))  
			 
			 SET @UserID = (SELECT TOP 1 Prs_ID 
							FROM GhadirGTS.dbo.TA_Person								
							WHERE Prs_BarCode = dbo.zerofixed(@UserID, 8))
			 SET @Date = CONVERT(VARCHAR(10), @dtDateTime, 101)
			 						
			 IF @UserID IS NOT NULL 
					AND 
				@GTSPreCard IS NOT NULL
			 BEGIN      
				INSERT INTO GhadirGTS.dbo.TA_BaseTraffic ([BasicTraffic_PrecardId]
														  ,[BasicTraffic_PersonID]
														  ,[BasicTraffic_Date]
														  ,[BasicTraffic_Time]
														  ,[BasicTraffic_Used]
														  ,[BasicTraffic_Active]
														  ,[BasicTraffic_Manual]
														  ,[BasicTraffic_State]
														  ,[BasicTraffic_ReportsListId])
				VALUES (@GTSPreCard, @UserID, @Date, @minute, 0, 1, 0, 0, @nIndex) 			 
			 END
		END	
		FETCH NEXT FROM ReportsList_Cursor
		INTO @nIndex, @dtDateTime, @nEvent, @UserID, @nTNAEvent
	END
	CLOSE ReportsList_Cursor
	DEALLOCATE ReportsList_Cursor
END TRY
BEGIN CATCH
	CLOSE ReportsList_Cursor
	DEALLOCATE ReportsList_Cursor
END CATCH
