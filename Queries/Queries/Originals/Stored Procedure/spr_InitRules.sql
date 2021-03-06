Alter PROC spr_InitRules(@rule_Code int)
As
begin
DECLARE @RuleName nvarchar(100)
	    ,@RuleTmpID numeric(18, 0)
		,@RuleScript nvarchar(MAX)
		,@RuleCSharptCode nvarchar(MAX)
		,@RuleCustomCode nvarchar(50)
		,@RuleOrder smallint
		,@CustomCategoryCode varchar(50)
		,@RuleIs bit
		,@OldRuleCode numeric(18, 0)	
		,@RuleIdentifierCode numeric	
		,@Result bit
		,@isPriodic bit		
		
		
		print 'spr_InitRules Rule_Code:'+Convert(varchar(5),@rule_Code)
		--delete INIT Rules 
		delete from ta_objectcategory
					where objcat_objectid in (SELECT DefRle_id
								FROM TA_DefinedRule DefRle
										INNER JOIN TA_ObjectCategory ObjCat
											ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
								WHERE
									  Cat.Cat_CustomCode =  CONVERT(varchar(5), @Rule_Code )+'-7' )

		delete from ta_object 
					where taobj_id in (SELECT DefRle_id
								FROM TA_DefinedRule DefRle
										INNER JOIN TA_ObjectCategory ObjCat
											ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
								WHERE
									  Cat.Cat_CustomCode =  CONVERT(varchar(5), @Rule_Code )+'-7' )

		delete from ta_definedruleparameter
					where defrleparam_definedruleid in (SELECT DefRle_id
								FROM TA_DefinedRule DefRle
										INNER JOIN TA_ObjectCategory ObjCat
											ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
								WHERE
									  Cat.Cat_CustomCode =  CONVERT(varchar(5), @Rule_Code )+'-7' )

		delete from ta_definedrule
					where defrle_id in (SELECT DefRle_id
								FROM TA_DefinedRule DefRle
										INNER JOIN TA_ObjectCategory ObjCat
											ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
								WHERE
									  Cat.Cat_CustomCode =  CONVERT(varchar(5), @Rule_Code )+'-7' )
		
		--حذف قوانینی که قبلا ایجاد شده و باید حذف شود		
		delete from TA_DefinedRule where DefRle_ID in (
SELECT DefRle_ID
								FROM TA_DefinedRule DefRle
										INNER JOIN TA_ObjectCategory ObjCat
											ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
								WHERE
									  Cat.Cat_CustomCode like (CONVERT(varchar(5),@rule_code)+ '-%')			
									  and DefRle_IdentifierCode not in (
									  SELECT RleTmp.RuleTmp_IdentifireCode 										
			FROM TA_RuleTemplateMapping AS RleTmpMapping			
					INNER JOIN dbo.ConditionResults(@Rule_Code) AS ConditionResult
						ON ConditionResult.ConditionID = RleTmpMapping.RleTmpMapping_templateConditionId
					INNER JOIN TA_RuleTemplate AS RleTmp
						ON RleTmp.RuleTmp_ID = RleTmpMapping.RleTmpMapping_RuleTemplateId	
									  ) 					
									  )										  

		DECLARE occurenceRuleTmp_cursor CURSOR
		FOR SELECT RleTmp.RuleTmp_ID, RleTmp.RuleTmp_Name, RleTmp.RuleTmp_Script, RleTmp.RuleTmp_CSharpCode, RleTmp.RuleTmp_CustomCode, 
					RleTmp.RuleTmp_CustomCategoryCode, RleTmp.RuleTmp_Order,RleTmp.RuleTmp_IdentifireCode, RleTmpMapping.RleTmpMapping_Is, 
					ConditionResult.OldRule_Code,ConditionResult.Result,rleTmp.RuleTmp_IsPeriodic
			FROM TA_RuleTemplateMapping AS RleTmpMapping			
					INNER JOIN dbo.ConditionResults(@Rule_Code) AS ConditionResult
						ON ConditionResult.ConditionID = RleTmpMapping.RleTmpMapping_templateConditionId
					INNER JOIN TA_RuleTemplate AS RleTmp
						ON RleTmp.RuleTmp_ID = RleTmpMapping.RleTmpMapping_RuleTemplateId	
						order by RleTmp.RuleTmp_IdentifireCode				
			
