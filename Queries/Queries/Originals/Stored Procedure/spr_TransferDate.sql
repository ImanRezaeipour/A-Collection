
ALTER PROCEDURE [dbo].[spr_TransferData]
AS
BEGIN
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
				AND 
			  NAME NOT LIKE 'TA_Category'

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

	--Fire grp_dtl triggers---------------
	IF EXISTS (SELECT * FROM grp_dtl)
	BEGIN
		BEGIN TRANSACTION T1
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
	END

	--Insert Categories-------------------
	DELETE FROM TA_Category
	DECLARE @CatId numeric,
			@CatCustomCode nvarchar(50),
			@i int,
			@count int
	---------------------
	INSERT INTO TA_Category VALUES('دسته قوانین', 0)
	SET @CatId = SCOPE_IDENTITY()
	---------------------
	INSERT INTO TA_Category(Cat_Name, Cat_CustomCode)
		SELECT Rule_Name, Rule_Code
		FROM rules
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	 SELECT @CatId, Cat_ID, 1
	 FROM TA_Category
	 WHERE Cat_ID <> @CatId
	---------------------
	SELECT @i = 0,
		   @count = COUNT(*) + 1
	FROM rules	   

	DECLARE category_cursor CURSOR
		FOR SELECT Cat_ID, Cat_CustomCode
			FROM TA_Category
			
	OPEN category_cursor
	FETCH NEXT FROM category_cursor
	INTO @CatId, @CatCustomCode
	WHILE @@FETCH_STATUS = 0 AND @i < @count
	BEGIN
		DECLARE @ChildId numeric
		
		INSERT INTO TA_Category VALUES(N'متفرقه-کارکرد', @CatCustomCode + '-1')
		SET @ChildId = SCOPE_IDENTITY()
		INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
		VALUES(@CatId, @ChildId, 1)
		
		INSERT INTO TA_Category VALUES(N'مرخصی', @CatCustomCode + '-2')
		SET @ChildId = SCOPE_IDENTITY()
		INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
		VALUES(@CatId, @ChildId, 1)
			
		INSERT INTO TA_Category VALUES(N'ماموریت', @CatCustomCode + '-3')
		SET @ChildId = SCOPE_IDENTITY()
		INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
		VALUES(@CatId, @ChildId, 1)
			
		INSERT INTO TA_Category VALUES(N'کم کاری', @CatCustomCode + '-4')
		SET @ChildId = SCOPE_IDENTITY()
		INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
		VALUES(@CatId, @ChildId, 1)
			
		INSERT INTO TA_Category VALUES(N'اضافه کاری', @CatCustomCode + '-5')
		SET @ChildId = SCOPE_IDENTITY()
		INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
		VALUES(@CatId, @ChildId, 1)
		
		SET @i = @i + 1
		
		FETCH NEXT FROM category_cursor
		INTO @CatId, @CatCustomCode
	END
	CLOSE category_cursor
	DEALLOCATE category_cursor 
	---------------------
	INSERT INTO TA_Category VALUES(N'دسته تقویم', @i + 1)
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

	--Fire Rulesetc triggers---------------
	IF EXISTS (SELECT * FROM Rulesetc)
	BEGIN
		BEGIN TRANSACTION T1
		SELECT * 
			INTO Rulesetc_tmp
		FROM rulesetc
		TRUNCATE TABLE rulesetc
		INSERT INTO rulesetc
			SELECT * 
			FROM Rulesetc_tmp	
		DROP TABLE Rulesetc_tmp	
		COMMIT TRANSACTION T1
	END

	------------------------------- 
	EXEC dbo.spr_create_tbls


	DECLARE @name varchar(50),
			@str  varchar(500)
			
	DECLARE db_cursor CURSOR FOR  
	SELECT name from sysobjects 
	where type='U' 
	and left(name,3)<>'TA_' 
	AND NAME NOT LIKE '%template%'
	AND NAME NOT like '%sysdiagrams%' 
	AND (NAME like 'C%' OR NAME like 'E%' OR NAME like 'T%' OR NAME like 'A%')
	ORDER BY [name]

	OPEN db_cursor   
	FETCH NEXT FROM db_cursor INTO @name   
	WHILE @@FETCH_STATUS = 0   
	BEGIN   
		   set @str= 'BEGIN TRAN T1 ' +     
					 'select * into ' + @name + '_tmp ' + 
					 'from ' + @name + ' ' +
					 'IF EXISTS(SELECT * FROM ' + @name + '_tmp) ' +
					 'BEGIN ' + 
					 'truncate table ' + @name + ' ' +				 
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

END