USE [GhadirGTS]
GO
/****** Object:  Trigger [dbo].[trg_INS_CFP]    Script Date: 03/18/2012 15:37:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[trg_INS_CFP]
   ON  [dbo].[TA_Calculation_Flag_Persons]
   INSTEAD OF INSERT
AS 
BEGIN	
	SET NOCOUNT ON;

    DECLARE @MinDate DateTime
    DECLARE @PrsId numeric(18, 0)
    DECLARE @Date DateTime 
    DECLARE @MidNigthCalc bit
    DECLARE @CalcIsValid bit
    
    BEGIN TRY
		DECLARE CFP_Cursor_Inserted CURSOR
		For SELECT CFP_PrsId, CFP_Date, CFP_MidNightCalculate, CFP_CalculationIsValid FROM inserted 
    
	    OPEN CFP_Cursor_Inserted	
		FETCH NEXT FROM CFP_Cursor_Inserted
		INTO @PrsId, @Date, @MidNigthCalc, @CalcIsValid
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @MinDate = NULL
			SELECT @MinDate = Min(CFP_date) 
			FROM TA_Calculation_Flag_Persons
			WHERE CFP_PrsID = @PrsId
			IF @MinDate IS NULL OR @MinDate = ''
			BEGIN
				 INSERT INTO TA_Calculation_Flag_Persons (CFP_PrsId, CFP_Date, CFP_MidNightCalculate, CFP_CalculationIsValid) 
				 VALUES (@PrsId, @Date, @MidNigthCalc, @CalcIsValid)
			END
			ELSE IF @MinDate >= @Date
			BEGIN
				UPDATE TA_Calculation_Flag_Persons 
				SET CFP_Date = @Date, CFP_MidNightCalculate = @MidNigthCalc, CFP_CalculationIsValid = @CalcIsValid				
				WHERE CFP_PrsId = @PrsId
			END
			FETCH NEXT FROM CFP_Cursor_Inserted
			INTO @PrsId, @Date, @MidNigthCalc, @CalcIsValid
		END
		CLOSE CFP_Cursor_Inserted
		DEALLOCATE CFP_Cursor_Inserted
	END TRY
	BEGIN CATCH
		exec spr_gettriggerlog 
		CLOSE CFP_Cursor_Inserted
		DEALLOCATE CFP_Cursor_Inserted			
	END CATCH
END
