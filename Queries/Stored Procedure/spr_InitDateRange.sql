create PROC spr_InitDateRange(@rule_Code int)
As
begin
DECLARE @CnpTmpID numeric(18, 0),							
				@CnpIdentifierCode numeric,				
				@CnpCustomCategoryCode varchar(50)

DECLARE	@CalcFromDate datetime
				,@CalcToDate datetime
				,@CalcType smallint		
				,@customeCode varchar(50)		
				,@CnpID numeric	
				,@counter numeric
				,@personItems numeric	

set @counter=0;
print 'spr_InitCalculationDateRange Rule_Code*:'+Convert(varchar(5),@rule_Code)				
	
		DELETE FROM TA_CalculationDateRange
					WHERE CalculationDateRange_PersonId in (select  prs_id from TA_Person where Prs_Barcode in (select p_barcode from persons where P_RuleGroup=@rule_code) and Prs_Active=1)

		DECLARE occurenceCnpTmp_cursor CURSOR
			FOR  SELECT CnpTmp.ConceptTmp_ID,
						CnpTmp.ConceptTmp_CustomCategoryCode, CnpTmp.ConceptTmp_IdentifierCode
						FROM TA_ConceptTemplate AS CnpTmp
						ORDER bY CnpTmp.ConceptTmp_IdentifierCode

		OPEN occurenceCnpTmp_cursor	
		FETCH NEXT FROM occurenceCnpTmp_cursor
		INTO @CnpTmpID, @CnpCustomCategoryCode, @CnpIdentifierCode
					
	    
		WHILE @@FETCH_STATUS = 0 			
		BEGIN					
			IF EXISTS (SELECT calcDateRng_ID FROM TA_CalculationDateRangeTemplate WHERE calcDateRng_CnpTmpId = @CnpTmpID)
			BEGIN
				print 'identifier '+	Convert(varchar(5),@CnpIdentifierCode)
										
				INSERT INTO TA_CalculationDateRange
						(CalculationDateRange_SecondaryConceptId, CalculationDateRange_PersonId,
						 CalculationDateRange_FromDate, CalculationDateRange_ToDate, CalculationDateRange_Type)
					SELECT CatCnp_ID,CatCnp_PersonId,calcDateRng_FromDate, calcDateRng_ToDate, calcDateRng_Type --,@CnpIdentifierCode,@CnpTmpID 
					FROM TA_CalculationDateRangeTemplate, CategorisedConcept_view 
					WHERE CatCnp_IdentifierCode=@CnpIdentifierCode 
							AND calcDateRng_CnpTmpId = @CnpTmpID	
							AND	calcDateRng_Param IN(SELECT Prs__Param 
													 FROM TA_Person 
													 WHERE Prs_ID=CatCnp_PersonId) 

							AND CatCnp_PersonId IN (SELECT  prs_id 
												    FROM TA_Person 
												    WHERE Prs_Barcode IN (SELECT p_barcode 
																		  FROM persons 
																		  WHERE P_RuleGroup=@rule_code) 
													AND Prs_Active=1)
	
								
			END
			FETCH NEXT FROM occurenceCnpTmp_cursor
			INTO @CnpTmpID,@CnpCustomCategoryCode, @CnpIdentifierCode
				
		END
				
		CLOSE occurenceCnpTmp_cursor
		DEALLOCATE occurenceCnpTmp_cursor
		
	
end