

ALTER PROC [dbo].[spr_UpdateCFP]
(
@prsID numeric 
,@Date date
)
AS
 DECLARE @MinDate DateTime
SET @MinDate = NULL
			SELECT @MinDate = Min(CFP_date) 
			FROM TA_Calculation_Flag_Persons
			WHERE CFP_PrsID = @PrsId
			IF @MinDate IS NULL OR @MinDate = ''
			BEGIN
				 INSERT INTO TA_Calculation_Flag_Persons (CFP_PrsId, CFP_Date, CFP_MidNightCalculate, CFP_CalculationIsValid) 
				 VALUES (@PrsId, @Date, 0, 0)
			END
			ELSE IF @MinDate >= @Date
			BEGIN
				UPDATE TA_Calculation_Flag_Persons 
				SET CFP_Date = @Date, CFP_MidNightCalculate = 0, CFP_CalculationIsValid = 0				
				WHERE CFP_PrsId = @PrsId
			END
			ELSE
			BEGIN
				UPDATE TA_Calculation_Flag_Persons 
				SET CFP_CalculationIsValid = 0				
				WHERE CFP_PrsId = @PrsId
			END

	UPDATE TA_BaseTraffic
	SET BasicTraffic_Used = 0
	WHERE BasicTraffic_Date >= @Date
			AND
		  BasicTraffic_PersonID	= @prsID
			OR
		  BasicTraffic_ID IN (SELECT ProceedTrafficPair_BasicTrafficIdFrom
							  FROM TA_ProceedTraffic
							  INNER JOIN TA_ProceedTrafficPair
							  ON ProceedTraffic_ID = ProceedTrafficPair_ProceedTrafficId
							  WHERE ProceedTraffic_FromDate >= @Date
										AND
									ProceedTraffic_ToDate >= @Date
										AND					
									ProceedTraffic_PersonId = @prsID)
				OR
		  BasicTraffic_ID IN (SELECT ProceedTrafficPair_BasicTrafficIdTo
							  FROM TA_ProceedTraffic
							  INNER JOIN TA_ProceedTrafficPair
							  ON ProceedTraffic_ID = ProceedTrafficPair_ProceedTrafficId
							  WHERE ProceedTraffic_FromDate >= @Date
										AND
									ProceedTraffic_ToDate >= @Date
										AND					
									ProceedTraffic_PersonId = @prsID)
										
	DELETE FROM TA_ProceedTraffic
	WHERE ProceedTraffic_FromDate >= @Date
				AND
			  ProceedTraffic_ToDate >= @Date
				AND					
			  ProceedTraffic_PersonId = @prsID
			  
		
	UPDATE TA_PermitPair
	SET PermitPair_IsApplyedOnTraffic = 0
	WHERE Permitpair_PermitId in (SELECT Permit_ID FROM TA_Permit
								  WHERE Permit_PersonId = @prsID
											AND 
										Permit_FromDate >= @Date)
GO


