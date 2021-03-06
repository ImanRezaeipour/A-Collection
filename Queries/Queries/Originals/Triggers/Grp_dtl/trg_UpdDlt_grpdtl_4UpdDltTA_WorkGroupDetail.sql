
ALTER TRIGGER [dbo].[trg_UpdDlt_grpdtl_4UpdDltTA_WorkGroupDetail]
   ON  [dbo].[grp_dtl]
   AFTER UPDATE, DELETE
AS 
BEGIN
	 SET NOCOUNT ON	
	begin try

	DECLARE @Grd_code int,
			 @Grd_year int,
			 @Grd_M1 nvarchar(31),
		 	 @Grd_M2 nvarchar(31),
			 @Grd_M3 nvarchar(31),
			 @Grd_M4 nvarchar(31),
			 @Grd_M5 nvarchar(31),
			 @Grd_M6 nvarchar(31),
			 @Grd_M7 nvarchar(31),
			 @Grd_M8 nvarchar(31),
			 @Grd_M9 nvarchar(31),
			 @Grd_M10 nvarchar(31),
			 @Grd_M11 nvarchar(31),
			 @Grd_M12 nvarchar(31)
			 
	DECLARE cursor_inserted CURSOR 
	FOR SELECT * FROM inserted
	OPEN cursor_inserted
	FETCH NEXT FROM cursor_inserted
	INTO @Grd_code, @Grd_year, @Grd_M1, @Grd_M2, @Grd_M3,
			 @Grd_M4, @Grd_M5, @Grd_M6, @Grd_M7, @Grd_M8,
			 @Grd_M9, @Grd_M10, @Grd_M11, @Grd_M12
	WHILE @@FETCH_STATUS = 0
	BEGIN			 
	 DELETE TA_WorkGroupDetail 
	 WHERE WorkGroupDtl_WorkGroupID = @Grd_code 
			AND 
		   substring(dbo.GTS_ASM_MiladiToShamsi( Convert(varchar(10),WorkGroupDtl_Date,101)), 1, 4) = @Grd_year	
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		select * from dbo.ascii_field_to_Record(1, @Grd_code, @Grd_year, @Grd_M1) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(2, @Grd_code, @Grd_year, @Grd_M2) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail		
		SELECT * from dbo.ascii_field_to_Record(3, @Grd_code, @Grd_year, @Grd_M3) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(4, @Grd_code, @Grd_year, @Grd_M4) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail  
		SELECT * from dbo.ascii_field_to_Record(5, @Grd_code, @Grd_year, @Grd_M5) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(6, @Grd_code, @Grd_year, @Grd_M6) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(7, @Grd_code, @Grd_year, @Grd_M7) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(8, @Grd_code, @Grd_year, @Grd_M8) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(9, @Grd_code, @Grd_year, @Grd_M9) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(10, @Grd_code, @Grd_year, @Grd_M10) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(11, @Grd_code, @Grd_year, @Grd_M11) 
	-------------------------
	 INSERT INTO TA_WorkGroupDetail 
		SELECT * from dbo.ascii_field_to_Record(12, @Grd_code, @Grd_year, @Grd_M12) 
	-------		
	FETCH NEXT FROM cursor_inserted
	INTO @Grd_code, @Grd_year, @Grd_M1, @Grd_M2, @Grd_M3,
			 @Grd_M4, @Grd_M5, @Grd_M6, @Grd_M7, @Grd_M8,
			 @Grd_M9, @Grd_M10, @Grd_M11, @Grd_M12

	END
	CLOSE cursor_inserted
	DEALLOCATE cursor_inserted
	
	

	end try
	begin catch
		exec spr_GetTriggerLog 
	end catch
END