print 'open'
		OPEN occurenceRuleTmp_cursor	
		FETCH NEXT FROM occurenceRuleTmp_cursor
		INTO @RuleTmpID, @RuleName, @RuleScript, @RuleCSharptCode, @RuleCustomCode, 
				@CustomCategoryCode, @RuleOrder, @RuleIdentifierCode, @RuleIs, @OldRuleCode,@Result,@isPriodic
					
		WHILE @@FETCH_STATUS = 0
		BEGIN
		print 'while'
			DECLARE @ID numeric	
			DECLARE @CategoryID numeric		
			if(@RuleIs = 1 and @Result=1)
			BEGIN
				set @CategoryID =0
				SELECT @CategoryID = Cat_ID
						FROM TA_Category		
						WHERE Cat_CustomCode =  CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CustomCategoryCode)
				set @CategoryID=isnull(@CategoryID,0)
					
				declare @defruleId decimal
				set @defruleId = null
				SELECT @defruleId=isnull(DefRle_ID,0)
								FROM TA_DefinedRule DefRle
										INNER JOIN TA_ObjectCategory ObjCat
											ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
										INNER JOIN TA_Category Cat
											ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
								WHERE DefRle__RleTmpID = @RuleTmpID
										AND
									  Cat.Cat_CustomCode = CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CustomCategoryCode)
										AND
									  Cat_IsRuleCategory = 1
									  
					set @defruleId=ISNULL(@defruleId,0)	
							  
				--insert rule
				IF @defruleId=0										
				BEGIN			
					print 	CONVERT(varchar(5), @RuleIdentifierCode )+ '  Inserted'
					
					INSERT INTO TA_Object DEFAULT VALUES
					SELECT @ID = SCOPE_IDENTITY()
														
					set @ID=isnull(@ID,0)					
														
					if @ID<>0 and @CategoryID<>0
					begin
					INSERT INTO TA_DefinedRule(DefRle_ID,DefRle_IdentifierCode,DefRle_MethodName,DefRle_Script,DefRle_TranslatedCode ,DefRle_Description ,DefRle_Name,DefRle__CustomCode,DefRle__RleTmpID,DefRle_IsPeriodic)
					 VALUES(@ID, 
														@RuleIdentifierCode, 
														'R' + CONVERT(varchar(20), @RuleIdentifierCode), 
														@RuleScript, 
														@RuleCSharptCode,
														'', 
														@RuleName, 
														@RuleCustomCode,
														@RuleTmpID,
														@isPriodic )	
					
					
										
					
					INSERT INTO TA_ObjectCategory VALUES(@ID,
														 @CategoryID,
														 1,
														 @RuleOrder)
					INSERT INTO TA_DefinedRuleParameter
						SELECT *
						FROM dbo.DefinedRuleParams(@RuleTmpID, 
												   @ID, 
												   @Rule_Code) 
					end
												   
				END			
				ELSE
				--update rule
				BEGIN
				    print 	CONVERT(varchar(5), @RuleIdentifierCode )+ '  Updated'
				 	
				 	UPDATE TA_DefinedRule 	set DefRle_IdentifierCode=@RuleIdentifierCode,DefRle_MethodName='R' + CONVERT(varchar(20), @RuleIdentifierCode)
				 	,DefRle_Script=@RuleScript,DefRle_TranslatedCode=@RuleCSharptCode,DefRle_Description=''
				 	,DefRle_Name=@RuleName,DefRle__CustomCode=@RuleCustomCode,DefRle__RleTmpID=@RuleTmpID
				 	WHERE DefRle_ID=@defruleId
				 	
				 	UPDATE TA_ObjectCategory SET ObjCat_RuleOrder=@RuleOrder where ObjCat_CategoryId=@CategoryID and ObjCat_ObjectId=@defruleId
				 	
				 	DELETE FROM TA_DefinedRuleParameter WHERE DefRleParam_DefinedRuleId=@defruleId 
				 					 
				 	
				 	INSERT INTO TA_DefinedRuleParameter
						SELECT *
						FROM dbo.DefinedRuleParams(@RuleTmpID, 
												   @defruleId, 
												   @Rule_Code) 
				 END
			END
			ELSE
			--delete rule
			BEGIN	
			print CONVERT(varchar(5), @RuleIdentifierCode )+ '  Deleted'	
				SET @ID=0
				SELECT @ID = DefRle_ID
				FROM TA_DefinedRule DefRle
						INNER JOIN TA_ObjectCategory ObjCat
							ON DefRle.DefRle_ID = ObjCat.ObjCat_ObjectId
						INNER JOIN TA_Category Cat
							ON Cat.Cat_ID = ObjCat.ObjCat_CategoryId
				WHERE 
					  DefRle__RleTmpID = @RuleTmpID
						AND
					  Cat.Cat_CustomCode = CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CustomCategoryCode)
						AND
					  Cat_IsRuleCategory = 1
					  
					  				  			
				set @CategoryID =0
				SELECT @CategoryID = Cat_ID
				FROM TA_Category		
				WHERE Cat_CustomCode =CONVERT(varchar(5), @Rule_Code )+ '-' +CONVERT(varchar(5), @CustomCategoryCode)
				
				
				set @ID=isnull(@ID,0)
				set @CategoryID=isnull(@CategoryID,0)
				
				if @ID<>0 and @CategoryID<>0
				begin				
					print 'deleteing....'+convert(varchar(5),@ID)+' - ' +convert(varchar(5),@CategoryID)
					DELETE FROM TA_ObjectCategory
					WHERE ObjCat_ObjectId = @ID
							AND					
						  ObjCat_CategoryId = @CategoryID
						  
					DELETE FROM TA_Object 
					WHERE TAObj_ID = @ID
					
					DELETE FROM TA_DefinedRuleParameter
					WHERE DefRleParam_DefinedRuleId = @ID
				end
				print CONVERT(varchar(5), @RuleIdentifierCode )+ ' - '+CONVERT(varchar(5), @ID )+ '  Deleted'							  
			END
												

		FETCH NEXT FROM occurenceRuleTmp_cursor
		INTO @RuleTmpID, @RuleName, @RuleScript, @RuleCSharptCode, @RuleCustomCode, 
				@CustomCategoryCode, @RuleOrder, @RuleIdentifierCode, @RuleIs, @OldRuleCode,@Result,@isPriodic
						
		END
		CLOSE occurenceRuleTmp_cursor
		DEALLOCATE occurenceRuleTmp_cursor	
		
		declare @tmpRule int
		select @tmpRule=Rule_sprule from rulesetc where Rule_Code=@rule_Code 
	
		if(@tmpRule is not null and @tmpRule >0)
		begin
			Exec dbo.spr_InitRules @tmpRule
		end

end