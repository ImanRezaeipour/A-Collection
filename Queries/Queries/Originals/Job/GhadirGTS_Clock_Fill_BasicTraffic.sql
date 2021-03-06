BEGIN TRY
	DECLARE @BarCode nvarchar(max)
	DECLARE @Chg int 
	DECLARE @Date nvarchar(50)
	DECLARE @Time int
	DECLARE @rdrCode int
	DECLARE @recState int
	
	DECLARE @GTSPreCard nvarchar(50)
	DECLARE @UserID numeric
	
	DECLARE C_Cursor CURSOR
	For SELECT Clock_BarCode, Clock_Chg, Clock_Date, Clock_Time, Clock_RdrCode, Clock_RecState
		FROM C139107 AS c
		WHERE GhadirGTS.dbo.GTS_ASM_ShamsiToMiladi(Clock_Date) >= (SELECT ISNULL(MAX(BasicTraffic_Date), '2012/07/22')
														 FROM GhadirGTS.dbo.TA_BaseTraffic 
														 WHERE BasicTraffic_ReportsListId IS NULL
																AND
															   BasicTraffic_ClockCustomCode = c.Clock_RdrCode
															    AND
															   BasicTraffic_PersonId = (SELECT TOP 1 Prs_ID 
																					    FROM GhadirGTS.dbo.TA_Person								
																					    WHERE Prs_BarCode = dbo.zerofixed(c.Clock_BarCode, 8))
													    )
			    AND
		      C.Clock_Time > (SELECT ISNULL(MAX(BasicTraffic_Time), 0)
							   FROM GhadirGTS.dbo.TA_BaseTraffic 
							   WHERE BasicTraffic_ReportsListId IS NULL
									  AND
								     BasicTraffic_ClockCustomCode = c.Clock_RdrCode
									  AND
								     BasicTraffic_PersonId = (SELECT TOP 1 Prs_ID 
															  FROM GhadirGTS.dbo.TA_Person								
															  WHERE Prs_BarCode = dbo.zerofixed(c.Clock_BarCode, 8))
									  AND
									 BasicTraffic_Date = GhadirGTS.dbo.GTS_ASM_ShamsiToMiladi(C.Clock_Date)
						     )													   
				AND
			  c.Clock_RdrCode IN (3, 51)
			    
	OPEN C_Cursor	
	FETCH NEXT FROM C_Cursor
	INTO @BarCode, @Chg, @Date, @Time, @rdrCode, @recState
	WHILE @@FETCH_STATUS = 0
	BEGIN			  
		 SET @GTSPreCard = (SELECT precrd_id 
							FROM GhadirGTS.dbo.TA_Precard 
							WHERE Precrd_Code = @recState)
										 
		 SET @UserID = (SELECT TOP 1 Prs_ID 
						FROM GhadirGTS.dbo.TA_Person								
						WHERE Prs_BarCode = dbo.zerofixed(@BarCode, 8))
						
		 SET @Date = GhadirGTS.dbo.GTS_ASM_ShamsiToMiladi(@Date)
			 						
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
													  ,[BasicTraffic_ClockCustomCode])
			VALUES (@GTSPreCard, @UserID, @Date, @Time, 0, 1, 0, 0, @rdrCode) 			 
		 END
		 FETCH NEXT FROM C_Cursor
		 INTO @BarCode, @Chg, @Date, @Time, @rdrCode, @recState
	END
	CLOSE C_Cursor
	DEALLOCATE C_Cursor
END TRY
BEGIN CATCH
	CLOSE C_Cursor
	DEALLOCATE C_Cursor
END CATCH

