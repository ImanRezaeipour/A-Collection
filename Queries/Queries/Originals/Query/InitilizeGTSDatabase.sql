
DECLARE @name_ varchar(50),
		@str_  varchar(200)
		
DECLARE db_cursor_ CURSOR FOR  
	SELECT name 
	FROM sysobjects 
	WHERE TYPE = 'U' 
			AND  
		  LEFT(name,3) = 'ta_' 
			AND 
		  NAME NOT LIKE '%template%'
			--AND 
		 -- NAME NOT LIKE 'TA_Category'.
		  AND
		   NAME NOT LIKE '%_Security%'
		  AND 
		   NAME NOT LIKE 'TA_Person'
		    AND 
		   NAME NOT LIKE 'TA_ObjectOrderSetup'
		   AND
		   NAME NOT LIKE 'TA_NormalDateRange'
		  

OPEN db_cursor_
FETCH NEXT FROM db_cursor_ INTO @name_   
------------------------
WHILE @@FETCH_STATUS = 0   
BEGIN   
       SET @str_= 'DELETE FROM ' + @name_
       EXECUTE(@str_)
       FETCH NEXT FROM db_cursor_ INTO @name_
END   
-----------------------
CLOSE db_cursor_   
DEALLOCATE db_cursor_ 
print 'Delete Finished'


--Fire Parts triggers---------------
IF EXISTS (SELECT * FROM parts)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO parts_tmp
	FROM parts
	TRUNCATE TABLE parts	
	INSERT INTO parts
		SELECT * 
		FROM parts_tmp
	DROP TABLE parts_tmp			
	COMMIT TRANSACTION T1
END
print 'Parts'

--Fire shifts triggers---------------
IF EXISTS (SELECT * FROM shifts)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO shifts_tmp
	FROM shifts
	TRUNCATE TABLE shifts	
	INSERT INTO shifts
		SELECT * 
		FROM shifts_tmp	
	DROP TABLE shifts_tmp	
	COMMIT TRANSACTION T1
END
print 'shift'

--Fire groups triggers---------------
IF EXISTS (SELECT * FROM groups)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO groups_tmp
	FROM groups
	TRUNCATE TABLE groups	
	INSERT INTO groups
		SELECT * 
		FROM groups_tmp	
	DROP TABLE groups_tmp	
	COMMIT TRANSACTION T1
END
print 'groups'
--DELETE FROM grp_dtl
--WHERE Grd_Year >1388

--Fire grp_dtl triggers---------------
IF EXISTS (SELECT * FROM grp_dtl)
BEGIN
	BEGIN TRANSACTION T1
	DELETE FROM grp_dtl where Grd_Code not in ( select Grp_Code from groups)
	
	SELECT * 
		INTO grp_dtl_tmp
	FROM grp_dtl
	TRUNCATE TABLE grp_dtl	
	INSERT INTO grp_dtl
		SELECT * 
		FROM grp_dtl_tmp
	DROP TABLE grp_dtl_tmp	
	COMMIT TRANSACTION T1
END
print 'group_dtl'
--Fire init triggers---------------
IF EXISTS (SELECT * FROM [init])
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO init_tmp
	FROM [init]
	TRUNCATE TABLE [init]	
	INSERT INTO [init]
		SELECT * 
		FROM init_tmp	
	DROP TABLE init_tmp	
	COMMIT TRANSACTION T1
END

print 'init'
--Fire Pishcard triggers---------------
IF EXISTS (SELECT * FROM Pishcard)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO Pishcard_tmp
	FROM Pishcard
	TRUNCATE TABLE Pishcard	
	INSERT INTO Pishcard
		SELECT * 
		FROM Pishcard_tmp	
	DROP TABLE Pishcard_tmp	
	COMMIT TRANSACTION T1
	
	INSERT INTO TA_Precard (precrd_ID , precrd_Name ,precrd_Active )
	VALUES (125,'اضافه کاری',1)
END
print 'pishcard'

--Insert Categories-------------------

DELETE FROM TA_Category
DECLARE @CatId numeric,
		@CatCustomCode nvarchar(50),
		@i int,
		@count int
