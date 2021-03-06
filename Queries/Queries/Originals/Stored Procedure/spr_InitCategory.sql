alter PROC spr_InitCategory(@ruleCode int)
As
begin
DECLARE @CatId numeric,
		@CatCustomCode nvarchar(50),
		@parentCatId int,
		@rulename nvarchar(100),		
		@ChildId int
		
print 'spr_InitCategory Rule_Code:'+ Convert(varchar(5),@ruleCode)
SELECT @rulename =rule_name from rules where Rule_Code=@ruleCode 

if not exists(select * from TA_Category where Cat_CustomCode=Convert(varchar(5),@ruleCode ))
begin
			
INSERT INTO TA_Category(Cat_Name, Cat_CustomCode)
VALUES (@rulename , @ruleCode )
SET @CatId = SCOPE_IDENTITY()

select @parentCatId=Cat_ID  from TA_Category 	where Cat_CustomCode='0'

INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
 VALUES( @parentCatId, @CatId, 1)


set @CatCustomCode=@ruleCode
INSERT INTO TA_Category (Cat_Name,Cat_CustomCode) VALUES(N'متفرقه-کارکرد', @CatCustomCode + '-1')
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)

INSERT INTO TA_Category (Cat_Name,Cat_CustomCode) VALUES(N'مرخصی', @CatCustomCode + '-2')
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
		
INSERT INTO TA_Category (Cat_Name,Cat_CustomCode) VALUES(N'ماموریت', @CatCustomCode + '-3')
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
		
INSERT INTO TA_Category (Cat_Name,Cat_CustomCode) VALUES(N'کم کاری', @CatCustomCode + '-4')
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)
		
INSERT INTO TA_Category (Cat_Name,Cat_CustomCode) VALUES(N'اضافه کاری', @CatCustomCode + '-5')
	SET @ChildId = SCOPE_IDENTITY()
	INSERT INTO TA_CategoryPart(CatPart_ParentCatId ,CatPart_ChildCatId ,CatPart_IsContain)
	VALUES(@CatId, @ChildId, 1)	
END
ELSE
begin
	update TA_Category set Cat_Name=@rulename  where cat_customcode=convert(varchar(5),@ruleCode)
end

	    declare @tmpRule int
		select @tmpRule=Rule_sprule from rulesetc where Rule_Code=@ruleCode 
	
		if(@tmpRule is not null and @tmpRule >0)
		begin
			Exec dbo.spr_InitCategory @tmpRule
		end
		
end