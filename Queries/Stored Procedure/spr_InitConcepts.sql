Alter PROC spr_InitConcepts(@rule_Code int)
As
begin

DECLARE @CnpTmpID numeric(18, 0),
				@CnpName nvarchar(50),
				@CnpScript nvarchar(MAX),
				@CnpCSharptCode nvarchar(MAX),
				@CnpCustomCode nvarchar(50),			
				@CnpIdentifierCode numeric,
				@CnpOrder smallint,
				@CnpType smallint,
				@CnpReadOnly bit,
				@CnpRangely bit,
				@CnpPColumn nvarchar(50),
				@CnpCustomCategoryCode varchar(50),
				@CnpIs bit,			
				@OldCnpCode numeric(18, 0)	

		print 'spr_InitConcepts Rule_Code:'+Convert(varchar(5),@rule_Code)				

		DECLARE occurenceCnpTmp_cursor CURSOR
			FOR  SELECT CnpTmp.ConceptTmp_ID, CnpTmp.ConceptTmp_Name, CnpTmp.ConceptTmp_Script, CnpTmp.ConceptTmp_CSharpCode, 
						CnpTmp.ConceptTmp_CustomCategoryCode, CnpTmp.ConceptTmp_IdentifierCode, CnpTmp.ConceptTmp_Order,CnpTmp.ConceptTmp_ReadOnly,CnpTmp.ConceptTmp_IsRangely,
						CnpTmp.ConceptTmp_Type,CnpTmp.ConceptTmp_PColumn
				 FROM TA_ConceptTemplate AS CnpTmp
				 order by CnpTmp.ConceptTmp_IdentifierCode

		OPEN occurenceCnpTmp_cursor	
		FETCH NEXT FROM occurenceCnpTmp_cursor
		INTO @CnpTmpID, @CnpName, @CnpScript, @CnpCSharptCode, 
				@CnpCustomCategoryCode, @CnpIdentifierCode, @CnpOrder, @CnpReadOnly,
				@CnpRangely, @CnpType, @CnpPColumn			
	    
		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @CnpID numeric	
			DECLARE @CnpCategoryID numeric	
			DECLARE	@CalcFromDate datetime
				   ,@CalcToDate datetime
				   ,@CalcType smallint
					
				  
			IF NOT EXISTS(SELECT ScndCnp_ID
							FROM TA_SecondaryConcept ScndCnp
										INNER JOIN TA_ObjectCategory ObjCat
											ON ScndCnp.ScndCnp_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId						
							WHERE 
								  ScndCnp.ScndCnp_IdentifierCode = @CnpIdentifierCode
									AND
								  Cat.Cat_CustomCode = '00' + CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CnpCustomCategoryCode)
									AND
								  Cat_IsConceptCategory = 1)
			BEGIN					
				print Convert(varchar(5),@CnpIdentifierCode) + ' inserted'
				INSERT INTO TA_Object DEFAULT VALUES
				SELECT @CnpID = SCOPE_IDENTITY()
				
				INSERT INTO TA_SecondaryConcept VALUES(@CnpID, 
														@CnpIdentifierCode, 
														@CnpName,
														@CnpScript,
														@CnpCSharptCode,
														'C' + CONVERT(varchar(20), @CnpIdentifierCode)
														,@CnpReadOnly
														,@CnpRangely
														,@CnpType
														,@CnpCustomCode
														,@CnpPColumn
														,null
														,@CnpTmpID )														
				
				SELECT @CnpCategoryID = Cat_ID
				FROM TA_Category		
				WHERE Cat_CustomCode = '00' + CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CnpCustomCategoryCode) 
						AND
					  Cat_IsConceptCategory = 1
				
		
				INSERT INTO TA_ObjectCategory VALUES(@CnpID,
													 @CnpCategoryID,
													 1,
													 @CnpOrder)														 
				
				INSERT INTO TA_SecondaryConceptParameter   
					SELECT *
					FROM dbo.ConceptParams(@CnpTmpID, 
										   @CnpID, 
										   @Rule_Code) 

				
   								   
				
			END
			ELSE--if scnd cnp exsists
			BEGIN
				print Convert(varchar(5),@CnpIdentifierCode) + ' updated'
				SELECT @CnpID = ScndCnp_ID
				FROM TA_SecondaryConcept ScndCnp
							INNER JOIN TA_ObjectCategory ObjCat
								ON ScndCnp.ScndCnp_ID = ObjCat.ObjCat_ObjectId
							INNER JOIN TA_Category Cat
								ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId						
				WHERE 
					  ScndCnp.ScndCnp_IdentifierCode = @CnpIdentifierCode
						AND
					  Cat.Cat_CustomCode = '00' + CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CnpCustomCategoryCode) 
					    AND
					  Cat_IsConceptCategory = 1
				  
				UPDATE TA_SecondaryConcept 
				SET ScndCnp_ScriptCode = @CnpScript,
					ScndCnp_TranslatedCode = @CnpCSharptCode,
					ScndCnp_ReadOnly = @CnpReadOnly,
					ScndCnp_IsRangely = @CnpRangely,
					ScndCnp_Type = @CnpType,
					ScndCnp_CustomeCode = @CnpCustomCode,
					ScndCnp__PColumn = @CnpPColumn	
				WHERE ScndCnp_ID = @CnpID					 
						
				DELETE FROM TA_SecondaryConceptParameter  
				WHERE ScndCnpParam_SecondaryConceptId =	@CnpID					
				INSERT INTO TA_SecondaryConceptParameter   
					SELECT *
					FROM dbo.ConceptParams(@CnpTmpID, 
										   @CnpID, 
										   @Rule_Code) 

			END						

			FETCH NEXT FROM occurenceCnpTmp_cursor
			INTO @CnpTmpID, @CnpName, @CnpScript, @CnpCSharptCode,
					@CnpCustomCategoryCode, @CnpIdentifierCode, @CnpOrder, @CnpReadOnly,
					@CnpRangely, @CnpType, @CnpPColumn
		END
				
		CLOSE occurenceCnpTmp_cursor
		DEALLOCATE occurenceCnpTmp_cursor
		
		declare @tmpRule int
		select @tmpRule=Rule_sprule from rulesetc where Rule_Code=@rule_Code 
	
		--if(@tmpRule is not null and @tmpRule >0)
		--begin
		--	Exec dbo.spr_InitConcepts @tmpRule
		--end

end