---------------------
INSERT INTO TA_Category VALUES('دسته قوانین', 0, 1, 0, 0)
SET @CatId = SCOPE_IDENTITY()
---------------------
INSERT INTO TA_Category(Cat_Name, Cat_CustomCode, Cat_IsRuleCategory, Cat_IsConceptCategory, Cat_IsCalanderCategory)
	SELECT Rule_Name, Rule_Code, 1, 0, 0
	FROM rules
INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
 SELECT @CatId, Cat_ID, 1
 FROM TA_Category
 WHERE Cat_ID <> @CatId
 
 print 'categories'
---------------------
SELECT @i = 0,
	   @count = COUNT(*) + 1
FROM rules	   


DECLARE category_cursor CURSOR
	FOR SELECT Cat_ID, Cat_CustomCode
		FROM TA_Category where cat_customcode <> '0'
		
OPEN category_cursor
FETCH NEXT FROM category_cursor
INTO @CatId, @CatCustomCode
WHILE @@FETCH_STATUS = 0 AND @i < @count - 1
BEGIN
	DECLARE @ChildId numeric
	print 'sub category'+convert(varchar(5),@i);
	INSERT INTO TA_Category VALUES(N'متفرقه-کارکرد', @CatCustomCode + '-1', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	
	INSERT INTO TA_Category VALUES(N'مرخصی', @CatCustomCode + '-2', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
		
	INSERT INTO TA_Category VALUES(N'ماموریت', @CatCustomCode + '-3', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
		
	INSERT INTO TA_Category VALUES(N'کم کاری', @CatCustomCode + '-4', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
		
	INSERT INTO TA_Category VALUES(N'اضافه کاری', @CatCustomCode + '-5', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	
	INSERT INTO TA_Category VALUES(N'متفرقه', @CatCustomCode + '-6', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	
	INSERT INTO TA_Category VALUES(N'مقداردهی', @CatCustomCode + '-7', 1, 0, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	
	SET @i = @i + 1
	
	FETCH NEXT FROM category_cursor
	INTO @CatId, @CatCustomCode
		
END
CLOSE category_cursor
DEALLOCATE category_cursor 
print 'concept category'
---------------------
--Insert Categories-------------------
INSERT INTO TA_Category VALUES('دسته مفاهیم', '00', 0, 1, 0)
SET @CatId = SCOPE_IDENTITY()
---------------------
INSERT INTO TA_Category(Cat_Name, Cat_CustomCode, Cat_IsRuleCategory, Cat_IsConceptCategory, Cat_IsCalanderCategory)
	SELECT Rule_Name, '00'+Convert(varchar(10),Rule_Code), 0, 1, 0
	FROM rules
INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
 SELECT @CatId, Cat_ID, 1
 FROM TA_Category
 WHERE Cat_ID <> @CatId and Cat_CustomCode like('00%')
 
 print 'categories'
---------------------
SELECT @i = 0,
	   @count = COUNT(*) + 1
FROM rules	   
print 'Concept Category Part'

if  exists(select id from sysobjects where  name='tmp_category') drop table tmp_category
select * into tmp_category from  TA_Category

DECLARE category_cursor CURSOR
	FOR SELECT Cat_ID, Cat_CustomCode
		FROM tmp_category where Cat_CustomCode like('00%') and cat_customcode <> '00'
		
OPEN category_cursor
FETCH NEXT FROM category_cursor
INTO @CatId, @CatCustomCode
WHILE @@FETCH_STATUS = 0 AND @i < @count -1  
BEGIN
	print 'sub category'+convert(varchar(5),@i);
	INSERT INTO TA_Category VALUES(N'متفرقه-کارکرد', @CatCustomCode + '-1', 0, 1, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	print 'متفرقه-کارکرد ' + @CatCustomCode
	INSERT INTO TA_Category VALUES(N'مرخصی', @CatCustomCode + '-2', 0, 1, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	print 'مرخصی'	
	INSERT INTO TA_Category VALUES(N'ماموریت', @CatCustomCode + '-3', 0, 1, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	print 'ماموریت'	
	INSERT INTO TA_Category VALUES(N'کم کاری', @CatCustomCode + '-4', 0, 1, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	print 'کم کاری'	
	INSERT INTO TA_Category VALUES(N'اضافه کاری', @CatCustomCode + '-5', 0, 1, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	print 'اضافه کاری'
	INSERT INTO TA_Category VALUES(N'متفرقه', @CatCustomCode + '-6', 0, 1, 0)
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
	print 'متفرقه'
	SET @i = @i + 1
	
	FETCH NEXT FROM category_cursor
	INTO @CatId, @CatCustomCode
		
END
CLOSE category_cursor
DEALLOCATE category_cursor 
print 'Concepts Category'
---------------------


INSERT INTO TA_Category VALUES(N'دسته تقویم', @count+10, 0, 0, 1)
SET @CatId = SCOPE_IDENTITY()
---------------------
INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
 VALUES(@CatId, @CatId, 1)
 
 --Fire holiday triggers---------------
IF EXISTS (SELECT * FROM holiday)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO holiday_tmp
	FROM holiday
	TRUNCATE TABLE holiday	
	INSERT INTO holiday
		SELECT * 
		FROM holiday_tmp	
	DROP TABLE holiday_tmp	
	COMMIT TRANSACTION T1
END
print 'holiday'

--Fire persons triggers---------------
IF EXISTS (SELECT * FROM persons)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO persons_tmp
	FROM persons
	TRUNCATE TABLE persons	
	INSERT INTO persons
		SELECT * 
		FROM persons_tmp	
	DROP TABLE persons_tmp	
	COMMIT TRANSACTION T1
END
print 'persons'

--Fire LeaveYear triggers---------------
IF EXISTS (SELECT * FROM morkhasi)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO morkhasi_tmp
	FROM morkhasi
	TRUNCATE TABLE morkhasi	
	INSERT INTO morkhasi
		SELECT * 
		FROM morkhasi_tmp	
	DROP TABLE morkhasi_tmp	
	COMMIT TRANSACTION T1
END
print 'morkhasi'
--Fire Rules triggers---------------
IF EXISTS (SELECT * FROM Rules)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO Rules_tmp
	FROM rules
	TRUNCATE TABLE rules	
	INSERT INTO rules
		SELECT * 
		FROM Rules_tmp	
	DROP TABLE Rules_tmp	
	COMMIT TRANSACTION T1
END
print 'rules'

--Fire Rulesetc triggers---------------
EXEC spr_InitLeaveSetting
print 'rulesetc'

--Fire addFree triggers---------------
IF EXISTS (SELECT * FROM addfree)
BEGIN
	BEGIN TRANSACTION T1
	SELECT * 
		INTO addfree_tmp
	FROM addfree
	TRUNCATE TABLE addfree	
	INSERT INTO addfree
		SELECT * 
		FROM addfree_tmp	
	DROP TABLE addfree_tmp	
	COMMIT TRANSACTION T1
END
print 'addfree'

------------------------------- 
EXEC dbo.spr_create_tbls

print 'spr_create_tbls'


DECLARE @name varchar(50),
		@str  varchar(500)
		
DECLARE db_cursor CURSOR FOR  
SELECT name from sysobjects 
where type='U' 
and left(name,3)<>'TA_' 
AND NAME NOT LIKE '%template%'
AND NAME NOT like '%sysdiagrams%' 
AND (   --NAME like 'C1388%' OR NAME like 'E1388%' OR NAME like 'T1388%' OR NAME like 'A1388%' OR
	  NAME like 'C1389%' --OR NAME like 'E1389%' OR NAME like 'T1389%' OR NAME like 'A1389%'
	 --OR NAME like 'C1390%' OR NAME like 'E1390%' OR NAME like 'T1390%' OR NAME like 'A1390%'
	 )
ORDER BY [name]

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   
WHILE @@FETCH_STATUS = 0   
BEGIN   
       set @str= 'BEGIN TRAN T1 ' +    
				 'Print '+''''+@name+'''' + 
				 'select * into ' + @name + '_tmp ' + 
				 'from ' + @name + ' ' +
				 'IF EXISTS(SELECT * FROM ' + @name + '_tmp) ' +
				 'BEGIN ' + 				
				 ' truncate table ' + @name + ' ' +				 
				 'insert into ' + @name + ' select * from ' + @name + '_tmp ' +
				 'END ' +
				 'drop table ' + @name + '_tmp ' +
				 'COMMIT TRAN T1'
       execute(@str)
----------------------
       FETCH NEXT FROM db_cursor INTO @name   
END   
CLOSE db_cursor   
DEALLOCATE db_cursor 

-- LEAVE Init
exec sp_LeaveBudgetPopulate




