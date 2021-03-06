ALTER TRIGGER trg_Ins_Persons_4InsTa_person
   ON   persons
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	BEGIN
		INSERT INTO TA_Person (Prs_Barcode,Prs_Name,Prs_Active,Prs__Param )
		SELECT p_barcode, p_Name + ' ' + p_Family,P_IsValid ,p_param 
		FROM inserted  
		WHERE p_barcode NOT IN (SELECT Prs_Barcode FROM TA_Person)
	
	print 'persons inserted'
		DELETE FROM TA_AssignWorkGroup
		WHERE AsgWorkGroup_PersonId IN (SELECT Prs_ID FROM TA_Person WHERE Prs_Barcode IN (SELECT p_barcode FROM inserted ))
		
	
		INSERT INTO TA_AssignWorkGroup (AsgWorkGroup_WorkGroupId, AsgWorkGroup_PersonId,
										AsgWorkGroup_FromDate, AsgWorkGroup_ToDate)
		SELECT ins.P_ShiftGroup, 
				prs.Prs_ID, 
				dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),Convert(varchar(4), Min(grpdtl.Grd_Year)) + '/1/1',101)),
				dbo.GTS_ASM_ShamsiToMiladi(Convert(varchar(10),Convert(varchar(4), MAX(grpdtl.Grd_Year) + 2) + '/12/29',101))				
		FROM TA_Person prs
				INNER JOIN inserted ins
					ON ins.P_BarCode = prs.Prs_Barcode
				INNER JOIN grp_dtl grpdtl
					ON grpdtl.Grd_Code = ins.P_ShiftGroup
	
		GROUP BY Ins.P_ShiftGroup, prs.Prs_ID
	print 'TA_AssignWorkGroup inserted'
	
		DELETE FROM TA_PersonUnit
		WHERE PrsUnit_PersonId IN (SELECT Prs_ID FROM TA_Person WHERE Prs_Barcode IN (SELECT p_barcode FROM inserted ))
	
		INSERT INTO TA_PersonUnit (PrsUnit_PersonId, PrsUnit_UnitId)
		SELECT prs.Prs_ID, 
				CASE (ins.P_Parts)
				 WHEN '' THEN 0
				 ELSE ins.P_Parts
				END
		FROM TA_Person prs
				INNER JOIN inserted ins
					ON ins.P_BarCode = prs.Prs_Barcode
		WHERE ins.P_Parts IN (select p_code from parts)		
		print 'TA_PersonUnit inserted'
		
		DELETE FROM TA_PersonAssignment
		WHERE PrsAsg_CategoryId IN (SELECT Cat_ID
									FROM TA_Category	
									WHERE Cat_Name = N'دسته تقویم')		
		INSERT INTO TA_PersonAssignment (PrsAsg_PersonId, PrsAsg_CategoryId, PrsAsg_FromDate, PrsAsg_ToDate)
		  SELECT Prs_ID, 
				(SELECT Cat_ID
				 FROM TA_Category	
				 WHERE Cat_Name = N'دسته تقویم'),
				 Convert(varchar(10), '1900/01/01', 101), 
				 Convert(varchar(10), '2100/01/01', 101)					  
		  FROM TA_Person 
		  WHERE Prs_Barcode IN (SELECT p_barcode 
								FROM inserted)
											
		
		
		print 'Calendar category inserted to TA_PersonAssignment'		
		
		DECLARE @BarCode varchar(10)
		DECLARE @RuleGroup numeric
		
		DECLARE inserted_cursor CURSOR
		FOR SELECT p_barcode, p_rulegroup FROM inserted order by p_rulegroup
		
		OPEN inserted_cursor
		FETCH inserted_cursor 
		INTO @BarCode, @RuleGroup
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			print @BarCode + ' - ' + convert(varchar(5),@RuleGroup)
			DELETE FROM TA_PersonAssignment
			WHERE PrsAsg_PersonId = (SELECT Prs_ID FROM TA_Person WHERE Prs_Barcode = @BarCode)
					AND
				  PrsAsg_CategoryId <> (SELECT Cat_ID
										FROM TA_Category	
										WHERE Cat_Name = N'دسته تقویم')
			
			DECLARE @Rule_spRule int
			DECLARE @Rule_FromDate varchar(10)
			DECLARE @Rule_ToDate varchar(10)
			
			SELECT @Rule_spRule = Rule_sprule, 
				   @Rule_FromDate = Rule_sprulefdate, 
				   @Rule_ToDate = Rule_spruleedate 
			FROM rulesetc 
			WHERE Rule_Code = @RuleGroup and rule_sprulefdate is not null and
			rule_spruleedate is not null 
					  		
			INSERT INTO TA_PersonAssignment (PrsAsg_PersonId, PrsAsg_CategoryId, PrsAsg_FromDate, PrsAsg_ToDate)
						SELECT prs.Prs_ID, cat.Cat_ID, Convert(varchar(10), '1900/01/01', 101), Convert(varchar(10), '2100/01/01', 101)
						FROM TA_Person prs
								INNER JOIN TA_Category cat
									ON cat.Cat_CustomCode = '00' + Convert(varchar(10), @RuleGroup)			
						WHERE Prs_BarCode = @BarCode							
								AND 
							  cat_IsConceptCategory = 1	
					  		
			IF (@Rule_spRule IS NOT NULL AND @Rule_spRule > 0)
			BEGIN
				WHILE(@Rule_spRule IS NOT NULL AND @Rule_spRule > 0 
				and Exists(select rule_code from rules where rule_code=@Rule_spRule))
				BEGIN
					print  ' @Rule_spRule '+convert(varchar(5),@Rule_spRule) + ' - ' + convert(varchar(5),@RuleGroup)+ ' '  +@BarCode
					INSERT INTO TA_PersonAssignment (PrsAsg_PersonId, PrsAsg_CategoryId, PrsAsg_FromDate, PrsAsg_ToDate)
					SELECT prs.Prs_ID, cat.Cat_ID, Convert(varchar(10), '1900/01/01', 101), Convert(varchar(10), dbo.GTS_ASM_ShamsiToMiladi(@Rule_FromDate), 101)
					FROM TA_Person prs
							INNER JOIN TA_Category cat
								ON cat.Cat_CustomCode = Convert(varchar(10), @RuleGroup)			
					WHERE Prs_BarCode = @BarCode 	
							AND 
						  cat_IsRuleCategory = 1	

					INSERT INTO TA_PersonAssignment (PrsAsg_PersonId, PrsAsg_CategoryId, PrsAsg_FromDate, PrsAsg_ToDate)
					SELECT prs.Prs_ID, cat.Cat_ID, Convert(varchar(10), DATEADD(day,1, dbo.GTS_ASM_ShamsiToMiladi(@Rule_FromDate)), 111), Convert(varchar(10), dbo.GTS_ASM_ShamsiToMiladi(@Rule_ToDate), 101)
					FROM TA_Person prs
							INNER JOIN TA_Category cat
								ON cat.Cat_CustomCode = Convert(varchar(10), @Rule_spRule)
					WHERE Prs_BarCode = @BarCode								
							AND 
						  cat_IsRuleCategory = 1	

					INSERT INTO TA_PersonAssignment (PrsAsg_PersonId, PrsAsg_CategoryId, PrsAsg_FromDate, PrsAsg_ToDate)
					SELECT prs.Prs_ID, cat.Cat_ID, Convert(varchar(10), DATEADD(day,1,  dbo.GTS_ASM_ShamsiToMiladi(@Rule_ToDate)), 111), Convert(varchar(10), '2100/01/01', 101)
					FROM TA_Person prs
							INNER JOIN TA_Category cat
								ON cat.Cat_CustomCode = Convert(varchar(10), @RuleGroup)			
					WHERE Prs_BarCode = @BarCode							
							AND 
						  cat_IsRuleCategory = 1	

					
					SET @RuleGroup = @Rule_spRule
					SELECT @Rule_spRule = Rule_sprule,
						   @Rule_FromDate = Rule_sprulefdate,
						   @Rule_ToDate = Rule_spruleedate 
					FROM rulesetc 
					WHERE Rule_Code = @RuleGroup	
				END
			END
			ELSE
			BEGIN
				print 'prsAsg insert:'+ Convert(varchar(5), @RuleGroup) + ' - ' + @BarCode
				
				INSERT INTO TA_PersonAssignment (PrsAsg_PersonId, PrsAsg_CategoryId, PrsAsg_FromDate, PrsAsg_ToDate)
				SELECT prs.Prs_ID, cat.Cat_ID, Convert(varchar(10), '1900/01/01', 101), Convert(varchar(10), '2100/01/01', 101)
				FROM TA_Person prs
						INNER JOIN TA_Category cat
							ON cat.Cat_CustomCode = Convert(varchar(10), @RuleGroup)
				WHERE Prs_BarCode = @BarCode								
			END
			
				
			FETCH inserted_cursor 
			INTO @BarCode, @RuleGroup
			
		END
		CLOSE inserted_cursor
		DEALLOCATE inserted_cursor
	END
END

				