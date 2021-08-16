BEGIN TRY
	DECLARE @BarCode nvarchar(max)
	DECLARE @Chg int 
	DECLARE @Date nvarchar(50)
	DECLARE @Time int
	DECLARE @rdrCode int
	
	DECLARE @recState int
	
	DECLARE @GTSPreCard nvarchar(50)
	DECLARE @prsId numeric
	
	DECLARE C_Cursor CURSOR
	For SELECT Clock_BarCode, Clock_Chg, Clock_Date, Clock_Time, Clock_RdrCode, Clock_RecState
		FROM C139107 AS c
		WHERE c.Clock_RdrCode IN (3, 51)
			    
	OPEN C_Cursor	
	FETCH NEXT FROM C_Cursor
	INTO @BarCode, @Chg, @Date, @Time, @rdrCode, @recState
	WHILE @@FETCH_STATUS = 0
	BEGIN			  
		 SET @GTSPreCard = (SELECT precrd_id 
							FROM [GhadirGTS2].dbo.TA_Precard 
							WHERE Precrd_Code = @recState)
										 
		 SET @prsId =  [GhadirGTS2].dbo.GetPerson(@BarCode)
						
		 SET @Date = [GhadirGTS2].dbo.GTS_ASM_ShamsiToMiladi(@Date)
			 						
		 IF @prsId IS NOT NULL 
				AND 
			@GTSPreCard IS NOT NULL
		 BEGIN    
		 if Not Exists(select BasicTraffic_ID from [GhadirGTS2].dbo.TA_BaseTraffic where BasicTraffic_PersonID=@prsId
																		AND BasicTraffic_Date=@Date
																		AND BasicTraffic_PrecardId=@GTSPreCard
																		AND BasicTraffic_Time=@Time)
		   BEGIN
			INSERT INTO [GhadirGTS2].dbo.TA_BaseTraffic ([BasicTraffic_PrecardId]
													  ,[BasicTraffic_PersonID]
													  ,[BasicTraffic_Date]
													  ,[BasicTraffic_Time]
													  ,[BasicTraffic_Used]
													  ,[BasicTraffic_Active]
													  ,[BasicTraffic_Manual]
													  ,[BasicTraffic_State]
													  ,[BasicTraffic_ClockCustomCode])
			VALUES (@GTSPreCard, @prsId, @Date, @Time, 0, 1, 0, 0, @rdrCode) 	
			END		 
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

