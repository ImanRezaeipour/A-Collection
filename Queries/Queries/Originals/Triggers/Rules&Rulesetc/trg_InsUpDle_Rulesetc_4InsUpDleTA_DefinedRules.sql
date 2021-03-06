
alter TRIGGER trg_InsUpDle_Rulesetc_4InsUpDleTA_DefinedRules
ON Rulesetc
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	begin try
	DECLARE @Rule_Code varchar(50)
			
----------------------------------------------			
if exists(select * from deleted) and not exists(select * from inserted)
begin
		
  	delete from TA_CategoryPart where CatPart_ParentCatId in
	(select Cat_ID from TA_Category where cat_customCode in (select Convert(varchar(5),rule_code) from deleted ))
	
	delete from TA_CategoryPart where CatPart_ChildCatId in
	(select Cat_ID from TA_Category where cat_customCode in (select Convert(varchar(5),rule_code) from deleted ))
	
		
	delete from TA_Category where cat_customCode in (select Convert(varchar(5),rule_code) from deleted )


declare deleted_cursor cursor
for select Rule_Code
	from deleted 
	order by rule_code
 
	
OPEN deleted_cursor	
FETCH NEXT FROM deleted_cursor
INTO  @Rule_Code
					
WHILE @@FETCH_STATUS = 0
BEGIN	

	delete from TA_Category where cat_customCode like @Rule_Code+'-%';
	
	FETCH NEXT FROM deleted_cursor
	INTO @Rule_Code	
	
END	
end

----------------------------------------------				
			
declare inserted_cursor cursor
for select Rule_Code
	from rules
	where rules.rule_code in (select inserted.rule_code from inserted)
	 order by rule_code
	 
OPEN inserted_cursor	
FETCH NEXT FROM inserted_cursor
INTO  @Rule_Code
					
WHILE @@FETCH_STATUS = 0
BEGIN	

--------------Categories---------------

		Exec dbo.spr_InitCategory @Rule_Code

--------------Rule Template---------------

		Exec dbo.spr_InitRules @Rule_Code
		
-------------ScndCnp Populating-----------
		
		exec dbo.spr_InitConcepts @Rule_Code
		
-------------Rangly Populating-----------
		
		exec dbo.spr_InitPriodics @Rule_Code		
		
-------------DateRange Populating-----------		

		exec dbo.spr_InitDateRange @Rule_Code
		
-------------Traffic Settings-------------		

		exec dbo.spr_InitTrafficSettings @Rule_Code

-------------Finished---------------------	
			
FETCH NEXT FROM inserted_cursor
INTO @Rule_Code

	END
	CLOSE inserted_cursor
	DEALLOCATE inserted_cursor
	
	--Leave Settings---------------------
		print 'ruleetc LeaveSetting Starting'				
	DECLARE @UseFutureMonth int,
			@MinutesInDay int

	DELETE FROM TA_LeaveSettings
	WHERE LeaveSet_PersonId IN (SELECT P.Prs_ID
			 		 FROM inserted i
							INNER JOIN TA_Person p
								ON P.Prs_BarCode IN (SELECT p_barcode FROM persons WHERE P_RuleGroup = i.Rule_Code))
	INSERT INTO TA_LeaveSettings(LeaveSet_PersonId, LeaveSet_UseFutureMounth, LeaveSet_MinutesInDay, LeaveSet_From)								 
		SELECT P.Prs_ID, i.Rule_motalab, i.Rule_mohr, GETDATE()
		FROM inserted i
				INNER JOIN TA_Person p
					ON P.Prs_BarCode IN (SELECT p_barcode FROM persons WHERE P_RuleGroup = i.Rule_Code)
	
	UPDATE TA_LeaveSettings SET LeaveSet_MinutesInDay = 480 WHERE LeaveSet_MinutesInDay=0
	print 'ruleetc CFP Starting'				
	INSERT INTO TA_Calculation_Flag_Persons(CFP_Barcode,CFP_Date)
	SELECT P_BarCode,LEFT(dbo.GTS_ASM_MiladiToShamsi(CONVERT(varchar(10),GetDate(),101)),4) +'/01/01' 
		FROM persons
		WHERE P_RuleGroup  in (SELECT Rule_Code FROM inserted)

	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch
END

