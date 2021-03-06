
alter TRIGGER trg_InsUpDle_Rules_4InsUpDleTA_DefinedRules
ON Rules
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
	from inserted --where Rule_Code=1
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

	print 'CFP Staring'
	INSERT INTO TA_Calculation_Flag_Persons(CFP_Barcode,CFP_Date)
	SELECT P_BarCode,LEFT(dbo.GTS_ASM_MiladiToShamsi(CONVERT(varchar(10),GetDate(),108)),4) +'/01/01' 
		FROM persons
		WHERE P_RuleGroup  in (SELECT Rule_Code FROM inserted)
		
	end try
	begin catch
	exec spr_GetTriggerLog 
	end catch		
END

