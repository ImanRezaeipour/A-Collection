ALTER TRIGGER trg_InsUpdDel_holiday_4InsUpdDelTA_Calendar
   ON  holiday 
   AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	begin try
	DECLARE @ObjID numeric,
			@Year int,
			@Month int,
			@RasmiDays nvarchar(31),
			@NonRasmiDays nvarchar(31),
			@CategoryId decimal
			
	SELECT @CategoryId = Cat_ID
	FROM TA_Category	
	WHERE Cat_Name = N'دسته تقویم'
			AND
		  Cat_IsCalanderCategory = 1


	DECLARE occurenceHoliday_cursor CURSOR
	FOR SELECT holiday_year, holiday_month, holiday_Rasmi, holiday_NonRasmi
		FROM inserted

	OPEN occurenceHoliday_cursor	
	FETCH NEXT FROM occurenceHoliday_cursor
	INTO @Year, @Month, @RasmiDays, @NonRasmiDays

	WHILE @@FETCH_STATUS = 0
	BEGIN
		----------------------------
		DELETE FROM TA_Calendar
		WHERE Calendar_Year = @Year
				AND
			  Calendar_Month = @Month	
		DELETE FROM TA_Object
		WHERE TA_Object.TAObj_ID IN (SELECT Calendar_ID FROM TA_Calendar
									 WHERE Calendar_Year = @Year
									 		 AND
										   Calendar_Month = @Month)													   				  
		----------------------------
		INSERT INTO TA_Object DEFAULT VALUES
		SET @ObjID = SCOPE_IDENTITY()	
		
		INSERT INTO TA_Calendar
		VALUES(@ObjID, 1, @Year, @Month, @RasmiDays, N'تعطیل رسمی')
		
		INSERT INTO TA_ObjectCategory(ObjCat_ObjectId, ObjCat_CategoryId, ObjCat_IsContain)
			VALUES(@ObjID, @CategoryId, 1)
		
		INSERT INTO TA_Object DEFAULT VALUES
		SET @ObjID = SCOPE_IDENTITY()	
		
		INSERT INTO TA_Calendar
		VALUES(@ObjID, 2, @Year, @Month, @NonRasmiDays, N'تعطیل غیررسمی')
		
		INSERT INTO TA_ObjectCategory(ObjCat_ObjectId, ObjCat_CategoryId, ObjCat_IsContain)
			VALUES(@ObjID, @CategoryId, 1)		
		----------------------------
		FETCH NEXT FROM occurenceHoliday_cursor
		INTO @Year, @Month, @RasmiDays, @NonRasmiDays
	END
	CLOSE occurenceHoliday_cursor
	DEALLOCATE occurenceHoliday_cursor
						
	end try
	begin catch	
		exec spr_GetTriggerLog 
	end catch
END
GO


